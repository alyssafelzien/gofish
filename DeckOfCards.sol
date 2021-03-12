pragma solidity 0.5.1;
pragma experimental ABIEncoderV2;

contract DeckOfCards {
    
    struct Card {
        uint _id;
        string _rank;
        string _suit;
        // string _toString;
    }
    
    string value;
    // string public card;
    string[] private ranks;
    Card[] public deck;
    string[] suits;
    Card public card;
    uint256 public deckLength;
    
    // pseudorandom should be ok
    function random() public view returns (uint8) {
        return uint8(uint256(block.timestamp)%(deck.length));
    }

    function addCard(uint _id, string memory _rank, string memory _suit) public {
        card = Card(_id, _rank, _suit);
        deck.push(card);
    }
    
    function checkIfEmpty() public view returns (bool) {
        if(deck.length == 0) {
            return true;
        } else  {
            return false;
        }
    }
    
    //you'd do something like hand.addCard(deck.pullCard())
    function pullCard() public returns (Card memory) {
        if(deck.length != 0) {
            deck.pop();
            // return deck[deck.length-1];
            //update deckLength to see how many are left
            deckLength = deck.length;
            return deck[random()];
        } 
    }
    
    constructor() public {
        buildDeck();
    }
    
    
    // function firstCard() public returns(string memory) {
    //     string memory x = deck[deck.length];
    //     delete deck[deck.length];
    //     return x;
    // }
    function buildDeck() public {
        suits = ['H', 'C', 'D', 'S'];
        ranks = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
        //build deck
        uint256 i;
        uint256 j;
        for(i = 0; i < suits.length; i++) {
            for(j = 0; j < ranks.length; j++) {
                
                addCard(i+j, ranks[j], suits[i]);
            }
        }
    }
    
    //pullOutAndAddToHand()
    
    
    function clearDeck() public {
        delete deck;
    }
}
