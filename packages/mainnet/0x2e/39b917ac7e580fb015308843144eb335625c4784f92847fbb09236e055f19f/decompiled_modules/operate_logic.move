module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_logic {
    public(friend) fun operate<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg5: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::Position, arg6: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap>, arg7: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote>, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::OperateAmount, arg11: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap>) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg2);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::assert_caps_installed<T0, T1>(arg1);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::assert_liquidity_program<T0, T1>(arg1, arg0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::assert_belongs_to(arg5, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_object_id<T0, T1>(arg1));
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::col_decimals<T0, T1>(arg1);
        let v1 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::debt_decimals<T0, T1>(arg1);
        let v2 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::is_none(&arg10) && 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::is_none(&arg11);
        assert!(!v2, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_operate_amount());
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::check_operate_amount(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::is_none(&arg10), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_is_max(&arg10), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::value(&arg10), v0);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::check_operate_amount(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::is_none(&arg11), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_is_max(&arg11), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::value(&arg11), v1);
        if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_is_negative(&arg10) || 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_is_positive(&arg11)) {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::assert_authorized(arg5, &arg6);
        };
        let (v3, v4, v5, v6, v7) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::get_position_info(arg5);
        let v8 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::new_operate_memory_vars(v3, v5, v4, v6, v7);
        let v9 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::get_top_tick<T0, T1>(arg1);
        if (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::gt(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick())) {
            let v10 = &mut v8;
            let v11 = &mut v9;
            settle_existing_position<T0, T1>(arg1, v10, v1, v11);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_dust_debt_raw(&mut v8, 0);
        };
        let (v12, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T0>(arg3, arg12);
        let (_, v15) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T1>(arg4, arg12);
        let (_, _, v18, v19) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::load_exchange_prices<T0, T1>(arg1, v12, v15, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg12));
        let v20 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::new_old_state(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8));
        let (v21, v22, v23, v24) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::get_new_position_info(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::new_amount_info(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scale(&arg10, v0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scale(&arg11, v1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(&v8)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::new_vault_exchange_prices(v18, v19, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::borrow_fee<T0, T1>(arg1)));
        let v25 = v22;
        let v26 = v21;
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_col_raw(&mut v8, v23);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(&mut v8, v24);
        let v27 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_is_none(&v26) && 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_is_none(&v25);
        assert!(!v27, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_operate_amount());
        if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(&v8) > 0) {
            let (v28, _, v30, v31) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::engine_mut<T0, T1>(arg1);
            let (v32, v33, v34, v35) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::add_debt_to_tick(v28, v30, v31, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_scaled_debt(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::get_minimum_debt(v1));
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_memory_tick(&mut v8, v32);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_memory_tick_id(&mut v8, v33);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(&mut v8, v34);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_dust_debt_raw(&mut v8, v35);
            let v36 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(&v8);
            let v37 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_negative(&v25) && v36 > 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::old_net_debt_raw(&v20);
            assert!(!v37, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_invalid_payback_or_deposit());
            if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_positive(&v26) && 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_is_none(&v25)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::check_if_ratio_safe_for_deposit(&v8, &v20, v36);
            };
            if (!0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::lt(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), v9)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_topmost_tick<T0, T1>(arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8));
            };
        } else {
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_memory_tick(&mut v8, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick());
        };
        if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8) != 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::cold_tick()) {
            if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::needs_quote(&v20, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(&v8), &v26, &v25)) {
                assert!(0x1::option::is_some<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote>(&arg7), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_price_quote_required());
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::check_if_position_safe<T0, T1>(arg1, 0x1::option::borrow<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote>(&arg7), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), v18, v19);
            };
        };
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::update_position_after_operate(arg5, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick_id(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::dust_debt_raw(&v8));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_user_position(0x2::tx_context::sender(arg13), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::nft_id(arg5), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::position_mint(arg5), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(&v8), (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::unscale_amounts(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), v0) as u64), (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::unscale_amounts(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(&v8), v1) as u64));
        let v38 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::get_scaled_is_positive(&v26) && 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::unscale_amounts(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::scaled_value(&v26), v0) < (0x2::balance::value<T0>(&arg8) as u128);
        let v39 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::unscale_col(&v26, v0, v38);
        let v40 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::unscale_debt(&v25, v1);
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&v39)) {
            let (v41, v42) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::calc_withdrawal_limit_before_operate<T0, T1, T0>(arg1, arg3, arg12);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::check_if_withdrawal_safe_for_withdrawal_gap(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::withdraw_gap<T0, T1>(arg1), (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v39) as u128), v12, v41, v42);
        };
        let v43 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&v39)) {
            0x2::balance::split<T0>(&mut arg8, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v39))
        } else {
            0x2::balance::zero<T0>()
        };
        let v44 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::supply<T0, T1>(arg0, arg1, arg3, v39, v43, arg12, arg13);
        0x2::balance::join<T0>(&mut v44, arg8);
        let v45 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&v40)) {
            0x2::balance::split<T1>(&mut arg9, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v40))
        } else {
            0x2::balance::zero<T1>()
        };
        let v46 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::borrow<T0, T1>(arg0, arg1, arg4, v40, v45, arg12, arg13);
        0x2::balance::join<T1>(&mut v46, arg9);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_total_supply<T0, T1>(arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::col_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::old_col_raw(&v20));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_total_borrow<T0, T1>(arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(&v8), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::old_net_debt_raw(&v20));
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_operate(0x2::tx_context::sender(arg13), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::nft_id(arg5), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v39), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&v39), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&v40), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&v40), 0x2::tx_context::sender(arg13));
        (v44, v46, arg6)
    }

    fun settle_existing_position<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::OperateMemoryVars, arg2: u8, arg3: &mut 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::tick_math::Tick) {
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick(arg1);
        let v1 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::load_tick(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::ticks<T0, T1>(arg0), v0);
        let v2 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::get_raw_debt(v1);
        if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::is_liquidated(v1) || 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::total_ids(v1) > 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::memory_tick_id(arg1)) {
            let (v3, v4, v5, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::engine_mut<T0, T1>(arg0);
            if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1) < 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::dust_debt_raw(arg1)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_absorbed_dust_debt_amount<T0, T1>(arg0, ((0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::dust_debt_raw(arg1) - 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1)) as u64));
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(arg1, 0);
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_col_raw(arg1, 0);
            } else if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1) < 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::liquidated_position_debt_multiplier() * 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::get_minimum_debt(arg2)) {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_absorbed_dust_debt_amount<T0, T1>(arg0, (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(arg1) as u64));
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(arg1, 0);
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_col_raw(arg1, 0);
            } else {
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::branch::update_debt_liquidity(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::branch::load_branch_mut(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::branches_mut<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::fetch_latest_position(arg1, v3, v5, v4)), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::get_minimum_branch_debt(arg2));
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(arg1));
            };
        } else {
            assert!(v2 != 0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_tick_is_empty());
            let v7 = if (v2 > 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1)) {
                v2 - 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::debt_raw(arg1)
            } else {
                0
            };
            let v8 = v7;
            if (v7 < 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::get_minimum_tick_debt(arg2)) {
                v8 = 0;
                if (v0 == *arg3) {
                    *arg3 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::set_top_tick<T0, T1>(arg0);
                };
                0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::update_tick_has_debt(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::tick_bitmap_mut<T0, T1>(arg0), v0, false);
            };
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::set_raw_debt(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::tick::load_tick_mut(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::ticks_mut<T0, T1>(arg0), v0), v8);
            0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::set_debt_raw(arg1, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_utils::get_net_debt_raw(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

