module 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_entry {
    struct CurrentLegAuth has drop {
        dummy_field: bool,
    }

    public fun admin_force_refresh_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = CurrentLegAuth{dummy_field: false};
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::force_sync_protocol_balance<T1, T2, CurrentLegAuth>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), view_current_underlying<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5), arg6, arg7, &v0);
    }

    public fun admin_recall_current_to_idle<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin_recall::AdminRecallReceipt<T1>, arg2: u64, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate_current_full<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurrentLegAuth{dummy_field: false};
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT();
        let v2 = 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::select_ctoken_withdraw_amount<T0, T1>(arg4, (arg2 as u128), 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_obligation_ctoken_amount<T0, T1>(arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin_recall::borrow_cap_for_recall<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0)), arg8);
        if (v2 == 0) {
            return
        };
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::refresh_usd_price<T1>(arg6, arg7, arg9);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin_recall::add_recall_withdraw_leg<T1, T2, CurrentLegAuth>(arg1, arg0, v1, withdraw_underlying<T0, T1>(arg3, arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin_recall::borrow_cap_for_recall<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), arg5, v2, arg6, arg9, arg10), &v0);
    }

    public fun begin_current_rewards_for_compound<T0, T1, T2, T3>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T3>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::RewardCompoundReceipt) {
        assert!(0x1::vector::length<u64>(&arg4) > 0, 1);
        let v0 = claim_current_rewards_to_coin<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg4, 0), arg5, arg6);
        let v1 = 1;
        while (v1 < 0x1::vector::length<u64>(&arg4)) {
            let v2 = claim_current_rewards_to_coin<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg4, v1), arg5, arg6);
            0x2::coin::join<T2>(&mut v0, v2);
            v1 = v1 + 1;
        };
        (v0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::begin_reward_compound<T1, T3>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), 0x2::coin::value<T2>(&v0), arg6))
    }

    public fun claim_current_rewards<T0, T1, T2, T3>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T3>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(claim_current_rewards_to_coin<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::get_fee_recipient<T1, T3>(arg1));
    }

    public(friend) fun claim_current_rewards_to_coin<T0, T1, T2, T3>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T3>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::assert_keeper_reward_claim_prologue<T1, T3>(arg0, arg1, 0x2::tx_context::sender(arg6));
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_validation::validate_current_market<T1, T3>(arg1, 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg2), 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg3));
        let v0 = CurrentLegAuth{dummy_field: false};
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::claim_deposit_rewards<T0, T1, T2>(arg2, arg3, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::borrow_cap_by_auth<T1, T3, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), 0, arg4, arg5, arg6)
    }

    public fun complete_current_rewards_for_compound<T0, T1, T2>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg2: 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::RewardCompoundReceipt, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::complete_reward_compound<T1, T2>(arg2, arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), arg5);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin_entry::inject_reward_to_idle<T1, T2>(arg0, arg1, arg3, arg4, arg5);
    }

    public fun deposit_to_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::DepositReceipt<T1>, arg2: u64, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate_current_full<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurrentLegAuth{dummy_field: false};
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT();
        let v2 = query_current_underlying<T0, T1, T2>(arg0, arg4, &v0);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::sync_for_deposit<T1, T2, CurrentLegAuth>(arg0, arg1, v1, v2, arg8, &v0);
        let v3 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::resolve_requested_deposit_amount<T1>(arg1, v1, arg2);
        if (v3 == 0) {
            return
        };
        let (v4, v5) = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::begin_deposit_leg<T1, T2, CurrentLegAuth>(arg1, arg0, v1, v3, &v0);
        let v6 = v4;
        let v7 = 0x2::balance::value<T1>(&v6);
        deposit_underlying<T0, T1>(v6, arg3, arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::borrow_cap_for_deposit<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), arg8, arg9);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::finish_deposit_leg_accounted<T1, T2, CurrentLegAuth>(arg1, arg0, v5, v7, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::accounted_value_delta(v2, query_current_underlying<T0, T1, T2>(arg0, arg4, &v0)), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::max_accounted_value_gap_for_input<T1, T2>(arg0, v7), &v0);
    }

    public(friend) fun deposit_underlying<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::deposit<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T1>(arg0, arg5), arg4, arg5);
    }

    fun query_current_underlying<T0, T1, T2>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &CurrentLegAuth) : u128 {
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_underlying_balance<T0, T1>(arg1, 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_obligation_ctoken_amount<T0, T1>(arg1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::borrow_cap_by_auth<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), arg2)))
    }

    public fun rebalance_deposit_to_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::RebalanceReceipt<T1>, arg2: u64, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate_current_full<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurrentLegAuth{dummy_field: false};
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT();
        let v2 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::get_amount(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::expected_deposit_plan<T1>(arg1), v1);
        if (v2 == 0) {
            return
        };
        let v3 = (0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::rebalance_balance_value<T1>(arg1) as u128);
        let v4 = if (v2 < v3) {
            (v2 as u64)
        } else {
            (v3 as u64)
        };
        let v5 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::resolve_requested_rebalance_deposit_amount<T1>(arg1, v1, v4);
        if (v5 == 0) {
            return
        };
        let v6 = query_current_underlying<T0, T1, T2>(arg0, arg4, &v0);
        let (v7, v8) = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::begin_rebalance_deposit_leg<T1, T2, CurrentLegAuth>(arg1, arg0, v1, v5, &v0);
        let v9 = v7;
        let v10 = 0x2::balance::value<T1>(&v9);
        if (v10 == 0) {
            0x2::balance::destroy_zero<T1>(v9);
            0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::finish_rebalance_deposit_leg_accounted<T1, T2, CurrentLegAuth>(arg1, arg0, v8, 0, 0, 0, &v0);
            return
        };
        deposit_underlying<T0, T1>(v9, arg3, arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), arg8, arg9);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::finish_rebalance_deposit_leg_accounted<T1, T2, CurrentLegAuth>(arg1, arg0, v8, v10, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::accounted_value_delta(v6, query_current_underlying<T0, T1, T2>(arg0, arg4, &v0)), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::max_accounted_value_gap_for_input<T1, T2>(arg0, v10), &v0);
    }

    public fun rebalance_withdraw_from_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::RebalanceReceipt<T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate_current_full<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6);
        let v0 = CurrentLegAuth{dummy_field: false};
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT();
        let v2 = 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::select_ctoken_withdraw_amount<T0, T1>(arg3, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::get_amount(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::expected_withdraw_plan<T1>(arg1), v1), 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_obligation_ctoken_amount<T0, T1>(arg3, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0)), arg7);
        if (v2 == 0) {
            return
        };
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::refresh_usd_price<T1>(arg5, arg6, arg8);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::add_rebalance_withdraw_leg<T1, T2, CurrentLegAuth>(arg1, arg0, v1, withdraw_underlying<T0, T1>(arg2, arg3, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_rebalance::borrow_cap_for_rebalance<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), arg4, v2, arg5, arg8, arg9), &v0);
    }

    public fun refresh_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::assert_refresh_gate<T1, T2>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), arg6, arg7);
        let v0 = CurrentLegAuth{dummy_field: false};
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::sync_protocol_balance_by_auth<T1, T2, CurrentLegAuth>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT(), view_current_underlying<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5), arg6, &v0);
    }

    fun validate_current_full<T0, T1, T2>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_validation::validate_current_config_with_price<T1, T2>(arg0, 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp>(arg1), 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>>(arg2), 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry>(arg3), 0x2::object::id<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle>(arg4), 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg5));
    }

    public fun view_current_underlying<T0, T1, T2>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u128 {
        validate_current_full<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v0 = CurrentLegAuth{dummy_field: false};
        query_current_underlying<T0, T1, T2>(arg0, arg2, &v0)
    }

    public fun withdraw_from_current<T0, T1, T2>(arg0: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::LLVPool<T1, T2>, arg1: &mut 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::WithdrawReceipt<T1, T2>, arg2: u128, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate_current_full<T0, T1, T2>(arg0, arg3, arg4, arg5, arg6, arg7);
        let v0 = CurrentLegAuth{dummy_field: false};
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_CURRENT();
        let v2 = 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_obligation_ctoken_amount<T0, T1>(arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::borrow_cap_for_withdraw<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0));
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::sync_for_withdraw<T1, T2, CurrentLegAuth>(arg0, arg1, v1, 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::get_underlying_balance<T0, T1>(arg4, v2), arg9, &v0);
        let v3 = 0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::select_ctoken_withdraw_amount<T0, T1>(arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::resolve_requested_withdraw_assets<T1, T2>(arg1, v1, arg2), v2, arg8);
        if (v3 == 0) {
            return
        };
        0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::refresh_usd_price<T1>(arg6, arg7, arg9);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::add_withdraw_leg<T1, T2, CurrentLegAuth>(arg1, arg0, v1, withdraw_underlying<T0, T1>(arg3, arg4, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_user_entry::borrow_cap_for_withdraw<T1, T2, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::CurrentObligationCapKey, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, CurrentLegAuth>(arg1, arg0, v1, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool::current_obligation_cap_key(), &v0), arg5, v3, arg6, arg9, arg10), &v0);
    }

    public(friend) fun withdraw_underlying<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x5aa3ebda7d85f918c568e4b7bad7def76f67e4ef646fd6e1c71e2c2d7e65b752::current_adapter::withdraw_as_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    // decompiled from Move bytecode v7
}

