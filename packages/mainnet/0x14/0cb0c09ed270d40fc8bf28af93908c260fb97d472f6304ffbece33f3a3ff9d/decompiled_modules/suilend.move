module 0x140cb0c09ed270d40fc8bf28af93908c260fb97d472f6304ffbece33f3a3ff9d::suilend {
    struct SuilendAdapterModule has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::AuthorizedTransferTicket, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        if (!0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            return
        };
        let v1 = 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg0, &v1, arg4, get_reserve_id<T0, T1>(arg0), arg2, arg3, arg5);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v1, &v0);
        let v3 = 0x2::coin::value<T2>(&v2);
        let (v4, v5, v6) = 0x140cb0c09ed270d40fc8bf28af93908c260fb97d472f6304ffbece33f3a3ff9d::utils::calculate_yield_earnings(arg1, v3, 0);
        if (v5 > 0) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::collect_performance_fee<T2, SuilendAdapterModule>(arg1, 0x2::coin::split<T2>(&mut v2, v5, arg5), &v0);
        };
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_reward<T2, SuilendAdapterModule>(arg1, 0x2::coin::into_balance<T2>(v2), &v0);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_earnings_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x1::type_name::with_defining_ids<T2>(), v4, v5, v6, arg5);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_adapter_activity_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::claim_reward_operation(), 0x1::type_name::with_defining_ids<T2>(), v3, arg5);
    }

    public fun deposit<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::AuthorizedTransferTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::set_adapter_name<SuilendAdapterModule>(arg1, 0x1::string::utf8(b"suilend"), &v0);
        let v1 = 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::asset_balance<T1>(arg1);
        let v2 = if (0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1)) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg3)
        };
        let v3 = v2;
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg0, v4, &v3, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, v4, arg2, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::withdraw_coin<T1, SuilendAdapterModule>(arg1, v1, &v0, arg3), arg3), arg3);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v3, &v0);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::record_adapter_deposit<SuilendAdapterModule>(arg1, v1, &v0);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_adapter_activity_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T1>(), v1, arg3);
    }

    public fun get_reserve_id<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0)
    }

    public fun withdraw_all<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::AuthorizedTransferTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        assert!(0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1), 1200);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::set_adapter_name<SuilendAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v2, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg0, v2, &v1, arg2, 18446744073709551615, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v1, &v0);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6, v7) = 0x140cb0c09ed270d40fc8bf28af93908c260fb97d472f6304ffbece33f3a3ff9d::utils::calculate_yield_earnings(arg1, v4, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::adapter_total_deposited<SuilendAdapterModule>(arg1));
        if (v6 > 0) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::collect_performance_fee<T1, SuilendAdapterModule>(arg1, 0x2::coin::split<T1>(&mut v3, v6, arg3), &v0);
        };
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_coin<T1, SuilendAdapterModule>(arg1, v3, &v0);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::reset_adapter_deposits<SuilendAdapterModule>(arg1, &v0);
        if (v5 > 0) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_earnings_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x1::type_name::with_defining_ids<T1>(), v5, v6, v7, arg3);
        };
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_adapter_activity_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T1>(), v4, arg3);
    }

    public fun withdraw_non_base<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::AuthorizedTransferTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterModule{dummy_field: false};
        assert!(0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::has_asset_type<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(arg1), 1200);
        assert!(!0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::supports_asset_type<T1>(arg1), 1201);
        let v1 = 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::withdraw_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, &v0);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg0);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, v2, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg0, v2, &v1, arg2, 18446744073709551615, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3);
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendAdapterModule>(arg1, v1, &v0);
        let v4 = 0x2::coin::value<T1>(&v3);
        let (v5, v6, v7) = 0x140cb0c09ed270d40fc8bf28af93908c260fb97d472f6304ffbece33f3a3ff9d::utils::calculate_yield_earnings(arg1, v4, 0);
        if (v6 > 0) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::collect_performance_fee<T1, SuilendAdapterModule>(arg1, 0x2::coin::split<T1>(&mut v3, v6, arg3), &v0);
        };
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::ticket::add_reward<T1, SuilendAdapterModule>(arg1, 0x2::coin::into_balance<T1>(v3), &v0);
        if (v5 > 0) {
            0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_earnings_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x1::type_name::with_defining_ids<T1>(), v5, v6, v7, arg3);
        };
        0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::emit_adapter_activity_event<SuilendAdapterModule>(arg1, &v0, 0x1::string::utf8(b"suilend"), 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T1>(), v4, arg3);
    }

    // decompiled from Move bytecode v6
}

