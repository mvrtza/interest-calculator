class Amortization {
  double payoff;
  double rate;
  int periods;

  Amortization(this.payoff, this.rate, this.periods);

  double calculateTotal() {
    double total = 0;
    for (var i = 1; i < periods + 1; i++) {
      total += (payoff) - (payoff * (rate * i / 100));
    }
    return total;
  }
}

class ReverseAmortization {
  double total;
  double rate;
  int periods;

  ReverseAmortization(this.total, this.rate, this.periods);

  double calculateMonthlyPayment() {
    double payoff = 0;
    for (var i = 1; i < periods + 1; i++) {
      payoff += 1 - (rate * i) / 100;
    }
    if (payoff != 0) {
      return total / payoff;
    } else {
      return 0;
    }
  }
}
class CalculateMonth {
  double total;
  double rate;
  double payoff;

  CalculateMonth(this.total, this.rate, this.payoff);
  int calculatePeriods() {
    double accumulated = 0;
    int periods = 0;
    bool whileloop = true;
    while (accumulated < total && whileloop) {

      accumulated += (payoff) - (payoff * (rate * periods / 100));
      if(accumulated <= 0.0){
        total = -1;
        whileloop = false;
        continue;
      }

      periods++;
    }

    return periods;
  }
}
