module 0xf31db015430ecfb43022476929ce760a9e962ce762fb95b918c75a2f334481b9::clmm_liquidity_script {
    struct CLMM_LIQUIDITY_SCRIPT has drop {
        dummy_field: bool,
    }

    struct BotCap has store, key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>,
        balances: 0x2::bag::Bag,
    }

    struct ExtractBalanceEvent has copy, drop, store {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CalcSwapAmountResult has copy, drop, store {
        amount_a: u64,
        amount_b: u64,
        a2b: bool,
    }

    public fun calc_swap_amount<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        let (v0, v1, v2) = calc_swap_amount_internal<T0, T1>(arg0, arg1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg2), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg3), arg4, arg5, arg6);
        let v3 = CalcSwapAmountResult{
            amount_a : v0,
            amount_b : v1,
            a2b      : v2,
        };
        0x2::event::emit<CalcSwapAmountResult>(v3);
    }

    fun calc_swap_amount_internal<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : (u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, _, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg4, true);
        let (v4, v5, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg5, false);
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg3);
        if (v1 >= v4) {
            let v11 = arg4 - v5;
            let v12 = 0;
            let v13 = 0;
            let v14 = 0;
            let v15 = 0;
            while (v15 < 20 && v12 < v11) {
                v11 = (v11 + v12) / 2;
                v13 = v11;
                let v16 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg6, true, true, v11);
                let v17 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v16);
                v14 = v17;
                if (((arg5 as u128) + (v17 as u128)) * 18446744073709551616 / ((arg4 - v11) as u128) >= (v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) * 18446744073709551616 / (v7 - v0) * v0 * v7 / 18446744073709551616) {
                } else {
                    v12 = v11;
                };
                v15 = v15 + 1;
            };
            (v13, v14, true)
        } else {
            let v18 = arg5 - v3;
            let v19 = 0;
            let v20 = 0;
            let v21 = 0;
            let v22 = 0;
            while (v22 < 20 && v19 < v18) {
                v18 = (v18 + v19) / 2;
                v20 = v18;
                let v23 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg6, false, true, v18);
                let v24 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v23);
                v21 = v24;
                if (((arg5 as u128) - (v18 as u128)) * 18446744073709551616 / ((arg4 + v24) as u128) >= (v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) * 18446744073709551616 / (v7 - v0) * v0 * v7 / 18446744073709551616) {
                    v19 = v18;
                };
                v22 = v22 + 1;
            };
            (v21, v20, false)
        }
    }

    public entry fun extract_balance_from_botcap<T0>(arg0: &mut BotCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9223372204358500351);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0) && 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) > 0) {
            let v1 = 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg1);
            let v2 = ExtractBalanceEvent{
                token  : v0,
                amount : 0x2::balance::value<T0>(&v1),
            };
            0x2::event::emit<ExtractBalanceEvent>(v2);
        };
    }

    fun init(arg0: CLMM_LIQUIDITY_SCRIPT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CLMM_LIQUIDITY_SCRIPT>(arg0, arg1);
        let v0 = BotCap{
            id       : 0x2::object::new(arg1),
            position : 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(),
            balances : 0x2::bag::new(arg1),
        };
        0x2::transfer::transfer<BotCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun remove_swap_add<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg2));
        let v2 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::mul(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::div(v0, v1), v1);
        let v3 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::add(v2, v1);
        if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg1)) {
            let v4 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg1);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_position_exist<T0, T1>(arg2, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v4)), 1);
            let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg0, arg2, &mut v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v4), arg6);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg0, arg2, v4);
            0x2::balance::join<T0>(&mut arg4, v5);
            0x2::balance::join<T1>(&mut arg5, v6);
        };
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg0, arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v3), arg7);
        let (v8, v9, v10) = calc_swap_amount_internal<T0, T1>(arg0, arg2, v2, v3, 0x2::balance::value<T0>(&arg4), 0x2::balance::value<T1>(&arg5), arg3);
        let v11 = if (v10) {
            v8
        } else {
            v9
        };
        let v12 = if (v10) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
        };
        let (v13, v14, v15) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg3, v10, true, v11, v12, arg6);
        let v16 = v15;
        if (v10) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::split<T0>(&mut arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v16)), 0x2::balance::zero<T1>(), v16);
            0x2::balance::join<T1>(&mut arg5, v14);
            0x2::balance::destroy_zero<T0>(v13);
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v16)), v16);
            0x2::balance::join<T0>(&mut arg4, v13);
            0x2::balance::destroy_zero<T1>(v14);
        };
        let (_, _, v19) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v2, v3, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg4), true);
        let v20 = if (v19 <= 0x2::balance::value<T1>(&arg5)) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T0>(&arg4), true, arg6, arg7)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T1>(&arg5), false, arg6, arg7)
        };
        let v21 = v20;
        let (v22, v23) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v21);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg4, v22), 0x2::balance::split<T1>(&mut arg5, v23), v21);
        0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1);
        (v7, arg4, arg5)
    }

    public entry fun remove_swap_add_with_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0.position)) {
            let v3 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position);
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg3, &v3, true);
            let v6 = v5;
            let v7 = v4;
            0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(arg5));
            0x2::balance::join<T1>(&mut v6, 0x2::coin::into_balance<T1>(arg6));
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T2>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>(), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg7));
            } else {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>()), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg7));
            };
            remove_swap_add<T0, T1>(arg1, 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v3), arg3, arg4, v7, v6, arg7, arg8)
        } else {
            remove_swap_add<T0, T1>(arg1, 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(), arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), arg7, arg8)
        };
        let v8 = v2;
        let v9 = v1;
        if (0x2::balance::value<T0>(&v9) > 0) {
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), v9);
            } else {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), v9);
            };
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        if (0x2::balance::value<T1>(&v8) > 0) {
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T1>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>(), v8);
            } else {
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>()), v8);
            };
        } else {
            0x2::balance::destroy_zero<T1>(v8);
        };
        0x1::option::fill<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position, v0);
    }

    // decompiled from Move bytecode v6
}

