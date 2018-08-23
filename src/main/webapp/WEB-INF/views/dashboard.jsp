<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>이채원 final</title>
 </head>
 <body class="cyan">
   <div class="box bg-1">
		<button class="button button--winona button--border-thin button--round-s" id='person' data-text="개인 권한 관리"><span>개인 권한 관리</span></button>
		<br><button class="button button--winona button--border-thin button--round-s" id='group' data-text="그룹 권한 관리"><span>그룹 권한 관리</span></button>
		<br><button class="button button--winona button--border-thin button--round-s"  id='personGroup' data-text="개인 그룹 맵핑"><span>개인 그룹 맵핑</span></button>
		<br><button class="button button--winona button--border-thin button--round-s"  id='team' data-text="부서 그룹 맵핑"><span>부서 그룹 맵핑</span></button>
		<br><button class="button button--winona button--border-thin button--round-s"  id='inherit' data-text="상속 관리"><span>상속 관리</span></button>
	</div>
  <script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
  <script>
			(function() {
				var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
				if(isSafari) {
					document.getElementById('support-note').style.display = 'block';
				}
			})();
			
			  document.getElementById('person').addEventListener('click', function( e ){
				  e.preventDefault();
				  window.location.href="/personal";
			  });
			  
			  document.getElementById('group').addEventListener('click', function( e ){
				  e.preventDefault();
				  window.location.href="/group";
			  });
			  
			  document.getElementById('team').addEventListener('click', function( e ){
				  e.preventDefault();
				  window.location.href="/teamGroup";
			  });
			  
			  document.getElementById('personGroup').addEventListener('click', function( e ){
				  e.preventDefault();
				  window.location.href="/personGroup";
			  });

		</script>
 </body>
</html>