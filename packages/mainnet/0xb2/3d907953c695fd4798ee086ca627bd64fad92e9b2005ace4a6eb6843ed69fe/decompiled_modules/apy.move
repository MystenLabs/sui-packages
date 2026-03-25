module 0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::apy {
    struct RateEntry has copy, drop, store {
        base_apy_bps: u64,
        reward_apy_bps: u64,
        total_apy_bps: u64,
        raw_base_apy_bps: u64,
        raw_reward_apy_bps: u64,
        updated_at_ms: u64,
    }

    struct ApyRegistry has key {
        id: 0x2::object::UID,
        entries: 0x2::vec_map::VecMap<u8, RateEntry>,
        previous_entries: 0x2::vec_map::VecMap<u8, RateEntry>,
        last_update_ms: u64,
        ema_alpha_bps: u64,
    }

    struct ApyUpdatedEvent has copy, drop {
        strategy_id: u8,
        base_apy_bps: u64,
        reward_apy_bps: u64,
        total_apy_bps: u64,
        timestamp_ms: u64,
    }

    struct EmaAlphaUpdatedEvent has copy, drop {
        old_alpha_bps: u64,
        new_alpha_bps: u64,
    }

    struct TvlUpdatedEvent has copy, drop {
        strategy_id: u8,
        tvl_cents: u64,
        timestamp_ms: u64,
    }

    public fun apr_to_apy_bps(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1000000000000;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 365) {
            let v3 = v1 * (v0 + (arg0 as u128) * v0 / (365 as u128) / 10000);
            v1 = v3 / v0;
            v2 = v2 + 1;
        };
        (((v1 - v0) * 10000 / v0) as u64)
    }

    public fun begin_update(arg0: &mut ApyRegistry, arg1: &0x2::clock::Clock) {
        arg0.previous_entries = arg0.entries;
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun compute_navi_reward_apy_bps(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0 || arg3 == 0) {
            return 0
        };
        let v0 = (arg2 as u256) * (arg3 as u256) * 1000000000000000000;
        if (v0 == 0) {
            return 0
        };
        apr_to_apy_bps((((arg0 as u256) * (31557600 as u256) * (arg1 as u256) * 10000 / v0) as u64))
    }

    public fun compute_reward_apy_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 == 0 || arg3 == 0) {
            return 0
        };
        let v0 = (arg3 as u128) / 100;
        if (v0 == 0) {
            return 0
        };
        apr_to_apy_bps((((arg0 as u128) * (31557600000 as u128) * (arg2 as u128) / (arg1 as u128) / 1000000000 / 100 * 10000 / v0) as u64))
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ApyRegistry{
            id               : 0x2::object::new(arg0),
            entries          : 0x2::vec_map::empty<u8, RateEntry>(),
            previous_entries : 0x2::vec_map::empty<u8, RateEntry>(),
            last_update_ms   : 0,
            ema_alpha_bps    : 2000,
        };
        0x2::transfer::share_object<ApyRegistry>(v0);
    }

    public fun ema_alpha_bps(arg0: &ApyRegistry) : u64 {
        arg0.ema_alpha_bps
    }

    public fun ema_smooth(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        (((v0 * (arg1 as u128) + (10000 - v0) * (arg0 as u128)) / 10000) as u64)
    }

    public fun finish_update(arg0: &ApyRegistry, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<u8, RateEntry>(&arg0.entries)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<u8, RateEntry>(&arg0.entries, v0);
            if (v2.updated_at_ms == arg0.last_update_ms) {
                let v3 = ApyUpdatedEvent{
                    strategy_id    : *v1,
                    base_apy_bps   : v2.base_apy_bps,
                    reward_apy_bps : v2.reward_apy_bps,
                    total_apy_bps  : v2.total_apy_bps,
                    timestamp_ms   : 0x2::clock::timestamp_ms(arg1),
                };
                0x2::event::emit<ApyUpdatedEvent>(v3);
            };
            v0 = v0 + 1;
        };
    }

    public fun get_base_apy(arg0: &ApyRegistry, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, RateEntry>(&arg0.entries, &arg1).base_apy_bps
    }

    public fun get_reward_apy(arg0: &ApyRegistry, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, RateEntry>(&arg0.entries, &arg1).reward_apy_bps
    }

    public fun get_total_apy(arg0: &ApyRegistry, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, RateEntry>(&arg0.entries, &arg1).total_apy_bps
    }

    public fun get_tvl(arg0: &ApyRegistry, arg1: u8) : u64 {
        let v0 = tvl_key(arg1);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
    }

    public fun last_update_ms(arg0: &ApyRegistry) : u64 {
        arg0.last_update_ms
    }

    public fun push_base_apy(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = if (arg3) {
            apr_to_apy_bps(arg2)
        } else {
            arg2
        };
        if (0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<u8, RateEntry>(&mut arg0.entries, &arg1);
            v1.raw_base_apy_bps = v0;
            v1.base_apy_bps = ema_smooth(v1.base_apy_bps, v0, arg0.ema_alpha_bps);
            v1.total_apy_bps = v1.base_apy_bps + v1.reward_apy_bps;
            v1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        } else {
            let v2 = RateEntry{
                base_apy_bps       : v0,
                reward_apy_bps     : 0,
                total_apy_bps      : v0,
                raw_base_apy_bps   : v0,
                raw_reward_apy_bps : 0,
                updated_at_ms      : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::vec_map::insert<u8, RateEntry>(&mut arg0.entries, arg1, v2);
        };
    }

    public fun push_navi_reward_data(arg0: &mut ApyRegistry, arg1: u8, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        store_reward_apy(arg0, arg1, compute_navi_reward_apy_bps(arg2, arg3, arg4, arg5), arg6);
    }

    public fun push_reward_apy(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        store_reward_apy(arg0, arg1, arg2, arg3);
    }

    public fun push_reward_data(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        store_reward_apy(arg0, arg1, compute_reward_apy_bps(arg2, arg3, arg4, arg5), arg6);
    }

    public fun push_tvl(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = tvl_key(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, arg2);
        };
        let v1 = TvlUpdatedEvent{
            strategy_id  : arg1,
            tvl_cents    : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TvlUpdatedEvent>(v1);
    }

    public fun select_best_strategy(arg0: &ApyRegistry, arg1: &0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::strategy::StrategyRegistry) : u8 {
        let v0 = 0x1362e9205332d5fd8132772683da18be735b456b97ac86a7115eacb3726c30ad::strategy::list_available(arg1);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 > 0, 502);
        let v2 = *0x1::vector::borrow<u8>(&v0, 0);
        let v3 = v2;
        let v4 = get_total_apy(arg0, v2);
        let v5 = 1;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<u8>(&v0, v5);
            v4 = get_total_apy(arg0, v6);
            if (v4 > v4) {
                v3 = v6;
            };
            v5 = v5 + 1;
        };
        v3
    }

    public(friend) fun set_ema_alpha(arg0: &mut ApyRegistry, arg1: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 < 10000, 501);
        arg0.ema_alpha_bps = arg2;
        let v0 = EmaAlphaUpdatedEvent{
            old_alpha_bps : arg0.ema_alpha_bps,
            new_alpha_bps : arg2,
        };
        0x2::event::emit<EmaAlphaUpdatedEvent>(v0);
    }

    fun store_reward_apy(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        if (0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, RateEntry>(&mut arg0.entries, &arg1);
            v0.raw_reward_apy_bps = arg2;
            v0.reward_apy_bps = ema_smooth(v0.reward_apy_bps, arg2, arg0.ema_alpha_bps);
            v0.total_apy_bps = v0.base_apy_bps + v0.reward_apy_bps;
            v0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        } else {
            let v1 = RateEntry{
                base_apy_bps       : 0,
                reward_apy_bps     : arg2,
                total_apy_bps      : arg2,
                raw_base_apy_bps   : 0,
                raw_reward_apy_bps : arg2,
                updated_at_ms      : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::vec_map::insert<u8, RateEntry>(&mut arg0.entries, arg1, v1);
        };
    }

    fun tvl_key(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"tvl_");
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, arg0 / 100 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 100 / 10 + 48);
        0x1::vector::push_back<u8>(v2, arg0 % 10 + 48);
        0x1::string::append_utf8(&mut v0, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

