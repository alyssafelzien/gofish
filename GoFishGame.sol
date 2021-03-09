pragma solidity 0.5.1;

import "./DeckOfCards.sol";
import "./Card.sol";

contract GoFishGame {
  //TODO
    // Figure out random
    // Get base classes set up 
    // Put some functionality in DeckOfCards?
  
  
  DeckOfCards cards private;
  uint startNumber = 5 private;
  Card playerCards [] public;
  Card computerCards [] private;
  address winner;
  bool gameOver;
  
  uint numPlayerPairs public; //TODO maybe make it a dictionary? Could make it so other people can join in?
  uint numComputerPairs public;

  
  constructor() public {
      startNumber = 5;
      numPlayerPairs = 0;
      numComputerPairs = 0;
      gameOver = false;
      winner = 0; // set to some default value
      while(playerCards.length < startNumber && computerCards.length < startNumber ) {
         // TODO figure out random generator stuff  uint card =  https://github.com/randao/randao 
      }
  }
  
  function playComputer() private {
    if(!gameOver()) {
      // randomly pick a card in hand
      
      // as player if they have the card
      
      // if yes  
            // take card and add it to deck. 
            
        // else
            Grab card from deck
            
    //Check for pairs
    containsPair()
    //player's turn
    gameOver();
    }
    else {
        //print game is over or something
    }
    
  }
  
  function play(Card card) public {
    if(!gameOver()) {
          // check if card is in there hand
          
          // if yes
            // check if computer has the card
                // yes - grab card from computer  
            
            // else
                // take from deck
            // check for pairs
            // computer's turn
        // else
            // print message saying invalid card
        containsPair()
        gameOver()
    else {
        // print game is over or something
    }
  }
  
  function drawCardFromDeck() {
      // determine what card is left,
      // return a random new card
  }
  
  function containsPair(Cards[] _cards) {
      // look through deck to see if has a pair/s
      for(int i = 0; i < cards.size; i++) {
          for(int j = l; j < cards.size; j++) {
              if( cards[i] == cards[j]) {
                  //found a pair!
                  if(msg.address == playerAddress) {
                      numPlayerPairs ++;
                  }
                  else {
                      numComputerPairs++;
                  }
                  cards.remove[i];
                  cards.remove[j];
                  i = -1;
                  j = 0; //start search over, must be a better way right?
              }
          }
      }
  }


function gameOver(Card card) {
      if(numPlayerPairs == 5) {
          // player won!
          winner = msg.address;
          gameOver = true;
      }
      else if(numComputerPairs == 5{
          winner = computer.address //not sure what to do here really
          gameOver = true;
      }
      else {

      }
  }

}
