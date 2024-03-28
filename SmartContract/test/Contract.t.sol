// // SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.13;

// import "forge-std/Test.sol";

// import "src/ENS.sol";

// contract TestContract is Test {
//     ENS e;
//     address A;
//     address B;
//     address C;

//     function setUp() public {
//         e = new ENS();
//         A = mkaddr("staker a");
//         B = mkaddr("staker b");
//         C = mkaddr("auction c");
//     }

//     function testRegister() public {
//         switchSigner(A);
//         string memory name = "John";
//         e.register(name);
//         string memory name2 = e.getName(address(A));

//         assertEq(name, name2, "ok");
//     }

//     function testRegisterSameName() public {
//         switchSigner(A);
//         string memory name = "John";
//         e.register(name);
//         string memory name2 = e.getName(address(A));

//         switchSigner(B);
//         // vm.expecetRevert e.register(name);
//     }

//     // function testFoo(uint256 x) public {
//     //     vm.assume(x < type(uint128).max);
//     //     assertEq(x + x, x * 2);
//     // }

//     function mkaddr(string memory name) public returns (address) {
//         address addr = address(
//             uint160(uint256(keccak256(abi.encodePacked(name))))
//         );
//         vm.label(addr, name);
//         return addr;
//     }

//     function switchSigner(address _newSigner) public {
//         address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
//         if (msg.sender == foundrySigner) {
//             vm.startPrank(_newSigner);
//         } else {
//             vm.stopPrank();
//             vm.startPrank(_newSigner);
//         }
//     }
// }
