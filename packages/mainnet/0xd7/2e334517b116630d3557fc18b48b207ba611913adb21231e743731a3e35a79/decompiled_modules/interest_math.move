module 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::interest_math {
    struct InterestSegment has store {
        start_index: u128,
        supply: u64,
        user_accounted: u128,
        fee_accounted: u128,
        index_accounted: u128,
        terminal_dust: u128,
    }

    public fun checkpoint(arg0: &mut InterestSegment, arg1: u128, arg2: u128) : (u128, u128, u128) {
        if (arg0.start_index == 0) {
            arg0.start_index = arg1;
        };
        let (v0, v1, v2) = cumulative(arg0.supply, arg0.start_index, arg1, arg2);
        arg0.user_accounted = v0;
        arg0.fee_accounted = v1;
        arg0.index_accounted = v2;
        (v0 - arg0.user_accounted, v1 - arg0.fee_accounted, v2 - arg0.index_accounted)
    }

    public fun cumulative(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : (u128, u128, u128) {
        assert!(arg1 > 0 && arg2 >= arg1, 0);
        assert!(arg3 <= 18446744073709551616, 2);
        if (arg0 == 0 || arg2 == arg1) {
            return (0, 0, 0)
        };
        let v0 = scaled_ratio((((arg0 as u128) * 18446744073709551616) as u256) * ((arg2 - arg1) as u256), (arg1 as u256) * (arg2 as u256));
        let v1 = (((v0 as u256) * (arg3 as u256) / (18446744073709551616 as u256)) as u128);
        let v2 = v0 - v1;
        (v2, v1, v2 / (arg0 as u128))
    }

    public fun double_remainder(arg0: u256, arg1: u256) : (u256, u64) {
        assert!(arg0 < arg1, 0);
        let v0 = arg1 - arg0;
        if (arg0 >= v0) {
            (arg0 - v0, 1)
        } else {
            (arg0 + arg0, 0)
        }
    }

    public fun dust(arg0: &InterestSegment) : u128 {
        arg0.terminal_dust + arg0.user_accounted - arg0.index_accounted * (arg0.supply as u128)
    }

    public fun new() : InterestSegment {
        InterestSegment{
            start_index     : 0,
            supply          : 0,
            user_accounted  : 0,
            fee_accounted   : 0,
            index_accounted : 0,
            terminal_dust   : 0,
        }
    }

    public fun principal_value(arg0: u64, arg1: u128) : u128 {
        assert!(arg1 > 0, 0);
        let v0 = (arg0 as u256) * (18446744073709551616 as u256) * (18446744073709551616 as u256) / (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    public fun restart(arg0: &mut InterestSegment, arg1: u128, arg2: u64) {
        arg0.terminal_dust = arg0.terminal_dust + arg0.user_accounted - arg0.index_accounted * (arg0.supply as u128);
        arg0.start_index = arg1;
        arg0.supply = arg2;
        arg0.user_accounted = 0;
        arg0.fee_accounted = 0;
        arg0.index_accounted = 0;
    }

    public fun scaled_ratio(arg0: u256, arg1: u256) : u128 {
        assert!(arg1 > 0, 0);
        let v0 = arg0 / arg1;
        assert!(v0 <= 18446744073709551615, 1);
        let v1 = arg0 % arg1;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 64) {
            let (v4, v5) = double_remainder(v1, arg1);
            v1 = v4;
            let v6 = v2 * 2;
            v2 = v6 + v5;
            v3 = v3 + 1;
        };
        (v0 as u128) * 18446744073709551616 + (v2 as u128)
    }

    // decompiled from Move bytecode v7
}

