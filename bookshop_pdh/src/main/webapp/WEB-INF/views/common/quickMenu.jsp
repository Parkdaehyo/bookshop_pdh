<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<script>
	var array_index=0;
	var SERVER_URL="${contextPath}/thumbnails.do";
	
	//빠른 메뉴의 다음 클릭 시 <hidden>태그에 저장된 상품 정보를 가져와 이미지를 표시합니다
	function fn_show_next_goods(){ //퀵메뉴의 다음 상품
		var img_sticky=document.getElementById("img_sticky"); //109, 썸네일에 대한 이미지
		var cur_goods_num=document.getElementById("cur_goods_num");
		var _h_goods_id=document.frm_sticky.h_goods_id; //form 태그안에 h.goods_id를 가져온다.
		var _h_goods_fileName=document.frm_sticky.h_goods_fileName; //103번
		
		//다음 클릭 시 배열의 인덱스를 1 증가시킵니다.
		if(array_index <_h_goods_id.length-1) //hideen 배열
			array_index++;
		
		//증가된 인덱스에 대한 배열 요소의 상품 번호와 이미지 파일 이름을 가져와 표시합니다.
		var goods_id=_h_goods_id[array_index].value;
		var fileName=_h_goods_fileName[array_index].value;
		img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
		cur_goods_num.innerHTML=array_index+1;
	}


 function fn_show_previous_goods(){ //이전 상품
	var img_sticky=document.getElementById("img_sticky");
	var cur_goods_num=document.getElementById("cur_goods_num");
	var _h_goods_id=document.frm_sticky.h_goods_id;
	var _h_goods_fileName=document.frm_sticky.h_goods_fileName;
	
	if(array_index >0)
		array_index--;
	
	var goods_id=_h_goods_id[array_index].value;
	var fileName=_h_goods_fileName[array_index].value;
	img_sticky.src=SERVER_URL+"?goods_id="+goods_id+"&fileName="+fileName;
	cur_goods_num.innerHTML=array_index+1;
}

function goodsDetail(){
	var cur_goods_num=document.getElementById("cur_goods_num");
	arrIdx=cur_goods_num.innerHTML-1;
	
	var img_sticky=document.getElementById("img_sticky");
	var h_goods_id=document.frm_sticky.h_goods_id;
	var len=h_goods_id.length;
	
	if(len>1){
		goods_id=h_goods_id[arrIdx].value;
	}else{
		goods_id=h_goods_id.value;
	}
	
	
	var formObj=document.createElement("form");
	var i_goods_id = document.createElement("input"); 
    
	i_goods_id.name="goods_id";
	i_goods_id.value=goods_id;
	
    formObj.appendChild(i_goods_id);
    document.body.appendChild(formObj); 
    formObj.method="get";
    formObj.action="${contextPath}/goods/goodsDetail.do?goods_id="+goods_id;
    formObj.submit();
	
	
}
</script>  
 
<body>    
    <div id="sticky" >
	<ul>
		<li><a href="#">
		   <img	width="24" height="24" src="${contextPath}/resources/image/naver.jpg">
				네이버
		</a></li>
		<li><a href="#">
		   <img width="24" height="24" src="${contextPath}/resources/image/twitter_icon.png">
			트위터
		</a></li>
		<li><a href="#">
		   <img	width="24" height="24" src="${contextPath}/resources/image/youtube.jpg">
				유튜브
		 </a></li>
	</ul>
	<div class="recent">
		<h3>최근 본 상품</h3>
		  <ul>
		<!--   상품이 없습니다. --> <!-- c:choose 조건문여는 신호탄 --> <!--  when은 if문 -->
		 <c:choose> 
			<c:when test="${ empty quickGoodsList }"> 
				     <strong>상품이 없습니다.</strong>
			</c:when>
			<c:otherwise> <!-- else문 -->
	       <form name="frm_sticky"  >	
	     
		      <c:forEach var="item" items="${quickGoodsList }" varStatus="itemNum">    <%-- 세션에 저장된 빠른 메뉴 목록의 이미지 정보를 <hidden> 태그에 차례대로 저장합니다. --%>       
		         <c:choose>
		           <c:when test="${itemNum.count==1 }"> 
			      <a href="javascript:goodsDetail();">
			  	         <img width="75" height="95" id="img_sticky"  	<%-- 썸네일에 대한 이미지 --%>
			                 src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
			      </a>
			      
			        <input type="hidden"  name="h_goods_id" value="${item.goods_id}" /> <%-- 동일한 <hidden> 태그에 연속해서 저장하면 배열로 저장됩니다. --%>
			        <input type="hidden" name="h_goods_fileName" value="${item.goods_fileName}" />
			      <br>
			      </c:when>
			      <c:otherwise>
			        <input type="hidden"  name="h_goods_id" value="${item.goods_id}" />
			        <input type="hidden" name="h_goods_fileName" value="${item.goods_fileName}" />
			      </c:otherwise>
			      </c:choose>
		     </c:forEach>
		   </c:otherwise>
	      </c:choose>
		 </ul>
     </form>		 
	</div>
	 <div>
	 <c:choose>
	    <c:when test="${ empty quickGoodsList }">
		    <h5>  &nbsp; &nbsp; &nbsp; &nbsp;  0/0  &nbsp; </h5>
	    </c:when>
	    <c:otherwise>
           <h5><a  href='javascript:fn_show_previous_goods();'> 이전 </a> &nbsp;  <span id="cur_goods_num">1</span>/${quickGoodsListNum}  &nbsp; <a href='javascript:fn_show_next_goods();'> 다음 </a> </h5>
       </c:otherwise>
       </c:choose>
    </div>
</div>
</body>
</html>
 
