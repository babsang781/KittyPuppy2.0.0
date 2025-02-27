<%@page import="com.kittypuppy.model.AnimalDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kittypuppy.model.AnimalDAO"%>
<%@page import="com.kittypuppy.model.MemberDTO"%>
<%@page import="com.kittypuppy.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <title>KittyPuppy</title>
    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@00&display=swap" rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css2? family=Gowun+Dodum&family=IBM+Plex+Sans+KR&family=Noto+Sans+KR&display=swap"
        rel="stylesheet">
    <!-- 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="js/bootstrap.min.js"></script>

    <style>
    
           body {
            font-family: 'IBM Plex Sans KR', sans-serif;
            background-color: #ffffff;
            font-size: 10px;
            color: #25aa90;
            display: flex;
            /* padding: 15px;
            margin: auto; */
        }

        .container {
            width: 360px;
            min-width: 360px;
            margin: auto;
        }

        @media (min-width: 992px) {
            .img-thumbnail {
                max-width: 100px;
                max-height: 100px;
            }

            
        }

        .container p {
            text-align: center;
            font-size: 12px;
        }

        .container h3 {
            text-align: center;
            color: #25aa90;
            margin-top: 8%;
            margin-bottom: 8%;
        }

        .btn {
            background-color: #25aa90;
            color: #fff;
        }

        html,
        body {
            height: 100%;
        }
        
        textarea{
        	height: 38px;
        }
        
        .col-2 > a{
        	margin-top: 8%;
            margin-bottom: 8%;
        }
        
        

        
    </style>

</head>
<body>
<%
	MemberDAO dao = new MemberDAO();
	MemberDTO member = (MemberDTO)session.getAttribute("member");
	String nick = member.getNick();
	
	// 수정하고싶은 반려동물 이름 받아오기
	String animalName = request.getParameter("animalName");

	AnimalDAO animal = new AnimalDAO();
	ArrayList<AnimalDTO> aniList = animal.aniShowAll(nick);
	AnimalDTO ani = null;
	for(int i = 0; i < aniList.size(); i++){
		if(aniList.get(i).getAnimalName().equals(animalName)){
			ani = aniList.get(i);
		}
	}
	
	pageContext.setAttribute("ani", ani);
%>
 <div class="container out">
 
 <form action="AniUpdateCon.do" method="post" enctype="multipart/form-data">

        <div class="row">


            <div class="d-grid gap-0 col-12 mx-auto">

                <div class="row">
                    <!-- 뒤로가기 아이콘 -->
                    <div class="col-2 py-4">
                        <a href="mypage.jsp" class=""><!-- 마이페이지 이동 -->
                        <i class="bi bi-chevron-left"
                                style="font-size: 2rem; color:#25aa8f7e ; align-items: center;"></i></a>
                            
                       
                    </div>

                    <div class="col-8 g-3" style="color:#25aa90;">
                        <h3> 반려동물수정</h3>
                    </div>
                    <!-- 아래 col-2가 있어야 text가 중앙으로 올수 있음 -->
                    <div class="col-2">
                        <h3> </h3>
                    </div>

                </div>
                <br>
                <!-- 프로필 사진 바꾸기 -->

                <!-- 원형 사진을 클릭하여 사진을 업로드 -->

                <div class="text-center ">
                     <!-- 사진업로드 이동 -->
                    <label class="btn btn-default" style="background-color: white;">
                        <img src="${ani.animalPic }"
                            class="avatar rounded-circle img-thumbnail" alt="avatar" style="width: 100px; height:100px;"
                            onerror="this.onerror=null; this.src='https://cdn.pixabay.com/photo/2018/11/13/21/43/instagram-3814049_960_720.png';"> <input
                            type="file" name="animalPic" hidden></i>
                    </label>

                    

                    <br>
                    <p>반려동물 사진 바꾸기</p>

                </div>



                <!-- 정보 변경 -->
                <!-- 닉네임 자동으로 채워지기 -->
                <textarea class="form-control mb-3" name="nick" readonly>${ani.nick }</textarea>
                <textarea class="form-control mb-3" name="animalName">${ani.animalName }</textarea>

                <div class="mb-3">

                    <select id="upKind" class="form-select" name="upKind">
                        <option>반려동물 대분류</option>
                        <option value="고양이">고양이</option>
                        <option value="개">개</option>
                        <option value="동물">동물</option>
                        <!--  <option value=""></option> 추가 하면 됨 -->

                    </select>
                </div>

                <div class="mb-3">
					<textarea class="form-control" name="kind">${ani.kind }</textarea>
                </div>


                <div class="mb-3">

                    <select id="animalSex" class="form-select" name="animalSex">
                        <option>성별</option>
                        <option value="암">암컷</option>
                        <option value="수">수컷</option>
                        <!--  퍼피유에 여아 남아로 되어 있음 -->
                    </select>
                </div>
				<textarea class="form-control mb-3" id = 'inputPhone' name="animalAge">${ani.animalAge }</textarea>
				<c:choose>
					<c:when test="${ani.animalProfile eq 'null'}">
						<textarea class="form-control mb-3" name="animalProfile">   </textarea>
					</c:when>
					<c:otherwise>
						<textarea class="form-control mb-3" name="animalProfile">${ani.animalProfile }</textarea>
					</c:otherwise>
				</c:choose>
				


            </div>


            <div class="d-grid gap-2 col-12 mx-auto">
                <button type="submit" class="btn" style="background-color: #25aa90;">완료</button>

            </div>

        </div>
</form>
    </div>

	<script src='jquery-3.6.0.min.js'></script>
	<script>
	
		if("${ani.upKind}" == "고양이"){
			$("#upKind").val("고양이").prop("selected",true);
		}else if("${ani.upKind}" == "개"){
			$("#upKind").val("개").prop("selected",true);
		}else{
			$("#upKind").val("동물").prop("selected",true);
		}
		
		if("${ani.animalSex}" == "수"){
			$("#animalSex").val("수").prop("selected",true);
		}else if("${ani.animalSex}" == "암"){
			$("#animalSex").val("암").prop("selected",true);
		}
		
	    // 숫자가 아닌 값 지우기
	    var replaceNotInt = /[^0-9]/gi;
	    
	    $(document).ready(function(){
	        
	        $("#inputPhone").on("focusout", function() {
	            var x = $(this).val();
	            if (x.length > 0) {
	                if (x.match(replaceNotInt)) {
	                   x = x.replace(replaceNotInt, "");
	                }
	                $(this).val(x);
	            }
	        }).on("keyup", function() {
	            $(this).val($(this).val().replace(replaceNotInt, ""));
	        });
	 
	    });
	 
	</script>

</body>
</html>