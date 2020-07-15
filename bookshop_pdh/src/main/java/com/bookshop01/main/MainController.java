package com.bookshop01.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop01.common.base.BaseController;
import com.bookshop01.goods.service.GoodsService;
import com.bookshop01.goods.vo.GoodsVO;

@Controller("mainController")
@EnableAspectJAutoProxy
public class MainController extends BaseController {
	
	@Autowired
	private GoodsService goodsService;
	
	
	@RequestMapping(value= "/main/main.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session;
		ModelAndView mav=new ModelAndView();
		String viewName=(String)request.getAttribute("viewName"); //main.jsp를 가져옵니다.
		mav.setViewName(viewName);
		
		session=request.getSession();
		//main/main.do로 요청시 세션에 "side_menu" 라는 이름으로 "user" 라는 글자를 바인딩, 
		session.setAttribute("side_menu", "user"); //속성, 즉 side_menu의 값에 따라 화면 왼쪽에 표시되는 메뉴 항목을 다르게 합니다.
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods(); //베스트셀러,신간,스테디셀러 정보를 조회해 Map에 저장합니다.
		mav.addObject("goodsMap", goodsMap); // main.jsp로  상품 정보를 전달합니다.
		return mav; //main.jsp로 포워딩한다. 
	}
}
