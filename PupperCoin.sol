pragma solidity ^0.5.0;
import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";
// @TODO: Inherit the crowdsale contracts
contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate,
        uint goal,
        uint startime,
        uint endtime, // rate in TKNbits
        address payable wallet, // sale beneficiary
        PupperCoin token // the PupperCoin;
    )
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        Crowdsale(rate, wallet, token)
        MintedCrowdsale()
        CappedCrowdsale(goal)
        TimedCrowdsale(startime,endtime)
        RefundableCrowdsale(goal)
        RefundablePostDeliveryCrowdsale()
        public
    {
        // constructor can stay empty
    }
}
contract PupperCoinSaleDeployer {
    address public pupper_sale_address;
    address public token_address;
    constructor(
        // @TODO: Fill in the constructor parameters!
        //string memory name,
        //string memory symbol,
        //address payable wallet // sale beneficiary;
        //uint rate
        //uint goal
        //uint starttime, endtime, // rate in TKNbits
    )
        public
    {
        // @TODO: create the PupperCoin and keep its address handy
        PupperCoin token = new PupperCoin("PupperCoin", "PUPPY", 1);
        token_address = address(token);
        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
        PupperCoinSale pupper_sale = new PupperCoinSale(1, 300, now, now + 10 minutes, 0x463Bc2541fe41a3F13332705d878CcC655392205, token);
        pupper_sale_address = address(pupper_sale);
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
        token.addMinter(pupper_sale_address);
        token.renounceMinter();
    }
}
