//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Address.sol";
//import AccessControl

contract NFT1155token is ERC1155 {
    using Address for address;

    mapping(uint => mapping(address => uint)) private _balances;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    string private _uri;

    constructor(string memory uri_) ERC1155(uri_) {
        _uri = uri_;
    }

    function safeTransferFrom(address from, address to, uint id, uint amount, bytes memory data) public override {
        require(from == _msgSender() || isApprovedForAll(from, _msgSender()), "caller is not owner nor approved");
        _safeTransferFrom(from, to, id, amount, data);
        // require(to != address(0), "transfer to the zero address");

        // address operator = _msgSender();

        // uint256 fromBalance = _balances[id][from];
        // require(fromBalance >= amount, "insufficient transfered balance");
        // unchecked {
        //     _balances[id][from] = fromBalance - amount;
        // }
        // _balances[id][to] += amount;

        // emit TransferSingle(operator, from, to, id, amount);

        // _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
    }
    
    function safeBatchTransferFrom( address from, address to, uint[] memory ids, uint[] memory amounts, bytes memory data) public override {
        require(from == _msgSender() || isApprovedForAll(from, _msgSender()), "caller is not owner nor approved");
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    //     require(ids.length == amounts.length, "ids and amounts length mismatch");
    //     require(to != address(0), "transfer to the zero address");

    //     address operator = _msgSender();

    //     for (uint256 i = 0; i < ids.length; ++i) {
    //         uint256 id = ids[i];
    //         uint256 amount = amounts[i];

    //         uint256 fromBalance = _balances[id][from];
    //         require(fromBalance >= amount, "insufficient transfered balance");
    //         unchecked {
    //             _balances[id][from] = fromBalance - amount;
    //         }
    //         _balances[id][to] += amount;
    //     }

    //     emit TransferBatch(operator, from, to, ids, amounts);

    //    _doSafeBatchTransferAcceptanceCheck(operator, from, to, ids, amounts, data);
    
    }


    function balanceOf(address account, uint id) public view override returns (uint) {
        require(account != address(0), "address 0 is not valid owner");
        return _balances[id][account];
    }

    function balanceOfBatch(address[] memory accounts, uint[] memory ids) public view override returns (uint[] memory) {
        require(accounts.length == ids.length, "accounts and ids length mismatch");

        uint[] memory batchBalances = new uint[](accounts.length);

        for (uint i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }
    function setApprovalForAll(address _operator, bool _approved) public override {
        require(msg.sender != _operator, "setting approval status for self");
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function isApprovedForAll(address account, address operator) public view override returns (bool) {
        return _operatorApprovals[account][operator];
    }

    // function _doSafeTransferAcceptanceCheck (address operator, address from, address to, uint id, uint amount, bytes memory data) private virtual override {
    //     if (to.isContract()) {
    //         try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (bytes4 response) {
    //             if (response != IERC1155Receiver.onERC1155Received.selector) {
    //                 revert("ERC1155Receiver rejected tokens");
    //             }
    //         } catch Error(string memory reason) {
    //             revert(reason);
    //         } catch {
    //             revert("transfer to non ERC1155Receiver");
    //         }
    //     }
    // }

    // function _doSafeBatchTransferAcceptanceCheck(address operator, address from, address to, uint[] memory ids, uint[] memory amounts, bytes memory data) private virtual override {
    //     if (to.isContract()) {
    //         try IERC1155Receiver(to).onERC1155BatchReceived(operator, from, ids, amounts, data) returns (
    //             bytes4 response
    //         ) {
    //             if (response != IERC1155Receiver.onERC1155BatchReceived.selector) {
    //                 revert("ERC1155Receiver rejected tokens");
    //             }
    //         } catch Error(string memory reason) {
    //             revert(reason);
    //         } catch {
    //             revert("transfer to non ERC1155Receiver");
    //         }
    //     }
    // }
    
    function mint(address to, uint id, uint amount, bytes memory data) public {
        _mint(to, id, amount, data);
    }

    function mintBatch(address to, uint[] memory ids, uint[] memory amounts, bytes memory data) public {
        _mintBatch(to, ids, amounts, data);
    }

    // function _mint(address to, uint id, uint amount, bytes memory data) internal override {
    //     require(to != address(0), "mint to the zero address");

    //     address operator = _msgSender();
    //     uint[] memory ids = _asSingletonArray(id);
    //     uint[] memory amounts = _asSingletonArray(amount);

    //     _balances[id][to] += amount;
    //     emit TransferSingle(operator, address(0), to, id, amount);

    //     _afterTokenTransfer(operator, address(0), to, ids, amounts, data);

    //     _doSafeTransferAcceptanceCheck(operator, address(0), to, id, amount, data);
    // }

    // function _asSingletonArray(uint element) private pure override returns(uint[] memory) {
    //     uint[] memory array = new uint[](1);
    //     array[0] = element;

    //     return array;
    // }

    //  function _mintBatch(
    //     address to,
    //     uint[] memory ids,
    //     uint[] memory amounts,
    //     bytes memory data
    // ) internal override {
    //     require(to != address(0), "mint to the zero address");
    //     require(ids.length == amounts.length, "ids and amounts length mismatch");

    //     address operator = _msgSender();


    //     for (uint256 i = 0; i < ids.length; i++) {
    //         _balances[ids[i]][to] += amounts[i];
    //     }

    //     emit TransferBatch(operator, address(0), to, ids, amounts);

    //     _doSafeBatchTransferAcceptanceCheck(operator, address(0), to, ids, amounts, data);
    // }
    
}
