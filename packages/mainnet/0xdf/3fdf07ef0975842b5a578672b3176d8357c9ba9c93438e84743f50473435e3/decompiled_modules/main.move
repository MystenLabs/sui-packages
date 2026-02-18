module 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::main {
    struct BotState has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        order_ids: vector<u128>,
        order_prices: vector<u64>,
        order_quantities: vector<u64>,
        order_expiries: vector<u64>,
        last_mm_refresh_ms: u64,
        last_arb_execution_ms: u64,
        tick_sequence: u64,
        total_mm_fills: u64,
        total_arb_trades: u64,
        total_errors: u64,
        cached_target_price: u64,
    }

    public fun deposit<T0>(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::AdminCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg3);
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_balance_change(0x2::coin::value<T0>(&arg2), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), true, true);
    }

    public fun withdraw<T0>(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::AdminCap, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_balance_change(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), true, false);
    }

    public fun create_bot_state(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::AdminCap, arg1: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BotState{
            id                    : 0x2::object::new(arg2),
            config_id             : 0x2::object::id<0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig>(arg1),
            order_ids             : vector[0, 0, 0, 0],
            order_prices          : vector[0, 0, 0, 0],
            order_quantities      : vector[0, 0, 0, 0],
            order_expiries        : vector[0, 0, 0, 0],
            last_mm_refresh_ms    : 0,
            last_arb_execution_ms : 0,
            tick_sequence         : 0,
            total_mm_fills        : 0,
            total_arb_trades      : 0,
            total_errors          : 0,
            cached_target_price   : 0,
        };
        0x2::transfer::share_object<BotState>(v0);
    }

    public fun emergency_shutdown<T0, T1>(arg0: &mut BotState, arg1: &mut 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg2: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::AdminCap, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::set_enabled(arg2, arg1, false);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg4, arg3, &v0, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg4, arg3, &v0);
        let v1 = 0;
        while (v1 < 4) {
            *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, v1) = 0;
            v1 = v1 + 1;
        };
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_error(b"emergency_shutdown", 0x2::clock::timestamp_ms(arg5));
    }

    public fun get_balance<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun get_cached_target_price(arg0: &BotState) : u64 {
        arg0.cached_target_price
    }

    public fun get_order_price(arg0: &BotState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.order_prices, arg1)
    }

    public fun get_order_quantity(arg0: &BotState, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.order_quantities, arg1)
    }

    public fun get_pool_mid_price<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1)
    }

    public fun get_tick_sequence(arg0: &BotState) : u64 {
        arg0.tick_sequence
    }

    public fun get_total_stats(arg0: &BotState) : (u64, u64, u64) {
        (arg0.total_mm_fills, arg0.total_arb_trades, arg0.total_errors)
    }

    fun needs_refresh(arg0: &BotState, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        if (*0x1::vector::borrow<u128>(&arg0.order_ids, arg1) == 0) {
            return true
        };
        let v0 = *0x1::vector::borrow<u64>(&arg0.order_expiries, arg1);
        if (arg4 >= v0) {
            return true
        };
        if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::abs_diff(*0x1::vector::borrow<u64>(&arg0.order_prices, arg1), arg2) > arg3) {
            return true
        };
        if (v0 - arg4 < arg5 / 2) {
            return true
        };
        false
    }

    public fun tick_mm_only<T0, T1>(arg0: &mut BotState, arg1: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        if (!0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_enabled(arg1)) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_mm_skip(b"disabled", arg4, v0);
            return
        };
        if (v0 >= arg6) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_error(b"expired", v0);
            return
        };
        if (0x2::tx_context::gas_price(arg8) > 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_gas_price(arg1)) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_mm_skip(b"gas_high", arg4, v0);
            return
        };
        arg0.cached_target_price = arg4;
        arg0.tick_sequence = arg0.tick_sequence + 1;
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg2, &v1, arg7, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg3, arg2, &v1);
        let v2 = 0;
        while (v2 < 4) {
            *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, v2) = 0;
            v2 = v2 + 1;
        };
        let (v3, v4) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::calculate_spreads(arg1, arg4, arg5);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        let (v6, v7, v8, v9) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::calculate_mm_sizes(arg1, v5);
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg3);
        let v13 = (arg4 - v3) / v10 * v10;
        let v14 = (arg4 + v3 + v10 - 1) / v10 * v10;
        let v15 = v6 / v11 * v11;
        let v16 = v15;
        let (v17, _) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::check_ask_capacity(v5, v7 / v11 * v11, 0, 0);
        let v19 = v17 / v11 * v11;
        let v20 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::sui_to_usdc_estimate(v15, v13);
        let (v21, _) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::check_bid_capacity(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v20, 0);
        if (v20 > 0 && v21 < v20) {
            v16 = v15 * v21 / v20 / v11 * v11;
        };
        if (v13 > 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_price_tick(arg1)) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_error(b"bid_price_too_high", v0);
            return
        };
        if (v14 < 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::min_price_tick(arg1)) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_error(b"ask_price_too_low", v0);
            return
        };
        let v23 = 0x2::clock::timestamp_ms(arg7) + 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::order_expiry_ms(arg1);
        let v24 = 0;
        let v25 = v24;
        let v26 = if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_mm_enabled(arg1)) {
            if (v16 < v12) {
                v6 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v26) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_mm_skip(b"bid_low_usdc", arg4, v0);
        };
        let v27 = if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_mm_enabled(arg1)) {
            if (v19 < v12) {
                v7 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v27) {
            0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_mm_skip(b"ask_low_base", arg4, v0);
        };
        if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_mm_enabled(arg1) && v16 >= v12) {
            let v28 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v1, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v13, v16, true, true, v23, arg7, arg8);
            *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, 0) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v28);
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_prices, 0) = v13;
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_quantities, 0) = v16;
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_expiries, 0) = v23;
            v25 = v24 + 1;
        };
        if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_mm_enabled(arg1) && v19 >= v12) {
            let v29 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v1, 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v14, v19, false, true, v23, arg7, arg8);
            *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, 1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v29);
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_prices, 1) = v14;
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_quantities, 1) = v19;
            *0x1::vector::borrow_mut<u64>(&mut arg0.order_expiries, 1) = v23;
            v25 = v25 + 1;
        };
        if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_tier_enabled(arg1) && 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::is_mm_enabled(arg1)) {
            let v30 = (arg4 - v4) / v10 * v10;
            let v31 = (arg4 + v4 + v10 - 1) / v10 * v10;
            let v32 = v8 / v11 * v11;
            let v33 = v32;
            let (v34, _) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::check_ask_capacity(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), v9 / v11 * v11, 0, 0);
            let v36 = v34 / v11 * v11;
            let v37 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::sui_to_usdc_estimate(v32, v30);
            let (v38, _) = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::check_bid_capacity(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), v37, 0);
            if (v37 > 0 && v38 < v37) {
                v33 = v32 * v38 / v37 / v11 * v11;
            };
            if (v33 >= v12) {
                let v40 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v1, 2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v30, v33, true, true, v23, arg7, arg8);
                *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, 2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v40);
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_prices, 2) = v30;
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_quantities, 2) = v33;
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_expiries, 2) = v23;
                v25 = v25 + 1;
            };
            if (v36 >= v12) {
                let v41 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, &v1, 3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v31, v36, false, true, v23, arg7, arg8);
                *0x1::vector::borrow_mut<u128>(&mut arg0.order_ids, 3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v41);
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_prices, 3) = v31;
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_quantities, 3) = v36;
                *0x1::vector::borrow_mut<u64>(&mut arg0.order_expiries, 3) = v23;
                v25 = v25 + 1;
            };
        };
        arg0.last_mm_refresh_ms = v0;
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_mm_refresh(arg4, v13, v14, *0x1::vector::borrow<u64>(&arg0.order_prices, 2), *0x1::vector::borrow<u64>(&arg0.order_prices, 3), v16, v19, *0x1::vector::borrow<u64>(&arg0.order_quantities, 2), *0x1::vector::borrow<u64>(&arg0.order_quantities, 3), v3 * 10000 / arg4, v4 * 10000 / arg4, 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory::calculate_inventory_ratio(v5, 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_position_sui(arg1)), v0);
        0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::events::emit_tick_summary(arg4, v25, 0, 0x2::tx_context::gas_price(arg8), v0);
    }

    // decompiled from Move bytecode v6
}

