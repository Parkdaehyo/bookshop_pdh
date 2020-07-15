<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"	isELIgnored="false"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>  

<div id="ad_main_banner">
	<ul class="bjqs">	 	
	  <li><img width="775" height="145" src="${contextPath}/resources/image/main_banner01.jpg"></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/math2.jpg"></li>
		<li><img width="775" height="145" src="${contextPath}/resources/image/main_banner03.jpg"></li> 
	</ul>
</div>
<div class="main_book">
	
	<%-- goods_count == 0 --%>
   <c:set var="goods_count" value="0" />
   
	<h3>중고 도서</h3>
	<%-- goodsMap에.bestseller(goodsList)는 item에 하나씩 담습니다.--%>
	<c:forEach var="item" items="${goodsMap.bestseller }"> <%-- 베스트 셀러를 표시합니다. --%>
	   <c:set  var="goods_count" value="${goods_count+1 }" /> <%-- item이 담겨서 for문을 돌때마다 count에 숫자를 부여합니다. --%>
		<div class="book">
		
			<%-- 이미지 클릭시 상품 상세 페이지로 넘어갑니다. --%>  
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }"> <%-- t_shoppings_goods --%>
			<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
			</a> 
			
			<%-- 썸네일 이미지를 표시합니다. --%>
										<!--  FiledownloadController  -->
										<!--  goods_fileName 부분은 다시 복습할것 -->
				<img width="121" height="154"                                             
				     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
		</div>
		
		<%-- goods_count4ㅏ 15면 --%>
	   <c:if test="${goods_count==15   }">
         <div class="book">
           <font size=20> <a href="#">more</a></font> <%-- more를 표시한다. --%> 
         </div>
     </c:if>
     
  </c:forEach>
</div>
<div class="clear"></div>
<div id="ad_sub_banner">
	<img width="770" height="117" src="${contextPath}/resources/image/sub_banner01.jpg">
</div>
<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3>새로 출판된 책</h3>
	<c:forEach var="item" items="${goodsMap.newbook }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
		<div class="book">
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="121" height="154" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="book">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>

<div class="clear"></div>
<div id="ad_sub_banner">
	<img width="770" height="117" src="${contextPath}/resources/image/sub_banner02.jpg">
</div>


<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3>스테디셀러</h3>
	<c:forEach var="item" items="${goodsMap.steadyseller }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
	   
		<div class="book">
		<%-- 이미지 클릭시 상품 상세 페이지로 넘어갑니다. --%>
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
	      <%-- 썸네일 이미지를 표시합니다 --%>
		 <img width="121" height="154" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price">
		    <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		       ${goods_price}원
		  </div>
	</div>
	 <c:if test="${goods_count==15   }"> <%-- 베스트셀러가 15개 이상이면 16번째 이미지에는 more를 표시합니다 --%>
     <div class="book">
       <font size=20> <a href="#">more</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>

   
   