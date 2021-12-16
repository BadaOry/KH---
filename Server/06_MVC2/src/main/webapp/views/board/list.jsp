<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/views/common/header.jsp" />

<style>
	section#board-list-container{width:600px; margin:0 auto; text-align:center;}
	section#board-list-container h2{margin:10px 0;}
	table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
	table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;} 
	/*글쓰기버튼*/
	input#btn-add{float:right; margin: 0 0 15px;}
	/*페이지바*/
	div#pageBar{margin-top:10px; text-align:center; background-color:rgba(0, 188, 212, 0.3);}
</style>
<section id="content">
	<h2 align="center">게시판 </h2>
	<div id="board-list-container">
		<!-- ▼ 로그인이 된 클라이언트에게만 글쓰기 버튼을 보여주는 c:if -->
		<c:if test="${ !empty loginMember }">
			<button type="button" id="btn-add"
				onclick="location.href='${ pageContext.request.contextPath }/board/write'">글쓰기</button>
		</c:if>
	
		<table id="tbl-board">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>첨부파일</th>
				<th>조회수</th>
			</tr>
			<!-- ▼ 한 페이지에 올라갈 글이 list 에 담겨서 넘어온 값이 null 일 경우의 c:if  -->
			<c:if test="${ empty list }">
				<tr>
					<td colspan="6">
						조회된 게시글이 없습니다.
					</td>
				</tr>	
			</c:if>
			<!-- ▼ 한 페이지에 올라갈 글이 list 에 담겨서 넘어온 값이 있는 경우의 c:if
			       ▷ 게시글이 여러개 있으니 forEach 반복문으로 사용  -->
			<c:if test="${ !empty list }">
				<c:forEach var="board" items="${ list }">
					<tr>
						<td>${ board.no }</td>
						<td>
							<a href="${ pageContext.request.contextPath }/board/view?no=${ board.no }">
								${ board.title }
							</a>
						</td>
						<td>${ board.writerId }</td>
						<td>${ board.createDate }</td>
						<!-- ▼ 첨부파일 있으면 아이콘, 없으면 - 보여주는 코드   -->
						<td>
							<c:if test="${ empty board.originalFileName }">
								<span> - </span>
							</c:if>
							<c:if test="${ !empty board.originalFileName }">
								<img src="${ pageContext.request.contextPath }/resources/images/file.png" width="20" height="20"/>
							</c:if>
						</td>
						<td>${ board.readCount }</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div id="pageBar">
			<!-- 맨 처음으로 : href 값에서 page=1을 주면 맨 처음 페이지로 갈 수 있음 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/board/list?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 : href 값에서 EL 문으로 pageInfo의 prevPage 메소드를 호출하면 됨-->

			<button onclick="location.href='${ pageContext.request.contextPath }/board/list?page=${ pageInfo.prevPage }'">&lt;</button>

			<!--  10개 페이지 목록 
			        : 현재 페이지는 disabled 로 만들고 싶음 
			          ▷ forEach 사용하여 첫 번쨰 페이지 부터 마지막 페이지까지의 버튼을 반복문으로 그려줄 것임
			          
			-->
			
			<c:forEach begin="${ pageInfo.startPage }" end ="${ pageInfo.endPage }" varStatus="status">
				<!-- ▼ 현재 페이지가 pageInfo 에서 가져온 currentPage 와 같으면 해당 버튼을 disabled 시키는 코드 -->
				<c:if test="${ status.current == pageInfo.currentPage }">
					<button disabled>${ status.current }</button>
				</c:if>
				<c:if test="${ status.current != pageInfo.currentPage }">
					<button onclick="location.href='${ pageContext.request.contextPath}/board/list?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>
		

			<!-- 다음 페이지로 : href 값에서 EL 문으로 pageInfo의 nextPage 메소드를 호출하면 됨-->
			<button onclick="location.href='${ pageContext.request.contextPath }/board/list?page=${ pageInfo.nextPage }'">&gt;</button>

			<!-- 맨 끝으로 : href 값에서 EL 문으로 pageInfo의 maxPage 메소드를 호출하면 됨 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/board/list?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />