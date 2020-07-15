package com.bookshop01.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;


@Controller
public class FileDownloadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	@RequestMapping("/download")
							//이미지 파일 이름과 상품 id를 가져옵니다.
	protected void download(@RequestParam("fileName") String fileName,
		                 	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		File image=new File(filePath);

		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer);
			if(count==-1)  
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	
	@RequestMapping("/thumbnails.do")
							//main.jsp(36)에서 fileName 과 goods_id을 받아옵니다.  
	protected void thumbnails(@RequestParam("fileName") String fileName,
                            	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();//외부로 데이터를 전송한다, OutputStream은 바이트 기반 출력 스트림의 최상위 클래스로 추상클래스입니다. 
		String filePath=CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		File image=new File(filePath); //file을 얻어온다.
		
		
		//아,이건 썸네일을 저장할 때 이미지명으로 사용할려고 이미지명을 얻어오는 코드인데 지금은 바로 출력하니 사용하지 않습니다.
		//int lastIndex = fileName.lastIndexOf("."); //lastIndexOf: 메서드에 문자열을 입력하면 위치에따라 숫자로 반환한다.
		//String imageFileName = fileName.substring(0,lastIndex); //0이상 lastIndex 미만을 출력.
		
		if (image.exists()) { //image가 존재한다면, //메인 페이지 이미지를 썸네일로 표시합니다.
			Thumbnails.of(image).size(121,154).outputFormat("png").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
