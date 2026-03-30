module 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::harvest {
    struct HarvestInfo has copy, drop, store {
        strategy_id: u8,
        last_harvest_ms: u64,
        total_harvested_usdc: u64,
        harvest_count: u64,
        min_threshold: u64,
        pyth_price_id: 0x2::object::ID,
        reward_decimals: u8,
    }

    struct HarvestConfig has key {
        id: 0x2::object::UID,
        protocols: vector<HarvestInfo>,
        cooldown_ms: u64,
        harvest_slippage_bps: u64,
    }

    struct HarvestPromise<phantom T0> {
        vault_id: 0x2::object::ID,
        strategy_id: u8,
        expected_amount: u64,
        reward_type: 0x1::type_name::TypeName,
    }

    struct HarvestExecutedEvent has copy, drop {
        strategy_id: u8,
        reward_amount: u64,
        usdc_received: u64,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    public fun complete_harvest<T0>(arg0: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &mut HarvestConfig, arg2: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy::StrategyRegistry, arg3: HarvestPromise<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let HarvestPromise {
            vault_id        : v0,
            strategy_id     : v1,
            expected_amount : v2,
            reward_type     : _,
        } = arg3;
        assert!(0x2::object::id<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>>(arg0) == v0, 702);
        let v4 = 0x2::coin::value<T0>(&arg4);
        assert!(v4 > 0, 703);
        let v5 = false;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<HarvestInfo>(&arg1.protocols)) {
            let v8 = 0x1::vector::borrow<HarvestInfo>(&arg1.protocols, v7);
            if (v8.strategy_id == v1) {
                assert!(0x2::object::id<0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject>(arg5) == v8.pyth_price_id, 705);
                v6 = v8.reward_decimals;
                v5 = true;
                break
            };
            v7 = v7 + 1;
        };
        assert!(v5, 701);
        let v9 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_info_from_price_info_object(arg5);
        let v10 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_identifier(&v9);
        let v11 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_identifier::get_bytes(&v10);
        let v12 = if (v11 == x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744") {
            true
        } else if (v11 == x"57ff7100a282e4af0c91154679c5dae2e5dcacb93fd467ea9cb7e58afdcfde27") {
            true
        } else {
            v11 == x"0b3eae8cb6e221e7388a435290e0f2211172563f94769077b7f4c4c6a11eea76"
        };
        assert!(v12, 707);
        let v13 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::pyth::get_price_no_older_than(arg5, arg6, 60);
        let v14 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_price(&v13);
        let v15 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_expo(&v13);
        let v16 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_positive(&v14);
        assert!((0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_conf(&v13) as u128) * 100 <= (v16 as u128) * 2, 706);
        let v17 = 1;
        let v18 = 0;
        while (v18 < (v6 as u64)) {
            v17 = v17 * 10;
            v18 = v18 + 1;
        };
        v18 = 0;
        while (v18 < 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_negative(&v15)) {
            v17 = v17 * 10;
            v18 = v18 + 1;
        };
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::floors::assert_slippage(arg1.harvest_slippage_bps, false);
        assert!(v4 >= (((v2 as u128) * (v16 as u128) * 1000000 / v17) as u64) * (10000 - (arg1.harvest_slippage_bps as u64)) / 10000, 704);
        let v19 = 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::performance_fee_bps<T0>(arg0);
        let v20 = 0;
        if (v19 > 0) {
            let v21 = v4 * v19 / 10000;
            v20 = v21;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v21, arg7), 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::fee_recipient<T0>(arg0));
        };
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::deposit_balance_to_idle<T0>(arg0, 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy::borrow_protocol_access_cap(arg2), 0x2::coin::into_balance<T0>(arg4));
        record_harvest(arg1, v1, v4 - v20, arg6);
        let v22 = HarvestExecutedEvent{
            strategy_id   : v1,
            reward_amount : v2,
            usdc_received : v4 - v20,
            fee_amount    : v20,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<HarvestExecutedEvent>(v22);
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HarvestConfig{
            id                   : 0x2::object::new(arg0),
            protocols            : 0x1::vector::empty<HarvestInfo>(),
            cooldown_ms          : 86400000,
            harvest_slippage_bps : 30,
        };
        0x2::transfer::share_object<HarvestConfig>(v0);
    }

    public fun get_cooldown_ms(arg0: &HarvestConfig) : u64 {
        arg0.cooldown_ms
    }

    public fun get_harvest_info(arg0: &HarvestConfig, arg1: u8) : (u64, u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow<HarvestInfo>(&arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                return (v1.last_harvest_ms, v1.total_harvested_usdc, v1.harvest_count, v1.min_threshold)
            };
            v0 = v0 + 1;
        };
        (0, 0, 0, 0)
    }

    public fun harvest_slippage_bps(arg0: &HarvestConfig) : u64 {
        arg0.harvest_slippage_bps
    }

    public fun issue_harvest_promise<T0, T1>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        let (v0, _) = should_harvest(arg1, arg3, arg5);
        assert!(v0, 700);
        HarvestPromise<T0>{
            vault_id        : 0x2::object::id<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>>(arg0),
            strategy_id     : arg3,
            expected_amount : arg4,
            reward_type     : 0x1::type_name::get<T1>(),
        }
    }

    public fun issue_harvest_promise_for_spoke<T0, T1>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy::StrategyRegistry, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        issue_harvest_promise<T0, T1>(arg0, arg1, 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy::borrow_protocol_access_cap(arg2), arg3, arg4, arg5)
    }

    public fun protocol_count(arg0: &HarvestConfig) : u64 {
        0x1::vector::length<HarvestInfo>(&arg0.protocols)
    }

    fun record_harvest(arg0: &mut HarvestConfig, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                v1.last_harvest_ms = 0x2::clock::timestamp_ms(arg3);
                v1.total_harvested_usdc = v1.total_harvested_usdc + arg2;
                v1.harvest_count = v1.harvest_count + 1;
                return
            };
            v0 = v0 + 1;
        };
        abort 701
    }

    public(friend) fun register_harvest_protocol(arg0: &mut HarvestConfig, arg1: u8, arg2: u64, arg3: 0x2::object::ID, arg4: u8) {
        let v0 = HarvestInfo{
            strategy_id          : arg1,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : arg2,
            pyth_price_id        : arg3,
            reward_decimals      : arg4,
        };
        0x1::vector::push_back<HarvestInfo>(&mut arg0.protocols, v0);
    }

    public(friend) fun set_cooldown_ms(arg0: &mut HarvestConfig, arg1: u64) {
        assert!(arg1 >= 3600000, 700);
        arg0.cooldown_ms = arg1;
    }

    public(friend) fun set_harvest_slippage_bps(arg0: &mut HarvestConfig, arg1: u64) {
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::floors::assert_slippage(arg1, false);
        arg0.harvest_slippage_bps = arg1;
    }

    public(friend) fun set_min_threshold(arg0: &mut HarvestConfig, arg1: u8, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                v1.min_threshold = arg2;
                return
            };
            v0 = v0 + 1;
        };
        abort 701
    }

    public(friend) fun set_pyth_price_id(arg0: &mut HarvestConfig, arg1: u8, arg2: 0x2::object::ID, arg3: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                v1.pyth_price_id = arg2;
                v1.reward_decimals = arg3;
                return
            };
            v0 = v0 + 1;
        };
        abort 701
    }

    public fun should_harvest(arg0: &HarvestConfig, arg1: u8, arg2: &0x2::clock::Clock) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow<HarvestInfo>(&arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                return (0x2::clock::timestamp_ms(arg2) - v1.last_harvest_ms >= arg0.cooldown_ms, v1.min_threshold)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public(friend) fun unregister_harvest_protocol(arg0: &mut HarvestConfig, arg1: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            if (0x1::vector::borrow<HarvestInfo>(&arg0.protocols, v0).strategy_id == arg1) {
                0x1::vector::swap_remove<HarvestInfo>(&mut arg0.protocols, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 701
    }

    // decompiled from Move bytecode v6
}

