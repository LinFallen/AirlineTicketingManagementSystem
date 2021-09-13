<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.jmu.po.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>机票查询</title>
<link rel="stylesheet" type="text/css" href="../css/rules.css">
</head>
<body>
<% if(session.getAttribute("user")==null){%><jsp:forward page="exit2.do"></jsp:forward><%}
   if(request.getAttribute("rule")==null){request.getRequestDispatcher("outputRule.do").forward(request,response);}
	User user = (User) session.getAttribute("user");
%>
<div id="header">
	<a href="user.jsp"><img alt="brand" src="../img/brand.png"></a>
	<sapn id="personal">
		<label><%=user.getUserName()%></label>&nbsp;&nbsp;
		<a href="exit.do" onclick="exit()">注销</a>	
	</span>
</div>

<div id="menubar">
	<div class="dropdown">
		<a href="user.jsp"><button class="dropbt">首页</button></a>
	</div>	

	<div class="dropdown">
		<button class="dropbt">云朵会员</button>
		<div class="content">
			<a href="myAccount.jsp">我的账户</a>
			<a href="myOrder.jsp">我的订单</a>

		</div>
	</div>
	<div class="dropdown">
		<button class="dropbt">出行帮助</button>
		<div class="content">
			<a href="outputRule.do">购票服务</a>

		</div>
	</div>
<hr>
</div>
<div id="middle">
	<h3>票务规则</h3>
	<textarea readonly="readonly">${rule.getRuleContext()}</textarea>
</div>

</body>
</html>