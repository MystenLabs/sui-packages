module 0x63b8c60108d91a85922b5ccb0c456e50c49f499b8bc552032b3f95cd2760b888::clmm_liquidity_script {
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

    struct RepositionEvent has copy, drop, store {
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct CalcSwapAmountResult has copy, drop, store {
        amount_a: u64,
        amount_b: u64,
        a2b: bool,
    }

    struct CalcSwapAmountResult2 has copy, drop, store {
        do_swap: bool,
        amount_a: u64,
        amount_b: u64,
        a2b: bool,
    }

    fun after_tick_in_range(arg0: u32, arg1: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) : bool {
        let v0 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(arg0);
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::mul(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::div(arg1, v0), v0);
        0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::gte(arg2, v1) && 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::lt(arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::add(v1, v0))
    }

    fun binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: bool, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg5: u64, arg6: u64, arg7: u8, arg8: u8) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 1;
        let v4 = arg5 / 2;
        let v5 = 0x1::vector::empty<u128>();
        let v6 = 0x1::vector::empty<u64>();
        while (v3 <= 2) {
            let v7 = v4 * v3;
            let v8 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg2, arg1, true, v7);
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v8);
            let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result_step_results(&v8);
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) > 1) {
                break
            };
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) == 1) {
                let v11 = *0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10, 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) - 1);
                assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_current_liquidity(&v11) == 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg2), 9223374364727050239);
                let (v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v9), v9, arg5 - v7, arg1);
                let v15 = v12;
                if (arg1) {
                    if (v14 > arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v8)) {
                        let (v16, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v9), v9, arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v8), !arg1);
                        assert!(v12 > v16, 9223374454921363455);
                        v15 = v16;
                    };
                } else if (v13 > arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v8)) {
                    let (v19, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v9), v9, arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v8), !arg1);
                    assert!(v12 > v19, 9223374506460971007);
                    v15 = v19;
                };
                0x1::vector::push_back<u128>(&mut v5, v15);
                0x1::vector::push_back<u64>(&mut v6, v7);
            };
            v3 = v3 + 1;
        };
        v3 = 0;
        let v22 = 0;
        let v23 = 0;
        while (v3 < 0x1::vector::length<u128>(&v5)) {
            if (*0x1::vector::borrow<u128>(&v5, v3) > v22) {
                v22 = *0x1::vector::borrow<u128>(&v5, v3);
            };
            v3 = v3 + 1;
        };
        let v24 = if (*0x1::vector::borrow<u64>(&v6, v23) > v4) {
            *0x1::vector::borrow<u64>(&v6, v23) - v4
        } else {
            0
        };
        let v25 = v24;
        let v26 = if (*0x1::vector::borrow<u64>(&v6, v23) + v4 >= arg5) {
            arg5
        } else {
            *0x1::vector::borrow<u64>(&v6, v23) + v4
        };
        let v27 = v26;
        let v28 = 0;
        while (v28 < 64) {
            let v29 = (v27 + v25) / 2;
            let v30 = if (v29 > v0) {
                v29 - v0
            } else {
                v0 - v29
            };
            if (v30 <= 0x1::u64::pow(10, arg7)) {
                break
            };
            let v31 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg2, arg1, true, v29);
            let v32 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v31);
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result_step_results(&v31)) > 1) {
                v27 = v29;
            } else {
                let v33 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v31);
                let v34 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v32);
                let (v35, v36, v37) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, v34, v32, arg5 - v29, arg1);
                let v38 = v35;
                if (arg1) {
                    if (v37 > arg6 + v33) {
                        let (v39, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, v34, v32, arg6 + v33, !arg1);
                        assert!(v35 > v39, 9223374862943256575);
                        v38 = v39;
                    };
                } else if (v36 > arg6 + v33) {
                    let (v42, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, v34, v32, arg6 + v33, !arg1);
                    assert!(v35 > v42, 9223374918777831423);
                    v38 = v42;
                };
                if (v38 > 0) {
                    v1 = v29;
                    v2 = v33;
                    let (v45, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, v34, v32, arg5 - v29 * 1001 / 1000, arg1);
                    if (v45 > v38) {
                        v25 = v29;
                    } else {
                        v27 = v29;
                    };
                } else if (v38 < 0) {
                    if (v29 > v0) {
                        v27 = v29;
                    } else {
                        v25 = v29;
                    };
                } else {
                    v25 = v29;
                };
            };
            let v48 = v28;
            v28 = v48 + 1;
        };
        0x1::debug::print<u64>(&v28);
        (v1, v2)
    }

    public fun calc_swap_amount<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        abort 1
    }

    fun calc_swap_amount_in_one_pool_internal2<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: u64, arg5: u64, arg6: u8, arg7: u8) : (bool, u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg4, true);
        let (v4, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg5, false);
        if (v1 > v4) {
            let (v11, v12) = binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0, true, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
            (true, v11, v12, true)
        } else {
            let (v13, v14) = binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0, false, arg1, arg2, arg3, arg5, arg4, arg7, arg6);
            (true, v13, v14, false)
        }
    }

    public fun calc_swap_amount_in_ratio<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        abort 1
    }

    fun calc_swap_amount_in_ratio_mmt<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: u64, arg4: u64, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : (bool, u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, _, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg1, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), v0, arg3, true);
        let (v4, v5, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg1, arg2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), v0, arg4, false);
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2);
        if (v1 == v4) {
            return (false, arg3, arg4, false)
        };
        let (v8, v9, v10) = if (v1 > v4) {
            let v11 = arg3 - v5;
            let v12 = 0;
            let v13 = 0;
            let v14 = 0;
            let v15 = 0;
            while (v15 < 20 && v12 < v11) {
                v11 = (v11 + v12) / 2;
                v13 = v11;
                let v16 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg5, true, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), v11);
                let v17 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v16);
                v14 = v17;
                if (((arg4 as u256) + (v17 as u256)) * 18446744073709551616 / ((arg3 - v11) as u256) >= ((v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg1)) as u256) * (v0 as u256) * (v7 as u256) / 18446744073709551616 / ((v7 - v0) as u256)) {
                } else {
                    v12 = v11;
                };
                v15 = v15 + 1;
            };
            (v13, v14, true)
        } else {
            let v18 = arg4 - v3;
            let v19 = 0;
            let v20 = 0;
            let v21 = 0;
            let v22 = 0;
            while (v22 < 20 && v19 < v18) {
                v18 = (v18 + v19) / 2;
                v20 = v18;
                let v23 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg5, false, true, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), v18);
                let v24 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v23);
                v21 = v24;
                if (((arg4 as u256) - (v18 as u256)) * 18446744073709551616 / ((arg3 + v24) as u256) >= ((v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg1)) as u256) * (v0 as u256) * (v7 as u256) / 18446744073709551616 / ((v7 - v0) as u256)) {
                    v19 = v18;
                };
                v22 = v22 + 1;
            };
            (v21, v20, false)
        };
        (true, v8, v9, v10)
    }

    public entry fun close_position_withdraw_capital<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg3, &v0, true);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg1, arg3, &mut v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v0), arg4);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg1, arg3, v0);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())));
        0x2::balance::join<T1>(&mut v3, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>())));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v0, arg2, true, arg4), arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun extract_balance_from_botcap<T0>(arg0: &mut BotCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9223372346092421119);
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

    public fun get_balance_in_botcap<T0>(arg0: &BotCap) : u64 {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
        }
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

    fun liquidity_diff_trigger_swap(arg0: u128, arg1: u128) : bool {
        arg0 > arg1 && (arg1 == 0 || arg0 * 100 / arg1 > 101) || arg0 == 0 || arg1 * 100 / arg0 > 101
    }

    fun remove_swap_add_in_one_pool<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = reposition_tick_range(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg2));
        if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg1)) {
            let v2 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg1);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_position_exist<T0, T1>(arg2, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v2)), 1);
            let (v3, v4) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg0, arg2, &mut v2, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v2), arg7);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg0, arg2, v2);
            0x2::balance::join<T0>(&mut arg3, v3);
            0x2::balance::join<T1>(&mut arg4, v4);
        };
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg0, arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v0), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1), arg8);
        let v6 = RepositionEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v5),
            tick_lower  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v0),
            tick_upper  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1),
        };
        0x2::event::emit<RepositionEvent>(v6);
        let (v7, v8, _, v10) = calc_swap_amount_in_one_pool_internal2<T0, T1>(arg0, arg2, v0, v1, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4), arg5, arg6);
        if (v7) {
            let v11 = if (v10) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
            };
            let (v12, v13, v14) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg2, v10, true, v8, v11, arg7);
            let v15 = v14;
            if (v10) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v15)), 0x2::balance::zero<T1>(), v15);
                0x2::balance::join<T1>(&mut arg4, v13);
                0x2::balance::destroy_zero<T0>(v12);
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v15)), v15);
                0x2::balance::join<T0>(&mut arg3, v12);
                0x2::balance::destroy_zero<T1>(v13);
            };
        };
        let (_, _, v18) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v0, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3), true);
        let (_, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v0, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T1>(&arg4), false);
        let v22 = if (v18 <= 0x2::balance::value<T1>(&arg4)) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v5, 0x2::balance::value<T0>(&arg3), true, arg7, arg8)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v5, 0x2::balance::value<T1>(&arg4), false, arg7, arg8)
        };
        let v23 = v22;
        let (v24, v25) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v23);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3, v24), 0x2::balance::split<T1>(&mut arg4, v25), v23);
        0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1);
        (v5, arg3, arg4)
    }

    public entry fun remove_swap_add_with_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    fun reposition_internal_with_mmt<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg2));
        let v2 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::mul(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::div(v0, v1), v1);
        let v3 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::add(v2, v1);
        if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg1)) {
            let v4 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg1);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_position_exist<T0, T1>(arg2, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v4)), 1);
            let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg0, arg2, &mut v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v4), arg7);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg0, arg2, v4);
            0x2::balance::join<T0>(&mut arg3, v5);
            0x2::balance::join<T1>(&mut arg4, v6);
        };
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg0, arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v3), arg8);
        let (v8, v9, v10, v11) = calc_swap_amount_in_ratio_mmt<T0, T1>(arg2, v2, v3, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4), arg6);
        if (v8) {
            let v12 = if (v11) {
                v9
            } else {
                v10
            };
            let v13 = if (v11) {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price()
            } else {
                0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price()
            };
            let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg6, v11, true, v12, v13, arg7, arg5, arg8);
            let v17 = v16;
            let v18 = v15;
            let v19 = v14;
            if (v11) {
                assert!(0x2::balance::value<T1>(&v18) >= v10, 9223376980362133503);
            } else {
                assert!(0x2::balance::value<T0>(&v19) >= v9, 9223376988952068095);
            };
            let (v20, v21) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v17);
            let v22 = if (v20 > 0) {
                0x2::balance::split<T0>(&mut arg3, v20)
            } else {
                0x2::balance::zero<T0>()
            };
            let v23 = if (v21 > 0) {
                0x2::balance::split<T1>(&mut arg4, v21)
            } else {
                0x2::balance::zero<T1>()
            };
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg6, v17, v22, v23, arg5, arg8);
            0x2::balance::join<T0>(&mut arg3, v19);
            0x2::balance::join<T1>(&mut arg4, v18);
        };
        let (_, _, v26) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v2, v3, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3), true);
        let v27 = if (v26 <= 0x2::balance::value<T1>(&arg4)) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T0>(&arg3), true, arg7, arg8)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T1>(&arg4), false, arg7, arg8)
        };
        let v28 = v27;
        let (v29, v30) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v28);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3, v29), 0x2::balance::split<T1>(&mut arg4, v30), v28);
        0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1);
        let v31 = RepositionEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v7),
            tick_lower  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2),
            tick_upper  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v3),
        };
        0x2::event::emit<RepositionEvent>(v31);
        (v7, arg3, arg4)
    }

    public entry fun reposition_mmt_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0.position)) {
            let v3 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position);
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg3, &v3, true);
            let v6 = v5;
            let v7 = v4;
            0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(arg4));
            0x2::balance::join<T1>(&mut v6, 0x2::coin::into_balance<T1>(arg5));
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T2>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>(), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg8));
            } else {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>()), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg8));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
                0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T1>())) {
                0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>())));
            };
            reposition_internal_with_mmt<T0, T1>(arg1, 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v3), arg3, v7, v6, arg6, arg7, arg8, arg9)
        } else {
            reposition_internal_with_mmt<T0, T1>(arg1, 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(), arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9)
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

    fun reposition_tick_range(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg1: u32) : (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) {
        let v0 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(arg1);
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::mul(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::div(arg0, v0), v0);
        (v1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::add(v1, v0))
    }

    public entry fun single_pool_remove_swap_add_decimals_with_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u8, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0.position)) {
            let v3 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position);
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg3, &v3, true);
            let v6 = v5;
            let v7 = v4;
            0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(arg4));
            0x2::balance::join<T1>(&mut v6, 0x2::coin::into_balance<T1>(arg5));
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T2>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>(), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg8));
            } else {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>()), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg8));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
                0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T1>())) {
                0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>())));
            };
            remove_swap_add_in_one_pool<T0, T1>(arg1, 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v3), arg3, v7, v6, arg6, arg7, arg8, arg9)
        } else {
            remove_swap_add_in_one_pool<T0, T1>(arg1, 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(), arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7, arg8, arg9)
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

    public entry fun single_pool_remove_swap_add_with_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

