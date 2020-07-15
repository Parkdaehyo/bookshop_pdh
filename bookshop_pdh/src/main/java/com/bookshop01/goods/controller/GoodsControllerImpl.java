package com.bookshop01.goods.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.goods.service.GoodsService;
import com.bookshop01.goods.vo.GoodsVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController   implements GoodsController {
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	
									
	                                                          //main.jsp에서 goods_id를 넘겨받습니다.
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id, //조회할 상품번호를 전달 받습니다.
			                       HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName"); //goodsDetail.jsp
		HttpSession session=request.getSession();
		Map goodsMap=goodsService.goodsDetail(goods_id); // 최종 도착지: goods.xml: selectGoodsDetailImage , imageResult 반환.
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap", goodsMap);
		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO"); //조회한 상품정보를 
		addGoodsInQuick(goods_id,goodsVO,session); // 빠른 메뉴에 표시하기 위해 전달 합니다.
		return mav; //goodsDetail.jsp
	}
	
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8") //브라우저로 전송하는 JSON 데이터의 한글 인코딩을 지정합니다.
	
											  //header.jsp에서 data : {keyword:value} 에서 keyword를 받음.
	public @ResponseBody String  keywordSearch(@RequestParam("keyword") String keyword, // 검색할 키워드를 가져옵니다.
			                                  HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		//System.out.println(keyword);
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase(); //대상 문자열을 모두 대문자로 반환합니다.
	    List<String> keywordList =goodsService.keywordSearch(keyword); //goods.xml selectKeywordSearch, 가져온 키워드가 포함된 상품 제목을 조회합니다.
	    
	 // 최종 완성될 JSONObject 선언(전체)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList); //조회할 데이터를 JSON에 저장합니다.
		 		
	    String jsonInfo = jsonObject.toString(); //JSON을 문자열로 변환한 후 브라우저로 출력합니다.
	   // System.out.println(jsonInfo);
	    return jsonInfo ; //브라우저로 출력?
	}
	
	
	//header.jsp seachWord 를 가져온다.
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName"); //searchGoods.jsp
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord); //goods.xml selectGoodsBySearchWord, 검색창에서 가져온 단어가 포함된 상품 제목을 조회합니다.
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsList", goodsList);
		return mav;
		
	}
	
	//ctrl shift r = quickMenu.jsp
	private void addGoodsInQuick(String goods_id,GoodsVO goodsVO,HttpSession session){
		boolean already_existed=false;
		List<GoodsVO> quickGoodsList; //최근 본 상품 저장 ArrayList
													//최초 요청시 null
		quickGoodsList=(ArrayList<GoodsVO>)session.getAttribute("quickGoodsList"); //세션에 저장된 최근 본 상품 목록을 가져옵니다.
		
		if(quickGoodsList!=null){ //최근 상품이 있는 경우
			if(quickGoodsList.size() < 4){ //미리본 상품 리스트에 상품개수가 세개 이하인 경우
			
				for(int i=0; i<quickGoodsList.size();i++){
					GoodsVO _goodsBean=(GoodsVO)quickGoodsList.get(i);
					if(goods_id.equals(Integer.toString(_goodsBean.getGoods_id()))){ //31.3 15:09 
						already_existed=true; //상품 목록을 가져와 이미 존재하는 상품인지 비교합니다.이미 존재할 경우 already_existed를 true로 설정합니다.
						//break;
						return;
					}
				}
				//already_existed가 false이면 상품정보를 목록에 저장합니다.
				if(already_existed==false){ //for문 돌면서 일치하는 goods_id가 없을 경우, 
					quickGoodsList.add(goodsVO);
				}
			}
			
			//최근 본 상품 목록이 없으면 생성하여 상품 정보를 저장합니다.
		}else{
			quickGoodsList =new ArrayList<GoodsVO>();
			quickGoodsList.add(goodsVO);
			
		}
		session.setAttribute("quickGoodsList",quickGoodsList); //최근 본 상품 목록을 세션에 저장합니다.
		session.setAttribute("quickGoodsListNum", quickGoodsList.size()); // 최근 본 상품 목록에 저장된 상품 개수를 세션에 저장합니다.
	}
}
