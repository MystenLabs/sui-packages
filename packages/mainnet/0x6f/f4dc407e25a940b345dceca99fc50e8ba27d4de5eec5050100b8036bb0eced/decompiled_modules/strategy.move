module 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy {
    struct ProtocolInfo has copy, drop, store {
        strategy_id: u8,
        risk_tier: u8,
        is_available: bool,
        rate_num: u64,
        rate_den: u64,
        last_rate_update_ms: u64,
        has_rewards: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        protocols: vector<ProtocolInfo>,
    }

    struct ProtocolStatusChangeEvent has copy, drop {
        strategy_id: u8,
        is_available: bool,
        timestamp_ms: u64,
    }

    struct BestProtocolSelectedEvent has copy, drop {
        best_strategy_id: u8,
        best_rate_num: u64,
        best_rate_den: u64,
        current_strategy_id: u8,
        should_reroute: bool,
    }

    public fun count_available(arg0: &StrategyRegistry) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 < 0x1::vector::length<ProtocolInfo>(&arg0.protocols)) {
            if (0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v1).is_available) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<ProtocolInfo>();
        let v1 = ProtocolInfo{
            strategy_id         : 0,
            risk_tier           : 0,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : false,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v1);
        let v2 = ProtocolInfo{
            strategy_id         : 1,
            risk_tier           : 1,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : false,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v2);
        let v3 = ProtocolInfo{
            strategy_id         : 2,
            risk_tier           : 1,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : true,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v3);
        let v4 = ProtocolInfo{
            strategy_id         : 3,
            risk_tier           : 1,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : true,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v4);
        let v5 = ProtocolInfo{
            strategy_id         : 4,
            risk_tier           : 2,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : false,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v5);
        let v6 = ProtocolInfo{
            strategy_id         : 5,
            risk_tier           : 0,
            is_available        : false,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : false,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v6);
        let v7 = ProtocolInfo{
            strategy_id         : 6,
            risk_tier           : 3,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : false,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v7);
        let v8 = ProtocolInfo{
            strategy_id         : 7,
            risk_tier           : 2,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : true,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v8);
        let v9 = ProtocolInfo{
            strategy_id         : 8,
            risk_tier           : 2,
            is_available        : true,
            rate_num            : 1,
            rate_den            : 1,
            last_rate_update_ms : 0,
            has_rewards         : true,
        };
        0x1::vector::push_back<ProtocolInfo>(&mut v0, v9);
        let v10 = StrategyRegistry{
            id        : 0x2::object::new(arg0),
            protocols : v0,
        };
        0x2::transfer::share_object<StrategyRegistry>(v10);
    }

    public fun get_protocol_info(arg0: &StrategyRegistry, arg1: u8) : (u8, bool, u64, u64, u64, bool) {
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<ProtocolInfo>(&arg0.protocols), 202);
        let v1 = 0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v0);
        (v1.risk_tier, v1.is_available, v1.rate_num, v1.rate_den, v1.last_rate_update_ms, v1.has_rewards)
    }

    public fun has_rewards(arg0: &StrategyRegistry, arg1: u8) : bool {
        let v0 = (arg1 as u64);
        if (v0 >= 0x1::vector::length<ProtocolInfo>(&arg0.protocols)) {
            return false
        };
        0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v0).has_rewards
    }

    public fun is_available(arg0: &StrategyRegistry, arg1: u8) : bool {
        let v0 = (arg1 as u64);
        if (v0 >= 0x1::vector::length<ProtocolInfo>(&arg0.protocols)) {
            return false
        };
        0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v0).is_available
    }

    public fun select_best_protocol(arg0: &StrategyRegistry) : (u8, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 255;
        let v3 = 1;
        while (v3 < 0x1::vector::length<ProtocolInfo>(&arg0.protocols)) {
            let v4 = 0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v3);
            if (v4.is_available && v4.rate_den > 0) {
                let v5 = (v4.rate_num as u128) * 1000000000 / (v4.rate_den as u128);
                if (v5 > v1 || v5 == v1 && v4.risk_tier < v2) {
                    v0 = v4.strategy_id;
                    v2 = v4.risk_tier;
                };
            };
            v3 = v3 + 1;
        };
        let v6 = 0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, (v0 as u64));
        (v0, v6.rate_num, v6.rate_den)
    }

    public fun set_available(arg0: &mut StrategyRegistry, arg1: u8, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<ProtocolInfo>(&arg0.protocols), 202);
        0x1::vector::borrow_mut<ProtocolInfo>(&mut arg0.protocols, v0).is_available = arg2;
        let v1 = ProtocolStatusChangeEvent{
            strategy_id  : arg1,
            is_available : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProtocolStatusChangeEvent>(v1);
    }

    public fun should_reroute(arg0: &StrategyRegistry, arg1: u8, arg2: u64) : (bool, u8) {
        let (v0, v1, v2) = select_best_protocol(arg0);
        if (v0 == 0 || v0 == arg1) {
            let v3 = BestProtocolSelectedEvent{
                best_strategy_id    : v0,
                best_rate_num       : v1,
                best_rate_den       : v2,
                current_strategy_id : arg1,
                should_reroute      : false,
            };
            0x2::event::emit<BestProtocolSelectedEvent>(v3);
            return (false, arg1)
        };
        let v4 = (arg1 as u64);
        if (v4 >= 0x1::vector::length<ProtocolInfo>(&arg0.protocols)) {
            return (true, v0)
        };
        let v5 = 0x1::vector::borrow<ProtocolInfo>(&arg0.protocols, v4);
        if (v5.rate_den == 0 || v5.rate_num == 0) {
            let v6 = BestProtocolSelectedEvent{
                best_strategy_id    : v0,
                best_rate_num       : v1,
                best_rate_den       : v2,
                current_strategy_id : arg1,
                should_reroute      : true,
            };
            0x2::event::emit<BestProtocolSelectedEvent>(v6);
            return (true, v0)
        };
        let v7 = (v1 as u128) * (v5.rate_den as u128);
        let v8 = (v5.rate_num as u128) * (v2 as u128);
        let v9 = v7 > v8 && v8 > 0 && (v7 - v8) * 10000 / v8 >= (arg2 as u128);
        let v10 = BestProtocolSelectedEvent{
            best_strategy_id    : v0,
            best_rate_num       : v1,
            best_rate_den       : v2,
            current_strategy_id : arg1,
            should_reroute      : v9,
        };
        0x2::event::emit<BestProtocolSelectedEvent>(v10);
        (v9, v0)
    }

    public fun strategy_alphafi() : u8 {
        8
    }

    public fun strategy_bluefin() : u8 {
        7
    }

    public fun strategy_bucket() : u8 {
        4
    }

    public fun strategy_idle() : u8 {
        0
    }

    public fun strategy_navi() : u8 {
        2
    }

    public fun strategy_scallop() : u8 {
        1
    }

    public fun strategy_suilend() : u8 {
        3
    }

    public fun strategy_turbos() : u8 {
        6
    }

    public fun update_rate(arg0: &mut StrategyRegistry, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = (arg1 as u64);
        assert!(v0 < 0x1::vector::length<ProtocolInfo>(&arg0.protocols), 202);
        let v1 = 0x1::vector::borrow_mut<ProtocolInfo>(&mut arg0.protocols, v0);
        v1.rate_num = arg2;
        v1.rate_den = arg3;
        v1.last_rate_update_ms = 0x2::clock::timestamp_ms(arg4);
    }

    // decompiled from Move bytecode v6
}

