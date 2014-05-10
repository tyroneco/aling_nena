class MoneyCalculator
  attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :total, :total_change, :change_thousands, :change_five_hundreds, :change_hundreds, :change_fifties, :change_twenties, :change_tens, :change_fives, :change_ones

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    @ones = ones.to_i*1
    @fives = fives.to_i*5
    @tens = tens.to_i*10
    @twenties = twenties.to_i*20
    @fifties = fifties.to_i*50
    @hundreds = hundreds.to_i*100
    @five_hundreds = five_hundreds.to_i*500
    @thousands = thousands.to_i*1000
    @total = @ones+@fives+@tens+@twenties+@fifties+@hundreds+@five_hundreds+@thousands
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
  end

  def change(price, amount_given)
    @total_change = amount_given-price
    change = amount_given-price
    if(change>=1000) 
        @change_thousands = change/1000
        change = change%1000
    end
    if(change>=500)
        @change_five_hundreds = change/500
        change = change%500
    end
    if(change>=100)
        @change_hundreds = change/100
        change = change%100 
    end
    if(change>=50)
        @change_fifties = change/50
        change = change%50
    end
    if(change>=20)
        @change_twenties = change/20
        change=change%20
    end
    if(change>=10)
        @change_tens = change/10
        change=change%10
    end
    if(change>=5)
        @change_fives = change/5
        change=change%5
    end
    if(change>=1)
        @change_ones = change/1
    end
    hashes = {
        :ones => @change_ones.to_i,
        :fives => @change_fives.to_i,
        :tens => @change_tens.to_i,
        :twenties => @change_twenties.to_i,
        :fifties => @change_fifties.to_i,
        :hundreds => @change_hundreds.to_i,
        :five_hundreds => @change_five_hundreds.to_i,
        :thousands => @change_thousands.to_i,
    }
    hashes.each_pair {|key, value| puts "#{key}: {value}"}
  end
end