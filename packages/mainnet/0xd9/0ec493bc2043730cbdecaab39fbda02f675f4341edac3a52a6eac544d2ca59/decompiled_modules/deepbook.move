module 0xd90ec493bc2043730cbdecaab39fbda02f675f4341edac3a52a6eac544d2ca59::deepbook {
    public fun borrow<T0>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T0>(arg1, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::open_loan(arg0), arg2);
        (0x2::coin::into_balance<0x2::sui::SUI>(v0), v1)
    }

    fun ask_quantity<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()));
        let (_, v5, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        v3 - v3 % v5
    }

    fun bid_quantity<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, arg1, arg2);
        let (_, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        v0 - v0 % v4
    }

    public fun buy_base<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = bid_quantity<T0, T1>(arg1, 0x2::balance::value<T1>(&arg3), arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(arg3, arg5), arg5);
        let (v3, v4) = fill<T0, T1>(arg1, arg2, v0, true, false, v1, v2, arg4, arg5);
        let v5 = 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg2, v3, arg5));
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, remainder<T1>(0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v4, arg5)), arg5))
    }

    public fun buy_base_deep<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = deep_leg<T0, T1>(arg1, arg4, arg5);
        let (v2, _, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0, 0x2::balance::value<T1>(&arg3), arg6);
        let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(arg3, arg7), arg7);
        let (v11, v12) = fill<T0, T1>(arg1, arg2, v2 - v2 % v6, true, true, v8, v9, arg6, arg7);
        charge_deep(arg0, v10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), deep_bound(v4, v0, v1), arg5);
        let v13 = 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg2, v11, arg7));
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v13));
        (v13, remainder<T1>(0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v12, arg7)), arg7))
    }

    fun charge_deep(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= arg1 && arg1 - arg2 <= arg3, 5);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::add_cost(arg0, deep_value(arg1 - arg2, arg4));
    }

    fun deep_bound(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::ceil_mul_div(arg0 + 1, arg2, arg1)
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
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::ceil_mul_div(arg0, arg1, 1000000000)
    }

    fun estimate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let v0 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::floor_mul_div(arg1, 1000000000 + 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::floor_mul_div(arg3, 5, 4), 1000000000 + 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::ceil_mul_div(arg4, 5, 4));
        if (v0 == 0) {
            return (0, 0)
        };
        let (v1, v2) = if (arg2) {
            let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v0, arg5);
            (v3, v4)
        } else {
            let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v0, arg5);
            (v6, v7)
        };
        if (arg2) {
            (v2, v1)
        } else {
            (v1, v2)
        }
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
        (v0, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::checked_sum(0x1::u64::max(v0, v3), arg1))
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
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()
    }

    fun is_sui<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()
    }

    public fun quote<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = fee_bounds<T0, T1>(arg1, arg3);
        let v2 = arg2 && is_sui<T0>() || is_sui<T1>();
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::quote_inputs(arg0);
        0x1::vector::reverse<u64>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v5)) {
            let (v7, v8) = estimate<T0, T1>(arg1, 0x1::vector::pop_back<u64>(&mut v5), arg2, v0, v1, arg4);
            0x1::vector::push_back<u64>(&mut v3, v7);
            if (v2) {
                0x1::vector::push_back<u64>(&mut v4, v8);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<u64>(v5);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_quote(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2, v3, vector[], v4);
    }

    public fun quote_deep<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = deep_leg<T0, T1>(arg1, arg3, arg4);
        let v2 = arg2 && is_sui<T0>() || is_sui<T1>();
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::quote_inputs(arg0);
        0x1::vector::reverse<u64>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v6)) {
            let (v8, v9, v10) = estimate_deep<T0, T1>(arg1, 0x1::vector::pop_back<u64>(&mut v6), arg2, v0, v1, arg5);
            0x1::vector::push_back<u64>(&mut v3, v8);
            0x1::vector::push_back<u64>(&mut v4, deep_value(v10, arg4));
            if (v2) {
                0x1::vector::push_back<u64>(&mut v5, v9);
            };
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u64>(v6);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_quote(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2, v3, v4, v5);
    }

    fun remainder<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T0>(&arg0) == 0 || is_sui<T0>()) {
            return arg0
        };
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        0x2::balance::zero<T0>()
    }

    public fun repay<T0>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::close_loan(arg0, &mut arg2)), arg4), arg3);
        arg2
    }

    public fun sell_base<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = ask_quantity<T0, T1>(arg1, 0x2::balance::value<T0>(&arg3));
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg2, 0x2::coin::from_balance<T0>(arg3, arg5), arg5);
        let (v3, v4) = fill<T0, T1>(arg1, arg2, v0, false, false, v1, v2, arg4, arg5);
        let v5 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v4, arg5));
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, remainder<T0>(0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg2, v3, arg5)), arg5))
    }

    public fun sell_base_deep<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = deep_leg<T0, T1>(arg1, arg4, arg5);
        let (_, _, v4) = estimate_deep<T0, T1>(arg1, 0x2::balance::value<T0>(&arg3), true, v0, v1, arg6);
        let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg2, 0x2::coin::from_balance<T0>(arg3, arg7), arg7);
        let (v11, v12) = fill<T0, T1>(arg1, arg2, 0x2::balance::value<T0>(&arg3) - 0x2::balance::value<T0>(&arg3) % v6, false, true, v8, v9, arg6, arg7);
        charge_deep(arg0, v10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), v4, arg5);
        let v13 = 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg2, v12, arg7));
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v13));
        (v13, remainder<T0>(0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg2, v11, arg7)), arg7))
    }

    // decompiled from Move bytecode v7
}

