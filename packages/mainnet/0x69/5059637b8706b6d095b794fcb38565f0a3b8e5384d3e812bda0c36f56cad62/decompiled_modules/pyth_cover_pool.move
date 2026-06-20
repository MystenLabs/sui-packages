module 0x695059637b8706b6d095b794fcb38565f0a3b8e5384d3e812bda0c36f56cad62::pyth_cover_pool {
    struct DepegCoverPool<phantom T0> has key {
        id: 0x2::object::UID,
        feed_id: vector<u8>,
        expo_neg: bool,
        expo_mag: u64,
        threshold: u64,
        max_age_secs: u64,
        premium_bps: u64,
        surge_premium_bps: u64,
        max_conf_bps: u64,
        min_dwell_secs: u64,
        activation_delay_secs: u64,
        max_policy_duration_secs: u64,
        max_cover_per_policy: u64,
        max_total_cover: u64,
        treasury_fee_bps: u64,
        keeper_bounty: u64,
        paused: bool,
        direct_sales_enabled: bool,
        timelock_secs: u64,
        pending: 0x1::option::Option<PendingParamUpdate>,
        funds: 0x2::balance::Balance<T0>,
        treasury: 0x2::balance::Balance<T0>,
        total_shares: u64,
        total_cover: u64,
        epoch_id: u64,
        epoch_armed: bool,
        epoch_first_breach_ms: u64,
        epoch_breached: bool,
        epoch_confirmed_ms: u64,
        epoch_breach_price: u64,
        epochs: 0x2::table::Table<u64, EpochState>,
        policies: 0x2::table::Table<0x2::object::ID, PolicyState>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct BuyerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PendingParamUpdate has copy, drop, store {
        kind: u8,
        value: u64,
        eta_ms: u64,
    }

    struct EpochState has copy, drop, store {
        first_breach_ms: u64,
        confirmed_ms: u64,
        price: u64,
    }

    struct PolicyState has drop, store {
        cover: u64,
        expiry_ms: u64,
        activation_ms: u64,
        epoch_id: u64,
        breached: bool,
    }

    struct LpShare<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u64,
    }

    struct Policy<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        cover: u64,
        premium_paid: u64,
        expiry_ms: u64,
        activation_ms: u64,
        epoch_id: u64,
        armed: bool,
        first_breach_ms: u64,
        breached: bool,
        breach_price: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        feed_id: vector<u8>,
        threshold: u64,
        premium_bps: u64,
    }

    struct CoverBought has copy, drop {
        pool: 0x2::object::ID,
        cover: u64,
        premium: u64,
        expiry_ms: u64,
        duration_secs: u64,
    }

    struct PausedSet has copy, drop {
        pool: 0x2::object::ID,
        paused: bool,
    }

    struct DirectSalesSet has copy, drop {
        pool: 0x2::object::ID,
        enabled: bool,
    }

    struct ParamUpdateProposed has copy, drop {
        pool: 0x2::object::ID,
        kind: u8,
        value: u64,
        eta_ms: u64,
    }

    struct ParamUpdateExecuted has copy, drop {
        pool: 0x2::object::ID,
        kind: u8,
        value: u64,
    }

    struct ParamUpdateCancelled has copy, drop {
        pool: 0x2::object::ID,
        kind: u8,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        cover: u64,
        price: u64,
    }

    struct PolicyExpired has copy, drop {
        pool: 0x2::object::ID,
        policy: 0x2::object::ID,
        cover: u64,
    }

    struct BreachArmed has copy, drop {
        pool: 0x2::object::ID,
        price: u64,
        at_ms: u64,
    }

    struct BreachConfirmed has copy, drop {
        pool: 0x2::object::ID,
        price: u64,
    }

    struct PoolBreachArmed has copy, drop {
        pool: 0x2::object::ID,
        epoch_id: u64,
        price: u64,
        at_ms: u64,
    }

    struct PoolBreachConfirmed has copy, drop {
        pool: 0x2::object::ID,
        epoch_id: u64,
        price: u64,
        at_ms: u64,
    }

    struct PoolEpochRecovered has copy, drop {
        pool: 0x2::object::ID,
        epoch_id: u64,
        next_epoch_id: u64,
        price: u64,
        at_ms: u64,
    }

    public fun activation_delay_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.activation_delay_secs
    }

    fun apply_param<T0>(arg0: &mut DepegCoverPool<T0>, arg1: u8, arg2: u64) {
        assert_valid_param_value<T0>(arg0, arg1, arg2);
        if (arg1 == 0) {
            arg0.threshold = arg2;
        } else if (arg1 == 1) {
            arg0.premium_bps = arg2;
        } else if (arg1 == 2) {
            arg0.surge_premium_bps = arg2;
        } else if (arg1 == 3) {
            arg0.max_age_secs = arg2;
        } else if (arg1 == 4) {
            arg0.max_conf_bps = arg2;
        } else if (arg1 == 5) {
            arg0.min_dwell_secs = arg2;
        } else if (arg1 == 6) {
            arg0.activation_delay_secs = arg2;
        } else if (arg1 == 7) {
            arg0.max_cover_per_policy = arg2;
        } else if (arg1 == 8) {
            arg0.max_total_cover = arg2;
        } else if (arg1 == 9) {
            arg0.treasury_fee_bps = arg2;
        } else if (arg1 == 10) {
            arg0.keeper_bounty = arg2;
        } else {
            arg0.max_policy_duration_secs = arg2;
        };
    }

    fun assert_admin<T0>(arg0: &DepegCoverPool<T0>, arg1: &AdminCap) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 19);
    }

    fun assert_can_update_param<T0>(arg0: &DepegCoverPool<T0>, arg1: u8) {
        if (is_settlement_param(arg1)) {
            let v0 = if (arg0.total_cover == 0) {
                if (!arg0.epoch_armed) {
                    !arg0.epoch_breached
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 31);
        };
    }

    fun assert_sale_open<T0>(arg0: &DepegCoverPool<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 > arg2, 28);
        assert!(arg1 - arg2 > sale_cutoff<T0>(arg0), 28);
    }

    fun assert_valid_param_value<T0>(arg0: &DepegCoverPool<T0>, arg1: u8, arg2: u64) {
        if (arg1 == 0) {
            assert!(arg2 > 0, 24);
        } else if (arg1 == 1) {
            assert!(arg2 > 0 && arg2 <= (10000 as u64), 24);
        } else if (arg1 == 2) {
            assert!(arg2 <= (10000 as u64), 24);
        } else if (arg1 == 3) {
            assert!(arg2 > 0 && arg2 <= 3600, 24);
        } else if (arg1 == 4) {
            assert!(arg2 > 0 && arg2 <= (10000 as u64), 24);
        } else if (arg1 == 5) {
            assert!(arg2 >= 300 && arg2 <= arg0.max_policy_duration_secs, 24);
        } else if (arg1 == 6) {
            assert!(arg2 >= 300 && arg2 < arg0.max_policy_duration_secs, 24);
        } else if (arg1 == 7) {
            let v0 = if (arg2 == 0) {
                true
            } else if (arg0.max_total_cover == 0) {
                true
            } else {
                arg2 <= arg0.max_total_cover
            };
            assert!(v0, 24);
        } else if (arg1 == 8) {
            assert!(arg2 == 0 || arg2 >= arg0.total_cover, 24);
        } else if (arg1 == 9) {
            assert!(arg2 <= 2000, 24);
        } else if (arg1 == 10) {
            assert!(arg2 <= 1000000000, 24);
        } else {
            let v1 = if (arg2 > arg0.activation_delay_secs) {
                if (arg2 >= arg0.min_dwell_secs) {
                    arg2 <= 7776000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 24);
        };
    }

    fun assert_valid_pool_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg0 > 0, 24);
        assert!(arg1 > 0 && arg1 <= 3600, 24);
        assert!(arg2 > 0 && arg2 <= (10000 as u64), 24);
        assert!(arg3 <= (10000 as u64), 24);
        assert!(arg4 > 0 && arg4 <= (10000 as u64), 24);
        assert!(arg5 > 0 && arg5 <= arg7, 24);
        assert!(arg6 < arg7, 24);
        assert!(arg7 > 0 && arg7 <= 7776000, 24);
        assert!(arg8 >= 3600 && arg8 <= 2592000, 24);
        assert!(arg9 <= 2000, 24);
    }

    fun build_pool<T0>(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : DepegCoverPool<T0> {
        assert_valid_pool_params(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
        DepegCoverPool<T0>{
            id                       : 0x2::object::new(arg16),
            feed_id                  : arg0,
            expo_neg                 : arg1,
            expo_mag                 : arg2,
            threshold                : arg3,
            max_age_secs             : arg4,
            premium_bps              : arg5,
            surge_premium_bps        : arg6,
            max_conf_bps             : arg7,
            min_dwell_secs           : arg8,
            activation_delay_secs    : arg9,
            max_policy_duration_secs : arg10,
            max_cover_per_policy     : arg11,
            max_total_cover          : arg12,
            treasury_fee_bps         : arg14,
            keeper_bounty            : arg15,
            paused                   : false,
            direct_sales_enabled     : false,
            timelock_secs            : arg13,
            pending                  : 0x1::option::none<PendingParamUpdate>(),
            funds                    : 0x2::balance::zero<T0>(),
            treasury                 : 0x2::balance::zero<T0>(),
            total_shares             : 0,
            total_cover              : 0,
            epoch_id                 : 0,
            epoch_armed              : false,
            epoch_first_breach_ms    : 0,
            epoch_breached           : false,
            epoch_confirmed_ms       : 0,
            epoch_breach_price       : 0,
            epochs                   : 0x2::table::new<u64, EpochState>(arg16),
            policies                 : 0x2::table::new<0x2::object::ID, PolicyState>(arg16),
        }
    }

    public fun buy_cover<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Policy<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg0.direct_sales_enabled, 32);
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg4, arg5);
        buy_cover_checked<T0>(arg0, arg1, arg2, arg3, v0, v1, arg5, arg6)
    }

    fun buy_cover_checked<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Policy<T0>, 0x2::coin::Coin<T0>) {
        assert!(!arg0.paused, 18);
        assert!(!arg0.epoch_armed && !arg0.epoch_breached, 26);
        assert!(arg2 > 0, 0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 > v0, 4);
        let v1 = (arg3 - v0 + 999) / 1000;
        assert!(v1 <= arg0.max_policy_duration_secs, 23);
        let v2 = v0 + arg0.activation_delay_secs * 1000;
        assert!(arg3 > v2, 15);
        assert!(arg0.max_cover_per_policy == 0 || arg2 <= arg0.max_cover_per_policy, 16);
        assert!(arg0.max_total_cover == 0 || (arg0.total_cover as u128) + (arg2 as u128) <= (arg0.max_total_cover as u128), 17);
        assert_sale_open<T0>(arg0, arg4, arg5);
        let v3 = premium_for_duration<T0>(arg0, arg2, v1);
        assert!(v3 > 0, 10);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 >= v3, 1);
        let v5 = 0x2::coin::into_balance<T0>(arg1);
        let v6 = if (v4 > v3) {
            0x2::coin::take<T0>(&mut v5, v4 - v3, arg7)
        } else {
            0x2::coin::zero<T0>(arg7)
        };
        let v7 = (((v3 as u128) * (arg0.treasury_fee_bps as u128) / 10000) as u64);
        if (v7 > 0) {
            0x2::balance::join<T0>(&mut arg0.treasury, 0x2::balance::split<T0>(&mut v5, v7));
        };
        0x2::balance::join<T0>(&mut arg0.funds, v5);
        assert!((0x2::balance::value<T0>(&arg0.funds) as u128) >= (arg0.total_cover as u128) + (arg2 as u128), 2);
        arg0.total_cover = arg0.total_cover + arg2;
        let v8 = 0x2::object::new(arg7);
        let v9 = PolicyState{
            cover         : arg2,
            expiry_ms     : arg3,
            activation_ms : v2,
            epoch_id      : arg0.epoch_id,
            breached      : false,
        };
        0x2::table::add<0x2::object::ID, PolicyState>(&mut arg0.policies, 0x2::object::uid_to_inner(&v8), v9);
        let v10 = CoverBought{
            pool          : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover         : arg2,
            premium       : v3,
            expiry_ms     : arg3,
            duration_secs : v1,
        };
        0x2::event::emit<CoverBought>(v10);
        let v11 = Policy<T0>{
            id              : v8,
            pool_id         : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover           : arg2,
            premium_paid    : v3,
            expiry_ms       : arg3,
            activation_ms   : v2,
            epoch_id        : arg0.epoch_id,
            armed           : false,
            first_breach_ms : 0,
            breached        : false,
            breach_price    : 0,
        };
        (v11, v6)
    }

    public fun buy_cover_with_cap<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &BuyerCap<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Policy<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 33);
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg5, arg6);
        buy_cover_checked<T0>(arg0, arg2, arg3, arg4, v0, v1, arg6, arg7)
    }

    public fun buyer_cap_pool_id<T0>(arg0: &BuyerCap<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun cancel_param_update<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_some<PendingParamUpdate>(&arg0.pending), 21);
        let v0 = 0x1::option::extract<PendingParamUpdate>(&mut arg0.pending);
        let v1 = ParamUpdateCancelled{
            pool : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            kind : v0.kind,
        };
        0x2::event::emit<ParamUpdateCancelled>(v1);
    }

    public fun claim_latched<T0>(arg0: &mut DepegCoverPool<T0>, arg1: Policy<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.breached || epoch_claims_policy<T0>(arg0, &arg1), 11);
        settle<T0>(arg0, arg1, arg2)
    }

    fun confirmation_deadline_ms<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.epoch_first_breach_ms + arg0.min_dwell_secs * 1000 * (3 + 1)
    }

    public fun create_and_share<T0>(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = new_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let v1 = 0x2::object::id<DepegCoverPool<T0>>(&v0);
        let v2 = PoolCreated{
            pool        : v1,
            feed_id     : v0.feed_id,
            threshold   : arg3,
            premium_bps : arg5,
        };
        0x2::event::emit<PoolCreated>(v2);
        let v3 = AdminCap{
            id      : 0x2::object::new(arg16),
            pool_id : v1,
        };
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg16));
        let v4 = BuyerCap<T0>{
            id      : 0x2::object::new(arg16),
            pool_id : v1,
        };
        0x2::transfer::transfer<BuyerCap<T0>>(v4, 0x2::tx_context::sender(arg16));
        0x2::transfer::share_object<DepegCoverPool<T0>>(v0);
    }

    public fun deposit_lp<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : LpShare<T0> {
        assert!(!arg0.paused, 18);
        assert!(!arg0.epoch_armed && !arg0.epoch_breached, 26);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.funds);
        let v2 = if (arg0.total_shares == 0) {
            v0
        } else {
            assert!(v1 > 0, 30);
            (((v0 as u128) * (arg0.total_shares as u128) / (v1 as u128)) as u64)
        };
        assert!(v2 > 0, 29);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        LpShare<T0>{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            shares  : v2,
        }
    }

    public fun direct_sales_enabled<T0>(arg0: &DepegCoverPool<T0>) : bool {
        arg0.direct_sales_enabled
    }

    fun do_latch<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &mut Policy<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        if (arg1.breached) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expiry_ms, 4);
        assert!(v0 >= arg1.activation_ms, 14);
        do_pool_latch<T0>(arg0, arg2, arg3, arg4, arg5);
        let v1 = if (arg1.epoch_id == arg0.epoch_id) {
            if (arg0.epoch_armed) {
                if (arg1.activation_ms <= arg0.epoch_first_breach_ms) {
                    !arg1.armed || arg1.first_breach_ms != arg0.epoch_first_breach_ms
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg1.armed = true;
            arg1.first_breach_ms = arg0.epoch_first_breach_ms;
            arg1.breach_price = arg0.epoch_breach_price;
            let v2 = BreachArmed{
                pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                price : arg0.epoch_breach_price,
                at_ms : arg0.epoch_first_breach_ms,
            };
            0x2::event::emit<BreachArmed>(v2);
        };
        if (epoch_claims_policy<T0>(arg0, arg1)) {
            let v3 = 0x2::object::id<Policy<T0>>(arg1);
            assert!(0x2::table::contains<0x2::object::ID, PolicyState>(&arg0.policies, v3), 25);
            0x2::table::borrow_mut<0x2::object::ID, PolicyState>(&mut arg0.policies, v3).breached = true;
            arg1.breach_price = 0x2::table::borrow<u64, EpochState>(&arg0.epochs, arg1.epoch_id).price;
            arg1.breached = true;
            let v4 = BreachConfirmed{
                pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                price : arg1.breach_price,
            };
            0x2::event::emit<BreachConfirmed>(v4);
        };
    }

    fun do_pool_latch<T0>(arg0: &mut DepegCoverPool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (!is_adverse<T0>(arg0, arg1, arg2)) {
            assert!((arg0.epoch_armed || arg0.epoch_breached) && is_healthy<T0>(arg0, arg1, arg2), 6);
            do_pool_recovery<T0>(arg0, arg1, arg2, arg3);
            return
        };
        if (arg0.epoch_breached) {
            return
        };
        if (!arg0.epoch_armed) {
            arg0.epoch_armed = true;
            arg0.epoch_first_breach_ms = v0;
            arg0.epoch_breach_price = arg1;
            let v1 = PoolBreachArmed{
                pool     : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                epoch_id : arg0.epoch_id,
                price    : arg1,
                at_ms    : v0,
            };
            0x2::event::emit<PoolBreachArmed>(v1);
        } else if (v0 > confirmation_deadline_ms<T0>(arg0)) {
            arg0.epoch_first_breach_ms = v0;
            arg0.epoch_breach_price = arg1;
            let v2 = PoolBreachArmed{
                pool     : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                epoch_id : arg0.epoch_id,
                price    : arg1,
                at_ms    : v0,
            };
            0x2::event::emit<PoolBreachArmed>(v2);
        } else if (v0 >= arg0.epoch_first_breach_ms + arg0.min_dwell_secs * 1000) {
            arg0.epoch_breached = true;
            arg0.epoch_confirmed_ms = v0;
            arg0.epoch_breach_price = arg1;
            if (!0x2::table::contains<u64, EpochState>(&arg0.epochs, arg0.epoch_id)) {
                let v3 = EpochState{
                    first_breach_ms : arg0.epoch_first_breach_ms,
                    confirmed_ms    : v0,
                    price           : arg1,
                };
                0x2::table::add<u64, EpochState>(&mut arg0.epochs, arg0.epoch_id, v3);
            };
            pay_keeper_bounty<T0>(arg0, arg4);
            let v4 = PoolBreachConfirmed{
                pool     : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                epoch_id : arg0.epoch_id,
                price    : arg1,
                at_ms    : v0,
            };
            0x2::event::emit<PoolBreachConfirmed>(v4);
        };
    }

    fun do_pool_recovery<T0>(arg0: &mut DepegCoverPool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 > arg2 && arg1 - arg2 > arg0.threshold, 27);
        if (arg0.epoch_breached) {
            arg0.epoch_id = arg0.epoch_id + 1;
        };
        arg0.epoch_armed = false;
        arg0.epoch_first_breach_ms = 0;
        arg0.epoch_breached = false;
        arg0.epoch_confirmed_ms = 0;
        arg0.epoch_breach_price = 0;
        let v0 = PoolEpochRecovered{
            pool          : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            epoch_id      : arg0.epoch_id,
            next_epoch_id : arg0.epoch_id,
            price         : arg1,
            at_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolEpochRecovered>(v0);
    }

    public fun epoch_armed<T0>(arg0: &DepegCoverPool<T0>) : bool {
        arg0.epoch_armed
    }

    public fun epoch_breach_price<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.epoch_breach_price
    }

    public fun epoch_breached<T0>(arg0: &DepegCoverPool<T0>) : bool {
        arg0.epoch_breached
    }

    fun epoch_claims_policy<T0>(arg0: &DepegCoverPool<T0>, arg1: &Policy<T0>) : bool {
        if (!0x2::table::contains<u64, EpochState>(&arg0.epochs, arg1.epoch_id)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, EpochState>(&arg0.epochs, arg1.epoch_id);
        arg1.activation_ms <= v0.first_breach_ms && arg1.expiry_ms >= v0.confirmed_ms
    }

    fun epoch_claims_state<T0>(arg0: &DepegCoverPool<T0>, arg1: &PolicyState) : bool {
        if (!0x2::table::contains<u64, EpochState>(&arg0.epochs, arg1.epoch_id)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, EpochState>(&arg0.epochs, arg1.epoch_id);
        arg1.activation_ms <= v0.first_breach_ms && arg1.expiry_ms >= v0.confirmed_ms
    }

    public fun epoch_confirmed_ms<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.epoch_confirmed_ms
    }

    public fun epoch_first_breach_ms<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.epoch_first_breach_ms
    }

    public fun epoch_id<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.epoch_id
    }

    public fun execute_param_update<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_some<PendingParamUpdate>(&arg0.pending), 21);
        let v0 = *0x1::option::borrow<PendingParamUpdate>(&arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.eta_ms, 22);
        assert_can_update_param<T0>(arg0, v0.kind);
        apply_param<T0>(arg0, v0.kind, v0.value);
        arg0.pending = 0x1::option::none<PendingParamUpdate>();
        let v1 = ParamUpdateExecuted{
            pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            kind  : v0.kind,
            value : v0.value,
        };
        0x2::event::emit<ParamUpdateExecuted>(v1);
    }

    public fun expire_policy<T0>(arg0: &mut DepegCoverPool<T0>, arg1: Policy<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        assert!(!arg1.breached && !epoch_claims_policy<T0>(arg0, &arg1), 12);
        let v0 = 0x2::object::id<Policy<T0>>(&arg1);
        let Policy {
            id              : v1,
            pool_id         : _,
            cover           : _,
            premium_paid    : _,
            expiry_ms       : _,
            activation_ms   : _,
            epoch_id        : _,
            armed           : _,
            first_breach_ms : _,
            breached        : _,
            breach_price    : _,
        } = arg1;
        if (0x2::table::contains<0x2::object::ID, PolicyState>(&arg0.policies, v0)) {
            release_expired_policy<T0>(arg0, v0, arg2);
        } else {
            assert!(0x2::clock::timestamp_ms(arg2) > arg1.expiry_ms, 5);
        };
        0x2::object::delete(v1);
    }

    public fun expire_policy_by_id<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        release_expired_policy<T0>(arg0, arg1, arg2);
    }

    public fun feed_id<T0>(arg0: &DepegCoverPool<T0>) : vector<u8> {
        arg0.feed_id
    }

    public fun has_pending_update<T0>(arg0: &DepegCoverPool<T0>) : bool {
        0x1::option::is_some<PendingParamUpdate>(&arg0.pending)
    }

    fun is_adverse<T0>(arg0: &DepegCoverPool<T0>, arg1: u64, arg2: u64) : bool {
        (arg1 as u128) + (arg2 as u128) <= (arg0.threshold as u128)
    }

    fun is_healthy<T0>(arg0: &DepegCoverPool<T0>, arg1: u64, arg2: u64) : bool {
        arg1 > arg2 && arg1 - arg2 > arg0.threshold
    }

    public fun is_paused<T0>(arg0: &DepegCoverPool<T0>) : bool {
        arg0.paused
    }

    fun is_settlement_param(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else {
            arg0 == 11
        }
    }

    public fun issue_buyer_cap<T0>(arg0: &DepegCoverPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : BuyerCap<T0> {
        assert_admin<T0>(arg0, arg1);
        BuyerCap<T0>{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::id<DepegCoverPool<T0>>(arg0),
        }
    }

    public fun keeper_bounty<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.keeper_bounty
    }

    public fun max_age_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_age_secs
    }

    public fun max_conf_bps<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_conf_bps
    }

    public fun max_cover_per_policy<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_cover_per_policy
    }

    public fun max_policy_duration_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_policy_duration_secs
    }

    public fun max_total_cover<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_total_cover
    }

    public fun min_dwell_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.min_dwell_secs
    }

    public fun new_pool<T0>(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : DepegCoverPool<T0> {
        assert!(arg8 >= 300, 24);
        assert!(arg9 >= 300, 24);
        build_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    fun pay_keeper_bounty<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.keeper_bounty;
        if (v0 > 0 && 0x2::balance::value<T0>(&arg0.treasury) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun policy_activation_ms<T0>(arg0: &Policy<T0>) : u64 {
        arg0.activation_ms
    }

    public fun policy_armed<T0>(arg0: &Policy<T0>) : bool {
        arg0.armed
    }

    public fun policy_breached<T0>(arg0: &Policy<T0>) : bool {
        arg0.breached
    }

    public fun policy_claimable_by_pool_epoch<T0>(arg0: &DepegCoverPool<T0>, arg1: &Policy<T0>) : bool {
        epoch_claims_policy<T0>(arg0, arg1)
    }

    public fun policy_cover<T0>(arg0: &Policy<T0>) : u64 {
        arg0.cover
    }

    public fun policy_epoch_id<T0>(arg0: &Policy<T0>) : u64 {
        arg0.epoch_id
    }

    public fun policy_expiry_ms<T0>(arg0: &Policy<T0>) : u64 {
        arg0.expiry_ms
    }

    public fun policy_first_breach_ms<T0>(arg0: &Policy<T0>) : u64 {
        arg0.first_breach_ms
    }

    public fun policy_id<T0>(arg0: &Policy<T0>) : 0x2::object::ID {
        0x2::object::id<Policy<T0>>(arg0)
    }

    public fun pool_value<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun premium_bps<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.premium_bps
    }

    public fun premium_for<T0>(arg0: &DepegCoverPool<T0>, arg1: u64) : u64 {
        premium_for_duration_unchecked<T0>(arg0, arg1, 2592000)
    }

    public fun premium_for_duration<T0>(arg0: &DepegCoverPool<T0>, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 4);
        assert!(arg2 <= arg0.max_policy_duration_secs, 23);
        premium_for_duration_unchecked<T0>(arg0, arg1, arg2)
    }

    fun premium_for_duration_unchecked<T0>(arg0: &DepegCoverPool<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 10000 * (2592000 as u128);
        ((((arg1 as u128) * (premium_rate_bps<T0>(arg0, arg1) as u128) * (arg2 as u128) + v0 - 1) / v0) as u64)
    }

    public fun premium_rate_bps<T0>(arg0: &DepegCoverPool<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        let v1 = if (v0 == 0) {
            10000
        } else {
            let v2 = ((arg0.total_cover as u128) + (arg1 as u128)) * 10000 / (v0 as u128);
            if (v2 > 10000) {
                10000
            } else {
                v2
            }
        };
        arg0.premium_bps + (((arg0.surge_premium_bps as u128) * v1 / 10000) as u64)
    }

    public fun propose_param_update<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg2 <= 11, 20);
        assert_valid_param_value<T0>(arg0, arg2, arg3);
        assert_can_update_param<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg0.timelock_secs * 1000;
        let v1 = PendingParamUpdate{
            kind   : arg2,
            value  : arg3,
            eta_ms : v0,
        };
        arg0.pending = 0x1::option::some<PendingParamUpdate>(v1);
        let v2 = ParamUpdateProposed{
            pool   : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            kind   : arg2,
            value  : arg3,
            eta_ms : v0,
        };
        0x2::event::emit<ParamUpdateProposed>(v2);
    }

    fun read_price_magnitude<T0>(arg0: &DepegCoverPool<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1) == arg0.feed_id, 7);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg0.max_age_secs);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 9);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5)
        };
        assert!(v6 == arg0.expo_neg && v7 == arg0.expo_mag, 8);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2);
        assert!((v8 as u128) * 10000 <= (v4 as u128) * (arg0.max_conf_bps as u128), 13);
        (v4, v8)
    }

    public fun reap_unclaimed_policy<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PolicyState>(&arg0.policies, arg1), 25);
        let v0 = 0x2::table::borrow<0x2::object::ID, PolicyState>(&arg0.policies, arg1);
        assert!(v0.breached || epoch_claims_state<T0>(arg0, v0), 11);
        assert!(0x2::clock::timestamp_ms(arg2) > 0x2::table::borrow<u64, EpochState>(&arg0.epochs, v0.epoch_id).confirmed_ms + 1209600 * 1000, 34);
        let v1 = 0x2::table::remove<0x2::object::ID, PolicyState>(&mut arg0.policies, arg1);
        arg0.total_cover = arg0.total_cover - v1.cover;
        let v2 = PolicyExpired{
            pool   : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            policy : arg1,
            cover  : v1.cover,
        };
        0x2::event::emit<PolicyExpired>(v2);
    }

    public fun record_breach<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &mut Policy<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg2, arg3);
        do_latch<T0>(arg0, arg1, v0, v1, arg3, arg4);
    }

    public fun record_pool_breach<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg1, arg2);
        do_pool_latch<T0>(arg0, v0, v1, arg2, arg3);
    }

    public fun record_pool_recovery<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg1, arg2);
        do_pool_recovery<T0>(arg0, v0, v1, arg2);
    }

    fun release_expired_policy<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PolicyState>(&arg0.policies, arg1), 25);
        let v0 = 0x2::table::remove<0x2::object::ID, PolicyState>(&mut arg0.policies, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.expiry_ms, 5);
        assert!(!v0.breached && !epoch_claims_state<T0>(arg0, &v0), 12);
        arg0.total_cover = arg0.total_cover - v0.cover;
        let v1 = PolicyExpired{
            pool   : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            policy : arg1,
            cover  : v0.cover,
        };
        0x2::event::emit<PolicyExpired>(v1);
    }

    fun sale_cutoff<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        ((((arg0.threshold as u128) * ((10000 as u128) + (50 as u128)) + 10000 - 1) / 10000) as u64)
    }

    public fun set_direct_sales<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        arg0.direct_sales_enabled = arg2;
        let v0 = DirectSalesSet{
            pool    : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            enabled : arg2,
        };
        0x2::event::emit<DirectSalesSet>(v0);
    }

    public fun set_paused<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PausedSet{
            pool   : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            paused : arg2,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    fun settle<T0>(arg0: &mut DepegCoverPool<T0>, arg1: Policy<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        let v0 = 0x2::object::id<Policy<T0>>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, PolicyState>(&arg0.policies, v0), 25);
        let v1 = 0x2::table::remove<0x2::object::ID, PolicyState>(&mut arg0.policies, v0);
        assert!(v1.cover == arg1.cover, 3);
        assert!(v1.expiry_ms == arg1.expiry_ms, 3);
        assert!(v1.activation_ms == arg1.activation_ms, 3);
        assert!(v1.epoch_id == arg1.epoch_id, 3);
        let v2 = v1.breached || arg1.breached;
        assert!(v2 || epoch_claims_policy<T0>(arg0, &arg1), 11);
        let v3 = arg1.cover;
        let v4 = if (v2) {
            arg1.breach_price
        } else {
            0x2::table::borrow<u64, EpochState>(&arg0.epochs, arg1.epoch_id).price
        };
        let Policy {
            id              : v5,
            pool_id         : _,
            cover           : _,
            premium_paid    : _,
            expiry_ms       : _,
            activation_ms   : _,
            epoch_id        : _,
            armed           : _,
            first_breach_ms : _,
            breached        : _,
            breach_price    : _,
        } = arg1;
        0x2::object::delete(v5);
        arg0.total_cover = arg0.total_cover - v3;
        let v16 = Claimed{
            pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover : v3,
            price : v4,
        };
        0x2::event::emit<Claimed>(v16);
        0x2::coin::take<T0>(&mut arg0.funds, v3, arg2)
    }

    public fun shares<T0>(arg0: &LpShare<T0>) : u64 {
        arg0.shares
    }

    public fun surge_premium_bps<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.surge_premium_bps
    }

    public fun threshold<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.threshold
    }

    public fun timelock_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.timelock_secs
    }

    public fun total_cover<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.total_cover
    }

    public fun total_shares<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.total_shares
    }

    public fun treasury_fee_bps<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.treasury_fee_bps
    }

    public fun treasury_value<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun withdraw_lp<T0>(arg0: &mut DepegCoverPool<T0>, arg1: LpShare<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let LpShare {
            id      : v0,
            pool_id : v1,
            shares  : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        assert!(!arg0.epoch_armed && !arg0.epoch_breached, 26);
        0x2::object::delete(v0);
        let v3 = 0x2::balance::value<T0>(&arg0.funds);
        let v4 = (((v2 as u128) * (v3 as u128) / (arg0.total_shares as u128)) as u64);
        arg0.total_shares = arg0.total_shares - v2;
        assert!(v3 - v4 >= arg0.total_cover, 2);
        0x2::coin::take<T0>(&mut arg0.funds, v4, arg2)
    }

    public fun withdraw_treasury<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin<T0>(arg0, arg1);
        0x2::coin::take<T0>(&mut arg0.treasury, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

