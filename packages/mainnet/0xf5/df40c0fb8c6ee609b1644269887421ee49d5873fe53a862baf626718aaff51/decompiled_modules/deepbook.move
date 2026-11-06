module 0xf5df40c0fb8c6ee609b1644269887421ee49d5873fe53a862baf626718aaff51::deepbook {
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
        let v4 = v1 + 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling());
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

    public fun buy_base<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg1, 0x2::coin::from_balance<T2>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v0;
        settle_deep(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v3));
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T2>(v1))
    }

    public fun buy_base_deep<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T1, T2>(arg1, 0x2::balance::value<T2>(&arg3), false, v0, v1, arg6);
        let v5 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        assert!(v5 > 0 && v5 >= v4, 2);
        let (v6, v7) = if (same<T1, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>() || same<T2, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            let v8 = 0x2::coin::zero<T1>(arg7);
            let v9 = 0x2::coin::from_balance<T2>(arg3, arg7);
            swap_deep_separated<T1, T2>(arg1, v8, v9, arg2, v4, 0, arg6, arg7)
        } else {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T1, T2>(arg1, 0x2::coin::from_balance<T2>(arg3, arg7), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v5), arg7), 1, arg6, arg7);
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12));
            (v10, v11)
        };
        let v13 = v6;
        charge_owned<T0>(arg0, v5, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v13));
        (0x2::coin::into_balance<T1>(v13), 0x2::coin::into_balance<T2>(v7))
    }

    public fun buy_base_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let v1 = 0x2::coin::from_balance<T2>(arg2, arg5);
        let (v2, v3) = swap_input_limit<T1, T2>(arg1, v0, v1, arg3, arg4, arg5);
        let v4 = v2;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v4));
        (0x2::coin::into_balance<T1>(v4), 0x2::coin::into_balance<T2>(v3))
    }

    public fun buy_base_limit_deep<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg6 > 0, 3);
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T1, T2>(arg1, 0x2::balance::value<T2>(&arg3), false, v0, v1, arg7);
        let v5 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        assert!(v5 > 0 && v5 >= v4, 2);
        let v6 = 0x2::coin::zero<T1>(arg8);
        let v7 = 0x2::coin::from_balance<T2>(arg3, arg8);
        let (v8, v9) = swap_deep_separated<T1, T2>(arg1, v6, v7, arg2, v4, arg6, arg7, arg8);
        let v10 = v8;
        charge_owned<T0>(arg0, v5, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v10));
        (0x2::coin::into_balance<T1>(v10), 0x2::coin::into_balance<T2>(v9))
    }

    fun charge_owned<T0>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= arg1 && arg1 - arg2 <= arg3, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::add_cost<T0>(arg0, deep_value(arg1 - arg2, arg4));
    }

    public fun close_fee(arg0: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg1: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg2));
    }

    fun deep_bound(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(arg0 + 1, arg2, arg1)
    }

    fun deep_leg<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg2 > 0, 3);
        assert!(arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        assert!(v0 > 0 || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), 2);
        (v0, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::checked_sum(0x1::u64::max(v0, v3), arg1))
    }

    fun deep_value(arg0: u64, arg1: u64) : u64 {
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(arg0, arg1, 1000000000)
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

    fun estimate_deep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg1 == 0) {
            return (0, 0, 0)
        };
        let (v0, v1, v2) = if (arg2) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg1, arg5)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg1, arg5)
        };
        let v3 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0)) {
            0
        } else {
            deep_bound(v2, arg3, arg4)
        };
        let (v4, v5) = if (arg2) {
            (v1, v0)
        } else {
            (v0, v1)
        };
        (v4, v5, v3)
    }

    public fun open_fee(arg0: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg1 > 0, 2);
        0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1, arg2))
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T1, T2>(arg1);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T1, T2>(arg1);
        let v6 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::checked_sum(0x1::u64::max(v0, v3), arg3);
        let (_, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg1);
        let v10 = (arg2 && same<T0, T1>() || same<T0, T2>()) && v6 == v0;
        let v11 = vector[];
        let v12 = vector[];
        let v13 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
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
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), arg2, v11, vector[], v12);
    }

    public fun quote_deep<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg3, arg4);
        let v2 = arg2 && same<T0, T1>() || same<T0, T2>();
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v6)) {
            let (v8, v9, v10) = estimate_deep<T1, T2>(arg1, 0x1::vector::pop_back<u64>(&mut v6), arg2, v0, v1, arg5);
            0x1::vector::push_back<u64>(&mut v3, v8);
            0x1::vector::push_back<u64>(&mut v4, deep_value(v10, arg4));
            if (v2) {
                0x1::vector::push_back<u64>(&mut v5, v9);
            };
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u64>(v6);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), arg2, v3, v4, v5);
    }

    fun reserved(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::floor_mul_div(arg0, 1000000000 + 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::floor_mul_div(arg1, 5, 4), 1000000000 + 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::search::ceil_mul_div(arg2, 5, 4))
    }

    fun same<T0, T1>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>()
    }

    public fun sell_base<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v1;
        settle_deep(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v3));
        (0x2::coin::into_balance<T2>(v3), 0x2::coin::into_balance<T1>(v0))
    }

    public fun sell_base_deep<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T1, T2>(arg1, 0x2::balance::value<T1>(&arg3), true, v0, v1, arg6);
        let v5 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        assert!(v5 > 0 && v5 >= v4, 2);
        let (v6, v7) = if (same<T1, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>() || same<T2, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            let v8 = 0x2::coin::from_balance<T1>(arg3, arg7);
            let v9 = 0x2::coin::zero<T2>(arg7);
            swap_deep_separated<T1, T2>(arg1, v8, v9, arg2, v4, 0, arg6, arg7)
        } else {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T1, T2>(arg1, 0x2::coin::from_balance<T1>(arg3, arg7), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, v5), arg7), 1, arg6, arg7);
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12));
            (v10, v11)
        };
        let v13 = v7;
        charge_owned<T0>(arg0, v5, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v13));
        (0x2::coin::into_balance<T2>(v13), 0x2::coin::into_balance<T1>(v6))
    }

    public fun sell_base_limit<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::from_balance<T1>(arg2, arg5);
        let v1 = 0x2::coin::zero<T2>(arg5);
        let (v2, v3) = swap_input_limit<T1, T2>(arg1, v0, v1, arg3, arg4, arg5);
        let v4 = v3;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v4));
        (0x2::coin::into_balance<T2>(v4), 0x2::coin::into_balance<T1>(v2))
    }

    public fun sell_base_limit_deep<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        assert!(arg6 > 0, 3);
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T1, T2>(arg1, 0x2::balance::value<T1>(&arg3), true, v0, v1, arg7);
        let v5 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        assert!(v5 > 0 && v5 >= v4, 2);
        let v6 = 0x2::coin::from_balance<T1>(arg3, arg8);
        let v7 = 0x2::coin::zero<T2>(arg8);
        let (v8, v9) = swap_deep_separated<T1, T2>(arg1, v6, v7, arg2, v4, arg6, arg7, arg8);
        let v10 = v9;
        charge_owned<T0>(arg0, v5, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v10));
        (0x2::coin::into_balance<T2>(v10), 0x2::coin::into_balance<T1>(v8))
    }

    fun settle_deep(arg0: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
    }

    fun swap_deep_separated<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 != v1 > 0, 3);
        let v2 = v1 > 0;
        let v3 = if (v2) {
            let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v1, arg6);
            v4
        } else {
            v0
        };
        let (_, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v10 = v3 - v3 % v8;
        if (v10 < v9) {
            return (arg1, arg2)
        };
        let v11 = 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3);
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg7);
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v12, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut v12, arg1, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(&mut v12, arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v12, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v11), arg7), arg7);
        let v14 = if (arg5 == 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, &mut v12, &v13, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v10, v2, true, arg6, arg7)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, &mut v12, &v13, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, v10, v2, true, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg6, arg7)
        };
        let v15 = v14;
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v15);
        let v17 = if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v15)) {
            if (v16 <= arg4) {
                v16 <= v11
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 2);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v12, v11 - v16, arg7)));
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut v12, arg7);
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(&mut v12, arg7);
        let v20 = if (v2) {
            0x2::coin::value<T0>(&v18)
        } else {
            0x2::coin::value<T1>(&v19)
        };
        assert!(v20 > 0, 3);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v12, 0x2::tx_context::sender(arg7));
        (v18, v19)
    }

    fun swap_input_limit<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg3 > 0, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 != v1 > 0, 3);
        let v2 = v1 > 0;
        let v3 = if (v2) {
            let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, v1, arg4);
            v4
        } else {
            let (v7, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()))
        };
        let (_, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v13 = v3 - v3 % v11;
        if (v13 < v12) {
            return (arg1, arg2)
        };
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg5);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut v14, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut v14, arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(&mut v14, arg2, arg5);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, &mut v14, &v15, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, v13, v2, false, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg4, arg5);
        assert!(!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v16), 2);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut v14, arg5);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(&mut v14, arg5);
        let v19 = if (v2) {
            0x2::coin::value<T0>(&v17)
        } else {
            0x2::coin::value<T1>(&v18)
        };
        assert!(v19 > 0, 3);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v14, 0x2::tx_context::sender(arg5));
        (v17, v18)
    }

    // decompiled from Move bytecode v7
}

