module 0xa1d6283cf5b81ba4a029ec4dab79df4b5eb904c2da95cb2cd917cc2fe0b2c2ac::harvest {
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
    }

    struct HarvestExecutedEvent has copy, drop {
        strategy_id: u8,
        reward_amount: u64,
        usdc_received: u64,
        timestamp_ms: u64,
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<HarvestInfo>();
        let v1 = HarvestInfo{
            strategy_id          : 2,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : 100000000,
        };
        0x1::vector::push_back<HarvestInfo>(&mut v0, v1);
        let v2 = HarvestInfo{
            strategy_id          : 3,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : 50000000,
        };
        0x1::vector::push_back<HarvestInfo>(&mut v0, v2);
        let v3 = HarvestInfo{
            strategy_id          : 7,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : 50000000,
        };
        0x1::vector::push_back<HarvestInfo>(&mut v0, v3);
        let v4 = HarvestInfo{
            strategy_id          : 8,
            last_harvest_ms      : 0,
            total_harvested_usdc : 0,
            harvest_count        : 0,
            min_threshold        : 50000000,
        };
        0x1::vector::push_back<HarvestInfo>(&mut v0, v4);
        let v5 = HarvestConfig{
            id          : 0x2::object::new(arg0),
            protocols   : v0,
            cooldown_ms : 86400000,
        };
        0x2::transfer::share_object<HarvestConfig>(v5);
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

    public fun record_harvest(arg0: &mut HarvestConfig, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                v1.last_harvest_ms = 0x2::clock::timestamp_ms(arg4);
                v1.total_harvested_usdc = v1.total_harvested_usdc + arg3;
                v1.harvest_count = v1.harvest_count + 1;
                let v2 = HarvestExecutedEvent{
                    strategy_id   : arg1,
                    reward_amount : arg2,
                    usdc_received : arg3,
                    timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::event::emit<HarvestExecutedEvent>(v2);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun set_cooldown_ms(arg0: &mut HarvestConfig, arg1: u64) {
        arg0.cooldown_ms = arg1;
    }

    public fun set_min_threshold(arg0: &mut HarvestConfig, arg1: u8, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HarvestInfo>(&arg0.protocols)) {
            let v1 = 0x1::vector::borrow_mut<HarvestInfo>(&mut arg0.protocols, v0);
            if (v1.strategy_id == arg1) {
                v1.min_threshold = arg2;
                return
            };
            v0 = v0 + 1;
        };
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

