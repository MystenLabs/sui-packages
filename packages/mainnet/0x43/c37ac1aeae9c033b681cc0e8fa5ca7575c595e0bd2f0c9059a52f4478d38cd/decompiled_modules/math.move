module 0x43c37ac1aeae9c033b681cc0e8fa5ca7575c595e0bd2f0c9059a52f4478d38cd::math {
    public fun calculate_min_output_with_slippage(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 1000, 4);
        arg0 - arg0 * arg1 / 10000
    }

    public fun calculate_optimal_split(arg0: u64, arg1: vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 1);
        let v3 = 0x1::vector::empty<u64>();
        v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v3, arg0 * *0x1::vector::borrow<u64>(&arg1, v2) / v1);
            v2 = v2 + 1;
        };
        v3
    }

    public fun calculate_output_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0, 1);
        assert!(arg2 > 0, 1);
        let v0 = arg0 * (10000 - arg3);
        let v1 = arg1 * 10000 + v0;
        assert!(v1 > 0, 1);
        v0 * arg2 / v1
    }

    public fun calculate_price_impact_bp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 1);
        assert!(arg2 > 0, 1);
        let v0 = arg2 * 1000000000 / arg1;
        let v1 = arg2 - calculate_output_amount(arg0, arg1, arg2, 0);
        assert!(v1 > 0, 3);
        let v2 = v1 * 1000000000 / (arg1 + arg0);
        if (v2 >= v0) {
            return 0
        };
        (v0 - v2) * 10000 / v0
    }

    public fun calculate_profit_margin_bp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg2;
        if (arg1 <= v0) {
            return 0
        };
        (arg1 - v0) * 10000 / v0
    }

    public fun calculate_slippage_bp(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        (arg0 - arg1) * 10000 / arg0
    }

    public fun calculate_weighted_average_price(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 5);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 5);
        assert!(v0 > 0, 3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0, v3) * *0x1::vector::borrow<u64>(&arg1, v3) * v4;
            v2 = v2 + v4;
            v3 = v3 + 1;
        };
        assert!(v2 > 0, 1);
        v1 / v2
    }

    public fun geometric_mean(arg0: u64, arg1: u64) : u64 {
        sqrt(safe_mul(arg0, arg1))
    }

    public fun is_profitable_arbitrage(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        calculate_profit_margin_bp(arg0, arg1, arg2) >= arg3
    }

    public fun is_slippage_acceptable(arg0: u64, arg1: u64, arg2: u64) : bool {
        assert!(arg2 <= 1000, 4);
        calculate_slippage_bp(arg0, arg1) <= arg2
    }

    public fun safe_div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        arg0 / arg1
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 2);
        v0
    }

    public fun sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

