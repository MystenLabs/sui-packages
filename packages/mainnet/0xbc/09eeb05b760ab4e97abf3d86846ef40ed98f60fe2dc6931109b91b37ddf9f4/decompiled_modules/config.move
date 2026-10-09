module 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct KeeperCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        epoch: u64,
    }

    struct Params has copy, drop, store {
        base_fee_bps: u64,
        exit_max_bps: u64,
        exit_min_bps: u64,
        tau_ms: u64,
        treasury_bps: u64,
        dividend_bps: u64,
        platform_bps: u64,
        creator_bps: u64,
        lock_days: vector<u64>,
        lock_multipliers: vector<u64>,
        epoch_ms: u64,
        launch_fee_mist: u64,
        wake_cooldown_ms: u64,
        entry_slippage_bps: u64,
        rebalance_slippage_bps: u64,
        emergency_slippage_bps: u64,
        retarget_notice_ms: u64,
        retarget_cooldown_ms: u64,
        release_max_bps: u64,
        creator_profit_max_bps: u64,
        max_legs: u64,
        lend_live_bps: u64,
        lend_idle_bps: u64,
    }

    struct MarketPolicy has copy, drop, store {
        enabled: bool,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        cap_usd_e6: u64,
        max_leverage_bps: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        params: Params,
        treasury: address,
        platform: address,
        keeper_epoch: u64,
        markets: 0x2::table::Table<0x2::object::ID, MarketPolicy>,
        setup_until_ms: u64,
        pending: 0x1::option::Option<PendingParams>,
    }

    struct PendingParams has copy, drop, store {
        params: Params,
        effective_ms: u64,
    }

    struct ParamsProposed has copy, drop {
        config: 0x2::object::ID,
        params: Params,
        effective_ms: u64,
    }

    struct ParamsCancelled has copy, drop {
        config: 0x2::object::ID,
    }

    struct ParamsChanged has copy, drop {
        config: 0x2::object::ID,
        params: Params,
    }

    struct RecipientsChanged has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
        platform: address,
    }

    struct PauseChanged has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct MarketChanged has copy, drop {
        config: 0x2::object::ID,
        market: 0x2::object::ID,
        policy: MarketPolicy,
    }

    struct KeeperIssued has copy, drop {
        config: 0x2::object::ID,
        recipient: address,
        cap: 0x2::object::ID,
        epoch: u64,
    }

    struct KeepersRevoked has copy, drop {
        config: 0x2::object::ID,
        epoch: u64,
    }

    struct Migrated has copy, drop {
        config: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct Halted has copy, drop {
        config: 0x2::object::ID,
        from: u64,
    }

    public fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    fun apply(arg0: &mut Config, arg1: Params) {
        arg0.params = arg1;
        let v0 = ParamsChanged{
            config : 0x2::object::id<Config>(arg0),
            params : arg1,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun assert_buying(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
    }

    public fun assert_keeper(arg0: &Config, arg1: &KeeperCap) {
        assert_version(arg0);
        assert!(arg1.config == 0x2::object::id<Config>(arg0) && arg1.epoch == arg0.keeper_epoch, 4);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun authorize(arg0: &Config, arg1: &AdminCap) {
        assert_version(arg0);
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 3);
    }

    public fun base_fee_bps(arg0: &Params) : u64 {
        arg0.base_fee_bps
    }

    public fun cancel_params(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        assert!(0x1::option::is_some<PendingParams>(&arg0.pending), 6);
        arg0.pending = 0x1::option::none<PendingParams>();
        let v0 = ParamsCancelled{config: 0x2::object::id<Config>(arg0)};
        0x2::event::emit<ParamsCancelled>(v0);
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, AdminCap) {
        let v0 = defaults();
        validate(&v0);
        let v1 = Config{
            id             : 0x2::object::new(arg0),
            version        : 1,
            paused         : false,
            params         : v0,
            treasury       : 0x2::tx_context::sender(arg0),
            platform       : 0x2::tx_context::sender(arg0),
            keeper_epoch   : 0,
            markets        : 0x2::table::new<0x2::object::ID, MarketPolicy>(arg0),
            setup_until_ms : 0x2::tx_context::epoch_timestamp_ms(arg0) + 172800000,
            pending        : 0x1::option::none<PendingParams>(),
        };
        let v2 = ParamsChanged{
            config : 0x2::object::id<Config>(&v1),
            params : v0,
        };
        0x2::event::emit<ParamsChanged>(v2);
        let v3 = AdminCap{
            id     : 0x2::object::new(arg0),
            config : 0x2::object::id<Config>(&v1),
        };
        (v1, v3)
    }

    fun cuts_only(arg0: &Params, arg1: &Params) : bool {
        let v0 = if (arg1.base_fee_bps > arg0.base_fee_bps) {
            true
        } else if (arg1.exit_max_bps > arg0.exit_max_bps) {
            true
        } else if (arg1.exit_min_bps > arg0.exit_min_bps) {
            true
        } else if (arg1.tau_ms > arg0.tau_ms) {
            true
        } else {
            arg1.launch_fee_mist > arg0.launch_fee_mist
        };
        if (v0) {
            return false
        };
        let v1 = *arg1;
        v1.base_fee_bps = arg0.base_fee_bps;
        v1.exit_max_bps = arg0.exit_max_bps;
        v1.exit_min_bps = arg0.exit_min_bps;
        v1.tau_ms = arg0.tau_ms;
        v1.launch_fee_mist = arg0.launch_fee_mist;
        v1 == *arg0
    }

    public fun defaults() : Params {
        Params{
            base_fee_bps           : 100,
            exit_max_bps           : 500,
            exit_min_bps           : 50,
            tau_ms                 : 108000000,
            treasury_bps           : 5000,
            dividend_bps           : 2500,
            platform_bps           : 1500,
            creator_bps            : 1000,
            lock_days              : vector[0, 7, 30, 90],
            lock_multipliers       : vector[10000, 20000, 50000, 100000],
            epoch_ms               : 86400000,
            launch_fee_mist        : 5000000000,
            wake_cooldown_ms       : 259200000,
            entry_slippage_bps     : 100,
            rebalance_slippage_bps : 50,
            emergency_slippage_bps : 300,
            retarget_notice_ms     : 259200000,
            retarget_cooldown_ms   : 1209600000,
            release_max_bps        : 1000,
            creator_profit_max_bps : 1000,
            max_legs               : 4,
            lend_live_bps          : 5000,
            lend_idle_bps          : 8500,
        }
    }

    public fun destroy_keeper(arg0: KeeperCap) {
        let KeeperCap {
            id     : v0,
            config : _,
            epoch  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emergency_slippage_bps(arg0: &Params) : u64 {
        arg0.emergency_slippage_bps
    }

    public fun entry_slippage_bps(arg0: &Params) : u64 {
        arg0.entry_slippage_bps
    }

    public fun epoch_ms(arg0: &Params) : u64 {
        arg0.epoch_ms
    }

    public fun execute_params(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(0x1::option::is_some<PendingParams>(&arg0.pending), 6);
        let PendingParams {
            params       : v0,
            effective_ms : v1,
        } = 0x1::option::extract<PendingParams>(&mut arg0.pending);
        let v2 = v0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v1, 8);
        validate(&v2);
        apply(arg0, v2);
    }

    public fun exit_fees(arg0: &Params) : (u64, u64, u64) {
        (arg0.exit_max_bps, arg0.exit_min_bps, arg0.tau_ms)
    }

    public fun halt(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        let v0 = Halted{
            config : 0x2::object::id<Config>(arg0),
            from   : arg0.version,
        };
        0x2::event::emit<Halted>(v0);
        arg0.version = 0;
    }

    public fun has_market(arg0: &Config, arg1: 0x2::object::ID) : bool {
        assert_version(arg0);
        0x2::table::contains<0x2::object::ID, MarketPolicy>(&arg0.markets, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0);
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun issue_keeper(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        authorize(arg0, arg1);
        let v0 = KeeperCap{
            id     : 0x2::object::new(arg3),
            config : 0x2::object::id<Config>(arg0),
            epoch  : arg0.keeper_epoch,
        };
        let v1 = KeeperIssued{
            config    : 0x2::object::id<Config>(arg0),
            recipient : arg2,
            cap       : 0x2::object::id<KeeperCap>(&v0),
            epoch     : arg0.keeper_epoch,
        };
        0x2::event::emit<KeeperIssued>(v1);
        0x2::transfer::transfer<KeeperCap>(v0, arg2);
    }

    public fun keeper_epoch(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.keeper_epoch
    }

    public fun launch_fee_mist(arg0: &Params) : u64 {
        arg0.launch_fee_mist
    }

    public fun lend_bps(arg0: &Params, arg1: bool) : u64 {
        if (arg1) {
            arg0.lend_live_bps
        } else {
            arg0.lend_idle_bps
        }
    }

    public fun lock_tier(arg0: &Params, arg1: u8) : (u64, u64) {
        assert!((arg1 as u64) < 0x1::vector::length<u64>(&arg0.lock_days), 2);
        (*0x1::vector::borrow<u64>(&arg0.lock_days, (arg1 as u64)) * 86400000, *0x1::vector::borrow<u64>(&arg0.lock_multipliers, (arg1 as u64)))
    }

    public fun market(arg0: &Config, arg1: 0x2::object::ID) : MarketPolicy {
        assert_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, MarketPolicy>(&arg0.markets, arg1), 5);
        let v0 = *0x2::table::borrow<0x2::object::ID, MarketPolicy>(&arg0.markets, arg1);
        assert!(v0.enabled, 5);
        v0
    }

    public fun market_any(arg0: &Config, arg1: 0x2::object::ID) : MarketPolicy {
        assert_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, MarketPolicy>(&arg0.markets, arg1), 5);
        *0x2::table::borrow<0x2::object::ID, MarketPolicy>(&arg0.markets, arg1)
    }

    public fun market_cap_usd_e6(arg0: &MarketPolicy) : u64 {
        arg0.cap_usd_e6
    }

    public fun market_enabled(arg0: &MarketPolicy) : bool {
        arg0.enabled
    }

    public fun market_max_leverage_bps(arg0: &MarketPolicy) : u64 {
        arg0.max_leverage_bps
    }

    public fun market_oracles(arg0: &MarketPolicy) : (0x2::object::ID, 0x2::object::ID) {
        (arg0.base_oracle, arg0.collateral_oracle)
    }

    public fun max_legs(arg0: &Params) : u64 {
        arg0.max_legs
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 3);
        assert!(arg0.version < 1, 1);
        let v0 = Migrated{
            config : 0x2::object::id<Config>(arg0),
            from   : arg0.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg0.version = 1;
    }

    public fun params(arg0: &Config) : Params {
        assert_version(arg0);
        arg0.params
    }

    public fun params_status(arg0: &Config) : (bool, Params, u64, u64) {
        if (0x1::option::is_some<PendingParams>(&arg0.pending)) {
            let v4 = 0x1::option::borrow<PendingParams>(&arg0.pending);
            (true, v4.params, v4.effective_ms, arg0.setup_until_ms)
        } else {
            (false, arg0.params, 0, arg0.setup_until_ms)
        }
    }

    public fun paused(arg0: &Config) : bool {
        assert_version(arg0);
        arg0.paused
    }

    public fun platform(arg0: &Config) : address {
        assert_version(arg0);
        arg0.platform
    }

    public fun propose_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        authorize(arg0, arg1);
        validate(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 172800000;
        let v1 = PendingParams{
            params       : arg2,
            effective_ms : v0,
        };
        arg0.pending = 0x1::option::some<PendingParams>(v1);
        let v2 = ParamsProposed{
            config       : 0x2::object::id<Config>(arg0),
            params       : arg2,
            effective_ms : v0,
        };
        0x2::event::emit<ParamsProposed>(v2);
    }

    public fun rebalance_slippage_bps(arg0: &Params) : u64 {
        arg0.rebalance_slippage_bps
    }

    public fun release_limits(arg0: &Params) : (u64, u64) {
        (arg0.release_max_bps, arg0.creator_profit_max_bps)
    }

    public fun retarget_timing(arg0: &Params) : (u64, u64) {
        (arg0.retarget_notice_ms, arg0.retarget_cooldown_ms)
    }

    public fun revoke_keepers(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        arg0.keeper_epoch = arg0.keeper_epoch + 1;
        let v0 = KeepersRevoked{
            config : 0x2::object::id<Config>(arg0),
            epoch  : arg0.keeper_epoch,
        };
        0x2::event::emit<KeepersRevoked>(v0);
    }

    public fun set_market(arg0: &mut Config, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: bool, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64) {
        authorize(arg0, arg1);
        assert!(arg7 >= 10000 && arg7 <= 100000, 2);
        let v0 = MarketPolicy{
            enabled           : arg3,
            base_oracle       : arg4,
            collateral_oracle : arg5,
            cap_usd_e6        : arg6,
            max_leverage_bps  : arg7,
        };
        if (0x2::table::contains<0x2::object::ID, MarketPolicy>(&arg0.markets, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, MarketPolicy>(&mut arg0.markets, arg2) = v0;
        } else {
            0x2::table::add<0x2::object::ID, MarketPolicy>(&mut arg0.markets, arg2, v0);
        };
        let v1 = MarketChanged{
            config : 0x2::object::id<Config>(arg0),
            market : arg2,
            policy : v0,
        };
        0x2::event::emit<MarketChanged>(v1);
    }

    public fun set_params(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        authorize(arg0, arg1);
        validate(&arg2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.setup_until_ms || cuts_only(&arg0.params, &arg2), 8);
        apply(arg0, arg2);
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        authorize(arg0, arg1);
        assert!(arg0.paused != arg2, 6);
        arg0.paused = arg2;
        let v0 = PauseChanged{
            config : 0x2::object::id<Config>(arg0),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_recipients(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: address) {
        authorize(arg0, arg1);
        assert!(arg2 != @0x0 && arg3 != @0x0, 7);
        arg0.treasury = arg2;
        arg0.platform = arg3;
        let v0 = RecipientsChanged{
            config   : 0x2::object::id<Config>(arg0),
            treasury : arg2,
            platform : arg3,
        };
        0x2::event::emit<RecipientsChanged>(v0);
    }

    public fun splits(arg0: &Params) : (u64, u64, u64, u64) {
        (arg0.treasury_bps, arg0.dividend_bps, arg0.platform_bps, arg0.creator_bps)
    }

    public fun treasury(arg0: &Config) : address {
        assert_version(arg0);
        arg0.treasury
    }

    public fun validate(arg0: &Params) {
        assert!(arg0.base_fee_bps <= 300, 2);
        let v0 = if (arg0.exit_max_bps <= 1000) {
            if (arg0.exit_min_bps <= arg0.exit_max_bps) {
                arg0.tau_ms > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!(arg0.treasury_bps + arg0.dividend_bps + arg0.platform_bps + arg0.creator_bps == 10000, 2);
        assert!(0x1::vector::length<u64>(&arg0.lock_days) == 0x1::vector::length<u64>(&arg0.lock_multipliers) && 0x1::vector::length<u64>(&arg0.lock_days) > 0, 2);
        assert!(*0x1::vector::borrow<u64>(&arg0.lock_days, 0) == 0 && *0x1::vector::borrow<u64>(&arg0.lock_multipliers, 0) == 10000, 2);
        assert!(arg0.epoch_ms >= 3600000, 2);
        let v1 = if (arg0.entry_slippage_bps > 0) {
            if (arg0.entry_slippage_bps <= 500) {
                if (arg0.rebalance_slippage_bps > 0) {
                    if (arg0.rebalance_slippage_bps <= 100) {
                        if (arg0.emergency_slippage_bps >= arg0.rebalance_slippage_bps) {
                            arg0.emergency_slippage_bps <= 500
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        assert!(arg0.retarget_notice_ms >= 3600000, 2);
        assert!(arg0.release_max_bps <= 10000 && arg0.creator_profit_max_bps <= 1000, 2);
        assert!(arg0.max_legs >= 1 && arg0.max_legs <= 8, 2);
        assert!(arg0.lend_live_bps <= 9000 && arg0.lend_idle_bps <= 9000, 2);
    }

    public fun version() : u64 {
        1
    }

    public fun wake_cooldown_ms(arg0: &Params) : u64 {
        arg0.wake_cooldown_ms
    }

    public fun with_fees(arg0: Params, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Params {
        arg0.base_fee_bps = arg1;
        arg0.exit_max_bps = arg2;
        arg0.exit_min_bps = arg3;
        arg0.tau_ms = arg4;
        arg0
    }

    public fun with_launch(arg0: Params, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Params {
        arg0.launch_fee_mist = arg1;
        arg0.wake_cooldown_ms = arg2;
        arg0.epoch_ms = arg3;
        arg0.max_legs = arg4;
        arg0
    }

    public fun with_lending(arg0: Params, arg1: u64, arg2: u64) : Params {
        arg0.lend_live_bps = arg1;
        arg0.lend_idle_bps = arg2;
        arg0
    }

    public fun with_release(arg0: Params, arg1: u64, arg2: u64) : Params {
        arg0.release_max_bps = arg1;
        arg0.creator_profit_max_bps = arg2;
        arg0
    }

    public fun with_retarget(arg0: Params, arg1: u64, arg2: u64) : Params {
        arg0.retarget_notice_ms = arg1;
        arg0.retarget_cooldown_ms = arg2;
        arg0
    }

    public fun with_slippage(arg0: Params, arg1: u64, arg2: u64, arg3: u64) : Params {
        arg0.entry_slippage_bps = arg1;
        arg0.rebalance_slippage_bps = arg2;
        arg0.emergency_slippage_bps = arg3;
        arg0
    }

    public fun with_splits(arg0: Params, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Params {
        arg0.treasury_bps = arg1;
        arg0.dividend_bps = arg2;
        arg0.platform_bps = arg3;
        arg0.creator_bps = arg4;
        arg0
    }

    // decompiled from Move bytecode v7
}

