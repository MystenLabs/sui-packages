module 0xcba352d4baa593e409b6902e3dc19d9097bd271591f7b4358b6911d0d5a8a385::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b"scallop"), &v0);
        let v1 = 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_coin<T0, ScallopAdapterModule>(arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::asset_balance<T0>(arg1), &v0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg2, v1, arg3, arg4), &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::record_adapter_deposit<ScallopAdapterModule>(arg1, v2, &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_adapter_activity_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::deposit_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::has_asset_type<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), 1100);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b""), &v0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg2, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::withdraw_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::asset_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), &v0, arg4), arg3, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        let (v3, v4, v5) = 0xcba352d4baa593e409b6902e3dc19d9097bd271591f7b4358b6911d0d5a8a385::utils::calculate_yield_earnings(arg1, v2, 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::adapter_total_deposited<ScallopAdapterModule>(arg1));
        if (v4 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::collect_performance_fee<T0>(arg1, 0x2::coin::split<T0>(&mut v1, v4, arg4));
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::add_coin<T0, ScallopAdapterModule>(arg1, v1, &v0);
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::ticket::reset_adapter_deposits<ScallopAdapterModule>(arg1, &v0);
        if (v3 > 0) {
            0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_earnings_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0x1::type_name::with_defining_ids<T0>(), v3, v4, v5, arg4);
        };
        0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::emit_adapter_activity_event<ScallopAdapterModule>(arg1, &v0, 0x1::string::utf8(b"scallop"), 0x4e14967f20d94a41fa060a9a8b1dd39c57e193747a5c0337db94971d60eb28cb::adapter_events::withdraw_operation(), 0x1::type_name::with_defining_ids<T0>(), v2, arg4);
    }

    // decompiled from Move bytecode v6
}

