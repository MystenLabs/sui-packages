module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard {
    struct Slot has copy, drop, store {
        ms: u64,
        lo: u64,
        hi: u64,
        dlo: u64,
        dhi: u64,
        tx: vector<u8>,
        last_seen_ms: u64,
        contested: u64,
        hour_contested: u64,
        contested_hours: u64,
        xlo: u64,
        xhi: u64,
        pc: bool,
        vol: u64,
        last_d: u64,
        last_m: u64,
        ilo: u64,
    }

    struct Pending has copy, drop, store {
        micro: u64,
        depth: u64,
        tx: vector<u8>,
        ms: u64,
    }

    struct Guard has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        depth_usdc: u64,
        avg7d_usdc: u64,
        depth_ms: u64,
        day_min_depth: u64,
        daily_depth: vector<u64>,
        hourly: vector<u64>,
        last_obs_ms: u64,
        last_check_ms: u64,
        out_streak: u64,
        hour_checks: vector<u64>,
        hours_in_day: u64,
        day_acc: u128,
        daily: vector<u64>,
        spot_micro: u64,
        twap24_micro: u64,
        twap7d_micro: u64,
        ref_micro: u64,
        bad_streak: u64,
        slot: Slot,
        day: u64,
        sold_today_usdc: u64,
        live: bool,
        paused: bool,
        clear_since_ms: u64,
    }

    struct Observed has copy, drop {
        spot_micro: u64,
        twap24_micro: u64,
        twap7d_micro: u64,
        depth_usdc: u64,
        paused: bool,
    }

    struct ManualResume has copy, drop {
        at_ms: u64,
        out_streak_before: u64,
        contested_hours_before: u64,
        halted_before: bool,
    }

    struct Contested has copy, drop {
        lo: u64,
        hi: u64,
        at_ms: u64,
    }

    struct ContestedHour has copy, drop {
        at_ms: u64,
        contested_slots: u64,
        contested_hours: u64,
        out_streak: u64,
        paused: bool,
    }

    public fun new<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Guard {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == @0xb0d1e939850258406a95c1d8946bbbd5e21b89aa858cc269ff2a600893eaaa46, 107);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v1)) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 107);
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(*0x1::ascii::as_bytes(0x1::type_name::as_string(&v2)) == b"46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE", 107);
        assert!(within((micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1)) as u128), (1000 as u128), 200), 108);
        new_inner<T0, T1>(arg1, arg2, arg3)
    }

    public fun admin_halted(arg0: &Guard) : bool {
        arg0.paused
    }

    fun anchor(arg0: &Guard) : u64 {
        if (0x1::vector::is_empty<u64>(&arg0.daily)) {
            arg0.ref_micro
        } else {
            *0x1::vector::borrow<u64>(&arg0.daily, 0)
        }
    }

    public fun assert_ipo_band<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool, 102);
        assert!(ipo_band_ok<T0, T1>(arg0, arg1), 109);
    }

    public fun assert_open(arg0: &Guard, arg1: &0x2::clock::Clock) {
        let v0 = if (arg0.live) {
            if (!arg0.paused) {
                trading_ok(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 100);
        fresh(arg0, arg1);
        assert!(!unhealthy(arg0.depth_usdc, arg0.avg7d_usdc), 111);
    }

    public fun assert_priced(arg0: &Guard, arg1: &0x2::clock::Clock) {
        assert!(arg0.live, 100);
        fresh(arg0, arg1);
    }

    public fun assert_sale_sane<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool, 102);
        assert!(!unhealthy(usdc_depth<T0, T1>(arg1), arg0.avg7d_usdc), 111);
        assert!(arg0.twap24_micro == 0 || within((micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1)) as u128), (arg0.twap24_micro as u128), 1000), 110);
        assert!(arg0.twap7d_micro == 0 || within((arg0.twap24_micro as u128), (arg0.twap7d_micro as u128), 1000), 110);
        assert!(arg0.twap24_micro == 0 || within((arg0.twap24_micro as u128), (anchor(arg0) as u128), 500), 110);
    }

    public fun attest<T0, T1>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut Guard, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        sample<T0, T1>(arg1, arg2, arg3, arg4);
    }

    fun avg(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + (*0x1::vector::borrow<u64>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 / (0x1::vector::length<u64>(arg0) as u128)) as u64)
    }

    public fun bad_streak(arg0: &Guard) : u64 {
        arg0.bad_streak
    }

    fun band(arg0: &Guard) : u128 {
        if (arg0.out_streak >= 6) {
            1500 + 25
        } else {
            1500
        }
    }

    public fun cap_depth(arg0: &Guard) : u64 {
        let v0 = arg0.depth_usdc;
        let v1 = v0;
        if (arg0.day_min_depth < v0) {
            v1 = arg0.day_min_depth;
        };
        if (!0x1::vector::is_empty<u64>(&arg0.daily_depth)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.daily_depth, 0x1::vector::length<u64>(&arg0.daily_depth) - 1);
            if (v2 < v1) {
                v1 = v2;
            };
        };
        v1
    }

    fun check(arg0: &mut Guard, arg1: Pending, arg2: u64) {
        arg0.last_check_ms = arg2;
        arg0.spot_micro = arg1.micro;
        if (arg1.ms >= arg0.last_obs_ms + 3600000) {
            commit(arg0, 0x1::option::some<u64>(arg1.micro), arg1.depth, arg1.ms);
        };
        0x1::vector::push_back<u64>(&mut arg0.hour_checks, arg1.micro);
        let v0 = arg1.micro;
        let v1 = false;
        if (arg0.twap24_micro > 0 && !within((v0 as u128), (arg0.twap24_micro as u128), 1000)) {
            v1 = true;
        };
        if (arg0.twap7d_micro > 0 && !within((arg0.twap24_micro as u128), (arg0.twap7d_micro as u128), 1000)) {
            v1 = true;
        };
        if (arg0.twap24_micro > 0 && !within((arg0.twap24_micro as u128), (anchor(arg0) as u128), 500)) {
            v1 = true;
        };
        if (unhealthy(arg0.depth_usdc, arg0.avg7d_usdc)) {
            v1 = true;
        };
        if (v1) {
            arg0.bad_streak = arg0.bad_streak + 1;
        } else {
            arg0.bad_streak = 0;
        };
        settle(arg0, false, v1, arg2);
        let v2 = Observed{
            spot_micro   : v0,
            twap24_micro : arg0.twap24_micro,
            twap7d_micro : arg0.twap7d_micro,
            depth_usdc   : arg0.depth_usdc,
            paused       : arg0.paused,
        };
        0x2::event::emit<Observed>(v2);
    }

    fun clamp(arg0: u64, arg1: u64) : u64 {
        clamp_bps(arg0, arg1, 200)
    }

    fun clamp_bps(arg0: u64, arg1: u64, arg2: u128) : u64 {
        let v0 = (((arg1 as u128) * (10000 - arg2) / 10000) as u64);
        let v1 = (((arg1 as u128) * (10000 + arg2) / 10000) as u64);
        if (arg0 < v0) {
            v0
        } else if (arg0 > v1) {
            v1
        } else {
            arg0
        }
    }

    fun close_slot(arg0: &mut Guard, arg1: u64) {
        arg0.slot.last_seen_ms = arg1;
        arg0.depth_usdc = arg0.slot.dhi;
        arg0.depth_ms = arg1;
        if (arg0.slot.dlo < arg0.day_min_depth) {
            arg0.day_min_depth = arg0.slot.dlo;
        };
        let v0 = arg0.slot.lo;
        let v1 = arg0.slot.hi;
        let v2 = arg0.ref_micro;
        let v3 = if (arg0.twap24_micro > 0) {
            arg0.twap24_micro
        } else {
            v2
        };
        let v4 = band(arg0);
        let v5 = if (inbw(v0, v2, v4) && inbw(v1, v2, v4)) {
            0x1::option::some<u64>(nearer(v0, v1, v3))
        } else {
            let v6 = if (!inbw(v0, v2, v4)) {
                if (!inbw(v1, v2, v4)) {
                    v0 > v2 == v1 > v2
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                0x1::option::some<u64>(nearer(v0, v1, v2))
            } else {
                0x1::option::none<u64>()
            }
        };
        let v7 = v5;
        let v8 = arg0.slot.ilo / 10000 * 100;
        let v9 = if (v8 > 10000000) {
            v8
        } else {
            10000000
        };
        if (0x1::option::is_none<u64>(&v7) && arg0.slot.vol < v9) {
            let v10 = arg0.slot.dlo;
            if (arg1 >= arg0.last_obs_ms + 3600000) {
                commit(arg0, 0x1::option::none<u64>(), v10, arg1);
            };
            arg0.slot.hour_contested = arg0.slot.hour_contested + 1;
            arg0.slot.pc = false;
            return
        };
        if (0x1::option::is_some<u64>(&v7)) {
            arg0.slot.pc = false;
            let v11 = Pending{
                micro : 0x1::option::destroy_some<u64>(v7),
                depth : arg0.slot.dlo,
                tx    : arg0.slot.tx,
                ms    : arg1,
            };
            check(arg0, v11, arg1);
        } else {
            let v12 = arg0.slot.dlo;
            if (arg1 >= arg0.last_obs_ms + 3600000) {
                commit(arg0, 0x1::option::none<u64>(), v12, arg1);
            };
            arg0.slot.contested = arg0.slot.contested + 1;
            let v13 = if (arg0.slot.pc) {
                if (inbw(arg0.slot.xlo, v2, v4)) {
                    inbw(arg0.slot.xhi, v2, v4)
                } else {
                    false
                }
            } else {
                false
            };
            if (!v13) {
                arg0.slot.hour_contested = arg0.slot.hour_contested + 1;
            };
            arg0.slot.pc = !v13;
            let v14 = Contested{
                lo    : v0,
                hi    : v1,
                at_ms : arg1,
            };
            0x2::event::emit<Contested>(v14);
        };
    }

    fun commit(arg0: &mut Guard, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::length<u64>(&arg0.hour_checks);
        let v1 = arg0.slot.hour_contested;
        let v2 = if (v0 > 0) {
            median(&arg0.hour_checks)
        } else {
            0
        };
        let v3 = v0 > 0 && within((v2 as u128), (arg0.ref_micro as u128), band(arg0));
        let v4 = if (v3) {
            if (v0 >= 6) {
                v1 <= 1
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            arg0.slot.contested_hours = 0;
            arg0.out_streak = 0;
        } else if (v0 >= 6 && !v3) {
            arg0.slot.contested_hours = 0;
            arg0.out_streak = arg0.out_streak + 1;
        } else if (v0 >= 6 || v1 <= 1) {
            arg0.slot.contested_hours = 0;
        } else {
            arg0.slot.contested_hours = arg0.slot.contested_hours + 1;
            arg0.out_streak = arg0.out_streak + 1;
            let v5 = ContestedHour{
                at_ms           : arg3,
                contested_slots : v1,
                contested_hours : arg0.slot.contested_hours,
                out_streak      : arg0.out_streak,
                paused          : arg0.out_streak >= 6,
            };
            0x2::event::emit<ContestedHour>(v5);
        };
        arg0.hour_checks = vector[];
        arg0.slot.hour_contested = 0;
        let v6 = if (v0 > 0) {
            0x1::option::some<u64>(v2)
        } else {
            arg1
        };
        let v7 = v6;
        if (0x1::option::is_none<u64>(&v7)) {
            arg0.last_obs_ms = arg3;
            return
        };
        let v8 = if (arg0.twap24_micro > 0) {
            arg0.twap24_micro
        } else {
            arg0.ref_micro
        };
        let v9 = clamp(0x1::option::destroy_some<u64>(v7), v8);
        0x1::vector::push_back<u64>(&mut arg0.hourly, v9);
        if (0x1::vector::length<u64>(&arg0.hourly) > 24) {
            0x1::vector::remove<u64>(&mut arg0.hourly, 0);
        };
        arg0.last_obs_ms = arg3;
        arg0.hours_in_day = arg0.hours_in_day + 1;
        arg0.day_acc = arg0.day_acc + (v9 as u128);
        if (arg0.hours_in_day >= 24) {
            0x1::vector::push_back<u64>(&mut arg0.daily, ((arg0.day_acc / (arg0.hours_in_day as u128)) as u64));
            if (0x1::vector::length<u64>(&arg0.daily) > 7) {
                0x1::vector::remove<u64>(&mut arg0.daily, 0);
            };
            0x1::vector::push_back<u64>(&mut arg0.daily_depth, arg0.day_min_depth);
            if (0x1::vector::length<u64>(&arg0.daily_depth) > 7) {
                0x1::vector::remove<u64>(&mut arg0.daily_depth, 0);
            };
            arg0.avg7d_usdc = avg(&arg0.daily_depth);
            arg0.hours_in_day = 0;
            arg0.day_acc = 0;
            arg0.day_min_depth = arg2;
        };
        if (0x1::vector::length<u64>(&arg0.hourly) == 24) {
            arg0.twap24_micro = avg(&arg0.hourly);
        };
        if (0x1::vector::length<u64>(&arg0.daily) == 7) {
            arg0.twap7d_micro = avg(&arg0.daily);
        };
    }

    public fun contested(arg0: &Guard) : u64 {
        arg0.slot.contested
    }

    public fun contested_hours(arg0: &Guard) : u64 {
        arg0.slot.contested_hours
    }

    public fun depth(arg0: &Guard) : u64 {
        arg0.depth_usdc
    }

    public fun depth_held_7d(arg0: &Guard, arg1: u64) : bool {
        if (0x1::vector::length<u64>(&arg0.daily_depth) == 7) {
            let v1 = true;
            let v2 = &arg0.daily_depth;
            let v3 = 0;
            while (v3 < 0x1::vector::length<u64>(v2)) {
                if (*0x1::vector::borrow<u64>(v2, v3) < arg1) {
                    v1 = false;
                };
                v3 = v3 + 1;
            };
            v1
        } else {
            false
        }
    }

    public fun depth_in_soos(arg0: &Guard) : u64 {
        if (arg0.twap24_micro == 0) {
            0
        } else {
            soos_for(arg0, cap_depth(arg0))
        }
    }

    fun fresh(arg0: &Guard, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.slot.last_seen_ms + 14400000, 104);
    }

    public(friend) fun go_live(arg0: &mut Guard, arg1: &0x2::clock::Clock) {
        assert!(arg0.twap24_micro > 0, 105);
        fresh(arg0, arg1);
        assert!(!unhealthy(arg0.depth_usdc, arg0.avg7d_usdc), 100);
        arg0.live = true;
        arg0.paused = false;
        arg0.clear_since_ms = 0;
    }

    public fun halt(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut Guard) {
        arg1.paused = true;
        arg1.clear_since_ms = 0;
    }

    public fun has_pending(arg0: &Guard) : bool {
        arg0.slot.ms > 0
    }

    public fun hourly_len(arg0: &Guard) : u64 {
        0x1::vector::length<u64>(&arg0.hourly)
    }

    fun in_range_usdc<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = 583337266871351588485 * 10102 / 10000;
        if (v0 >= v1 || v0 < 583337266871351588485 * 9901 / 10000) {
            return 0
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), false)
    }

    fun inb(arg0: u64, arg1: u64) : bool {
        within((arg0 as u128), (arg1 as u128), 1500)
    }

    fun inbw(arg0: u64, arg1: u64, arg2: u128) : bool {
        within((arg0 as u128), (arg1 as u128), arg2)
    }

    public fun ipo_band_ok<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : bool {
        trading_ok(arg0)
    }

    public fun last_check(arg0: &Guard) : u64 {
        arg0.last_check_ms
    }

    public fun last_obs(arg0: &Guard) : u64 {
        arg0.last_obs_ms
    }

    public fun live(arg0: &Guard) : bool {
        arg0.live
    }

    public fun manual_resume(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut Guard, arg2: &0x2::clock::Clock) {
        assert!(arg1.live, 100);
        let v0 = ManualResume{
            at_ms                  : 0x2::clock::timestamp_ms(arg2),
            out_streak_before      : arg1.out_streak,
            contested_hours_before : arg1.slot.contested_hours,
            halted_before          : arg1.paused,
        };
        arg1.out_streak = 0;
        arg1.slot.contested_hours = 0;
        arg1.paused = false;
        arg1.clear_since_ms = 0;
        0x2::event::emit<ManualResume>(v0);
    }

    fun median(arg0: &vector<u64>) : u64 {
        let v0 = *arg0;
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = 1;
        while (v2 < v1) {
            while (v2 > 0 && *0x1::vector::borrow<u64>(&v0, v2 - 1) > *0x1::vector::borrow<u64>(&v0, v2)) {
                0x1::vector::swap<u64>(&mut v0, v2 - 1, v2);
                v2 = v2 - 1;
            };
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<u64>(&v0, (v1 - 1) / 2)
    }

    public fun micro_from_sqrt(arg0: u128) : u64 {
        let v0 = arg0 >> 32;
        ((18446744073709551616000000 / v0 * v0) as u64)
    }

    fun nearer(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        if (v0 <= v1) {
            arg0
        } else {
            arg1
        }
    }

    fun new_inner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Guard {
        let v0 = micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0));
        let v1 = usdc_depth<T0, T1>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, clamp(v0, 1000));
        let v4 = Slot{
            ms              : v2,
            lo              : v0,
            hi              : v0,
            dlo             : v1,
            dhi             : v1,
            tx              : *0x2::tx_context::digest(arg2),
            last_seen_ms    : v2,
            contested       : 0,
            hour_contested  : 0,
            contested_hours : 0,
            xlo             : 18446744073709551615,
            xhi             : 0,
            pc              : false,
            vol             : 0,
            last_d          : v1,
            last_m          : v0,
            ilo             : in_range_usdc<T0, T1>(arg0),
        };
        Guard{
            id              : 0x2::object::new(arg2),
            pool            : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            depth_usdc      : v1,
            avg7d_usdc      : v1,
            depth_ms        : v2,
            day_min_depth   : v1,
            daily_depth     : vector[],
            hourly          : v3,
            last_obs_ms     : v2,
            last_check_ms   : v2,
            out_streak      : 0,
            hour_checks     : vector[],
            hours_in_day    : 1,
            day_acc         : (clamp(v0, 1000) as u128),
            daily           : vector[],
            spot_micro      : v0,
            twap24_micro    : 0,
            twap7d_micro    : 0,
            ref_micro       : 1000,
            bad_streak      : 0,
            slot            : v4,
            day             : 0,
            sold_today_usdc : 0,
            live            : false,
            paused          : true,
            clear_since_ms  : 0,
        }
    }

    public fun observe<T0, T1>(arg0: &mut Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        sample<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun out_streak(arg0: &Guard) : u64 {
        arg0.out_streak
    }

    public fun paused(arg0: &Guard) : bool {
        arg0.paused || !trading_ok(arg0)
    }

    public fun pinned_pool() : address {
        @0xb0d1e939850258406a95c1d8946bbbd5e21b89aa858cc269ff2a600893eaaa46
    }

    public fun pool_id(arg0: &Guard) : 0x2::object::ID {
        arg0.pool
    }

    public fun price_hi<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        let v0 = micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        let v1 = price_micro(arg0);
        if (v0 > v1) {
            v0
        } else {
            v1
        }
    }

    public fun price_lo<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        let v0 = micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        let v1 = price_micro(arg0);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    public fun price_micro(arg0: &Guard) : u64 {
        assert!(arg0.twap24_micro > 0, 105);
        arg0.twap24_micro
    }

    public(friend) fun record_sale(arg0: &mut Guard, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_priced(arg0, arg2);
        let v0 = sales_room(arg0, arg2);
        assert!(arg1 <= v0, 101);
        arg0.sold_today_usdc = arg0.sold_today_usdc + arg1;
    }

    public fun reference(arg0: &Guard) : u64 {
        arg0.ref_micro
    }

    public fun sale_sane<T0, T1>(arg0: &Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : bool {
        if (!unhealthy(usdc_depth<T0, T1>(arg1), arg0.avg7d_usdc)) {
            if (arg0.twap24_micro == 0 || within((micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1)) as u128), (arg0.twap24_micro as u128), 1000)) {
                if (arg0.twap7d_micro == 0 || within((arg0.twap24_micro as u128), (arg0.twap7d_micro as u128), 1000)) {
                    arg0.twap24_micro == 0 || within((arg0.twap24_micro as u128), (anchor(arg0) as u128), 500)
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

    public(friend) fun sales_room(arg0: &mut Guard, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.sold_today_usdc = 0;
        };
        let v1 = (((cap_depth(arg0) as u128) * (200 as u128) / 10000) as u64);
        if (arg0.sold_today_usdc >= v1) {
            0
        } else {
            v1 - arg0.sold_today_usdc
        }
    }

    public(friend) fun sample<T0, T1>(arg0: &mut Guard, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool, 102);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = micro_from_sqrt(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
        let v2 = usdc_depth<T0, T1>(arg1);
        let v3 = in_range_usdc<T0, T1>(arg1);
        let v4 = *0x2::tx_context::digest(arg3);
        if (v4 == arg0.slot.tx) {
            return
        };
        arg0.slot.tx = v4;
        let v5 = if (v2 > arg0.slot.last_d) {
            v2 - arg0.slot.last_d
        } else {
            arg0.slot.last_d - v2
        };
        arg0.slot.vol = arg0.slot.vol + v5;
        arg0.slot.last_d = v2;
        arg0.slot.last_m = v1;
        if (v3 < arg0.slot.ilo) {
            arg0.slot.ilo = v3;
        };
        if (v0 < arg0.slot.ms + 300000) {
            widen(arg0, v1, v2);
            return
        };
        widen(arg0, v1, v2);
        close_slot(arg0, v0);
        arg0.slot.ms = v0;
        arg0.slot.lo = v1;
        arg0.slot.hi = v1;
        arg0.slot.dlo = v2;
        arg0.slot.dhi = v2;
        arg0.slot.xlo = 18446744073709551615;
        arg0.slot.xhi = 0;
        arg0.slot.ilo = v3;
        arg0.slot.vol = 0;
    }

    fun settle(arg0: &mut Guard, arg1: bool, arg2: bool, arg3: u64) {
        if (!arg0.live) {
            return
        };
        if (arg1) {
            arg0.paused = true;
            arg0.clear_since_ms = 0;
        } else if (arg2) {
            if (arg0.paused) {
                arg0.clear_since_ms = 0;
            };
        } else if (arg0.paused) {
            if (arg0.clear_since_ms == 0) {
                arg0.clear_since_ms = arg3;
            } else if (arg3 >= arg0.clear_since_ms + 86400000) {
                arg0.paused = false;
            };
        };
    }

    public fun share(arg0: Guard) {
        0x2::transfer::share_object<Guard>(arg0);
    }

    public fun slot_range(arg0: &Guard) : (u64, u64) {
        (arg0.slot.lo, arg0.slot.hi)
    }

    public fun sold_today(arg0: &Guard) : u64 {
        arg0.sold_today_usdc
    }

    public fun soos_for(arg0: &Guard, arg1: u64) : u64 {
        (((arg1 as u128) * 1000000 / (price_micro(arg0) as u128)) as u64)
    }

    public fun spot(arg0: &Guard) : u64 {
        arg0.spot_micro
    }

    public fun trading_ok(arg0: &Guard) : bool {
        arg0.out_streak < 6
    }

    public fun twap24(arg0: &Guard) : u64 {
        arg0.twap24_micro
    }

    public fun twap7d(arg0: &Guard) : u64 {
        arg0.twap7d_micro
    }

    fun unhealthy(arg0: u64, arg1: u64) : bool {
        arg0 < 25000000 || (arg0 as u128) * 2 < (arg1 as u128)
    }

    fun usdc_depth<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u64 {
        let (v0, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg0);
        0x2::balance::value<T0>(v0)
    }

    public fun usdc_value(arg0: &Guard, arg1: u64) : u64 {
        (((arg1 as u128) * (price_micro(arg0) as u128) / 1000000) as u64)
    }

    fun widen(arg0: &mut Guard, arg1: u64, arg2: u64) {
        if (arg1 < arg0.slot.lo) {
            arg0.slot.lo = arg1;
        };
        if (arg1 > arg0.slot.hi) {
            arg0.slot.hi = arg1;
        };
        if (arg2 < arg0.slot.dlo) {
            arg0.slot.dlo = arg2;
        };
        if (arg2 > arg0.slot.dhi) {
            arg0.slot.dhi = arg2;
        };
        if (arg1 < arg0.slot.xlo) {
            arg0.slot.xlo = arg1;
        };
        if (arg1 > arg0.slot.xhi) {
            arg0.slot.xhi = arg1;
        };
    }

    fun within(arg0: u128, arg1: u128, arg2: u128) : bool {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        v0 * 10000 <= arg1 * arg2
    }

    // decompiled from Move bytecode v7
}

