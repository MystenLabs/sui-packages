module 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::price_guard {
    struct PriceGuard has key {
        id: 0x2::object::UID,
        base_type: 0x1::type_name::TypeName,
        bucket_lows: vector<u64>,
        bucket_highs: vector<u64>,
        bucket_index: u64,
        cur_bucket_start_ts: u64,
        spike_threshold_bp: u64,
        window_ms: u64,
        new_positions_paused: bool,
        paused_until_ts_ms: u64,
        pause_duration_ms: u64,
        max_staleness_ms: u64,
        last_update_ts_ms: u64,
        created_ts_ms: u64,
        pending_trigger_ts_ms: u64,
        pending_trigger_up: bool,
        u64_padding: vector<u64>,
    }

    struct PriceGuardLatched has copy, drop {
        guard_id: 0x2::object::ID,
        base_type: 0x1::type_name::TypeName,
        price: u64,
        rolling_low: u64,
        rolling_high: u64,
        paused_until_ts_ms: u64,
    }

    struct PriceGuardCleared has copy, drop {
        guard_id: 0x2::object::ID,
        base_type: 0x1::type_name::TypeName,
        by_admin: bool,
        now_ms: u64,
    }

    struct PriceGuardConfigUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        spike_threshold_bp: u64,
        window_ms: u64,
        pause_duration_ms: u64,
        max_staleness_ms: u64,
    }

    public fun assert_base_type<T0>(arg0: &PriceGuard) {
        assert!(arg0.base_type == 0x1::type_name::with_defining_ids<T0>(), 1501);
    }

    public fun assert_trading_allowed(arg0: &PriceGuard, arg1: u64, arg2: u64) {
        assert!(!is_stale(arg0, arg2), 1502);
        assert!(!is_unseeded(arg0), 1505);
        assert!(!is_latch_active(arg0, arg2), 1503);
        assert!(!would_trigger(arg0, arg1), 1507);
    }

    public fun bucket_start_ts(arg0: &PriceGuard) : u64 {
        arg0.cur_bucket_start_ts
    }

    fun bucket_width_ms(arg0: &PriceGuard) : u64 {
        sub_bucket_width(arg0.window_ms)
    }

    fun clear_buckets(arg0: &mut PriceGuard) {
        let v0 = 0;
        while (v0 < 7) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_lows, v0) = 0;
            *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_highs, v0) = 0;
            v0 = v0 + 1;
        };
        arg0.bucket_index = 0;
    }

    fun clear_pending(arg0: &mut PriceGuard) {
        arg0.pending_trigger_ts_ms = 0;
        arg0.pending_trigger_up = false;
    }

    public fun created_ts_ms(arg0: &PriceGuard) : u64 {
        arg0.created_ts_ms
    }

    fun effective_high(arg0: &PriceGuard) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 7) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.bucket_highs, v2);
            if (v3 > v0) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun effective_low(arg0: &PriceGuard) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0;
        while (v2 < 7) {
            let v3 = *0x1::vector::borrow<u64>(&arg0.bucket_lows, v2);
            if (v3 > 0 && (v0 == 0 || v3 < v0)) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun emit_config_updated(arg0: &PriceGuard) {
        let v0 = PriceGuardConfigUpdated{
            guard_id           : 0x2::object::id<PriceGuard>(arg0),
            spike_threshold_bp : arg0.spike_threshold_bp,
            window_ms          : arg0.window_ms,
            pause_duration_ms  : arg0.pause_duration_ms,
            max_staleness_ms   : arg0.max_staleness_ms,
        };
        0x2::event::emit<PriceGuardConfigUpdated>(v0);
    }

    fun has_baseline(arg0: &PriceGuard) : bool {
        effective_low(arg0) > 0
    }

    public fun is_armed(arg0: &PriceGuard) : bool {
        arg0.last_update_ts_ms > 0
    }

    fun is_latch_active(arg0: &PriceGuard, arg1: u64) : bool {
        arg0.new_positions_paused && arg1 < arg0.paused_until_ts_ms
    }

    public fun is_stale(arg0: &PriceGuard, arg1: u64) : bool {
        let v0 = if (is_armed(arg0)) {
            arg0.last_update_ts_ms
        } else {
            arg0.created_ts_ms
        };
        arg1 > v0 && arg1 - v0 > arg0.max_staleness_ms
    }

    public fun is_trading_allowed(arg0: &PriceGuard, arg1: u64, arg2: u64) : bool {
        if (!is_stale(arg0, arg2)) {
            if (!is_unseeded(arg0)) {
                if (!is_latch_active(arg0, arg2)) {
                    !would_trigger(arg0, arg1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_unseeded(arg0: &PriceGuard) : bool {
        !has_baseline(arg0)
    }

    public fun last_update_ts_ms(arg0: &PriceGuard) : u64 {
        arg0.last_update_ts_ms
    }

    public fun max_staleness_ms(arg0: &PriceGuard) : u64 {
        arg0.max_staleness_ms
    }

    fun maybe_clear_latch(arg0: &mut PriceGuard, arg1: u64) {
        if (arg0.new_positions_paused && !is_latch_active(arg0, arg1)) {
            arg0.new_positions_paused = false;
            let v0 = PriceGuardCleared{
                guard_id  : 0x2::object::id<PriceGuard>(arg0),
                base_type : arg0.base_type,
                by_admin  : false,
                now_ms    : arg1,
            };
            0x2::event::emit<PriceGuardCleared>(v0);
        };
    }

    public fun new_guard<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        let v0 = new_guard_<T0>(0x2::clock::timestamp_ms(arg3), arg4);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v0.base_type);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::id<PriceGuard>(&v0));
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::emit_admin_event(4, 0, 0, v1, v2, vector[], arg4);
        0x2::transfer::share_object<PriceGuard>(v0);
    }

    fun new_guard_<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : PriceGuard {
        PriceGuard{
            id                    : 0x2::object::new(arg1),
            base_type             : 0x1::type_name::with_defining_ids<T0>(),
            bucket_lows           : vector[0, 0, 0, 0, 0, 0, 0],
            bucket_highs          : vector[0, 0, 0, 0, 0, 0, 0],
            bucket_index          : 0,
            cur_bucket_start_ts   : arg0,
            spike_threshold_bp    : 20000,
            window_ms             : 86400000,
            new_positions_paused  : false,
            paused_until_ts_ms    : 0,
            pause_duration_ms     : 1800000,
            max_staleness_ms      : 600000,
            last_update_ts_ms     : 0,
            created_ts_ms         : arg0,
            pending_trigger_ts_ms : 0,
            pending_trigger_up    : false,
            u64_padding           : vector[],
        }
    }

    public fun pause_duration_ms(arg0: &PriceGuard) : u64 {
        arg0.pause_duration_ms
    }

    public fun paused_until_ts_ms(arg0: &PriceGuard) : u64 {
        arg0.paused_until_ts_ms
    }

    public fun pending_trigger_ts_ms(arg0: &PriceGuard) : u64 {
        arg0.pending_trigger_ts_ms
    }

    public fun pending_trigger_up(arg0: &PriceGuard) : bool {
        arg0.pending_trigger_up
    }

    fun record_observation(arg0: &mut PriceGuard, arg1: u64) {
        let v0 = arg0.bucket_index;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.bucket_lows, v0);
        if (*v1 == 0 || arg1 < *v1) {
            *v1 = arg1;
        };
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.bucket_highs, v0);
        if (arg1 > *v2) {
            *v2 = arg1;
        };
    }

    public fun resume(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut PriceGuard, arg4: &0x2::clock::Clock) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        arg3.new_positions_paused = false;
        arg3.paused_until_ts_ms = 0;
        clear_buckets(arg3);
        clear_pending(arg3);
        let v0 = PriceGuardCleared{
            guard_id  : 0x2::object::id<PriceGuard>(arg3),
            base_type : arg3.base_type,
            by_admin  : true,
            now_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PriceGuardCleared>(v0);
    }

    fun ring_triggers_at(arg0: &PriceGuard, arg1: u64) : bool {
        let v0 = effective_low(arg0);
        if (v0 == 0) {
            return false
        };
        (effective_high(arg0) as u128) * (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128) >= (v0 as u128) * (arg1 as u128)
    }

    public fun rolling_high(arg0: &PriceGuard) : u64 {
        effective_high(arg0)
    }

    public fun rolling_low(arg0: &PriceGuard) : u64 {
        effective_low(arg0)
    }

    fun rotate_buckets(arg0: &mut PriceGuard, arg1: u64) {
        let v0 = bucket_width_ms(arg0);
        if (arg1 <= arg0.cur_bucket_start_ts) {
            return
        };
        let v1 = arg1 - arg0.cur_bucket_start_ts;
        if (v1 < v0) {
            return
        };
        let v2 = v1 / v0;
        if (v2 >= 7) {
            clear_buckets(arg0);
            arg0.cur_bucket_start_ts = arg1;
            return
        };
        let v3 = 0;
        while (v3 < v2) {
            arg0.bucket_index = (arg0.bucket_index + 1) % 7;
            *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_lows, arg0.bucket_index) = 0;
            *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_highs, arg0.bucket_index) = 0;
            v3 = v3 + 1;
        };
        arg0.cur_bucket_start_ts = arg0.cur_bucket_start_ts + v2 * v0;
    }

    fun seed(arg0: &mut PriceGuard, arg1: u64, arg2: u64) {
        clear_buckets(arg0);
        *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_lows, 0) = arg1;
        *0x1::vector::borrow_mut<u64>(&mut arg0.bucket_highs, 0) = arg1;
        arg0.cur_bucket_start_ts = arg2;
        clear_pending(arg0);
    }

    public fun set_max_staleness(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut PriceGuard, arg4: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        let v0 = if (arg4 >= 60000) {
            if (arg4 <= 86400000) {
                if (arg4 < arg3.pause_duration_ms) {
                    arg4 <= bucket_width_ms(arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1500);
        arg3.max_staleness_ms = arg4;
        emit_config_updated(arg3);
    }

    public fun set_pause_duration(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut PriceGuard, arg4: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        let v0 = if (arg4 >= 120000) {
            if (arg4 <= 86400000) {
                arg4 > arg3.max_staleness_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1500);
        arg3.pause_duration_ms = arg4;
        emit_config_updated(arg3);
    }

    public fun set_spike_threshold(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut PriceGuard, arg4: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        assert!(arg4 >= 11000 && arg4 <= 1000000, 1500);
        if (ring_triggers_at(arg3, arg4)) {
            clear_buckets(arg3);
        };
        arg3.spike_threshold_bp = arg4;
        clear_pending(arg3);
        emit_config_updated(arg3);
    }

    public fun set_window(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg3: &mut PriceGuard, arg4: u64, arg5: &0x2::clock::Clock) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg1, arg2);
        let v0 = if (arg4 >= 3600000) {
            if (arg4 <= 2592000000) {
                sub_bucket_width(arg4) >= arg3.max_staleness_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1500);
        arg3.window_ms = arg4;
        arg3.cur_bucket_start_ts = 0x2::clock::timestamp_ms(arg5);
        clear_pending(arg3);
        emit_config_updated(arg3);
    }

    public fun spike_threshold_bp(arg0: &PriceGuard) : u64 {
        arg0.spike_threshold_bp
    }

    fun sub_bucket_width(arg0: u64) : u64 {
        (arg0 + 6 - 1) / 6
    }

    public fun update<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut PriceGuard, arg2: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg3: &0x2::clock::Clock) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::version_check(arg0);
        assert_base_type<T0>(arg1);
        let (v0, _) = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::oracle::get_price<T0>(arg2, arg3);
        update_(arg1, v0, 0x2::clock::timestamp_ms(arg3));
    }

    fun update_(arg0: &mut PriceGuard, arg1: u64, arg2: u64) {
        assert!(arg1 != 0, 1302);
        assert!(arg2 >= arg0.last_update_ts_ms, 1504);
        let v0 = if (is_armed(arg0)) {
            arg2 - arg0.last_update_ts_ms <= arg0.max_staleness_ms
        } else {
            false
        };
        arg0.last_update_ts_ms = arg2;
        maybe_clear_latch(arg0, arg2);
        if (!has_baseline(arg0)) {
            seed(arg0, arg1, arg2);
            return
        };
        let v1 = (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128);
        let v2 = (arg1 as u128);
        let v3 = v2 * v1 >= (effective_low(arg0) as u128) * (arg0.spike_threshold_bp as u128);
        let v4 = v2 * (arg0.spike_threshold_bp as u128) <= (effective_high(arg0) as u128) * v1;
        let v5 = effective_low(arg0);
        let v6 = effective_high(arg0);
        rotate_buckets(arg0, arg2);
        let v7 = v3 || v4;
        if (!v7) {
            clear_pending(arg0);
            record_observation(arg0, arg1);
            return
        };
        let v8 = if (arg0.pending_trigger_ts_ms == 0) {
            true
        } else if (!v0) {
            true
        } else {
            arg0.pending_trigger_up != v3
        };
        if (v8) {
            arg0.pending_trigger_ts_ms = arg2;
            arg0.pending_trigger_up = v3;
        } else if (arg2 - arg0.pending_trigger_ts_ms >= arg0.window_ms) {
            seed(arg0, arg1, arg2);
        };
        arg0.new_positions_paused = true;
        arg0.paused_until_ts_ms = arg2 + arg0.pause_duration_ms;
        let v9 = PriceGuardLatched{
            guard_id           : 0x2::object::id<PriceGuard>(arg0),
            base_type          : arg0.base_type,
            price              : arg1,
            rolling_low        : v5,
            rolling_high       : v6,
            paused_until_ts_ms : arg0.paused_until_ts_ms,
        };
        0x2::event::emit<PriceGuardLatched>(v9);
    }

    public fun window_ms(arg0: &PriceGuard) : u64 {
        arg0.window_ms
    }

    public fun would_trigger(arg0: &PriceGuard, arg1: u64) : bool {
        if (!has_baseline(arg0) || arg1 == 0) {
            return true
        };
        let v0 = (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128);
        let v1 = (arg1 as u128);
        v1 * v0 >= (effective_low(arg0) as u128) * (arg0.spike_threshold_bp as u128) || v1 * (arg0.spike_threshold_bp as u128) <= (effective_high(arg0) as u128) * v0
    }

    // decompiled from Move bytecode v7
}

