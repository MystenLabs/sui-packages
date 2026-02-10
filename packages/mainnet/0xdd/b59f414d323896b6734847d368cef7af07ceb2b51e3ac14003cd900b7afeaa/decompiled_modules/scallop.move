module 0xddb59f414d323896b6734847d368cef7af07ceb2b51e3ac14003cd900b7afeaa::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b"scallop"), &v0);
        let v1 = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, ScallopAdapterModule>(arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0>(arg1), &v0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg2, v1, arg3, arg4), &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_record_deposit<ScallopAdapterModule>(arg1, v2, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::AuthorizedTransferTicket<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::has_asset_type<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), 1100);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::withdraw_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::asset_balance<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), &v0, arg4), arg3, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        let (v3, v4, v5) = 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::calculate_lending_yield_earnings<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet>(arg1, v2, 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_get_total_deposited<ScallopAdapterModule>(arg1, &v0));
        if (v4 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::collect_performance_fee<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, ScallopAdapterModule>(arg1, 0x2::coin::split<T0>(&mut v1, v4, arg4), &v0);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::add_coin<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, T0, ScallopAdapterModule>(arg1, v1, &v0);
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::ticket::lending_reset_deposits<ScallopAdapterModule>(arg1, &v0);
        if (v3 > 0) {
            0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_earnings_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0x1::type_name::with_defining_ids<T0>(), v3, v4, v5, arg4);
        };
        0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::emit_adapter_activity_event<0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::lending_sheet::LendingSheet, ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0xf2513ec8c0158b6668e03ff5b813a529bdc1461d3727843528cf333eb86af34f::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    // decompiled from Move bytecode v6
}

