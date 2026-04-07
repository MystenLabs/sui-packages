module 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::apy {
    struct RateEntry has copy, drop, store {
        base_apy_bps: u64,
        reward_apy_bps: u64,
        total_apy_bps: u64,
        raw_base_apy_bps: u64,
        raw_reward_apy_bps: u64,
        updated_at_ms: u64,
        last_payload_timestamp_ms: u64,
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

    public fun assert_not_stale(arg0: &ApyRegistry, arg1: u8, arg2: &0x2::clock::Clock) {
        if (!0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg2) - 0x2::vec_map::get<u8, RateEntry>(&arg0.entries, &arg1).updated_at_ms <= 7200000, 503);
    }

    public fun begin_update(arg0: &mut ApyRegistry, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_update_ms == 0 || v0 - arg0.last_update_ms >= 1800000, 504);
        arg0.previous_entries = arg0.entries;
        arg0.last_update_ms = v0;
    }

    fun clamp_raw_growth(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 + arg0 / 2 + 500;
        if (arg1 > v0) {
            v0
        } else {
            arg1
        }
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

    public fun get_entry_updated_at(arg0: &ApyRegistry, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, RateEntry>(&arg0.entries, &arg1).updated_at_ms
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

    public fun max_ema_alpha_bps() : u64 {
        5000
    }

    public fun min_ema_alpha_bps() : u64 {
        500
    }

    public fun push_base_apy(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = if (arg3) {
            apr_to_apy_bps(arg2)
        } else {
            arg2
        };
        update_base_apy_internal(arg0, arg1, v0, 0, arg4);
    }

    public fun push_base_apy_verified(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = if (arg3) {
            apr_to_apy_bps(arg2)
        } else {
            arg2
        };
        let v1 = apr_to_apy_bps(arg4);
        let v2 = if (v1 > 500) {
            v1 - 500
        } else {
            0
        };
        assert!(v0 <= v1 + 500 && v0 >= v2, 505);
        update_base_apy_internal(arg0, arg1, v0, 0, arg5);
    }

    public fun push_full_from_enclave(arg0: &mut ApyRegistry, arg1: &vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, arg1, &arg2), 605);
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        assert!(v3 >= v2 && v3 - v2 <= 300000, 601);
        update_base_apy_internal(arg0, v1, 0x2::bcs::peel_u64(&mut v0), v2, arg4);
        store_reward_apy(arg0, v1, 0x2::bcs::peel_u64(&mut v0), arg4);
        push_tvl(arg0, v1, 0x2::bcs::peel_u64(&mut v0), arg4);
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

    public fun select_best_strategy(arg0: &ApyRegistry, arg1: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry) : u8 {
        let v0 = 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::list_available(arg1);
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

    public(friend) fun set_ema_alpha(arg0: &mut ApyRegistry, arg1: u64) {
        assert!(arg1 >= 500 && arg1 <= 5000, 501);
        arg0.ema_alpha_bps = arg1;
        let v0 = EmaAlphaUpdatedEvent{
            old_alpha_bps : arg0.ema_alpha_bps,
            new_alpha_bps : arg1,
        };
        0x2::event::emit<EmaAlphaUpdatedEvent>(v0);
    }

    public fun stale_apy_threshold_ms() : u64 {
        7200000
    }

    fun store_reward_apy(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock) {
        if (0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, RateEntry>(&mut arg0.entries, &arg1);
            v0.raw_reward_apy_bps = arg2;
            v0.reward_apy_bps = ema_smooth(v0.reward_apy_bps, clamp_raw_growth(v0.reward_apy_bps, arg2), arg0.ema_alpha_bps);
            v0.total_apy_bps = v0.base_apy_bps + v0.reward_apy_bps;
            v0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        } else {
            let v1 = RateEntry{
                base_apy_bps              : 0,
                reward_apy_bps            : arg2,
                total_apy_bps             : arg2,
                raw_base_apy_bps          : 0,
                raw_reward_apy_bps        : arg2,
                updated_at_ms             : 0x2::clock::timestamp_ms(arg3),
                last_payload_timestamp_ms : 0,
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

    fun update_base_apy_internal(arg0: &mut ApyRegistry, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x2::vec_map::contains<u8, RateEntry>(&arg0.entries, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, RateEntry>(&mut arg0.entries, &arg1);
            if (arg3 > 0) {
                assert!(arg3 > v0.last_payload_timestamp_ms, 606);
                v0.last_payload_timestamp_ms = arg3;
            };
            v0.raw_base_apy_bps = arg2;
            v0.base_apy_bps = ema_smooth(v0.base_apy_bps, clamp_raw_growth(v0.base_apy_bps, arg2), arg0.ema_alpha_bps);
            v0.total_apy_bps = v0.base_apy_bps + v0.reward_apy_bps;
            v0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        } else {
            let v1 = RateEntry{
                base_apy_bps              : arg2,
                reward_apy_bps            : 0,
                total_apy_bps             : arg2,
                raw_base_apy_bps          : arg2,
                raw_reward_apy_bps        : 0,
                updated_at_ms             : 0x2::clock::timestamp_ms(arg4),
                last_payload_timestamp_ms : arg3,
            };
            0x2::vec_map::insert<u8, RateEntry>(&mut arg0.entries, arg1, v1);
        };
    }

    // decompiled from Move bytecode v6
}

