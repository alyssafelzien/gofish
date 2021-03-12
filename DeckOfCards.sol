pragma solidity 0.5.1;
pragma experimental ABIEncoderV2;
import "./DeckOfCards.sol";
contract PlayerHand {

    string value;
    // string public card;
    string[] private ranks;
    Card[] public hand;
    Card[] public removedCards;
    string[] suits;
    Card public playerCard;
    
    
    struct Card {
        uint _id;
        string _rank;
        string _suit;
        // string _toString;
    }
    
    function add(Card memory c) public {
        hand.push(c);
    }
    
    // this should return an array of cards 
    function removeCardsOfRank(string memory s) public returns (Card[] memory){
        delete removedCards;
        uint foundCards = 0;
        for(uint j = 0; j < hand.length; j++) {
            // Card memory c = hand[j];
            // Compare bytes of strings
            if(keccak256(bytes(hand[j]._rank)) == keccak256(bytes(s))) {
            // if(c._rank == s) {
                foundCards += 1;
                // at the end we will pop 'foundCards' many cards into a cardArray for placing into other players hand
                Card memory temp = hand[hand.length-foundCards];
                hand[hand.length-foundCards] = hand[j];
                hand[j] = temp;
            }
        }
        //if there are 2 found cards, should only pop the last 2 elements
        while(foundCards >= 0) {
            // Card memory popped = hand[hand.length];
            removedCards.push(hand[hand.length-1]);
            hand.pop();
            foundCards -= 1;
        }
        // whatever uses this must check if removedCards is empty. 
        return removedCards;
    }
    
    function checkIfEmpty() public view returns (bool) {
        if(hand.length == 0) {
            return true;
        } else  {
            return false;
        }
    }
    
    
    // pullOutAndAddToHand()
    // hand.add(deck.pull())
    
    
    function clearHand() public {
        delete hand;
    }
}
