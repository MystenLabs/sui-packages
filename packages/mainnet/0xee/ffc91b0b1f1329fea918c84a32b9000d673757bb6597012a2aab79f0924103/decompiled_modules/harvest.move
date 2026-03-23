module 0xba0b81fdf50cba87ac4a95686dfed7baf21323adea809b41875b040fff6c072a::harvest {
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

    struct HarvestReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        strategy_id: u8,
    }

    struct HarvestExecutedEvent has copy, drop {
        strategy_id: u8,
        reward_amount: u64,
        usdc_received: u64,
        fee_amount: u64,
        timestamp_ms: u64,
    }

    public fun borrow_cap_for_harvest<T0: store + key>(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg1: &HarvestConfig, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) : (T0, 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::CapReceipt<T0>, HarvestReceipt<T0>) {
        let (v0, _) = should_harvest(arg1, arg2, arg4);
        assert!(v0, 700);
        let (v2, v3) = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::borrow_protocol_cap<T0>(arg0, arg3);
        let v4 = HarvestReceipt<T0>{
            vault_id    : 0x2::object::id<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault>(arg0),
            strategy_id : arg2,
        };
        (v2, v3, v4)
    }

    public fun complete_harvest<T0: store + key>(arg0: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg1: &mut HarvestConfig, arg2: 0x1::string::String, arg3: T0, arg4: 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::CapReceipt<T0>, arg5: HarvestReceipt<T0>, arg6: 0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let HarvestReceipt {
            vault_id    : v0,
            strategy_id : v1,
        } = arg5;
        assert!(0x2::object::id<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault>(arg0) == v0, 702);
        let v2 = 0x2::coin::value<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&arg6);
        assert!(v2 > 0, 703);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_slippage(arg1.harvest_slippage_bps);
        assert!(v2 >= arg8 * (10000 - (arg1.harvest_slippage_bps as u64)) / 10000, 704);
        let v3 = 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::performance_fee_bps(arg0);
        let v4 = 0;
        if (v3 > 0) {
            let v5 = v2 * v3 / 10000;
            v4 = v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>>(0x2::coin::split<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg6, v5, arg10), 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::fee_recipient(arg0));
        };
        0x2::balance::join<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::borrow_idle_balance_mut(arg0), 0x2::coin::into_balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(arg6));
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::return_protocol_cap<T0>(arg0, arg2, arg3, arg4);
        record_harvest(arg1, v1, v2 - v4, arg9);
        let v6 = HarvestExecutedEvent{
            strategy_id   : v1,
            reward_amount : arg7,
            usdc_received : v2 - v4,
            fee_amount    : v4,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<HarvestExecutedEvent>(v6);
    }

    public fun create_config(arg0: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HarvestConfig{
            id                   : 0x2::object::new(arg1),
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

    public(friend) fun register_harvest_protocol(arg0: &mut HarvestConfig, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u8, arg3: u64) {
        let v0 = HarvestInfo{
            strategy_id          : arg2,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : arg3,
        };
        0x1::vector::push_back<HarvestInfo>(&mut arg0.protocols, v0);
    }

    public(friend) fun set_cooldown_ms(arg0: &mut HarvestConfig, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u64) {
        assert!(arg2 >= 3600000, 700);
        arg0.cooldown_ms = arg2;
    }

    public(friend) fun set_harvest_slippage_bps(arg0: &mut HarvestConfig, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u64) {
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_slippage(arg2);
        arg0.harvest_slippage_bps = arg2;
    }

    public(friend) fun set_min_threshold(arg0: &mut HarvestConfig, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg2: u8, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg2) {
                v1.min_threshold = arg3;
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

    // decompiled from Move bytecode v6
}

