module 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_price_ticket {
    struct QuoteCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        staking_id: 0x2::object::ID,
        exchange_rate: u64,
        sy_index: u128,
        updated_at: u64,
    }

    public fun quote<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg1: &mut 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::PriceCollector<T0>, arg2: &0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::HaedalMarketVault<T0, T1, T2>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock) {
        0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::package_version::assert_current(arg0);
        0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::assert_staking_match<T0, T1, T2>(arg2, arg3);
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::assert_market_id<T0>(arg1, 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::market_id<T0, T1, T2>(arg2));
        let v0 = 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::exchange_rate(arg3);
        let v1 = sy_index_from_exchange_rate(v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::collector::collect<T0, 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::sign::HAEDAL>(arg1, 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::sign::sign(), v1, v2);
        let v3 = QuoteCollectedEvent{
            market_id     : 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::market_id<T0, T1, T2>(arg2),
            staking_id    : 0x4e4f6a5ee9504840a1bd5a9db589782fa44d6d1ce6f4fe45e93c6b664e161ca3::haedal_market_vault::staking_id<T0, T1, T2>(arg2),
            exchange_rate : v0,
            sy_index      : v1,
            updated_at    : v2,
        };
        0x2::event::emit<QuoteCollectedEvent>(v3);
    }

    public fun sy_index_from_exchange_rate(arg0: u64) : u128 {
        assert!(arg0 > 0, 1200);
        let v0 = (arg0 as u256) * 18446744073709551616 / 1000000;
        assert!(v0 > 0, 1201);
        assert!(v0 <= 340282366920938463463374607431768211455, 1202);
        (v0 as u128)
    }

    // decompiled from Move bytecode v7
}

