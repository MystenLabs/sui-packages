module 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::suilend {
    struct SuilendAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        if (!0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            return
        };
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg0, &v1, arg4, get_reserve_id<T0, T1>(arg0), arg2, arg3, arg5);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v1, &v0);
        let v3 = 0x2::coin::value<T2>(&v2);
        let v4 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::calculate_performance_fee(arg1, v3);
        if (v4 > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::collect_performance_fee<T2>(arg1, 0x2::coin::split<T2>(&mut v2, v4, arg5));
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_reward<T2, SuilendAdapterModule>(arg1, 0x2::coin::into_balance<T2>(v2), &v0);
        let v5 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::is_agent_ticket(arg1)) {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::agent_owner_type()
        } else {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::user_owner_type()
        };
        0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::emit_adapter_activity_event(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::claim_reward_operation(), v5, 0x2::tx_context::sender(arg5), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1), 0x1::type_name::get<T2>(), v3);
    }

    public fun deposit<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::set_adapter_name<SuilendAdapterModule>(arg1, 0x1::string::utf8(b"suilend"), &v0);
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::asset_balance<T1>(arg1);
        let v2 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg3)
        };
        let v3 = v2;
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, v4, &v3, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, v4, arg2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_coin<T1, SuilendAdapterModule>(arg1, v1, &v0, arg3), arg3), arg3);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v3, &v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::record_adapter_deposit<SuilendAdapterModule>(arg1, v1, &v0);
        let v5 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::is_agent_ticket(arg1)) {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::agent_owner_type()
        } else {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::user_owner_type()
        };
        0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::emit_adapter_activity_event(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::deposit_operation(), v5, 0x2::tx_context::sender(arg3), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1), 0x1::type_name::get<T1>(), v1);
    }

    public fun get_reserve_id<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0)
    }

    public fun withdraw_all<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1), 0);
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v2, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg0, v2, &v1, arg2, 18446744073709551615, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v1, &v0);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::utils::calculate_yield_performance_fee(arg1, v4, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::adapter_total_deposited<SuilendAdapterModule>(arg1));
        if (v5 > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::collect_performance_fee<T1>(arg1, 0x2::coin::split<T1>(&mut v3, v5, arg3));
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_coin<T1, SuilendAdapterModule>(arg1, v3, &v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::reset_adapter_deposits<SuilendAdapterModule>(arg1, &v0);
        let v6 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::is_agent_ticket(arg1)) {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::agent_owner_type()
        } else {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::user_owner_type()
        };
        0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::emit_adapter_activity_event(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_account_id(arg1), 0x1::string::utf8(b"suilend"), 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::withdraw_operation(), v6, 0x2::tx_context::sender(arg3), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1), 0x1::type_name::get<T1>(), v4);
    }

    // decompiled from Move bytecode v6
}

