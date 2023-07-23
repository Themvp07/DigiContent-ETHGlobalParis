// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importar la interfaz del token ERC-20
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ITokenSplitter {
    function views() external view returns (uint256);
}

contract TokenSplitter {
    uint256 public views1 = 1;
    address public address1;
    address public address2;
    ITokenSplitter public APIConsumercontract;
    IERC20 public token;

    constructor(
        address _address1,
        address _address2,
        address _tokenAddress,
        address _APIConsumercontract
    ) {
        address1 = _address1;
        address2 = _address2;
        token = IERC20(_tokenAddress);
        APIConsumercontract = ITokenSplitter(_APIConsumercontract); // Agregar el guion bajo en esta línea
    }

    function getViews() public {
        views1 = APIConsumercontract.views();
    }

    function splitTokens() public {
        // Obtener el saldo del contrato
        uint256 balance = token.balanceOf(address(this));

        // Calcular la mitad de los tokens
        uint256 halfBalance = balance / 2;

        // Asegurarnos de que haya suficientes tokens para el reparto
        require(balance >= halfBalance * 2, "Insufficient balance for splitting");

        // Transferir la mitad de los tokens a address1
        token.transfer(address1, halfBalance);

        // Transferir la otra mitad de los tokens a address2
        token.transfer(address2, halfBalance);
    }

    function setAddress2(address _newAddress) external {
        address2 = _newAddress;
    }

    // Función para obtener el valor de 'views' del contrato viewAPI2
 /*   function views() external view override returns (uint256) {
        return ITokenSplitter(APIConsumercontract).views();
    }
*/
}

