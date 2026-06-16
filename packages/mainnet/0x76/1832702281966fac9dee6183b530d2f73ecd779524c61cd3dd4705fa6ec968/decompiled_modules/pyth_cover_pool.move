module 0x761832702281966fac9dee6183b530d2f73ecd779524c61cd3dd4705fa6ec968::pyth_cover_pool {
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
        max_cover_per_policy: u64,
        max_total_cover: u64,
        treasury_fee_bps: u64,
        keeper_bounty: u64,
        paused: bool,
        timelock_secs: u64,
        pending: 0x1::option::Option<PendingParamUpdate>,
        funds: 0x2::balance::Balance<T0>,
        treasury: 0x2::balance::Balance<T0>,
        total_shares: u64,
        total_cover: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PendingParamUpdate has copy, drop, store {
        kind: u8,
        value: u64,
        eta_ms: u64,
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
    }

    struct PausedSet has copy, drop {
        pool: 0x2::object::ID,
        paused: bool,
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

    struct BreachArmed has copy, drop {
        pool: 0x2::object::ID,
        price: u64,
        at_ms: u64,
    }

    struct BreachConfirmed has copy, drop {
        pool: 0x2::object::ID,
        price: u64,
    }

    public fun activation_delay_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.activation_delay_secs
    }

    fun apply_param<T0>(arg0: &mut DepegCoverPool<T0>, arg1: u8, arg2: u64) {
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
        } else {
            arg0.keeper_bounty = arg2;
        };
    }

    fun assert_admin<T0>(arg0: &DepegCoverPool<T0>, arg1: &AdminCap) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 19);
    }

    public fun buy_cover<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Policy<T0> {
        assert!(!arg0.paused, 18);
        assert!(arg2 > 0, 0);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 4);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg0.activation_delay_secs * 1000;
        assert!(arg3 > v0, 15);
        assert!(arg0.max_cover_per_policy == 0 || arg2 <= arg0.max_cover_per_policy, 16);
        assert!(arg0.max_total_cover == 0 || arg0.total_cover + arg2 <= arg0.max_total_cover, 17);
        let v1 = premium_for<T0>(arg0, arg2);
        assert!(v1 > 0, 10);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v1, 1);
        let v3 = (((v2 as u128) * (arg0.treasury_fee_bps as u128) / 10000) as u64);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        if (v3 > 0) {
            0x2::balance::join<T0>(&mut arg0.treasury, 0x2::balance::split<T0>(&mut v4, v3));
        };
        0x2::balance::join<T0>(&mut arg0.funds, v4);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg0.total_cover + arg2, 2);
        arg0.total_cover = arg0.total_cover + arg2;
        let v5 = CoverBought{
            pool      : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover     : arg2,
            premium   : v2,
            expiry_ms : arg3,
        };
        0x2::event::emit<CoverBought>(v5);
        Policy<T0>{
            id              : 0x2::object::new(arg5),
            pool_id         : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover           : arg2,
            premium_paid    : v2,
            expiry_ms       : arg3,
            activation_ms   : v0,
            armed           : false,
            first_breach_ms : 0,
            breached        : false,
            breach_price    : 0,
        }
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
        assert!(arg1.breached, 11);
        settle<T0>(arg0, arg1, arg2)
    }

    public fun create_and_share<T0>(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = new_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v1 = 0x2::object::id<DepegCoverPool<T0>>(&v0);
        let v2 = PoolCreated{
            pool        : v1,
            feed_id     : v0.feed_id,
            threshold   : arg3,
            premium_bps : arg5,
        };
        0x2::event::emit<PoolCreated>(v2);
        let v3 = AdminCap{
            id      : 0x2::object::new(arg15),
            pool_id : v1,
        };
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg15));
        0x2::transfer::share_object<DepegCoverPool<T0>>(v0);
    }

    public fun deposit_lp<T0>(arg0: &mut DepegCoverPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : LpShare<T0> {
        assert!(!arg0.paused, 18);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.funds);
        let v2 = if (arg0.total_shares == 0 || v1 == 0) {
            v0
        } else {
            (((v0 as u128) * (arg0.total_shares as u128) / (v1 as u128)) as u64)
        };
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        LpShare<T0>{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            shares  : v2,
        }
    }

    fun do_latch<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &mut Policy<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        if (arg1.breached) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg1.expiry_ms, 4);
        assert!(v0 >= arg1.activation_ms, 14);
        assert!(arg2 + arg3 <= arg0.threshold, 6);
        if (!arg1.armed) {
            arg1.armed = true;
            arg1.first_breach_ms = v0;
            arg1.breach_price = arg2;
            let v1 = BreachArmed{
                pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                price : arg2,
                at_ms : v0,
            };
            0x2::event::emit<BreachArmed>(v1);
        } else if (v0 >= arg1.first_breach_ms + arg0.min_dwell_secs * 1000) {
            arg1.breach_price = arg2;
            arg1.breached = true;
            let v2 = arg0.keeper_bounty;
            if (v2 > 0 && 0x2::balance::value<T0>(&arg0.treasury) >= v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.treasury, v2, arg5), 0x2::tx_context::sender(arg5));
            };
            let v3 = BreachConfirmed{
                pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
                price : arg2,
            };
            0x2::event::emit<BreachConfirmed>(v3);
        };
    }

    public fun execute_param_update<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_some<PendingParamUpdate>(&arg0.pending), 21);
        let v0 = *0x1::option::borrow<PendingParamUpdate>(&arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.eta_ms, 22);
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
        let Policy {
            id              : v0,
            pool_id         : v1,
            cover           : v2,
            premium_paid    : _,
            expiry_ms       : v4,
            activation_ms   : _,
            armed           : _,
            first_breach_ms : _,
            breached        : v8,
            breach_price    : _,
        } = arg1;
        assert!(v1 == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        assert!(0x2::clock::timestamp_ms(arg2) > v4, 5);
        assert!(!v8, 12);
        0x2::object::delete(v0);
        arg0.total_cover = arg0.total_cover - v2;
    }

    public fun feed_id<T0>(arg0: &DepegCoverPool<T0>) : vector<u8> {
        arg0.feed_id
    }

    public fun has_pending_update<T0>(arg0: &DepegCoverPool<T0>) : bool {
        0x1::option::is_some<PendingParamUpdate>(&arg0.pending)
    }

    public fun is_paused<T0>(arg0: &DepegCoverPool<T0>) : bool {
        arg0.paused
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

    public fun max_total_cover<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.max_total_cover
    }

    public fun min_dwell_secs<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.min_dwell_secs
    }

    public fun new_pool<T0>(arg0: vector<u8>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : DepegCoverPool<T0> {
        DepegCoverPool<T0>{
            id                    : 0x2::object::new(arg15),
            feed_id               : arg0,
            expo_neg              : arg1,
            expo_mag              : arg2,
            threshold             : arg3,
            max_age_secs          : arg4,
            premium_bps           : arg5,
            surge_premium_bps     : arg6,
            max_conf_bps          : arg7,
            min_dwell_secs        : arg8,
            activation_delay_secs : arg9,
            max_cover_per_policy  : arg10,
            max_total_cover       : arg11,
            treasury_fee_bps      : arg13,
            keeper_bounty         : arg14,
            paused                : false,
            timelock_secs         : arg12,
            pending               : 0x1::option::none<PendingParamUpdate>(),
            funds                 : 0x2::balance::zero<T0>(),
            treasury              : 0x2::balance::zero<T0>(),
            total_shares          : 0,
            total_cover           : 0,
        }
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

    public fun policy_cover<T0>(arg0: &Policy<T0>) : u64 {
        arg0.cover
    }

    public fun policy_expiry_ms<T0>(arg0: &Policy<T0>) : u64 {
        arg0.expiry_ms
    }

    public fun policy_first_breach_ms<T0>(arg0: &Policy<T0>) : u64 {
        arg0.first_breach_ms
    }

    public fun pool_value<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun premium_bps<T0>(arg0: &DepegCoverPool<T0>) : u64 {
        arg0.premium_bps
    }

    public fun premium_for<T0>(arg0: &DepegCoverPool<T0>, arg1: u64) : u64 {
        (((arg1 as u128) * (premium_rate_bps<T0>(arg0, arg1) as u128) / 10000) as u64)
    }

    public fun premium_rate_bps<T0>(arg0: &DepegCoverPool<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        let v1 = if (v0 == 0) {
            10000
        } else {
            let v2 = ((arg0.total_cover + arg1) as u128) * 10000 / (v0 as u128);
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
        assert!(arg2 <= 10, 20);
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

    public fun record_breach<T0>(arg0: &mut DepegCoverPool<T0>, arg1: &mut Policy<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = read_price_magnitude<T0>(arg0, arg2, arg3);
        do_latch<T0>(arg0, arg1, v0, v1, arg3, arg4);
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
        let Policy {
            id              : v0,
            pool_id         : v1,
            cover           : v2,
            premium_paid    : _,
            expiry_ms       : _,
            activation_ms   : _,
            armed           : _,
            first_breach_ms : _,
            breached        : _,
            breach_price    : v9,
        } = arg1;
        assert!(v1 == 0x2::object::id<DepegCoverPool<T0>>(arg0), 3);
        0x2::object::delete(v0);
        arg0.total_cover = arg0.total_cover - v2;
        let v10 = Claimed{
            pool  : 0x2::object::id<DepegCoverPool<T0>>(arg0),
            cover : v2,
            price : v9,
        };
        0x2::event::emit<Claimed>(v10);
        0x2::coin::take<T0>(&mut arg0.funds, v2, arg2)
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

