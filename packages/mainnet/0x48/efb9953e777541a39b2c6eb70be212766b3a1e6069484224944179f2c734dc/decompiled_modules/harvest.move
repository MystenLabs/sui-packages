module 0x4c013c912c99697629b9e92ca27e7e1d6274daf7e5b85446803344d909b9d6e::harvest {
    struct HarvestInfo has copy, drop, store {
        strategy_id: u8,
        last_harvest_ms: u64,
        total_harvested_usdc: u64,
        harvest_count: u64,
        min_threshold: u64,
    }

    struct HarvestConfig has key {
        id: 0x2::object::UID,
        protocols: vector<HarvestInfo>,
        cooldown_ms: u64,
        harvest_slippage_bps: u64,
        tee_public_key: vector<u8>,
    }

    struct HarvestPayload has copy, drop, store {
        vault_id: 0x2::object::ID,
        strategy_id: u8,
        expected_harvest_usdc: u64,
        reward_amount: u64,
        slippage_bps: u64,
        gas_cost_usdc: u64,
        net_profit_usdc: u64,
        hot_potato_safe: bool,
        timestamp_ms: u64,
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

    public fun complete_harvest<T0>(arg0: &mut 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &mut HarvestConfig, arg2: &0x4c013c912c99697629b9e92ca27e7e1d6274daf7e5b85446803344d909b9d6e::strategy::StrategyRegistry, arg3: HarvestPromise<T0>, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let HarvestPromise {
            vault_id        : v0,
            strategy_id     : v1,
            expected_amount : v2,
            reward_type     : _,
        } = arg3;
        assert!(0x2::object::id<0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>>(arg0) == v0, 702);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.tee_public_key, &arg5), 708);
        let v4 = 0x2::bcs::new(arg5);
        let v5 = 0x2::bcs::peel_u64(&mut v4);
        0x2::bcs::peel_u64(&mut v4);
        0x2::bcs::peel_u64(&mut v4);
        0x2::bcs::peel_u64(&mut v4);
        0x2::bcs::peel_u64(&mut v4);
        let v6 = 0x2::object::id<0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>>(arg0);
        assert!(0x2::bcs::peel_address(&mut v4) == 0x2::object::id_to_address(&v6), 709);
        assert!(0x2::bcs::peel_u8(&mut v4) == v1, 710);
        assert!(0x2::bcs::peel_u64(&mut v4) > 0x2::clock::timestamp_ms(arg8) - 300000, 711);
        assert!(0x2::bcs::peel_bool(&mut v4), 712);
        let v7 = if (v5 > 0) {
            v5 - v5 * arg1.harvest_slippage_bps / 10000
        } else {
            0
        };
        assert!(0x2::coin::value<T0>(&arg4) >= v7, 715);
        let v8 = 0x2::coin::value<T0>(&arg4);
        assert!(v8 > 0, 703);
        let v9 = 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::performance_fee_bps<T0>(arg0);
        let v10 = 0;
        if (v9 > 0) {
            let v11 = v8 * v9 / 10000;
            v10 = v11;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v11, arg9), 0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::fee_recipient<T0>(arg0));
        };
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::deposit_balance_to_idle<T0>(arg0, 0x4c013c912c99697629b9e92ca27e7e1d6274daf7e5b85446803344d909b9d6e::strategy::borrow_protocol_access_cap(arg2), 0x2::coin::into_balance<T0>(arg4));
        record_harvest(arg1, v1, v8 - v10, arg8);
        let v12 = HarvestExecutedEvent{
            strategy_id   : v1,
            reward_amount : v2,
            usdc_received : v8 - v10,
            fee_amount    : v10,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<HarvestExecutedEvent>(v12);
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HarvestConfig{
            id                   : 0x2::object::new(arg0),
            protocols            : 0x1::vector::empty<HarvestInfo>(),
            cooldown_ms          : 86400000,
            harvest_slippage_bps : 30,
            tee_public_key       : 0x1::vector::empty<u8>(),
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

    public fun issue_harvest_promise<T0, T1>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::ProtocolAccessCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        let (v0, _) = should_harvest(arg1, arg3, arg5);
        assert!(v0, 700);
        HarvestPromise<T0>{
            vault_id        : 0x2::object::id<0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>>(arg0),
            strategy_id     : arg3,
            expected_amount : arg4,
            reward_type     : 0x1::type_name::get<T1>(),
        }
    }

    public fun issue_harvest_promise_direct<T0, T1>(arg0: &0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x4c013c912c99697629b9e92ca27e7e1d6274daf7e5b85446803344d909b9d6e::strategy::StrategyRegistry, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        issue_harvest_promise<T0, T1>(arg0, arg1, 0x4c013c912c99697629b9e92ca27e7e1d6274daf7e5b85446803344d909b9d6e::strategy::borrow_protocol_access_cap(arg2), arg3, arg4, arg5)
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

    public(friend) fun register_harvest_protocol(arg0: &mut HarvestConfig, arg1: u8, arg2: u64) {
        assert!(0x1::vector::length<HarvestInfo>(&arg0.protocols) < 8, 505);
        let v0 = HarvestInfo{
            strategy_id          : arg1,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : arg2,
        };
        0x1::vector::push_back<HarvestInfo>(&mut arg0.protocols, v0);
    }

    public(friend) fun set_cooldown_ms(arg0: &mut HarvestConfig, arg1: u64) {
        assert!(arg1 >= 3600000, 700);
        arg0.cooldown_ms = arg1;
    }

    public(friend) fun set_harvest_slippage_bps(arg0: &mut HarvestConfig, arg1: u64) {
        0x7a84d2cb1d3cb785b6209f0e411d290856ca2193381af1bcdca721c10e38d5b0::floors::assert_slippage(arg1, false);
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

    public(friend) fun update_harvest_protocol(arg0: &mut HarvestConfig, arg1: u8, arg2: 0x2::object::ID, arg3: u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            if (0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0).strategy_id == arg1) {
                return
            };
            v0 = v0 + 1;
        };
        abort 701
    }

    public(friend) fun update_tee_key(arg0: &mut HarvestConfig, arg1: vector<u8>) {
        arg0.tee_public_key = arg1;
    }

    // decompiled from Move bytecode v6
}

