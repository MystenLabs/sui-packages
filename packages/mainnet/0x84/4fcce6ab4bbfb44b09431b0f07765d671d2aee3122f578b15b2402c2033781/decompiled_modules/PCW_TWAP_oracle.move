module 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::PCW_TWAP_oracle {
    struct Checkpoint has copy, drop, store {
        timestamp: u64,
        cumulative: u256,
    }

    struct SimpleTWAP has store {
        last_window_twap: u128,
        cumulative_price: u256,
        window_start: u64,
        last_update: u64,
        window_size_ms: u64,
        max_movement_ppm: u64,
        initialized: bool,
        cumulative_total: u256,
        last_price: u128,
        initialized_at: u64,
        checkpoints: vector<Checkpoint>,
        last_checkpoint_at: u64,
    }

    struct WindowFinalized has copy, drop {
        timestamp: u64,
        raw_twap: u128,
        capped_twap: u128,
        num_windows: u64,
    }

    fun advance(arg0: &mut SimpleTWAP, arg1: u64, arg2: u128) {
        let v0 = arg0.window_size_ms;
        let v1 = arg0.last_update - arg0.window_start;
        let v2 = arg1 - arg0.last_update;
        if (v1 + v2 < v0) {
            arg0.cumulative_price = arg0.cumulative_price + (arg2 as u256) * (v2 as u256);
            arg0.cumulative_total = arg0.cumulative_total + (arg0.last_window_twap as u256) * (v2 as u256);
            arg0.last_update = arg1;
            return
        };
        let v3 = compute_delta_m(arg0.last_window_twap, arg0.max_movement_ppm);
        let v4 = v0 - v1;
        arg0.cumulative_price = arg0.cumulative_price + (arg2 as u256) * (v4 as u256);
        arg0.cumulative_total = arg0.cumulative_total + (arg0.last_window_twap as u256) * (v4 as u256);
        let v5 = arg0.cumulative_price / (v0 as u256);
        let v6 = if (v5 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v5 as u128)
        };
        apply_pcw_cap(arg0, v6, 1, v3);
        arg0.cumulative_price = 0;
        arg0.last_update = arg0.last_update + v4;
        let v7 = (arg1 - arg0.last_update) / v0;
        if (v7 > 0) {
            arg0.cumulative_total = arg0.cumulative_total + (arg0.last_window_twap as u256) * (v7 as u256) * (v0 as u256);
            apply_pcw_cap(arg0, arg2, v7, v3);
            arg0.last_update = arg0.last_update + v7 * v0;
        };
        let v8 = arg1 - arg0.last_update;
        if (v8 > 0) {
            arg0.cumulative_price = (arg2 as u256) * (v8 as u256);
            arg0.cumulative_total = arg0.cumulative_total + (arg0.last_window_twap as u256) * (v8 as u256);
            arg0.last_update = arg1;
        };
    }

    fun apply_pcw_cap(arg0: &mut SimpleTWAP, arg1: u128, arg2: u64, arg3: u128) {
        let v0 = arg0.last_window_twap;
        let v1 = arg0.window_size_ms;
        let (v2, v3) = if (arg1 > v0) {
            (arg1 - v0, true)
        } else {
            (v0 - arg1, false)
        };
        let v4 = (arg3 as u256) * (arg2 as u256);
        let v5 = if (v4 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v4 as u128)
        };
        let v6 = 0x1::u128::min(v5, v2);
        let v7 = if (v3) {
            v0 + v6
        } else {
            v0 - v6
        };
        if (v6 > 0 && arg2 > 0) {
            let v8 = (v6 as u256) / (arg3 as u256);
            let v9 = if (v8 >= ((arg2 - 1) as u256)) {
                arg2 - 1
            } else {
                (v8 as u64)
            };
            let v10 = if (arg2 > v9 + 1) {
                (v6 as u256) * ((arg2 - 1 - v9) as u256)
            } else {
                0
            };
            let v11 = (v1 as u256) * ((arg3 as u256) * (v9 as u256) * ((v9 + 1) as u256) / 2 + v10);
            if (v3) {
                arg0.cumulative_total = arg0.cumulative_total + v11;
            } else if (arg0.cumulative_total >= v11) {
                arg0.cumulative_total = arg0.cumulative_total - v11;
            } else {
                arg0.cumulative_total = 0;
            };
        };
        let v12 = arg0.window_start + arg2 * v1;
        let v13 = WindowFinalized{
            timestamp   : v12,
            raw_twap    : arg1,
            capped_twap : v7,
            num_windows : arg2,
        };
        0x2::event::emit<WindowFinalized>(v13);
        arg0.last_window_twap = v7;
        arg0.window_start = v12;
    }

    fun apply_signed_correction(arg0: u256, arg1: u256, arg2: bool) : u256 {
        if (arg1 == 0) {
            arg0
        } else if (arg2) {
            arg0 + arg1
        } else if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    fun catch_up_to(arg0: &mut SimpleTWAP, arg1: u64) {
        if (arg1 <= arg0.last_update) {
            return
        };
        let v0 = arg0.last_price;
        advance(arg0, arg1, v0);
    }

    public fun checkpoint_at_or_before(arg0: &SimpleTWAP, arg1: u64) : 0x1::option::Option<Checkpoint> {
        let v0 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        if (v0 == 0) {
            return 0x1::option::none<Checkpoint>()
        };
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            let v2 = 0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v1);
            if (v2.timestamp <= arg1) {
                return 0x1::option::some<Checkpoint>(*v2)
            };
        };
        0x1::option::none<Checkpoint>()
    }

    fun compute_delta_m(arg0: u128, arg1: u64) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ppm_denominator() as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        0x1::u128::max(1, (v0 as u128))
    }

    public fun cumulative_at(arg0: &SimpleTWAP, arg1: u64) : u256 {
        assert!(arg1 >= arg0.last_update, 4);
        let v0 = arg1 - arg0.last_update;
        if (v0 == 0) {
            return arg0.cumulative_total
        };
        let v1 = arg0.window_size_ms;
        let v2 = arg0.last_update - arg0.window_start;
        let v3 = arg0.last_price;
        if (v2 + v0 < v1) {
            return arg0.cumulative_total + (arg0.last_window_twap as u256) * (v0 as u256)
        };
        let v4 = arg0.last_window_twap;
        let v5 = compute_delta_m(v4, arg0.max_movement_ppm);
        let v6 = v1 - v2;
        let v7 = (arg0.cumulative_price + (v3 as u256) * (v6 as u256)) / (v1 as u256);
        let v8 = if (v7 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v7 as u128)
        };
        let (v9, v10, v11) = simulate_pcw_cap(v4, v8, 1, v5, v1);
        let v12 = apply_signed_correction(arg0.cumulative_total + (v4 as u256) * (v6 as u256), v10, v11);
        let v13 = v12;
        let v14 = v9;
        let v15 = v0 - v6;
        let v16 = v15 / v1;
        if (v16 > 0) {
            let (v17, v18, v19) = simulate_pcw_cap(v9, v3, v16, v5, v1);
            v13 = apply_signed_correction(v12 + (v9 as u256) * (v16 as u256) * (v1 as u256), v18, v19);
            v14 = v17;
        };
        let v20 = v15 - v16 * v1;
        if (v20 > 0) {
            v13 = v13 + (v14 as u256) * (v20 as u256);
        };
        v13
    }

    public fun cumulative_total(arg0: &SimpleTWAP) : u256 {
        arg0.cumulative_total
    }

    public fun get_ninety_day_twap(arg0: &SimpleTWAP, arg1: &0x2::clock::Clock) : 0x1::option::Option<u128> {
        get_window_twap(arg0, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ninety_days_ms(), arg1)
    }

    public fun get_twap(arg0: &SimpleTWAP) : u128 {
        assert!(arg0.initialized, 3);
        arg0.last_window_twap
    }

    public fun get_window_twap(arg0: &SimpleTWAP, arg1: u64, arg2: &0x2::clock::Clock) : 0x1::option::Option<u128> {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 <= arg1) {
            return 0x1::option::none<u128>()
        };
        let v1 = v0 - arg1;
        let v2 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        if (v2 == 0) {
            return 0x1::option::none<u128>()
        };
        let v3 = 0x1::option::none<u64>();
        let v4 = v2;
        while (v4 > 0) {
            v4 = v4 - 1;
            if (0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v4).timestamp <= v1) {
                v3 = 0x1::option::some<u64>(v4);
                break
            };
        };
        if (0x1::option::is_none<u64>(&v3)) {
            return 0x1::option::none<u128>()
        };
        let v5 = 0x1::option::destroy_some<u64>(v3);
        let v6 = 0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v5);
        let v7 = if (v6.timestamp == v1) {
            v6.cumulative
        } else {
            let (v8, v9) = if (v5 + 1 < v2) {
                let v10 = 0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v5 + 1);
                (v10.timestamp, v10.cumulative)
            } else {
                (v0, cumulative_at(arg0, v0))
            };
            v6.cumulative + (v9 - v6.cumulative) * ((v1 - v6.timestamp) as u256) / ((v8 - v6.timestamp) as u256)
        };
        if (arg1 == 0) {
            return 0x1::option::none<u128>()
        };
        let v11 = cumulative_at(arg0, v0);
        if (v11 < v7) {
            return 0x1::option::none<u128>()
        };
        let v12 = (v11 - v7) / (arg1 as u256);
        assert!(v12 <= 340282366920938463463374607431768211455, 0);
        0x1::option::some<u128>((v12 as u128))
    }

    public fun initialized_at(arg0: &SimpleTWAP) : u64 {
        arg0.initialized_at
    }

    public fun is_ready(arg0: &SimpleTWAP, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.initialized) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.initialized_at) {
            return false
        };
        v0 - arg0.initialized_at >= arg0.window_size_ms
    }

    public fun last_price(arg0: &SimpleTWAP) : u128 {
        arg0.last_price
    }

    public fun last_update(arg0: &SimpleTWAP) : u64 {
        arg0.last_update
    }

    public fun max_movement_ppm(arg0: &SimpleTWAP) : u64 {
        arg0.max_movement_ppm
    }

    fun maybe_commit_checkpoint(arg0: &mut SimpleTWAP, arg1: u64) {
        if (arg1 >= arg0.last_checkpoint_at + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::one_week_ms()) {
            record_checkpoint(arg0, arg1);
        };
    }

    public fun new(arg0: u128, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : SimpleTWAP {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 1);
        assert!(arg2 > 0 && arg2 < 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::ppm_denominator(), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = SimpleTWAP{
            last_window_twap   : arg0,
            cumulative_price   : 0,
            window_start       : v0,
            last_update        : v0,
            window_size_ms     : arg1,
            max_movement_ppm   : arg2,
            initialized        : true,
            cumulative_total   : 0,
            last_price         : arg0,
            initialized_at     : v0,
            checkpoints        : 0x1::vector::empty<Checkpoint>(),
            last_checkpoint_at : v0,
        };
        let v2 = &mut v1;
        record_checkpoint(v2, v0);
        v1
    }

    public fun new_default(arg0: u128, arg1: &0x2::clock::Clock) : SimpleTWAP {
        new(arg0, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::twap_price_cap_window(), 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::default_twap_max_movement_ppm(), arg1)
    }

    fun record_checkpoint(arg0: &mut SimpleTWAP, arg1: u64) {
        let v0 = if (arg1 >= arg0.last_update) {
            arg0.cumulative_total + (arg0.last_window_twap as u256) * ((arg1 - arg0.last_update) as u256)
        } else {
            arg0.cumulative_total
        };
        let v1 = Checkpoint{
            timestamp  : arg1,
            cumulative : v0,
        };
        if (0x1::vector::length<Checkpoint>(&arg0.checkpoints) >= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::max_twap_checkpoints()) {
            0x1::vector::remove<Checkpoint>(&mut arg0.checkpoints, 0);
        };
        0x1::vector::push_back<Checkpoint>(&mut arg0.checkpoints, v1);
        arg0.last_checkpoint_at = arg1;
    }

    fun simulate_pcw_cap(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u64) : (u128, u256, bool) {
        let (v0, v1) = if (arg1 > arg0) {
            (arg1 - arg0, true)
        } else {
            (arg0 - arg1, false)
        };
        let v2 = (arg3 as u256) * (arg2 as u256);
        let v3 = if (v2 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v2 as u128)
        };
        let v4 = 0x1::u128::min(v3, v0);
        let v5 = if (v1) {
            arg0 + v4
        } else {
            arg0 - v4
        };
        let v6 = if (v4 > 0 && arg2 > 0) {
            let v7 = (v4 as u256) / (arg3 as u256);
            let v8 = if (v7 >= ((arg2 - 1) as u256)) {
                arg2 - 1
            } else {
                (v7 as u64)
            };
            let v9 = if (arg2 > v8 + 1) {
                (v4 as u256) * ((arg2 - 1 - v8) as u256)
            } else {
                0
            };
            (arg4 as u256) * ((arg3 as u256) * (v8 as u256) * ((v8 + 1) as u256) / 2 + v9)
        } else {
            0
        };
        (v5, v6, v1)
    }

    public fun try_commit_checkpoint(arg0: &mut SimpleTWAP, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.last_checkpoint_at + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::one_week_ms()) {
            catch_up_to(arg0, v0);
            record_checkpoint(arg0, v0);
            true
        } else {
            false
        }
    }

    public fun update(arg0: &mut SimpleTWAP, arg1: u128, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_update, 2);
        if (v0 == arg0.last_update) {
            arg0.last_price = arg1;
            return
        };
        let v1 = arg0.last_price;
        advance(arg0, v0, v1);
        arg0.last_price = arg1;
        maybe_commit_checkpoint(arg0, v0);
    }

    public fun window_size_ms(arg0: &SimpleTWAP) : u64 {
        arg0.window_size_ms
    }

    // decompiled from Move bytecode v6
}

