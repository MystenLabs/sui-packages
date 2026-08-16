module 0x570a3a82addc51476c6b9d5635e909d4eb5608f08fdc4a685f2443e9e5ddc9f4::quote {
    public fun bluefin_a2b<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, bluefin_out<T0, T1>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun bluefin_b2a<T0, T1>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, bluefin_out<T0, T1>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun bluefin_out<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 0x570a3a82addc51476c6b9d5635e909d4eb5608f08fdc4a685f2443e9e5ddc9f4::sqrt_limit::bounded(v0, arg1, 4295048017, 79226673515401279992447579054);
        if (!0x570a3a82addc51476c6b9d5635e909d4eb5608f08fdc4a685f2443e9e5ddc9f4::sqrt_limit::usable(v0, v1, arg1)) {
            return 0
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, v1);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v2)) {
            0
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2)
        }
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, turbos_out<T0, T1, T2>(arg1, true, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u8) {
        let v0 = 0;
        while (v0 < 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::ladder_len()) {
            0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::record_quote(arg0, arg2, v0, turbos_out<T0, T1, T2>(arg1, false, 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::quote_in(arg0, v0)));
            v0 = v0 + 1;
        };
    }

    fun turbos_out<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = (arg2 as u128);
        let (_, v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), v1, true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
        if (v3 + v5 < v1) {
            return 0
        };
        (v4 as u64)
    }

    // decompiled from Move bytecode v7
}

