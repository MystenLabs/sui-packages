module 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::harvest {
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

    public fun complete_harvest<T0>(arg0: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg1: &mut HarvestConfig, arg2: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::StrategyRegistry, arg3: HarvestPromise<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::EnclaveRegistry, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let HarvestPromise {
            vault_id        : v0,
            strategy_id     : v1,
            expected_amount : v2,
            reward_type     : _,
        } = arg3;
        assert!(0x2::object::id<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>>(arg0) == v0, 702);
        let v4 = 0x2::coin::value<T0>(&arg4);
        assert!(v4 > 0, 703);
        let v5 = false;
        let v6 = 0;
        while (v6 < 0x1::vector::length<HarvestInfo>(&arg1.protocols)) {
            if (0x1::vector::borrow<HarvestInfo>(&arg1.protocols, v6).strategy_id == v1) {
                v5 = true;
                break
            };
            v6 = v6 + 1;
        };
        assert!(v5, 701);
        let v7 = 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::verify_and_decode_yield_receipt(arg5, arg6, arg7);
        assert!(0x2::clock::timestamp_ms(arg8) - 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_yield_timestamp_ms(&v7) <= 60000, 708);
        assert!(0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_yield_strategy_id(&v7) == v1, 701);
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::floors::assert_slippage(arg1.harvest_slippage_bps, false);
        assert!(v4 >= 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_yield_asset_amount(&v7) * (10000 - (arg1.harvest_slippage_bps as u64)) / 10000, 704);
        let v8 = 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::performance_fee_bps<T0>(arg0);
        let v9 = 0;
        if (v8 > 0) {
            let v10 = v4 * v8 / 10000;
            v9 = v10;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v10, arg9), 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::fee_recipient<T0>(arg0));
        };
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::deposit_balance_to_idle<T0>(arg0, 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::borrow_protocol_access_cap(arg2), 0x2::coin::into_balance<T0>(arg4));
        record_harvest(arg1, v1, v4 - v9, arg8);
        let v11 = HarvestExecutedEvent{
            strategy_id   : v1,
            reward_amount : v2,
            usdc_received : v4 - v9,
            fee_amount    : v9,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<HarvestExecutedEvent>(v11);
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

    public fun issue_harvest_promise<T0, T1>(arg0: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        let (v0, _) = should_harvest(arg1, arg3, arg5);
        assert!(v0, 700);
        HarvestPromise<T0>{
            vault_id        : 0x2::object::id<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>>(arg0),
            strategy_id     : arg3,
            expected_amount : arg4,
            reward_type     : 0x1::type_name::with_defining_ids<T1>(),
        }
    }

    public fun issue_harvest_promise_for_spoke<T0, T1>(arg0: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg1: &HarvestConfig, arg2: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::StrategyRegistry, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : HarvestPromise<T0> {
        issue_harvest_promise<T0, T1>(arg0, arg1, 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::borrow_protocol_access_cap(arg2), arg3, arg4, arg5)
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
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::floors::assert_slippage(arg1, false);
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

    // decompiled from Move bytecode v6
}

