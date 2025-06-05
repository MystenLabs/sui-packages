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

    fun binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: bool, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 1;
        while (v7 <= 100) {
            let v8 = arg5 / 100 * v7;
            let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg2, arg1, true, v8);
            let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result_step_results(&v9);
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) > 1) {
                v5 = v8;
                break
            };
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) == 1) {
                let v11 = *0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10, 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v10) - 1);
                let v12 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_current_sqrt_price(&v11);
                let (v13, _, v15) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v12), v12, arg5 - v8, arg1);
                let v16 = v13;
                if (v15 > arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_amount_out(&v11)) {
                    let (v17, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v12), v12, arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_amount_out(&v11), arg1);
                    v16 = v17;
                };
                if (((v16 as u256) << 64) / ((v16 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_current_liquidity(&v11)) as u256) > 0) {
                    v6 = v4;
                    v5 = v8;
                } else {
                    v5 = v8;
                    break
                };
            };
            v7 = v7 + 1;
        };
        while (v0 < 32) {
            let v20 = (v5 + v6) / 2;
            if (v20 == v1) {
                break
            };
            let v21 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg2, arg1, true, v20);
            let v22 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result_step_results(&v21);
            if (0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v22) > 1) {
                v5 = v20;
            } else {
                let v23 = *0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v22, 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::SwapStepResult>(v22) - 1);
                let v24 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_current_sqrt_price(&v23);
                let (v25, _, v27) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v24), v24, arg5 - v20, arg1);
                let v28 = v25;
                if (v27 > arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_amount_out(&v23)) {
                    let (v29, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg3, arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v24), v24, arg6 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_amount_out(&v23), arg1);
                    v28 = v29;
                };
                let v32 = ((v28 as u256) << 64) / ((v28 + 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_current_liquidity(&v23)) as u256);
                if (v32 > 0) {
                    v2 = v20;
                    v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::step_swap_result_amount_out(&v23);
                    v6 = v20;
                } else if (v32 < 0) {
                    if (v20 > v1) {
                        v5 = v20;
                    } else {
                        v6 = v20;
                    };
                } else {
                    v6 = v20;
                };
            };
            v0 = v0 + 1;
        };
        (v2, v3)
    }

    public fun calc_swap_amount<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        let (v0, v1, v2, v3) = calc_swap_amount_internal<T0, T1>(arg0, arg1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg2), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg3), arg4, arg5, arg6);
        let v4 = CalcSwapAmountResult2{
            do_swap  : v0,
            amount_a : v1,
            amount_b : v2,
            a2b      : v3,
        };
        0x2::event::emit<CalcSwapAmountResult2>(v4);
    }

    fun calc_swap_amount_in_one_pool_internal<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: u64, arg5: u64) : (bool, u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg1);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let (v3, _, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v2, arg4, true);
        let (v6, v7, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v2, arg5, false);
        let v9 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg3);
        if (v3 == v6) {
            return (false, arg4, arg5, false)
        };
        let (v10, v11, v12, v13) = if (v3 > v6) {
            let v14 = arg4 - v7;
            let v15 = 0;
            let v16 = 0;
            let v17 = 0;
            let v18 = 0;
            let v19 = 0;
            while (v19 < 20 && v15 < v14) {
                v14 = (v14 + v15) / 2;
                v16 = v14;
                let v20 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, true, v14);
                let v21 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v20);
                v17 = v21;
                if (((arg5 as u256) + (v21 as u256)) * 18446744073709551616 / ((arg4 - v14) as u256) >= ((v2 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) as u256) * (v2 as u256) * (v9 as u256) / ((v9 - v2) as u256)) {
                } else {
                    v15 = v14;
                };
                v18 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v20);
                v19 = v19 + 1;
            };
            (v16, v17, true, v18)
        } else {
            let v22 = arg5 - v5;
            let v23 = 0;
            let v24 = 0;
            let v25 = 0;
            let v26 = 0;
            let v27 = 0;
            while (v27 < 20 && v23 < v22) {
                v22 = (v22 + v23) / 2;
                v24 = v22;
                let v28 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, false, true, v22);
                let v29 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v28);
                v25 = v29;
                if (((arg5 as u256) - (v22 as u256)) * 18446744073709551616 / ((arg4 + v29) as u256) >= ((v2 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) as u256) * (v2 as u256) * (v9 as u256) / ((v9 - v2) as u256)) {
                    v23 = v22;
                };
                v26 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v28);
                v27 = v27 + 1;
            };
            (v25, v24, false, v26)
        };
        let (v30, v31, v32) = if (after_tick_in_range(v0, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(v13))) {
            (true, v10, v11)
        } else if (v12) {
            let v33 = 0;
            let v34 = v10;
            let v35 = v10 / 2;
            let v36 = 0;
            while (v36 < 10 && v35 < v34) {
                v35 = (v34 + v35) / 2;
                let v37 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, true, v35);
                if (after_tick_in_range(v0, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v37)))) {
                    v34 = v35;
                } else {
                    v33 = v35;
                };
                v36 = v36 + 1;
            };
            if (v33 != 0) {
                let v38 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, v12, true, v33);
                (true, v33, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v38))
            } else {
                (true, v10, v11)
            }
        } else {
            let v39 = 0;
            let v40 = v11;
            let v41 = v11 / 2;
            let v42 = 0;
            while (v42 < 10 && v41 < v40) {
                v41 = (v40 + v41) / 2;
                let v43 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, false, true, v41);
                if (after_tick_in_range(v0, v1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_tick_at_sqrt_price(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_after_sqrt_price(&v43)))) {
                } else {
                    v39 = v41;
                    v40 = v41;
                };
                v42 = v42 + 1;
            };
            if (v39 != 0) {
                let v44 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculate_swap_result<T0, T1>(arg0, arg1, v12, true, v39);
                (true, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::calculated_swap_result_amount_out(&v44), v39)
            } else {
                (true, v10, v11)
            }
        };
        (v30, v31, v32, v12)
    }

    fun calc_swap_amount_in_one_pool_internal2<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: u64, arg5: u64) : (bool, u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg4, true);
        let (v4, _, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg5, false);
        if (!liquidity_diff_trigger_swap(v1, v4)) {
            return (false, arg4, arg5, false)
        };
        if (v1 > v4) {
            let (v11, v12) = binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0, true, arg1, arg2, arg3, arg4, arg5);
            (true, v11, v12, true)
        } else {
            let (v13, v14) = binary_search_for_best_swap_amount_in_pool<T0, T1>(arg0, false, arg1, arg2, arg3, arg5, arg4);
            (true, v13, v14, false)
        }
    }

    fun calc_swap_amount_internal<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg3: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg4: u64, arg5: u64, arg6: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) : (bool, u64, u64, bool) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, _, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg4, true);
        let (v4, v5, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(arg2, arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg1), v0, arg5, false);
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg3);
        if (v1 == v4) {
            return (false, arg4, arg5, false)
        };
        let (v8, v9, v10) = if (v1 > v4) {
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
                if (((arg5 as u256) + (v17 as u256)) * 18446744073709551616 / ((arg4 - v11) as u256) >= ((v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) as u256) * (v0 as u256) * (v7 as u256) / 18446744073709551616 / ((v7 - v0) as u256)) {
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
                if (((arg5 as u256) - (v18 as u256)) * 18446744073709551616 / ((arg4 + v24) as u256) >= ((v0 - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::get_sqrt_price_at_tick(arg2)) as u256) * (v0 as u256) * (v7 as u256) / 18446744073709551616 / ((v7 - v0) as u256)) {
                    v19 = v18;
                };
                v22 = v22 + 1;
            };
            (v21, v20, false)
        };
        (true, v8, v9, v10)
    }

    public entry fun extract_balance_from_botcap<T0>(arg0: &mut BotCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 9223372316027650047);
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
        arg0 > arg1 && arg0 * 10 / arg1 > 11 || arg1 * 10 / arg0 > 11
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
        let (v8, v9, v10, v11) = calc_swap_amount_internal<T0, T1>(arg0, arg2, v2, v3, 0x2::balance::value<T0>(&arg4), 0x2::balance::value<T1>(&arg5), arg3);
        if (v8) {
            let v12 = if (v11) {
                v9
            } else {
                v10
            };
            let v13 = if (v11) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
            };
            let (v14, v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg3, v11, true, v12, v13, arg6);
            let v17 = v16;
            if (v11) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::split<T0>(&mut arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v17)), 0x2::balance::zero<T1>(), v17);
                0x2::balance::join<T1>(&mut arg5, v15);
                0x2::balance::destroy_zero<T0>(v14);
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v17)), v17);
                0x2::balance::join<T0>(&mut arg4, v14);
                0x2::balance::destroy_zero<T1>(v15);
            };
        };
        let (_, _, v20) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v2, v3, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg4), true);
        let v21 = if (v20 <= 0x2::balance::value<T1>(&arg5)) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T0>(&arg4), true, arg6, arg7)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v7, 0x2::balance::value<T1>(&arg5), false, arg6, arg7)
        };
        let v22 = v21;
        let (v23, v24) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v22);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg4, v23), 0x2::balance::split<T1>(&mut arg5, v24), v22);
        0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1);
        (v7, arg4, arg5)
    }

    fun remove_swap_add_in_one_pool<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: 0x1::option::Option<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        let (v1, v2) = reposition_tick_range(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg2));
        if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg1)) {
            let v3 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg1);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_position_exist<T0, T1>(arg2, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v3)), 1);
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg0, arg2, &mut v3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v3), arg5);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg0, arg2, v3);
            0x2::balance::join<T0>(&mut arg3, v4);
            0x2::balance::join<T1>(&mut arg4, v5);
        };
        let v6 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg0, arg2, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2), arg6);
        let v7 = RepositionEvent{
            position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v6),
            tick_lower  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v1),
            tick_upper  : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(v2),
        };
        0x2::event::emit<RepositionEvent>(v7);
        let (v8, v9, v10, v11) = calc_swap_amount_in_one_pool_internal2<T0, T1>(arg0, arg2, v1, v2, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        if (v8) {
            let v12 = if (v11) {
                v9
            } else {
                v10
            };
            let v13 = if (v11) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price()
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price()
            };
            let (v14, v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg2, v11, true, v12, v13, arg5);
            let v17 = v16;
            if (v11) {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v17)), 0x2::balance::zero<T1>(), v17);
                0x2::balance::join<T1>(&mut arg4, v15);
                0x2::balance::destroy_zero<T0>(v14);
            } else {
                0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v17)), v17);
                0x2::balance::join<T0>(&mut arg3, v14);
                0x2::balance::destroy_zero<T1>(v15);
            };
        };
        let (_, _, v20) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::get_liquidity_by_amount(v1, v2, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2), 0x2::balance::value<T0>(&arg3), true);
        let v21 = if (v20 <= 0x2::balance::value<T1>(&arg4)) {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v6, 0x2::balance::value<T0>(&arg3), true, arg5, arg6)
        } else {
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg2, &mut v6, 0x2::balance::value<T1>(&arg4), false, arg5, arg6)
        };
        let v22 = v21;
        let (v23, v24) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v22);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(&mut arg3, v23), 0x2::balance::split<T1>(&mut arg4, v24), v22);
        0x1::option::destroy_none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1);
        (v6, arg3, arg4)
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
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
                0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T1>())) {
                0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>())));
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

    fun reposition_tick_range(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, arg1: u32) : (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) {
        let v0 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(arg1);
        let v1 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::mul(0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::div(arg0, v0), v0);
        (v1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::add(v1, v0))
    }

    public entry fun single_pool_remove_swap_add_with_reward1<T0, T1, T2>(arg0: &mut BotCap, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = if (0x1::option::is_some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0.position)) {
            let v3 = 0x1::option::extract<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&mut arg0.position);
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg1, arg3, &v3, true);
            let v6 = v5;
            let v7 = v4;
            0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(arg4));
            0x2::balance::join<T1>(&mut v6, 0x2::coin::into_balance<T1>(arg5));
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T2>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>(), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg6));
            } else {
                0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.balances, 0x1::type_name::get<T2>()), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg1, arg3, &v3, arg2, true, arg6));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
                0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>())));
            };
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T1>())) {
                0x2::balance::join<T1>(&mut v6, 0x2::balance::withdraw_all<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::get<T1>())));
            };
            remove_swap_add_in_one_pool<T0, T1>(arg1, 0x1::option::some<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v3), arg3, v7, v6, arg6, arg7)
        } else {
            remove_swap_add_in_one_pool<T0, T1>(arg1, 0x1::option::none<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(), arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg7)
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

