module 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_price_ticket {
    struct QuoteCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        vault_rate: u64,
        sy_index: u128,
        updated_at: u64,
        quoted_at: u64,
    }

    public fun current_sy_index<T0: drop, T1: drop>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>) : u128 {
        sy_index_from_vault_rate(0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg0))
    }

    public fun quote<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::PriceCollector<T2>, arg2: &0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault::EmberMarketVault<T0, T1, T2, T3, T4>, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg4: &0x2::clock::Clock) {
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::package_version::assert_current(arg0);
        0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault::assert_ember_vault_match<T0, T1, T2, T3, T4>(arg2, arg3);
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg3);
        let v1 = sy_index_from_vault_rate(v0);
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_last_updated_at<T0, T1>(arg3);
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::assert_market_id<T2>(arg1, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault::market_id<T0, T1, T2, T3, T4>(arg2));
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::collect<T2, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::EMBER>(arg1, 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::sign::sign(), v1, v2);
        let v3 = QuoteCollectedEvent{
            market_id      : 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault::market_id<T0, T1, T2, T3, T4>(arg2),
            ember_vault_id : 0xc56a55893f4791d03726f9c109725765b584c06eb5625704ce782112d763ef99::ember_market_vault::ember_vault_id<T0, T1, T2, T3, T4>(arg2),
            vault_rate     : v0,
            sy_index       : v1,
            updated_at     : v2,
            quoted_at      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<QuoteCollectedEvent>(v3);
    }

    public fun sy_index_from_vault_rate(arg0: u64) : u128 {
        assert!(arg0 > 0, 1200);
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(18446744073709551616, 1000000000, (arg0 as u128));
        assert!(v0 > 0, 1201);
        v0
    }

    // decompiled from Move bytecode v7
}

