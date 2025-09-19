module 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::scallop {
    struct ScallopAdapterModule has drop {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::set_adapter_name<ScallopAdapterModule>(arg1, 0x1::string::utf8(b"scallop"), &v0);
        let v1 = 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_coin<T0, ScallopAdapterModule>(arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::asset_balance<T0>(arg1), &v0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg0, arg2, v1, arg3, arg4), &v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::record_adapter_deposit<ScallopAdapterModule>(arg1, v2, &v0);
        let v3 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::is_agent_ticket(arg1)) {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::agent_owner_type()
        } else {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::user_owner_type()
        };
        0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::emit_adapter_activity_event(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_account_id(arg1), 0x1::string::utf8(b"scallop"), 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::deposit_operation(), v3, 0x2::tx_context::sender(arg4), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1), 0x1::type_name::get<T0>(), v2);
    }

    public fun withdraw_all<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::AuthorizedTransferTicket, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterModule{dummy_field: false};
        assert!(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::has_asset_type<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(arg1), 0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::withdraw_coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, ScallopAdapterModule>(arg1, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::asset_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1), &v0, arg4), arg3, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::utils::calculate_yield_performance_fee(arg1, v2, 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::adapter_total_deposited<ScallopAdapterModule>(arg1));
        if (v3 > 0) {
            0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::collect_performance_fee<T0>(arg1, 0x2::coin::split<T0>(&mut v1, v3, arg4));
        };
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::add_coin<T0, ScallopAdapterModule>(arg1, v1, &v0);
        0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::reset_adapter_deposits<ScallopAdapterModule>(arg1, &v0);
        let v4 = if (0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::is_agent_ticket(arg1)) {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::agent_owner_type()
        } else {
            0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::user_owner_type()
        };
        0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::emit_adapter_activity_event(0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_account_id(arg1), 0x1::string::utf8(b"scallop"), 0x5dfebe6419ac4cc764220aac4c12780252244b11243290007774914a2661e21d::events::withdraw_operation(), v4, 0x2::tx_context::sender(arg4), 0xf63d57bbdb810ea1c76b0b66fd9c587baa7b12badd96d451a056c0f314eec5ad::ticket::get_strategy_name(arg1), 0x1::type_name::get<T0>(), v2);
    }

    // decompiled from Move bytecode v6
}

