module 0x2a74b5b27122aaf707fce12cdeb7f283f07509fa18dd9945d82ae443ca952171::config {
    struct Config has store {
        round_duration: u64,
        prize_rates: vector<u64>,
        withdraw_fee_rate: u64,
    }

    public fun get_prize_count(arg0: &Config) : u64 {
        0x1::vector::length<u64>(&arg0.prize_rates)
    }

    public fun get_prize_rate(arg0: &Config, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(&arg0.prize_rates) <= arg1) {
            return 0
        };
        *0x1::vector::borrow<u64>(&arg0.prize_rates, arg1)
    }

    public fun get_rate_denominator() : u64 {
        10000
    }

    public fun get_round_duration(arg0: &Config) : u64 {
        arg0.round_duration
    }

    public fun get_withdraw_fee_rate(arg0: &Config) : u64 {
        arg0.withdraw_fee_rate
    }

    public(friend) fun new() : Config {
        Config{
            round_duration    : 604800,
            prize_rates       : vector[5000, 1100, 1100, 1100, 1100],
            withdraw_fee_rate : 100,
        }
    }

    public(friend) fun set_prize_rate(arg0: &mut Config, arg1: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg1) > 0, 2);
        assert!(arg0.prize_rates != arg1, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 <= 10000, 2);
        arg0.prize_rates = arg1;
    }

    public(friend) fun set_round_duration(arg0: &mut Config, arg1: u64) {
        assert!(arg0.round_duration != arg1, 1);
        assert!(arg1 > 0, 2);
        arg0.round_duration = arg1;
    }

    public(friend) fun set_withdraw_fee_rate(arg0: &mut Config, arg1: u64) {
        assert!(arg0.withdraw_fee_rate != arg1, 1);
        arg0.withdraw_fee_rate = arg1;
    }

    // decompiled from Move bytecode v6
}

