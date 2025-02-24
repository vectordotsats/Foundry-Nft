// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() public returns (MoodNft) {
        string memory sadSvg = vm.readFile("../images/sad.svg");
        string memory happySvg = vm.readFile("../images/happy.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgImageToUri(sadSvg),
            svgImageToUri(happySvg)
        );

        vm.stopBroadcast();
        return moodNft;
    }

    function svgImageToUri(
        string memory svgImage
    ) public pure returns (string memory) {
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory base64EncodedImage = Base64.encode(
            bytes(string(abi.encodePacked(svgImage)))
        );
        return string(abi.encodePacked(baseUrl, base64EncodedImage));
    }
}
