module 0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::f {
    struct TradingPair<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        concentration: u64,
        big_k: u128,
        target_x: u64,
        mult_x: u64,
        mult_y: u64,
        fee_millionth: u64,
        x_price_id: address,
        y_price_id: address,
        x_retain_decimals: u64,
        y_retain_decimals: u64,
        cumulative_volume: u64,
        volumes: vector<u64>,
        times: vector<u64>,
        target_y_based_lock: bool,
        target_y_reference: u64,
        pyth_mode: bool,
        pyth_y_add: u64,
        pyth_y_sub: u64,
    }

    public fun fsxy<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, true, 0, arg2, 0x2::coin::zero<T1>(arg4), arg3, arg4);
        0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::u::tod<T0>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    public fun fsyx<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg0, arg1, false, 0, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::u::tod<T1>(v1, 0x2::tx_context::sender(arg4));
        v0
    }

    fun get_target_y<T0, T1>(arg0: &TradingPair<T0, T1>) : u64 {
        (0x2::balance::value<T0>(&arg0.reserve_x) * arg0.mult_x + 0x2::balance::value<T1>(&arg0.reserve_y) * arg0.mult_y - arg0.target_x * arg0.mult_x) / arg0.mult_y
    }

    fun is_target_y_locked<T0, T1>(arg0: &mut TradingPair<T0, T1>) : bool {
        let v0 = get_target_y<T0, T1>(arg0);
        0x1::debug::print<u64>(&v0);
        let v1 = if (v0 > arg0.target_y_reference) {
            v0
        } else {
            arg0.target_y_reference
        };
        arg0.target_y_reference = v1;
        if ((arg0.target_y_reference - v0) * 10000 / arg0.target_y_reference > 500) {
            arg0.target_y_based_lock = true;
        };
        arg0.target_y_based_lock
    }

    public fun quote_x_to_y<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_target_y_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_x_to_y_((arg1 as u128), (arg0.target_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.mult_x as u128), (arg0.mult_y as u128))
        }
    }

    fun quote_x_to_y_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v1 / v2 - v1 / (v2 + arg0)) as u64);
        assert!((v3 as u128) < arg4, 3);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    public fun quote_y_to_x<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_target_y_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_y_to_x_((arg1 as u128), (arg0.target_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.mult_x as u128), (arg0.mult_y as u128))
        }
    }

    fun quote_y_to_x_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v2 - v1 / (v1 / v2 + arg0)) as u64);
        assert!((v3 as u128) < arg3, 2);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    // decompiled from Move bytecode v6
}

