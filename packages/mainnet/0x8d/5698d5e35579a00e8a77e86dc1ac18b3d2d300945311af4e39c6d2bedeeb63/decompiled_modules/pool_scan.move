module 0x8d5698d5e35579a00e8a77e86dc1ac18b3d2d300945311af4e39c6d2bedeeb63::pool_scan {
    struct ReservesFound has copy, drop {
        pool_type: vector<u8>,
        reserve_x: u64,
        reserve_y: u64,
        price_x_per_y: u64,
        price_y_per_x: u64,
    }

    struct ArbOpportunity has copy, drop {
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        token_in: vector<u8>,
        token_out: vector<u8>,
        estimated_profit: u64,
    }

    public fun check_triangular_arb(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg3 * arg1 / arg0 * arg2 / arg1 * arg0 / arg2;
        if (v0 > arg3) {
            v0 - arg3
        } else {
            0
        }
    }

    public fun find_best_pool(arg0: vector<u64>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + 1;
        };
        0
    }

    public entry fun get_kriya_reserves<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v3 = if (v1 > 0) {
            v0 / v1
        } else {
            0
        };
        let v4 = if (v0 > 0) {
            v1 / v0
        } else {
            0
        };
        let v5 = ReservesFound{
            pool_type     : b"kriya",
            reserve_x     : v0,
            reserve_y     : v1,
            price_x_per_y : v3,
            price_y_per_x : v4,
        };
        0x2::event::emit<ReservesFound>(v5);
    }

    public fun optimal_swap_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        arg0 / 3 * (10000 - arg2) / 10000
    }

    // decompiled from Move bytecode v7
}

