<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDto"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 목록</title>
</head>
<body>
	<%
		String sql = "SELECT * FROM board ORDER BY bnum DESC"; //게시판 목록이 글번호 내림차순으로 정렬
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/boardtest"; //마지막 자리는 테이블이 아닌 스키마 이름
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardDto> boardlist = new ArrayList<BoardDto>();
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int bnum = rs.getInt("bnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bwriter = rs.getString("bwriter");
				int bhit = rs.getInt("bhit");
				String bdate = rs.getString("bdate");
				
				BoardDto bdto = new BoardDto(bnum, btitle, bcontent, bwriter, bhit, bdate);
				boardlist.add(bdto);
			}
			
			request.setAttribute("boardList", boardlist);
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
		}
		
		}	
	%>
	
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="bDto" items="${boardList}">
				<tr>
					<td>${bDto.bnum}</td>
					<td>
						<a href="boardview.jsp?bnum=${bDto.bnum}">
							<c:choose>
								<c:when test="${fn:length(bDto.btitle)>20}">
									${fn:substring(bDto.btitle,0,21)}...
								</c:when>
								<c:otherwise>
									${bDto.btitle}
								</c:otherwise>
							</c:choose>
						</a>
					</td>
					<td>${bDto.bwriter}</td>
					<td>${bDto.bhit}</td>
					<td>
					${fn:substring(bDto.bdate,0,10)}
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<input type="button" value="글쓰기" onclick="location.href='boardwrite.jsp'">
</body>
</html>