<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath %>">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Insert title here</title>
    <style>
        body { background: #ffffff; color: #444;font-size:12px; }
        a { color: #07c; text-decoration: none; border: 0; background-color: transparent; }
        body, div, q, iframe, form, h5 { margin: 0; padding: 0; }
        img, fieldset { border: none 0; }
        body, td, textarea { word-break: break-all; word-wrap: break-word; line-height:1.6; }
        body, input, textarea, select, button { margin: 0; font-size: 12px; font-family: Tahoma, SimSun, sans-serif; }
        div, p, table, th, td { font-size:1em; font-family:inherit; line-height:inherit; }
        h5 { font-size:12px; }
        ol li,ul li{ margin-bottom:0.5em;}
        pre, code { font-family: "Courier New", Courier, monospace; word-wrap:break-word; line-height:1.4; font-size:12px;}
        pre{background:#f6f6f6; border:#eee solid 1px; margin:1em 0.5em; padding:0.5em 1em;}
        #content { padding-left:50px; padding-right:50px; }
        #content h2 { font-size:20px; color:#069; padding-top:8px; margin-bottom:8px; }
        #content h3 { margin:8px 0; font-size:14px; COLOR:#693; }
        #content h4 { margin:8px 0; font-size:16px; COLOR:#690; }
        #content div.item { margin-top:10px; margin-bottom:10px; border:#eee solid 4px; padding:10px; }
        hr { clear:both; margin:7px 0; +margin: 0;
            border:0 none; font-size: 1px; line-height:1px; color: #069; background-color:#069; height: 1px; }
        .i nfobar { background:#fff9e3; border:1px solid #fadc80; color:#743e04; }
        .buttonStyle{width:64px;height:22px;line-height:22px;color:#369;text-align:center;background:url(${basePath}plugins/zDialog/images/buticon.gif) no-repeat left top;border:0;font-size:12px;}
        .buttonStyle:hover{background:url(${basePath}plugins/zDialog/images/buticon.gif) no-repeat left -23px;}

    </style>

</head>
<body >
<div id="forlogin">
    <table width="100%" border="0" align="center" cellpadding="4" cellspacing="4" bordercolor="#666666">
        <tr>
            <td colspan="2" bgcolor="#eeeeee">????????????</td>
        </tr>
        <tr>
            <td width="150" align="right">????????????:</td>
            <td><input type="text" id="password" /></td>
        </tr>
        <tr>
            <td align="right">????????????:</td>
            <td><input type="text" id="tpassword" /></td>
        </tr>
        <tr>
            <td colspan="2" align="left" style="padding-left:160px;">
                <input type="button" onClick="doSave()" value="??????" class="buttonStyle" />
                <input onClick="dialogClose();" class="buttonStyle" type="button" value="??????" />
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript" src="<%=basePath%>static/js/jquery-1.8.3.js"></script>
<!-- ??????JQuery????????? start-->
<script type="text/javascript" src="<%=basePath%>static/js/jquery.tips.js"></script>
<!-- ??????JQuery????????? end-->
<script type="text/javascript" src="<%=basePath%>plugins/zDialog/zDialog.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/zDialog/zDrag.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/zDialog/zProgress.js"></script>
<script type="text/javascript">

    function dialogClose()
    {
        parentDialog.close();
    }

    function doSave() {
        var password = $("#password").val();
        var tpassword = $("#tpassword").val();
        if ($.trim(password) == '' || $.trim(tpassword) == '') {
            alert("???????????????!");
            return;
        }

        if( $.trim(password) != $.trim(tpassword) ) {
            alert("????????????????????????!");
            return;
        }

        $.ajax({
            type: "POST",
            url: 'user/updatePwd/${username}/'+password,
            dataType:'json',
            cache: false,
            success: function(data){
                if("success" == data.result){
                    alert('????????????!');
                    parent.location.reload();
                    doDialogClose();
                }else{
                    $("#password").tips({
                        side : 1,
                        msg : "????????????!",
                        bg : '#FF5080',
                        time : 15
                    });
                }
            }
        });
    }

</script>
</body>
</html>