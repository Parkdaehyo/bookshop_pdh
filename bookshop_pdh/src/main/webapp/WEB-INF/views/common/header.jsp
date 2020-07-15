<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<script type="text/javascript">

	var loopSearch=true; //제시된 키워드를 클릭하면 keywordSearch()함수의 실행을 중지시킵니다?
	function keywordSearch(){
		if(loopSearch==false)
			return;
	 var value=document.frmSearch.searchWord.value; //form.searchWord의 각각의 값을 변수에 저장.
		$.ajax({
			type : "get",
			async : true, //false인 경우 동기식으로 처리한다.
			url : "${contextPath}/goods/keywordSearch.do", //searchWord를 여기로 보낸다.
			data : {keyword:value}, //value값이 searhword
			
			success : function(data, textStatus) {
			    var jsonInfo = JSON.parse(data); //JSON.parse(data): 전송된 데이터를 JSON으로 파싱합니다. jsonInfo == keywordList
				displayResult(jsonInfo); //전송된 JSON 데이터를 표시합니다.
			},
			error : function(data, textStatus) {
				alert("에러가 발생했습니다."+data);
			},
			complete : function(data, textStatus) {
				//alert("작업을완료 했습니다");
				
			}
		}); //end ajax	
	}
	
	function displayResult(jsonInfo){
		var count = jsonInfo.keyword.length; //JSON 데이터 개수를 구합니다.
		if(count > 0) {
		    var html = '';
		    //JSON데이터를 차례대로 <a>태그를 이용해 키워드 목록을 만듭니다.
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    //<a>태그로 만든 키워드 목록을 <div>태그에 차례대로 표시합니다.
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword; //검색창에 입력한 내용
		 loopSearch = false;
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}

</script>
<body>
	<div id="logo">
	<a href="${contextPath}/main/main.do">
		<img width="176" height="80" alt="booktopia" src="${contextPath}/resources/image/Booktopia_Logo.jpg">
		</a>
	</div>
	<div id="head_link">
		<ul>
		   <c:choose>
		     <c:when test="${isLogOn==true and not empty memberInfo }"> <%-- 로그인시 '로그아웃'을 표시합니다. --%>
			   <li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
			   <li><a href="${contextPath}/mypage/myPageMain.do">마이페이지</a></li>
			   <li><a href="${contextPath}/cart/myCartList.do">장바구니</a></li>
			   <li><a href="#">주문배송</a></li>
			 </c:when>
			 <c:otherwise> <%-- 로그아웃 시 '로그인'을 표시합니다. --%>
			   <li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
			   <li><a href="${contextPath}/member/memberForm.do">회원가입</a></li> 
			 </c:otherwise>
			</c:choose>
			
			   <li><a href="#">고객센터</a></li>
			   <%-- 관리자로 로그인시 '관리자'를 표시합니다. --%>
      <c:if test="${isLogOn==true and memberInfo.member_id =='admin' }">  
	   	   <li class="no_line"><a href="${contextPath}/admin/goods/adminGoodsMain.do">관리자</a></li>
	    </c:if>
			  
		</ul>
	</div>
	<br>
	<div id="search" >
	
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do" >
																	<!--  키를 눌렀다가 땠을때 이벤트 -->
			<input name="searchWord" class="main_input" type="text"  onKeyUp="keywordSearch()"> 
			<input type="submit" name="search" class="btn1"  value="검 색" >
		</form>
	</div>
   <div id="suggest">
        <div id="suggestList"></div>
   </div>
</body>
</html>