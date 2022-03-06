# frozen_string_literal: true

module ApplicationHelper
  def player_name(p)
    p.surname +
      (if p.firstname
         ', ' + p.firstname
       else
         +(p.initial ? ', ' + p.initial : '')
       end)
  end

  def highest_score(score, notout)
    score.to_s + (notout ? '*' : '')
  end
end
