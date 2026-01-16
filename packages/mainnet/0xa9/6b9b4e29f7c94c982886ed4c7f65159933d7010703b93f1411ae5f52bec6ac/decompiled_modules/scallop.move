module 0xa96b9b4e29f7c94c982886ed4c7f65159933d7010703b93f1411ae5f52bec6ac::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b"scallop"), &v0);
        let v1 = 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_coin<T0, ScallopAdapterModule>(arg1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::asset_balance<T0>(arg1), &v0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg2, v1, arg3, arg4), &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::record_adapter_deposit<ScallopAdapterModule>(arg1, v2, &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_adapter_activity_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::has_asset_type<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), 1100);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg2, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::withdraw_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::asset_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), &v0, arg4), arg3, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        let (v3, v4, v5) = 0xa96b9b4e29f7c94c982886ed4c7f65159933d7010703b93f1411ae5f52bec6ac::utils::calculate_yield_earnings(arg1, v2, 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::adapter_total_deposited<ScallopAdapterModule>(arg1));
        if (v4 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::collect_performance_fee<T0, ScallopAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v1, v4, arg4), &v0);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::add_coin<T0, ScallopAdapterModule>(arg1, v1, &v0);
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::ticket::reset_adapter_deposits<ScallopAdapterModule>(arg1, &v0);
        if (v3 > 0) {
            0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_earnings_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0x1::type_name::with_defining_ids<T0>(), v3, v4, v5, arg4);
        };
        0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::emit_adapter_activity_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0xec609c742ab97a056182daff442093b14ffdbcecb525cb8fc22a33c6f6c633a4::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    // decompiled from Move bytecode v6
}

