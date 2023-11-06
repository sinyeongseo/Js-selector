package com.spring.solinsystem;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller	
public class DevController{
	
	//GET 페이지로 이동
	@RequestMapping("/")
	public String main() {
		
		return "index";
	}

	@RequestMapping(value ="/add.do", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
		@ResponseBody
		public String elementadd() throws UnsupportedEncodingException {
		  	List<String> content = new ArrayList<>(); //html 내의 모든 내용 저장하는 리스트
		  	List<String> contentDiv = new ArrayList<>(); //html 내용 중 div 요소만 저장하는 list
		  	
			String[] htmlList = {"view1","view2","view3","view4"}; //리스트에 html파일 이름 저장
			int htmlLength = htmlList.length;
			Random random = new Random(); //랜덤함수 호출
			int RandomIndex = random.nextInt(htmlLength); //랜덤으로 html 이름 가져오기
			
			ClassPathResource resource = new ClassPathResource("templates/"+htmlList[RandomIndex]+".html");
			//html 경로 resource 가져오기
			try {
				    Path path = Paths.get(resource.getURI()); //경로 가져오기
				    content = Files.readAllLines(path); //경로에 대한 모든 줄을 content list에 저장  
				        
				    Pattern pattern = Pattern.compile("<div\\b[^>]*>(.*?)</div>"); //패턴 정의
				    for (String line : content) { //content에 있는 값들을 line에 대입하여 읽음
			            Matcher matcher = pattern.matcher(line); //line을 패턴과 맞춰봄
			            while (matcher.find()) { //패턴과 맞다면
			                String divTag = matcher.group(1);// 일치하는 패턴 중 첫 번째 그룹을 가져옴
			                contentDiv.add(divTag); //contentDiv 리스트에 넣어줌
			            }
			        }
				} catch (IOException e) {
				    System.out.println("오류가 발생했습니다");
				}

			  if (!contentDiv.isEmpty()) {
		            int randomIndex = random.nextInt(contentDiv.size()); //contenDiv 리스트 사이즈 내에서 랜덤으로 index 값 가져오기
		            String randomElement = contentDiv.get(randomIndex); //index값에 대한 값 가져오기
		            String jsonString = "{\"jsonString\": \"" + randomElement + "\"}"; //JSON 문자열 준비
		            // JSON 형식으로 응답
		            return jsonString;
		        } else {
		            // 요소가 없을 경우 빈 문자열 반환
		        	System.out.println("요소가 없음");
		            return "";
		        }
			}
}
