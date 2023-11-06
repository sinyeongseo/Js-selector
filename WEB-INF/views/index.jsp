<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 화면 페이지</title>
<style type="text/css">
	* {
		text-align:center;
		background-size: contain;
	}
	body{
		width:700px;
		 margin: 0 auto;
		text-align:center;
	}
	#fixed, #canvasContatiner{
		width:750px;
		margin: 0 auto;
		height: 650px;
		background-color:#bddbfa;
	}
	#button {
		text-align:center;
		width:700;
	}
	button {
		box-shadow:inset 0px 1px 0px 0px #dcecfb;
		background:linear-gradient(to bottom, #bddbfa 5%, #80b5ea 100%);
		background-color:#bddbfa;
		border-radius:5px;
		border:1px solid #84bbf3;
		display:inline-block;
		cursor:pointer;
		color:#ffffff;
		font-family:Arial;
		font-size:15px;
		font-weight:bold;
		padding:6px 24px;
		text-decoration:none;
		text-shadow:0px 1px 0px #528ecc;
	}
	a {
		text-decoration: none;
	}
	#snow {
		color:white;
	}
	.highlighted {
   		background-image:url('/images/index.gif');
  		border: 2px solid white;
    }
</style>
</head>
<body>
<script type="text/javascript" charset="UTF-8">
var idCounter = 1;//전역 변수로 선언하여 값이 증가되도록 선언
function AddElement(){
	  	var url = '<%= request.getContextPath()%>/add.do';
		//프로젝트 Path만 가져온다.
		fetch(url)//서버에 요청이 알맞게 왔을 경우
		.then(function(response) {
            if (!response.ok) {
                throw new Error('Network response was not ok.');
            }
            return response.json(); // JSON으로 파싱하여 promise 객체를 반환
        })
        .then(function(data) {        	
            const newDiv = document.createElement('div');// 서버에서 응답한 데이터로 <div> 태그를 생성하고 id 값을 부여합니다.
            newDiv.id = 'element' + idCounter;
            newDiv.innerHTML = 'element' + idCounter+ '<br>'+ data.jsonString;
            const canvasContainer = document.getElementById("canvasContatiner");  
	        canvasContainer.appendChild(newDiv);// 부모 요소에 새로운 div 추가
            function MoveElementClosure(idCounter) {  //idcounter 값을 받아서 MoveElement로 넘겨줌
                return function () {
                  MoveElement(idCounter);
                };
              }
            const button = document.createElement('button'); //버튼 생성
            button.innerHTML = 'element' + idCounter; //몇번째 요소인지 나타냄
            button.addEventListener('click', MoveElementClosure(idCounter)); //클릭시 idcounter 값을 올바르게 넘기기
            const fixedButton = document.getElementById('button'); //div button 부분에 요소들 가져옴
            fixedButton.appendChild(button); //요소들 추가해줌
           	
            idCounter++; //idCounter 값 증가
        })
        .catch(function(error){
            console.error('Error:', error); // 오류 처리
        });
}
function DeleteElement() { //초기화 하는 함수 작성하기
		var ele = document.getElementById('canvasContatiner'); //fixed 안에 있는 요소들을 가져옴
		var eleCount = ele.childElementCount; // 그안에 있는 자식 요소들의 개수를 셈
		ele.innerHTML=""; //요소들을 초기화 시킴
		
		var elebt = document.getElementById('button'); //div button 안에 있는 요소들을 가져옴
		elebt.innerHTML=""; //요소들을 초기화 시킴
		
		var final = "요소들을 총 " + eleCount +"개 초기화 했습니다.";
		const divElement = document.getElementById("canvasContatiner");
		divElement.innerHTML = final;   //총 몇개를 초기화했는지 문구를 띄워줌
		
		if(eleCount == 0){
			ele.innerHTML=""; 
		}
}

function MoveElement(idCounter){
	 const targetElement = document.getElementById('element' + idCounter); //id 값이 동일한 요소 가져오기
	  if (targetElement) { // 동일한 요소가 있다면
		  targetElement.scrollIntoView({ behavior: 'smooth' });	//브랴우저 화면에 보이도록 스크롤을 부드럽게 이동하도록 설정
	    const highlightedElement = document.querySelector('.highlighted');	//class 선택자를 통해서 클래스 값 들을 가져와서 변수에 저장
	    if (highlightedElement) { //해당 요소가 있다면
	      highlightedElement.classList.remove('highlighted'); //요소가 highlighted 클래스가 있는 경우 클래스를 제거해줌
	    } 
	    targetElement.classList.add('highlighted');// 해당 요소에 강조 클래스를 통해 효과 추가
	  }
}
</script>
	<br><br>
	<button id="add" onclick="AddElement()">요소 추가 </button> &nbsp; &nbsp; &nbsp;
	<button id="initial" onclick="DeleteElement()">초기화</button>

	<p>☃&nbsp; &nbsp; &nbsp;이곳에 HTML 요소들이 랜덤 출력됩니다.&nbsp; &nbsp; &nbsp;☃</p>
	<p>。゜ ・。。゜・。❄゜゜・ 。゜・ ❄゜・。❄゜❄ ゜・。❄゜ ゜。゜・・❄゜・。゜❄゜ ゜゜。。゜・。。。゜・ 。❄・❄゜゜・</p>
	
	<!-- <img style="height: 100%; margin: 0;" src='/images/view1.jpg' alt="My Image"> -->
	<div id="fixedarea">
	<p>고정된 영역</p>
	<hr>
		<div id="canvasContatiner" style="max-height: 700px;max-width:700px;overflow: scroll;">
				
		</div>
	<hr>
		<div id="button">				
		
		
		
		
		
		
		
		
		
		</div>	
	</div>

</body>
</html>