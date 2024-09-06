// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";
import {DeployMoodNft} from "script/DeployMoodNft.s.sol";

contract MoodNftIntegrationTest is Test {
    MoodNft moodNft;
    DeployMoodNft deployer;

    address USER = makeAddr("user");

    string public constant SAD_IMG_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8IS0tIEZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIGZpbGw9IiM4N0NFRUIiIC8+CiAgCiAgPCEtLSBFeWVzIC0tPgogIDxjaXJjbGUgY3g9IjM1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiIC8+CiAgPGNpcmNsZSBjeD0iNjUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIgLz4KICAKICA8IS0tIFNhZCBNb3V0aCAtLT4KICA8cGF0aCBkPSJNMzUsNjUgUTUwLDUwIDY1LDY1IiBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0ibm9uZSIgLz4KPC9zdmc+Cg==";

    string public constant HAPPY_IMG_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8IS0tIEZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIGZpbGw9IiNGRkQ3MDAiIC8+CiAgCiAgPCEtLSBFeWVzIC0tPgogIDxjaXJjbGUgY3g9IjM1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiIC8+CiAgPGNpcmNsZSBjeD0iNjUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIgLz4KICAKICA8IS0tIFNtaWxlIC0tPgogIDxwYXRoIGQ9Ik0zNSw2MCBRNTAsNzUgNjUsNjAiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIzIiBmaWxsPSJub25lIiAvPgo8L3N2Zz4K";

    string public constant SAD_TOKEN_URI = "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsICJkZXNjcmlwdGlvbiI6Ik5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kLCAxMDAlIG9uIENoYWluISIsICJhdHRyaWJ1dGVzIjogW3sidHJhaXRfdHlwZSI6ICJtb29kaW5lc3MiLCAidmFsdWUiOiAxMDB9XSwgImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCM2FXUjBhRDBpTVRBd0lpQm9aV2xuYUhROUlqRXdNQ0lnZUcxc2JuTTlJbWgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5JajQ4WTJseVkyeGxJR040UFNJMU1DSWdZM2s5SWpVd0lpQnlQU0kwTUNJZ1ptbHNiRDBpSXpnM1EwVkZRaUl2UGp4amFYSmpiR1VnWTNnOUlqTTFJaUJqZVQwaU5EQWlJSEk5SWpVaUlHWnBiR3c5SWlNd01EQWlMejQ4WTJseVkyeGxJR040UFNJMk5TSWdZM2s5SWpRd0lpQnlQU0kxSWlCbWFXeHNQU0lqTURBd0lpOCtQSEJoZEdnZ1pEMGlUVE0xTERZMUlGRTFNQ3cxTUNBMk5TdzJOU0lnYzNSeWIydGxQU0lqTURBd0lpQnpkSEp2YTJVdGQybGtkR2c5SWpNaUlHWnBiR3c5SW01dmJtVWlMejQ4TDNOMlp6ND0ifQ==";

    string public constant HAPPY_TOKEN_URI = "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsICJkZXNjcmlwdGlvbiI6Ik5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kLCAxMDAlIG9uIENoYWluISIsICJhdHRyaWJ1dGVzIjogW3sidHJhaXRfdHlwZSI6ICJtb29kaW5lc3MiLCAidmFsdWUiOiAxMDB9XSwgImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCM2FXUjBhRDBpTVRBd0lpQm9aV2xuYUhROUlqRXdNQ0lnZUcxc2JuTTlJbWgwZEhBNkx5OTNkM2N1ZHpNdWIzSm5Mekl3TURBdmMzWm5JajRLSUNBOElTMHRJRVpoWTJVZ0xTMCtDaUFnUEdOcGNtTnNaU0JqZUQwaU5UQWlJR041UFNJMU1DSWdjajBpTkRBaUlHWnBiR3c5SWlOR1JrUTNNREFpSUM4K0NpQWdDaUFnUENFdExTQkZlV1Z6SUMwdFBnb2dJRHhqYVhKamJHVWdZM2c5SWpNMUlpQmplVDBpTkRBaUlISTlJalVpSUdacGJHdzlJaU13TURBaUlDOCtDaUFnUEdOcGNtTnNaU0JqZUQwaU5qVWlJR041UFNJME1DSWdjajBpTlNJZ1ptbHNiRDBpSXpBd01DSWdMejRLSUNBS0lDQThJUzB0SUZOdGFXeGxJQzB0UGdvZ0lEeHdZWFJvSUdROUlrMHpOU3cyTUNCUk5UQXNOelVnTmpVc05qQWlJSE4wY205clpUMGlJekF3TUNJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWlCbWFXeHNQU0p1YjI1bElpQXZQZ284TDNOMlp6NEsifQ==";

    function setUp() external {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testViewTokenURIIntergration() public {
        vm.prank(USER);
        moodNft.mint();
        console.log(moodNft.tokenURI(0));
    }

    function testFlipMood() public {
        vm.prank(USER);
        moodNft.mint();

        vm.prank(USER);
        moodNft.flipMood(0);

        // console.log("tokenurii0", moodNft.tokenURI(0));
        // console.log("tokenurii1", moodNft.tokenURI(1));

        assertEq(keccak256(abi.encodePacked(moodNft.tokenURI(0))), keccak256(abi.encodePacked(SAD_TOKEN_URI)));
    }
}
