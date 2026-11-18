module 0x17ce92c6e39ae328c65f1e315fde887b1203afec5f4165599608800a41d2a938::nya_quoter {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct QuoterCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PropPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        base_vault: 0x2::balance::Balance<T0>,
        quote_vault: 0x2::balance::Balance<T1>,
        paused: bool,
        quoter_epoch: u64,
        bid_e9: u64,
        ask_e9: u64,
        anchor_mid_e9: u64,
        last_anchor_ms: u64,
        valid_until_ms: u64,
        max_base_fill: u64,
        max_quote_fill: u64,
        max_step_bps: u64,
        step_window_ms: u64,
        normal_gas_price: u64,
        surcharge_bps_per_100_gp: u64,
        max_toxic_surcharge_bps: u64,
        auto_skew_bps: u64,
        window_ms: u64,
        max_window_base_delta: u64,
        window_start_ms: u64,
        window_signed_base: u64,
        window_sign_is_buy_base: bool,
    }

    struct RequoteEvent has copy, drop {
        pool_id: 0x2::object::ID,
        bid_e9: u64,
        ask_e9: u64,
        valid_until_ms: u64,
        timestamp_ms: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        effective_px_e9: u64,
        toxic_surcharge_bps: u64,
        gas_price: u64,
        timestamp_ms: u64,
    }

    public fun admin_reset_anchor<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        assert!(arg2 > 0 && arg3 >= arg2, 4);
        arg0.bid_e9 = arg2;
        arg0.ask_e9 = arg3;
        arg0.anchor_mid_e9 = ((((arg2 as u128) + (arg3 as u128)) / 2) as u64);
        arg0.last_anchor_ms = 0;
        arg0.paused = arg4;
    }

    public fun admin_set_risk_params<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        arg0.max_step_bps = arg2;
        arg0.step_window_ms = arg3;
        arg0.normal_gas_price = arg4;
        arg0.surcharge_bps_per_100_gp = arg5;
        arg0.max_toxic_surcharge_bps = arg6;
        arg0.auto_skew_bps = arg7;
        arg0.window_ms = arg8;
        arg0.max_window_base_delta = arg9;
    }

    fun apply_auto_skew<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: u64, arg2: bool) {
        if (arg0.auto_skew_bps == 0 || arg0.max_base_fill == 0) {
            return
        };
        let v0 = (arg1 as u128) * (arg0.auto_skew_bps as u128) / (arg0.max_base_fill as u128);
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        if (arg2) {
            arg0.bid_e9 = (((arg0.bid_e9 as u128) * (10000 + v1) / 10000) as u64);
            arg0.ask_e9 = (((arg0.ask_e9 as u128) * (10000 + v1) / 10000) as u64);
        } else {
            arg0.bid_e9 = (((arg0.bid_e9 as u128) * (10000 - v1) / 10000) as u64);
            arg0.ask_e9 = (((arg0.ask_e9 as u128) * (10000 - v1) / 10000) as u64);
        };
    }

    public fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (PropPool<T0, T1>, AdminCap, QuoterCap) {
        assert!(arg0 > 0 && arg1 >= arg0, 4);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = PropPool<T0, T1>{
            id                       : v0,
            base_vault               : 0x2::balance::zero<T0>(),
            quote_vault              : 0x2::balance::zero<T1>(),
            paused                   : false,
            quoter_epoch             : 0,
            bid_e9                   : arg0,
            ask_e9                   : arg1,
            anchor_mid_e9            : ((((arg0 as u128) + (arg1 as u128)) / 2) as u64),
            last_anchor_ms           : 0,
            valid_until_ms           : 0,
            max_base_fill            : 0,
            max_quote_fill           : 0,
            max_step_bps             : arg2,
            step_window_ms           : 5000,
            normal_gas_price         : arg3,
            surcharge_bps_per_100_gp : arg4,
            max_toxic_surcharge_bps  : arg5,
            auto_skew_bps            : arg6,
            window_ms                : arg7,
            max_window_base_delta    : arg8,
            window_start_ms          : 0,
            window_signed_base       : 0,
            window_sign_is_buy_base  : false,
        };
        let v3 = AdminCap{
            id      : 0x2::object::new(arg9),
            pool_id : v1,
        };
        let v4 = QuoterCap{
            id      : 0x2::object::new(arg9),
            pool_id : v1,
        };
        (v2, v3, v4)
    }

    public fun deposit_base<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        0x2::balance::join<T0>(&mut arg0.base_vault, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_quote<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T1>) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        0x2::balance::join<T1>(&mut arg0.quote_vault, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun emergency_pause<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &QuoterCap) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        arg0.paused = true;
        arg0.valid_until_ms = 0;
    }

    public fun quote_a2b<T0, T1>(arg0: &PropPool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(!arg0.paused, 1);
        assert!(arg3 <= arg0.valid_until_ms, 2);
        assert!(arg1 > 0, 6);
        assert!(arg1 <= arg0.max_base_fill, 7);
        let v0 = toxic_surcharge_bps<T0, T1>(arg0, arg2);
        let v1 = (arg0.bid_e9 as u128) * (10000 - (v0 as u128)) / 10000;
        ((((arg1 as u128) * v1 / 1000000000) as u64), (v1 as u64), v0)
    }

    public fun quote_b2a<T0, T1>(arg0: &PropPool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(!arg0.paused, 1);
        assert!(arg3 <= arg0.valid_until_ms, 2);
        assert!(arg1 > 0, 6);
        assert!(arg1 <= arg0.max_quote_fill, 7);
        let v0 = toxic_surcharge_bps<T0, T1>(arg0, arg2);
        let v1 = (arg0.ask_e9 as u128) * (10000 + (v0 as u128)) / 10000;
        ((((arg1 as u128) * 1000000000 / v1) as u64), (v1 as u64), v0)
    }

    public fun quotes<T0, T1>(arg0: &PropPool<T0, T1>) : (u64, u64, u64, bool) {
        (arg0.bid_e9, arg0.ask_e9, arg0.valid_until_ms, arg0.paused)
    }

    fun record_window_delta<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) {
        if (arg0.window_ms == 0 || arg1 >= arg0.window_start_ms + arg0.window_ms) {
            arg0.window_start_ms = arg1;
            arg0.window_signed_base = 0;
            arg0.window_sign_is_buy_base = arg3;
        };
        if (arg0.window_signed_base == 0) {
            arg0.window_sign_is_buy_base = arg3;
            arg0.window_signed_base = arg2;
        } else if (arg0.window_sign_is_buy_base == arg3) {
            arg0.window_signed_base = arg0.window_signed_base + arg2;
        } else if (arg2 >= arg0.window_signed_base) {
            arg0.window_signed_base = arg2 - arg0.window_signed_base;
            arg0.window_sign_is_buy_base = arg3;
        } else {
            arg0.window_signed_base = arg0.window_signed_base - arg2;
        };
        assert!(arg0.window_signed_base <= arg0.max_window_base_delta, 8);
    }

    public fun requote<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &QuoterCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        assert!(arg2 > 0 && arg3 >= arg2, 4);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = ((arg2 as u128) + (arg3 as u128)) / 2;
        if (arg0.last_anchor_ms == 0 || v0 >= arg0.last_anchor_ms + arg0.step_window_ms) {
            let v2 = (arg0.anchor_mid_e9 as u128);
            let v3 = if (v1 >= v2) {
                v1 - v2
            } else {
                v2 - v1
            };
            assert!(v3 * 10000 <= v2 * (arg0.max_step_bps as u128), 5);
            arg0.anchor_mid_e9 = (v1 as u64);
            arg0.last_anchor_ms = v0;
        } else {
            let v4 = (arg0.anchor_mid_e9 as u128);
            let v5 = if (v1 >= v4) {
                v1 - v4
            } else {
                v4 - v1
            };
            assert!(v5 * 10000 <= v4 * (arg0.max_step_bps as u128), 5);
        };
        arg0.bid_e9 = arg2;
        arg0.ask_e9 = arg3;
        arg0.valid_until_ms = arg4;
        arg0.max_base_fill = arg5;
        arg0.max_quote_fill = arg6;
        arg0.paused = false;
        let v6 = RequoteEvent{
            pool_id        : 0x2::object::id<PropPool<T0, T1>>(arg0),
            bid_e9         : arg2,
            ask_e9         : arg3,
            valid_until_ms : arg4,
            timestamp_ms   : v0,
        };
        0x2::event::emit<RequoteEvent>(v6);
    }

    public fun reserves<T0, T1>(arg0: &PropPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.base_vault), 0x2::balance::value<T1>(&arg0.quote_vault))
    }

    public fun share_pool<T0, T1>(arg0: PropPool<T0, T1>) {
        0x2::transfer::share_object<PropPool<T0, T1>>(arg0);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::tx_context::gas_price(arg4);
        let (v3, v4, v5) = quote_a2b<T0, T1>(arg0, v0, v2, v1);
        assert!(v3 >= arg2, 10);
        assert!(0x2::balance::value<T1>(&arg0.quote_vault) >= v3, 9);
        record_window_delta<T0, T1>(arg0, v1, v0, false);
        apply_auto_skew<T0, T1>(arg0, v0, false);
        0x2::balance::join<T0>(&mut arg0.base_vault, 0x2::coin::into_balance<T0>(arg1));
        let v6 = SwapEvent{
            pool_id             : 0x2::object::id<PropPool<T0, T1>>(arg0),
            a2b                 : true,
            amount_in           : v0,
            amount_out          : v3,
            effective_px_e9     : v4,
            toxic_surcharge_bps : v5,
            gas_price           : v2,
            timestamp_ms        : v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        0x2::coin::take<T1>(&mut arg0.quote_vault, v3, arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::tx_context::gas_price(arg4);
        let (v3, v4, v5) = quote_b2a<T0, T1>(arg0, v0, v2, v1);
        assert!(v3 >= arg2, 10);
        assert!(0x2::balance::value<T0>(&arg0.base_vault) >= v3, 9);
        record_window_delta<T0, T1>(arg0, v1, v3, true);
        apply_auto_skew<T0, T1>(arg0, v3, true);
        0x2::balance::join<T1>(&mut arg0.quote_vault, 0x2::coin::into_balance<T1>(arg1));
        let v6 = SwapEvent{
            pool_id             : 0x2::object::id<PropPool<T0, T1>>(arg0),
            a2b                 : false,
            amount_in           : v0,
            amount_out          : v3,
            effective_px_e9     : v4,
            toxic_surcharge_bps : v5,
            gas_price           : v2,
            timestamp_ms        : v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        0x2::coin::take<T0>(&mut arg0.base_vault, v3, arg4)
    }

    public fun toxic_surcharge_bps<T0, T1>(arg0: &PropPool<T0, T1>, arg1: u64) : u64 {
        if (arg1 <= arg0.normal_gas_price || arg0.surcharge_bps_per_100_gp == 0) {
            return 0
        };
        let v0 = ((arg1 - arg0.normal_gas_price) as u128) * (arg0.surcharge_bps_per_100_gp as u128) / 100;
        let v1 = (arg0.max_toxic_surcharge_bps as u128);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        (v2 as u64)
    }

    public fun withdraw_base<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        0x2::coin::take<T0>(&mut arg0.base_vault, arg2, arg3)
    }

    public fun withdraw_quote<T0, T1>(arg0: &mut PropPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.pool_id == 0x2::object::id<PropPool<T0, T1>>(arg0), 3);
        0x2::coin::take<T1>(&mut arg0.quote_vault, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

