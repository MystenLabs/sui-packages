module 0x7ab26280da68ad2934828d7f6e1177e40e63a6ccc47ce588d31f460072826bc6::arb {
    struct Probe has drop {
        best_amount: u64,
        best_net: u64,
        gas_floor_base: u64,
        deep_price_scaled: u128,
    }

    public fun add_u64(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun begin(arg0: u64, arg1: u128) : Probe {
        Probe{
            best_amount       : 0,
            best_net          : 0,
            gas_floor_base    : arg0,
            deep_price_scaled : arg1,
        }
    }

    fun deep_cost_in_base(arg0: u64, arg1: u128) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            let v1 = 10 * 1000000000;
            ((arg0 as u128) * arg1 * 11 + v1 - 1) / v1
        }
    }

    public fun finish(arg0: Probe) : u64 {
        assert!(arg0.best_amount > 0, 1);
        arg0.best_amount
    }

    public fun quote_linear(arg0: u64, arg1: u128, arg2: u128) : u64 {
        if (arg0 == 0 || arg2 == 0) {
            0
        } else {
            let v1 = (arg0 as u128) * arg1 / arg2;
            if (v1 > 18446744073709551615) {
                0
            } else {
                (v1 as u64)
            }
        }
    }

    public fun record(arg0: &mut Probe, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        if (arg5 || arg1 == 0) {
            return
        };
        let v0 = (arg2 as u128) + (arg3 as u128);
        if (v0 <= (arg1 as u128)) {
            return
        };
        let v1 = v0 - (arg1 as u128);
        let v2 = (arg0.gas_floor_base as u128) + deep_cost_in_base(arg4, arg0.deep_price_scaled);
        if (v1 > v2) {
            let v3 = v1 - v2;
            let v4 = if (v3 > 18446744073709551615) {
                (18446744073709551615 as u64)
            } else {
                (v3 as u64)
            };
            if (v4 > arg0.best_net) {
                arg0.best_net = v4;
                arg0.best_amount = arg1;
            };
        };
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u128, arg4: address) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0 && (v0 as u128) >= (arg1 as u128) + deep_cost_in_base(arg2, arg3), 2);
        0x2::balance::send_funds<T0>(arg0, arg4);
    }

    public fun step(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: bool) : (u64, bool) {
        let v0 = if (arg4) {
            true
        } else if (arg1) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg3 && arg2 > 0
        };
        let v1 = if (arg0 == 0) {
            1
        } else {
            arg0
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v7
}

