pragma solidity 0.5.1;
pragma experimental ABIEncoderV2;

import "./DeckOfCards.sol";

contract GoFishGame {
  
  enum Winner { PLAYER, COMPUTER, TIE, IN_PROGRESS }
    
  DeckOfCards public deckOfCards;
  DeckOfCards.Card[]  public playerCards;
  DeckOfCards.Card[] public computerCards;
  uint8 public numPlayerCards;
  uint8 public numComputerCards;
  
  Winner public winner;
  bool public gameIsOver;
  bool public isPlayerTurn;
    
  uint8 public numPlayerPairs;
  uint8 public numComputerPairs;
  
  uint8 constant startNumberCards = 5;
    
  constructor() public {
      startGame();
  }
  
  /**
   * Starts a fresh, new game
   */ 
  function startGame() public {
      numPlayerPairs = 0;
      numComputerPairs = 0;
      gameIsOver = false;
      isPlayerTurn = true;
      winner = Winner.IN_PROGRESS;
      
      // set up deck and give cards to player and computer
      deckOfCards = new DeckOfCards();
      for(int i = 0; i < startNumberCards; i++) {
        playerCards.push(deckOfCards.pullCard());
        computerCards.push(deckOfCards.pullCard());
      }
      numPlayerCards = 5;
      numComputerCards = 5;
      gameOver();
  }
 
 
   /**
   * Takes a random card from its hand and takes one with the same rank from the player.
   * If the player doesn't have a matching card, takes a card from the deck.
   */
   function playComputer() public {
    if(!gameOver() && !isPlayerTurn) {
      isPlayerTurn = true;
      // randomly pick a card in hand
      uint8 index = randomComputerCard();
      DeckOfCards.Card memory card = computerCards[index];
      int cardIndex = playerHandContainsRank(card.rank);
      if(cardIndex >= 0) {
          DeckOfCards.Card memory newCard = removeCardFromPlayer(uint8(cardIndex));
          computerCards.push(newCard);
          numPlayerCards--;
      }
      else if(!deckOfCards.isEmpty()) { //go fishing
         DeckOfCards.Card memory newCard = deckOfCards.pullCard();
         if(newCard.rank == card.rank) { //the computer got what it wanted! 
              isPlayerTurn = false;
          }
          computerCards.push(newCard);
      }
      numComputerCards++;
      gameOver(); //check if game is over
    }
  }
  
  /**
   * Given a card from the player deck, takes a card with the same rank from the computer. 
   * If the computer doesn't have a match, takes a card from the deck.
   */
  function play(DeckOfCards.Card memory _card ) public 
  {
     if(!gameOver() && isPlayerTurn) {
      // randomly pick a card in hand
      isPlayerTurn = false;
      int cardIndex = computerHandContainsRank(_card.rank);
      if(cardIndex >= 0) {
          DeckOfCards.Card memory newCard = removeCardFromComputer(uint8(cardIndex));
          playerCards.push(newCard);
          numComputerCards--;
      }
      else if(!deckOfCards.isEmpty()) { //go fishing
          DeckOfCards.Card memory newCard = deckOfCards.pullCard();
          if(newCard.rank == _card.rank) { //you got what you wanted! 
              isPlayerTurn = true;
          }
          playerCards.push(newCard);
      }
      numPlayerCards++;
      gameOver(); //check if game is over
    }
  }
 
  
  /**
   *  Returns a random card index in the computer's hand 
   */
  function randomComputerCard() public view returns (uint8)  {
    return uint8(uint256(block.timestamp)%(computerCards.length));    
  }
  
  
  /**
   *  Checks the player hand for pairs
   */
  function playerHandFindPair() public {
      // look through deck to see if has a pair/s
      bool foundPair = false;
      for(uint8 i = 0; i < playerCards.length; i++) {
          for(uint8 j = i+1; j < playerCards.length; j++) {
              if(playerCards[i].rank == playerCards[j].rank) {
                  //found a pair!
                  numPlayerPairs ++;
                  foundPair = true;
                  DeckOfCards.Card memory firstCard = removeCardFromPlayer(i);
                  int8 newIndexToRemove = playerHandContainsRank(firstCard.rank);
                  if(newIndexToRemove >= 0) {
                    removeCardFromPlayer(uint8(newIndexToRemove));
                    numPlayerCards = numPlayerCards - 2;
                  }
              }
          }
      }
      if(foundPair) {
          playerHandFindPair(); // search to see if any other pairs
      }
  }
  
  /**
   * Checks the computer hand for pairs
   */ 
  function computerHandFindPair() public {
      // look through deck to see if has a pair/s
      bool foundPair = false;
      for(uint8 i = 0; i < computerCards.length; i++) {
          for(uint8 j = i+1; j < computerCards.length; j++) {
              if(computerCards[i].rank == computerCards[j].rank) {
                  //found a pair!
                  numComputerPairs ++;
                  foundPair = true;
                  DeckOfCards.Card memory firstCard = removeCardFromComputer(i);
                  int8 newIndexToRemove = computerHandContainsRank(firstCard.rank);
                  if(newIndexToRemove >= 0) {
                    removeCardFromComputer(uint8(newIndexToRemove));
                    numComputerCards = numComputerCards - 2;
                  } 
              }
          }
      }
      if(foundPair) {
          computerHandFindPair(); // search to see if any other pairs
      }
  }

/**
 *  Checks for pairs in the player and computer hand and checks if either has reached 5 or more pairs
 */ 
function gameOver() public returns (bool){
     computerHandFindPair();
     playerHandFindPair();
     if(numPlayerPairs >= 5 && numPlayerPairs > numComputerPairs) {
          // player won!
          winner = Winner.PLAYER;
          gameIsOver = true;
      }
      else if(numComputerPairs >= 5 && numComputerPairs > numPlayerPairs) {
          winner = Winner.COMPUTER;
          gameIsOver = true;
      }
      else if(numPlayerPairs >= 5 && numComputerPairs == numPlayerPairs) { // then it's a tie!
          winner = Winner.TIE;
          gameIsOver = true;
      }
      else {
          gameIsOver = false;
      }
      return gameIsOver;
  }
  
  /**
   * Given an index, removes a card from the player's hand
   */ 
  function removeCardFromPlayer(uint8 _index) private returns (DeckOfCards.Card memory) {
     DeckOfCards.Card memory card = playerCards[_index];
     playerCards[_index] = playerCards[playerCards.length - 1];
     playerCards.pop();
     return card;
  }
  
   /**
   * Given an index, removes a card from the computer's hand
   */ 
  function removeCardFromComputer(uint8 _index) private returns (DeckOfCards.Card memory) {
     DeckOfCards.Card memory card = computerCards[_index];
     computerCards[_index] = computerCards[computerCards.length - 1];
     computerCards.pop();
     return card;
  }
  
   /**
   * Returns index of card or negative one if it's not there.  
   */
  function playerHandContainsRank(uint8 _rank) private view returns (int8) {
       int8 _indexOfCard = -1;
       for(uint8 i = 0; i < playerCards.length; i++) {
           DeckOfCards.Card memory c  = playerCards[i];
           if(c.rank == _rank) {
                _indexOfCard = int8(i);    
           }
      }
      return _indexOfCard;
  }
  
  /**
   * Returns index of card or negative one if it's not there.  
   */
  function computerHandContainsRank(uint8 _rank) private view returns (int8) {
       int8 indexOfCard = -1;
       for(uint8 i = 0; i < computerCards.length; i++) {
           DeckOfCards.Card memory c = computerCards[i];
           if(c.rank == _rank) {
                indexOfCard = int8(i);    
           }
      }
      return indexOfCard;
  }

}
