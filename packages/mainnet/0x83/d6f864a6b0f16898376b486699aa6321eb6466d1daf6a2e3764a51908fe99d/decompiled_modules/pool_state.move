module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state {
    struct PoolState<phantom T0> has store {
        token_balance: u64,
        vusd_balance: u64,
        d: u64,
        a: u64,
        balance_ratio_min_bp: u64,
    }

    public(friend) fun a<T0>(arg0: &PoolState<T0>) : u64 {
        arg0.a
    }

    public(friend) fun add_token_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.token_balance = arg0.token_balance + arg1;
    }

    public(friend) fun add_vusd_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.vusd_balance = arg0.vusd_balance + arg1;
    }

    public(friend) fun cbrt(arg0: u256) : u64 {
        let v0 = 0;
        let v1 = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        while (v1 > 0) {
            let v2 = v0 << 1;
            v0 = v2;
            let v3 = 3 * v2 * (v2 + 1) + 1;
            if (arg0 / v1 >= v3) {
                arg0 = arg0 - v1 * v3;
                v0 = v2 + 1;
            };
            v1 = v1 >> 3;
        };
        (v0 as u64)
    }

    public(friend) fun d<T0>(arg0: &PoolState<T0>) : u64 {
        arg0.d
    }

    public(friend) fun get_balance_ratio_min_bp<T0>(arg0: &PoolState<T0>) : u64 {
        arg0.balance_ratio_min_bp
    }

    public(friend) fun get_d(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u128) * (arg2 as u128);
        let v1 = (((arg0 as u128) * ((arg1 + arg2) as u128) * v0) as u256);
        let v2 = ((v0 * (((arg0 as u128) << 2) - 1) / 3) as u256);
        let v3 = sqrt(v1 * v1 + v2 * v2 * v2);
        let v4 = if (v3 > v1) {
            cbrt(v1 + v3) - cbrt(v3 - v1)
        } else {
            cbrt(v1 + v3) + cbrt(v1 - v3)
        };
        v4 << 1
    }

    public(friend) fun get_y<T0>(arg0: &PoolState<T0>, arg1: u64) : u64 {
        let v0 = (arg0.a as u128);
        let v1 = (arg1 as u128);
        let v2 = (arg0.d as u128);
        let v3 = v0 << 2;
        let v4 = v3 * v1;
        let v5 = v3 * v2 - v2;
        let (v6, v7) = if (v5 >= v4) {
            (v5 - v4, true)
        } else {
            (v4 - v5, false)
        };
        if (v7) {
            ((((sqrt((((v2 * v2 * v2) as u256) * (v3 as u256) + ((v6 * v6) as u256) * (v1 as u256)) * (v1 as u256)) as u128) + v1 * v6) / (v0 << 3) * v1) as u64)
        } else {
            ((((sqrt((((v2 * v2 * v2) as u256) * (v3 as u256) + ((v6 * v6) as u256) * (v1 as u256)) * (v1 as u256)) as u128) - v1 * v6) / (v0 << 3) * v1) as u64)
        }
    }

    public(friend) fun new<T0>(arg0: u64) : PoolState<T0> {
        PoolState<T0>{
            token_balance        : 0,
            vusd_balance         : 0,
            d                    : 0,
            a                    : arg0,
            balance_ratio_min_bp : 0,
        }
    }

    public(friend) fun set_balance_ratio_min_bp<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.balance_ratio_min_bp = arg1;
    }

    public(friend) fun set_token_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.token_balance = arg1;
    }

    public(friend) fun set_vusd_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.vusd_balance = arg1;
    }

    public(friend) fun sqrt(arg0: u256) : u256 {
        if (arg0 > 0) {
            let v0 = (arg0 >> 1) + 1;
            let v1 = v0 + arg0 / v0 >> 1;
            while (v0 > v1) {
                let v2 = v1 + arg0 / v1;
                v1 = v2 >> 1;
            };
            return v0
        };
        0
    }

    public(friend) fun sub_token_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.token_balance = arg0.token_balance - arg1;
    }

    public(friend) fun sub_vusd_balance<T0>(arg0: &mut PoolState<T0>, arg1: u64) {
        arg0.vusd_balance = arg0.vusd_balance - arg1;
    }

    public(friend) fun token_balance<T0>(arg0: &PoolState<T0>) : u64 {
        arg0.token_balance
    }

    public(friend) fun update_d<T0>(arg0: &mut PoolState<T0>) {
        arg0.d = get_d(arg0.a, arg0.token_balance, arg0.vusd_balance);
    }

    public(friend) fun validate_balance_ratio<T0>(arg0: &PoolState<T0>) {
        if (arg0.token_balance > arg0.vusd_balance) {
            assert!(arg0.vusd_balance * 10000 / arg0.token_balance >= arg0.balance_ratio_min_bp, 0);
        } else if (arg0.token_balance < arg0.vusd_balance) {
            assert!(arg0.token_balance * 10000 / arg0.vusd_balance >= arg0.balance_ratio_min_bp, 1);
        };
    }

    public(friend) fun vusd_balance<T0>(arg0: &PoolState<T0>) : u64 {
        arg0.vusd_balance
    }

    // decompiled from Move bytecode v6
}

