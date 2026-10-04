module 0x20fbf825d0c4d03e09356cdf67a2601ba3c1c1b33391edaa2d40e92462def2d4::deepbook {
    fun ask_input(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == arg1) {
            arg0
        } else {
            reserved(arg0, arg1, arg2)
        }
    }

    fun ask_plan(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()));
        let v1 = v0 - v0 % arg2;
        let v2 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128);
        let v3 = (v1 as u128) + (v1 as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier() as u128) / v2 * (arg1 as u128) / v2;
        if (v1 < arg3 || v3 > (arg0 as u128)) {
            return (0, 0, 0)
        };
        let v4 = v1 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling());
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills();
        let v6 = if (arg2 >= v5) {
            0
        } else {
            v5
        };
        if (v4 <= v6) {
            return (0, 0, 0)
        };
        (v1, (v3 as u64), v4 - v6)
    }

    public fun buy_base<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg1, 0x2::coin::from_balance<T2>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v0;
        settle_deep(v2);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v3));
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T2>(v1))
    }

    fun estimate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        if (!arg2) {
            let v0 = reserved(arg1, arg3, arg4);
            if (v0 == 0) {
                return (0, 0)
            };
            let (v1, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v0, arg7);
            return (v1, v2)
        };
        let v4 = ask_input(arg1, arg3, arg4);
        if (v4 == 0) {
            return (0, 0)
        };
        let (v5, v6, v7) = ask_plan(v4, arg3, arg5, arg6);
        if (v5 == 0) {
            return (0, v4)
        };
        let (_, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v7, arg7);
        (v9, v4 - v6)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T2>(arg1);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T1, T2>(arg1);
        let v6 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(0x1::u64::max(v0, v3), arg3);
        let (_, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg1);
        let v10 = (arg2 && same<T0, T1>() || same<T0, T2>()) && v6 == v0;
        let v11 = vector[];
        let v12 = vector[];
        let v13 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v13);
        let v14 = 0;
        while (v14 < 0x1::vector::length<u64>(&v13)) {
            let (v15, v16) = estimate<T1, T2>(arg1, 0x1::vector::pop_back<u64>(&mut v13), arg2, v0, v6, v8, v9, arg4);
            0x1::vector::push_back<u64>(&mut v11, v15);
            if (v10) {
                0x1::vector::push_back<u64>(&mut v12, v16);
            };
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<u64>(v13);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), arg2, v11, vector[], v12);
    }

    fun reserved(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::floor_mul_div(arg0, 1000000000 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::floor_mul_div(arg1, 5, 4), 1000000000 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(arg2, 5, 4))
    }

    fun same<T0, T1>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>()
    }

    public fun sell_base<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v1;
        settle_deep(v2);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v3));
        (0x2::coin::into_balance<T2>(v3), 0x2::coin::into_balance<T1>(v0))
    }

    fun settle_deep(arg0: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
    }

    // decompiled from Move bytecode v7
}

