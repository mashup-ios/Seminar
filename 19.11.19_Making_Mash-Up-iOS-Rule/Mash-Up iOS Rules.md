# Making Mash-Up iOS Rules!

해커톤을 시작하기 앞서 우리만의 룰을 간단하게 정리해보자

## Code

### SwiftLint를 사용하자

프로젝트 내에서 혹은 프로젝트 간의 일관성 유지를 용이하게 하고, 여러명의 사람이 작업을 할 때 효율적이다.



```swift
pod 'SwiftLint'
```

이후에 root folder 에 .swiftlint.yml 이라는 파일을 만들어서 설정을 한다.

``` swift
touch .swiftlint.yml
// touch 라는 명령어를 터미널에 입력하면 파일이 생성됩니다.
```

설정에 필요한 파라미터는 다음과 같다. 필요한 부분만 설정해준다. 

- `disabled_rules`: Disable rules from the default enabled set.
- `opt_in_rules`: Enable rules not from the default set.
- `whitelist_rules`: Acts as a whitelist, only the rules specified in this list will be enabled. Can not be specified alongside `disabled_rules` or `opt_in_rules`.
- `analyzer_rules`: This is an entirely separate list of rules that are only run by the `analyze` command. All analyzer rules are opt-in, so this is the only configurable rule list (there is no disabled/whitelist equivalent).
- 그외 내가 포함시킬 혹은 제외할 파일을 설정할 때에는 다음과 같은 파라미터를 통해서 설정한다.
  - `included`
  - `excluded` 

#### Xcode 설정

Target -> build phase -> new Runscript -> ${PODS_ROOT}/SwiftLint/swiftlint



설정을 마치면 컴파일시 파일들을 확인한다. 일일이 확인하는 것도 좋지만 미리 만들어진 basic rules 를 사용하면서 필요한 경우 변경하는 것도 좋은 방법이다. [SwiftLint Rules](https://github.com/realm/SwiftLint/blob/master/Rules.md) ( 참고로 현재는 github에서 md가 제대로 보이지 않는다. 복사해서 다른 md editor를 활용하자 )


### Extension

우리가 공통으로 알아야 할 점이 뭐가 있을까? 대표적으로 extension을 생각해보자. 우리가 흔히 사용하는 extension, but 나에게는 익숙하지만 팀원들에게 익숙하지 않다. 그렇다면 이것을 알리는 것이 좋다. 

1. extension 파일 자체에 설명을 추가
  
   - 장점 : 간편하다.
   - 단점 : 알기가 쉽지 않다.
   
2. wiki 에 사용법과 추가한 내역을 올린다.
   - 장점 : 팀원들과 공유하기 쉬움
   - 단점 : 일이 많아짐 > PR 을 통해서 wiki에 올리면 approve 를 하던지 해야 함

##### Mash-Up iOS팀은 기본적으로 1번 룰을 따르도록 한다. 단, PR 단계에서 해당 extension에 대한 설명이 없다면 approve를 금지 시킨다.




## Style Guide

Swift Lint로도 상당히 많은 부분을 해결할 수 있지만 그 외에도 논쟁의 여지? 혹은 선호의 차이가 있는 스타일은 반드시 있기 마련이다. 이런 경우를 대비해서 Style Guide 를 참고하고 이를 활용해보자

##### Mash-Up iOS 팀은 기본적으로 [raywenderlich](https://github.com/raywenderlich/swift-style-guide) 룰을 따르는 것으로 한다. 문서가 가장 깔끔하다고 느껴지기 때문, 팀원 모두가 동의했다면 최대한 따르는 것이 좋다고 생각한다. 만약 **의문이 든다면 issue 를 링크에 날리도록** ! 해당 룰을 추가하자

>  #### StyleGuide
>
>  [Google](https://google.github.io/swift/) 
>  [raywenderlich](https://github.com/raywenderlich/swift-style-guide)
>  [airbnb](https://github.com/airbnb/swift)
>  [styleshare](https://github.com/StyleShare/swift-style-guide)



#### Reference

> swift lint
>
> https://github.com/realm/SwiftLint
>
> https://zeddios.tistory.com/447 





## Using Github

### commit

Commit 또한 중구난방으로 작성하기 보다는 아래의 기본적인 Template 를 활용하여 작성하기로 한다. 단, 영어가 아닌 한글로 작성하는 것도 가능하다. 기본적으로 갖는 커밋의 주제(?)는 다음과 같다

- **feat:** a new feature
- **fix:** a bug fix
- **docs:** changes to documentation
- **style:** formatting, missing semi colons, etc; no code change
- **refactor:** refactoring production code
- **test:** adding tests, refactoring test; no production code change
- **chore:** updating build tasks, package manager configs, etc; no production code change

[Udacity Commit Style Guide](https://udacity.github.io/git-styleguide/)



### issue

언제 이슈를 오픈할까?

1. 해야하는 목록들을 다 이슈로 만들어 놓는다. 그리고 하나씩 close
   - 장점 : 꼼꼼하게 , 눈에보인다 , 일을 쉽게 알 수 있다, project 관리가 용이하다.
   - 단점 : Too Much, 놓친부분을 또 이슈를 만들어야 돼
2. 정말로 해결해야 할 이슈만 올린다.
   - 장점 : 편해
   - 단점 : 프로젝트 관리가 조금 힘들수가 있다.

##### Mash-Up iOS팀은 기본적으로 1번 룰을 따르도록 한다. 단 세부적으로 나누는 단위는 팀 내부에서 상의한다.



### 커밋과 PR에 이슈를 언급하자

- 커밋에 이슈를 언급한다. #1234
- PR 에 close #123, #1234



### branch's name

- master
- develop
- feature
  - 이슈넘버 + 기능이 들어가 있어야 됩니다.
    - [1234] login
    - 1234_login
  - 여러개의 이슈는 팀마다 정하기
- 필요한 경우에는 다음과 같은 브랜치를 사용할 수 있습니다.
  - hotfix 
  - release 



## Etc

만약에 룰을 추가하고 싶은 경우 혹은 변경하고 싶은 경우에는 팀원들과 공유한 뒤 해당 md 를 수정하도록 한다. Mash-Up iOS팀에서 모두들 즐거운 코딩을 하시길!

그럼 20000