pragma solidity 0.5.1;

contract DeckOfCards {

    string value;
    string public card;
    string[] private ranks;
    string[] public deck;
    string[] suits;

    
    // function cancat(string memory a, string memory b) public view returns(string memory){
    //     return(string(abi.encodePacked(a,"/",b)));
    // }
    // function firstCard(DeckOfCards d) public view returns(string memory) {
    //     return d.deck[0];
    // }
    
    constructor() public {
        buildDeck();
    }
    
    function buildDeck() public {
        suits = ['H', 'C', 'D', 'S'];
        ranks = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
        //build deck
        uint256 i;
        uint256 j;
        for(i = 0; i < suits.length; i++) {
            for(j = 0; j < ranks.length; j++) {
                // deck.push(cancat(ranks[j], suits[i]));
                // having trouble concatenating strings or returning them
                deck.push('test');
            }
        }
    }
    function clearDeck() public {
        delete deck;
    }
}
