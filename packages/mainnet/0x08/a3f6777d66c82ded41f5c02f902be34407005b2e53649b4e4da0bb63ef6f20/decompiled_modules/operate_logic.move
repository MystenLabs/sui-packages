module 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_logic {
    public(friend) fun operate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg2: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::Position, arg6: 0x1::option::Option<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap>, arg7: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::OperateAmount, arg11: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap>) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::assert_version(arg2);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::assert_caps_installed<T0, T1>(arg1);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::assert_liquidity_program<T0, T1>(arg1, arg0);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::assert_belongs_to(arg5, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::vault_object_id<T0, T1>(arg1));
        let v0 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::col_decimals<T0, T1>(arg1);
        let v1 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::debt_decimals<T0, T1>(arg1);
        let v2 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::is_none(&arg10) && 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::is_none(&arg11);
        assert!(!v2, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_invalid_operate_amount());
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::check_operate_amount(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::is_none(&arg10), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_is_max(&arg10), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::value(&arg10), v0);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::check_operate_amount(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::is_none(&arg11), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_is_max(&arg11), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::value(&arg11), v1);
        if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_is_negative(&arg10) || 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_is_positive(&arg11)) {
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::assert_authorized(arg5, &arg6);
        };
        let (v3, v4, v5, v6, v7) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::get_position_info(arg5);
        let v8 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::new_operate_memory_vars(v3, v5, v4, v6, v7);
        let v9 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::get_top_tick<T0, T1>(arg1);
        if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::gt(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick())) {
            let v10 = &mut v8;
            let v11 = &mut v9;
            settle_existing_position<T0, T1>(arg1, v10, v1, v11);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_dust_debt_raw(&mut v8, 0);
        };
        let (v12, _) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T0>(arg3, arg12);
        let (_, v15) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T1>(arg4, arg12);
        let (_, _, v18, v19) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::load_exchange_prices<T0, T1>(arg1, v12, v15, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg12));
        let v20 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::new_old_state(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8));
        let (v21, v22, v23, v24) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::get_new_position_info(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::new_amount_info(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scale(&arg10, v0), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scale(&arg11, v1), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(&v8)), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::new_vault_exchange_prices(v18, v19, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::borrow_fee<T0, T1>(arg1)));
        let v25 = v22;
        let v26 = v21;
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_col_raw(&mut v8, v23);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(&mut v8, v24);
        let v27 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scaled_is_none(&v26) && 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scaled_is_none(&v25);
        assert!(!v27, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_invalid_operate_amount());
        if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(&v8) > 0) {
            let (v28, _, v30, v31) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::engine_mut<T0, T1>(arg1);
            let (v32, v33, v34, v35) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::add_debt_to_tick(v28, v30, v31, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_scaled_debt(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::get_minimum_debt(v1));
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_memory_tick(&mut v8, v32);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_memory_tick_id(&mut v8, v33);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(&mut v8, v34);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_dust_debt_raw(&mut v8, v35);
            let v36 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_net_debt_raw(&v8);
            let v37 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_scaled_is_negative(&v25) && v36 > 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::old_net_debt_raw(&v20);
            assert!(!v37, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_invalid_payback_or_deposit());
            if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_scaled_is_positive(&v26) && 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scaled_is_none(&v25)) {
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::check_if_ratio_safe_for_deposit(&v8, &v20, v36);
            };
            if (!0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::lt(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8), v9)) {
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_topmost_tick<T0, T1>(arg1, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8));
            };
        } else {
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_memory_tick(&mut v8, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick());
        };
        if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8) != 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::cold_tick()) {
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::check_if_position_safe<T0, T1>(arg1, arg7, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8), v18, v19, &v26, &v25);
        };
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::update_position_after_operate(arg5, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick_id(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::dust_debt_raw(&v8));
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::events::emit_log_user_position(0x2::tx_context::sender(arg13), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::nft_id(arg5), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::vault_id<T0, T1>(arg1), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::position_mint(arg5), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(&v8), (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::unscale_amounts(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), v0) as u64), (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::unscale_amounts(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(&v8), v1) as u64));
        let v38 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::get_scaled_is_positive(&v26) && 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::unscale_amounts(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::scaled_value(&v26), v0) < (0x2::balance::value<T0>(&arg8) as u128);
        let v39 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::unscale_col(&v26, v0, v38);
        let v40 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::unscale_debt(&v25, v1);
        if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_negative(&v39)) {
            let (v41, v42) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::calc_withdrawal_limit_before_operate<T0, T1, T0>(arg1, arg3, arg12);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::check_if_withdrawal_safe_for_withdrawal_gap(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::withdraw_gap<T0, T1>(arg1), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v39) as u128), v12, v41, v42);
        };
        let v43 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_positive(&v39)) {
            0x2::balance::split<T0>(&mut arg8, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v39))
        } else {
            0x2::balance::zero<T0>()
        };
        let v44 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::supply<T0, T1>(arg0, arg1, arg3, v39, v43, arg12, arg13);
        0x2::balance::join<T0>(&mut v44, arg8);
        let v45 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_negative(&v40)) {
            0x2::balance::split<T1>(&mut arg9, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v40))
        } else {
            0x2::balance::zero<T1>()
        };
        let v46 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::borrow<T0, T1>(arg0, arg1, arg4, v40, v45, arg12, arg13);
        0x2::balance::join<T1>(&mut v46, arg9);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_total_supply<T0, T1>(arg1, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::col_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::old_col_raw(&v20));
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_total_borrow<T0, T1>(arg1, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_net_debt_raw(&v8), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::old_net_debt_raw(&v20));
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::events::emit_log_operate(0x2::tx_context::sender(arg13), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::nft_id(arg5), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v39), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_negative(&v39), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::value(&v40), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_is_negative(&v40), 0x2::tx_context::sender(arg13));
        (v44, v46, arg6)
    }

    fun settle_existing_position<T0, T1>(arg0: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::OperateMemoryVars, arg2: u8, arg3: &mut 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math::Tick) {
        let v0 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick(arg1);
        let v1 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::load_tick(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::ticks<T0, T1>(arg0), v0);
        let v2 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::get_raw_debt(v1);
        if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::is_liquidated(v1) || 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::total_ids(v1) > 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::memory_tick_id(arg1)) {
            let (v3, v4, v5, _) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::engine_mut<T0, T1>(arg0);
            if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1) < 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::dust_debt_raw(arg1)) {
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_absorbed_dust_debt_amount<T0, T1>(arg0, ((0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::dust_debt_raw(arg1) - 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1)) as u64));
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(arg1, 0);
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_col_raw(arg1, 0);
            } else if (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1) < 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::liquidated_position_debt_multiplier() * 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::get_minimum_debt(arg2)) {
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_absorbed_dust_debt_amount<T0, T1>(arg0, (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_net_debt_raw(arg1) as u64));
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(arg1, 0);
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_col_raw(arg1, 0);
            } else {
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::branch::update_debt_liquidity(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::branch::load_branch_mut(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::branches_mut<T0, T1>(arg0), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::fetch_latest_position(arg1, v3, v5, v4)), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::get_minimum_branch_debt(arg2));
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(arg1, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_net_debt_raw(arg1));
            };
        } else {
            assert!(v2 != 0, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::errors::vault_tick_is_empty());
            let v7 = if (v2 > 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1)) {
                v2 - 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::debt_raw(arg1)
            } else {
                0
            };
            let v8 = v7;
            if (v7 < 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::constants::get_minimum_tick_debt(arg2)) {
                v8 = 0;
                if (v0 == *arg3) {
                    *arg3 = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::set_top_tick<T0, T1>(arg0);
                };
                0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::update_tick_has_debt(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::tick_bitmap_mut<T0, T1>(arg0), v0, false);
            };
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::set_raw_debt(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::tick::load_tick_mut(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::ticks_mut<T0, T1>(arg0), v0), v8);
            0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::set_debt_raw(arg1, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_utils::get_net_debt_raw(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

