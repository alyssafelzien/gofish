pragma solidity 0.5.1;
pragma experimental ABIEncoderV2;

contract DeckOfCards {
    
    struct Card {
        uint8 id;
        uint8 rank;
        uint8 suit;
    }

    uint8[] private ranks;
    Card[] public deck;
    uint8[] private suits;
    Card public card;
    uint256 public deckLength;
    
    // pseudorandom should be ok
    function random() public view returns (uint8) {
        return uint8(uint256(block.timestamp)%(deck.length));
    }

    function addCard(uint8 _id, uint8 _rank, uint8  _suit) public {
        card = Card(_id, _rank, _suit);
        deck.push(card);
    }
    
    function isEmpty() public view returns (bool) {
        if(deck.length == 0) {
            return true;
        } else  {
            return false;
        }
    }
    
    //you'd do something like hand.addCard(deck.pullCard())
    function pullCard() public returns (Card memory) {
        if(deck.length != 0) {
             uint8 index = random();
             Card memory retCard = deck[index];
             deck[index] = deck[deck.length - 1];
             deck.pop();
             deckLength = deck.length;
             return retCard;
        } 
    }
    
    constructor() public {
        buildDeck();
    }
    
   function buildDeck() public {
        suits = [0, 1, 2, 3]; //['H', 'C', 'D', 'S'];
        ranks = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]; //['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
        //build deck
        uint8 i;
        uint8 j;
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
    
        
    function getStringSuit(uint8 suit) public pure returns(string memory) {
        if(suit == 0) {
            return 'H';
        }
        if(suit == 1) {
            return 'C';
        }
        if(suit == 2) {
            return 'D';
        }
        if(suit == 3) {
            return 'S';
        }
    }
    
    function getStringRank(uint8 rank) public pure returns(string memory) {
        if(rank == 1) {
            return 'Ace';
        }
        if(rank == 2) {
            return '2';
        }
        if(rank == 3) {
            return '3';
        }
        if(rank == 4) {
            return '4';
        }
        if(rank == 5) {
            return '5';
        }
        if(rank == 6) {
            return '6';
        }
        if(rank == 7) {
            return '7';
        }
        if(rank == 8) {
            return '8';
        }
        if(rank == 9) {
            return '9';
        }
        if(rank == 10) {
            return '10';
        }
        if(rank == 11) {
            return 'Jack';
        }
        if(rank == 12) {
            return 'Queen';
        }
        if(rank == 13) {
            return 'King';
        }
    }
}
