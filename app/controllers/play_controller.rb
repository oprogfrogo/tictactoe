class PlayController < ApplicationController
  
  WINNING_COMBOS = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ]
  
  def index
    
  end
  
  def start
    session[:existing_squares] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    session[:player1_squares] = []
    session[:player2_squares] = []
    session[:players_turn] = 1
  end
  
  def choose
    
    session[:players_turn] = (3 - session[:players_turn])
    
    session[:player1_squares] << params[:id].to_i if session[:players_turn] == 1
    session[:player2_squares] << params[:id].to_i if session[:players_turn] == 2
    
    session[:existing_squares].delete(params[:id].to_i)
    
    WINNING_COMBOS.each {|arr|
      if (arr & session[:player1_squares]).count >= 3
        @winner = 1
      end
      if (arr & session[:player2_squares]).count >= 3
        @winner = 2
      end
    }
    logger.error("------#{@winner}")
    logger.error("----------------#{session[:player1_squares].inspect}-------------#{session[:player2_squares]}")
    respond_to do |format|
      format.js
    end
  end
  
end
