module 0x7e94bb2b910eb3415c6842955d9bc631e003475fcf965f42ff831338ce4b8855::deepbook {
    fun ask_input(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == arg1) {
            arg0
        } else {
            reserved(arg0, arg1, arg2)
        }
    }

    fun ask_plan(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = ask_size(arg0, arg1, arg2);
        let v1 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() as u128);
        let v2 = (v0 as u128) + (v0 as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier() as u128) / v1 * (arg1 as u128) / v1;
        if (v0 < arg3 || v2 > (arg0 as u128)) {
            return (0, 0, 0)
        };
        let v3 = v0 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling());
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills();
        let v5 = if (arg2 >= v4) {
            0
        } else {
            v4
        };
        if (v3 <= v5) {
            return (0, 0, 0)
        };
        (v0, (v2 as u64), v3 - v5)
    }

    fun ask_quantity<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        ask_size(arg1, v0, v4)
    }

    fun ask_size(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()));
        v0 - v0 % arg2
    }

    fun bid_quantity<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, arg1, arg2);
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        v0 - v0 % v4
    }

    public fun buy_base<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = bid_quantity<T1, T2>(arg1, 0x2::balance::value<T2>(&arg3), arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg2, 0x2::coin::from_balance<T2>(arg3, arg5), arg5);
        let (v3, v4) = fill<T1, T2>(arg1, arg2, v0, true, false, v1, v2, arg4, arg5);
        let v5 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v3, arg5));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, remainder<T0, T2>(0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg2, v4, arg5)), arg5))
    }

    public fun buy_base_deep<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (v2, _, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T1, T2>(arg1, 0, 0x2::balance::value<T2>(&arg3), arg6);
        let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg1);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg2, 0x2::coin::from_balance<T2>(arg3, arg7), arg7);
        let (v11, v12) = fill<T1, T2>(arg1, arg2, v2 - v2 % v6, true, true, v8, v9, arg6, arg7);
        charge_deep<T0>(arg0, v10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), deep_bound(v4, v0, v1), arg5);
        let v13 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v11, arg7));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v13));
        (v13, remainder<T0, T2>(0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg2, v12, arg7)), arg7))
    }

    fun charge_deep<T0>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= arg1 && arg1 - arg2 <= arg3, 5);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::add_cost<T0>(arg0, deep_value(arg1 - arg2, arg4));
    }

    fun deep_bound(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(arg0 + 1, arg2, arg1)
    }

    fun deep_leg<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (arg2 > 0) {
            if (!is_deep<T0>()) {
                !is_deep<T1>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let (v1, v2) = fee_bounds<T0, T1>(arg0, arg1);
        assert!(v1 > 0, 5);
        (v1, v2)
    }

    fun deep_value(arg0: u64, arg1: u64) : u64 {
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(arg0, arg1, 1000000000)
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
        let (v3, v4) = if (arg2) {
            (v1, v0)
        } else {
            (v0, v1)
        };
        (v3, v4, deep_bound(v2, arg3, arg4))
    }

    fun fee_bounds<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : (u64, u64) {
        assert!(arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg0);
        (v0, 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::checked_sum(0x1::u64::max(v0, v3), arg1))
    }

    fun fill<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (u64, u64) {
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        if (arg2 >= v2) {
            let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, arg1);
            let v6 = if (v3 == 0) {
                if (v4 == 0) {
                    v5 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 3);
            let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::get_balance_manager_referral_id(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0));
            assert!(0x1::option::is_none<0x2::object::ID>(&v7), 4);
            let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg8);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v8, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg2, arg3, arg4, arg7, arg8);
        };
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        assert!(v9 >= arg5 && v10 >= arg6, 2);
        (v9 - arg5, v10 - arg6)
    }

    fun is_deep<T0>() : bool {
        same<T0, 0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = fee_bounds<T1, T2>(arg1, arg3);
        let (_, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg1);
        let v5 = (arg2 && same<T0, T1>() || same<T0, T2>()) && v1 == v0;
        let v6 = vector[];
        let v7 = vector[];
        let v8 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v8)) {
            let (v10, v11) = estimate<T1, T2>(arg1, 0x1::vector::pop_back<u64>(&mut v8), arg2, v0, v1, v3, v4, arg4);
            0x1::vector::push_back<u64>(&mut v6, v10);
            if (v5) {
                0x1::vector::push_back<u64>(&mut v7, v11);
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v8);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), arg2, v6, vector[], v7);
    }

    public fun quote_deep<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg3, arg4);
        let v2 = arg2 && same<T0, T1>() || same<T0, T2>();
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
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
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), arg2, v3, v4, v5);
    }

    fun remainder<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T1>(&arg0) == 0 || same<T0, T1>()) {
            return arg0
        };
        0x2::balance::send_funds<T1>(arg0, 0x2::tx_context::sender(arg1));
        0x2::balance::zero<T1>()
    }

    fun reserved(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::floor_mul_div(arg0, 1000000000 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::floor_mul_div(arg1, 5, 4), 1000000000 + 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::search::ceil_mul_div(arg2, 5, 4))
    }

    fun same<T0, T1>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>()
    }

    public fun sell_base<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = ask_quantity<T1, T2>(arg1, 0x2::balance::value<T1>(&arg3));
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(arg3, arg5), arg5);
        let (v3, v4) = fill<T1, T2>(arg1, arg2, v0, false, false, v1, v2, arg4, arg5);
        let v5 = 0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg2, v4, arg5));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, remainder<T0, T1>(0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v3, arg5)), arg5))
    }

    public fun sell_base_deep<T0, T1, T2>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = deep_leg<T1, T2>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T1, T2>(arg1, 0x2::balance::value<T1>(&arg3), true, v0, v1, arg6);
        let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T1, T2>(arg1);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg2);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(arg3, arg7), arg7);
        let (v11, v12) = fill<T1, T2>(arg1, arg2, 0x2::balance::value<T1>(&arg3) - 0x2::balance::value<T1>(&arg3) % v6, false, true, v8, v9, arg6, arg7);
        charge_deep<T0>(arg0, v10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        let v13 = 0x2::coin::into_balance<T2>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T2>(arg2, v12, arg7));
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v13));
        (v13, remainder<T0, T1>(0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v11, arg7)), arg7))
    }

    // decompiled from Move bytecode v7
}

