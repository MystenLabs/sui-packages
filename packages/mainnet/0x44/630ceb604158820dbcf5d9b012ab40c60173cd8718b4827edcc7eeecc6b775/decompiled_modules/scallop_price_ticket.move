module 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_price_ticket {
    struct QuoteCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
    }

    public fun quote<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::PriceCollector<T1>, arg2: &0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::ScallopMarketVault<T0, T1, T2, T3>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock) {
        0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::package_version::assert_current(arg0);
        0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::assert_scallop_market_match<T0, T1, T2, T3>(arg2, arg4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg3, arg4, arg5);
        let v0 = 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::current_sy_index<T0>(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::assert_market_id<T1>(arg1, 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::market_id<T0, T1, T2, T3>(arg2));
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::collect<T1, 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::sign::SCALLOP>(arg1, 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::sign::sign(), v0, v1);
        let v2 = QuoteCollectedEvent{
            market_id         : 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::market_id<T0, T1, T2, T3>(arg2),
            scallop_market_id : 0xe77999674332f5bd078c8d7182002f7bbf7844591f4d36dbfd1182b25ae071c0::scallop_market_vault::scallop_market_id<T0, T1, T2, T3>(arg2),
            sy_index          : v0,
            updated_at        : v1,
        };
        0x2::event::emit<QuoteCollectedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

