module 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        params: Params,
        paused: bool,
        proposal: 0x1::option::Option<Proposal>,
    }

    struct Proposal has drop, store {
        params: Params,
        execute_ms: u64,
    }

    struct Params has copy, drop, store {
        base_fee_bps: u64,
        exit_max_bps: u64,
        exit_min_bps: u64,
        tau_ms: u64,
        treasury_bps: u64,
        dividend_bps: u64,
        platform_bps: u64,
        lock_days: vector<u64>,
        lock_multipliers: vector<u64>,
        epoch_ms: u64,
        timelock_ms: u64,
        launch_fee_mist: u64,
        max_positions: u64,
        max_trade_bps: u64,
        max_notional_usd: u64,
        wake_cooldown_ms: u64,
    }

    public fun authorize(arg0: &Config, arg1: &AdminCap) {
        assert!(arg1.config == 0x2::object::id<Config>(arg0), 2);
    }

    public fun base_fee(arg0: &Params) : u64 {
        arg0.base_fee_bps
    }

    public fun cancel(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        arg0.proposal = 0x1::option::none<Proposal>();
    }

    public fun cancel_funding(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::cancel(&mut arg0.id);
    }

    public fun cancel_hibernation(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::cancel(&mut arg0.id);
    }

    public fun cooldown(arg0: &Params) : u64 {
        arg0.wake_cooldown_ms
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (Config, AdminCap) {
        let v0 = Config{
            id       : 0x2::object::new(arg0),
            params   : defaults(),
            paused   : false,
            proposal : 0x1::option::none<Proposal>(),
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            config : 0x2::object::id<Config>(&v0),
        };
        (v0, v1)
    }

    public fun create_with_params(arg0: Params, arg1: &mut 0x2::tx_context::TxContext) : (Config, AdminCap) {
        validate(&arg0);
        let v0 = Config{
            id       : 0x2::object::new(arg1),
            params   : arg0,
            paused   : false,
            proposal : 0x1::option::none<Proposal>(),
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg1),
            config : 0x2::object::id<Config>(&v0),
        };
        (v0, v1)
    }

    public fun defaults() : Params {
        Params{
            base_fee_bps     : 100,
            exit_max_bps     : 500,
            exit_min_bps     : 50,
            tau_ms           : 108000000,
            treasury_bps     : 5000,
            dividend_bps     : 3500,
            platform_bps     : 1500,
            lock_days        : vector[0, 7, 30, 90],
            lock_multipliers : vector[10000, 20000, 50000, 100000],
            epoch_ms         : 86400000,
            timelock_ms      : 172800000,
            launch_fee_mist  : 5000000000,
            max_positions    : 256,
            max_trade_bps    : 0,
            max_notional_usd : 75000,
            wake_cooldown_ms : 259200000,
        }
    }

    public fun epoch_ms(arg0: &Params) : u64 {
        arg0.epoch_ms
    }

    public fun execute(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Proposal>(&arg0.proposal), 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<Proposal>(&arg0.proposal).execute_ms, 3);
        let Proposal {
            params     : v0,
            execute_ms : _,
        } = 0x1::option::extract<Proposal>(&mut arg0.proposal);
        arg0.params = v0;
    }

    public fun execute_funding(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::execute(&mut arg0.id, arg1);
    }

    public fun execute_hibernation(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::execute(&mut arg0.id, arg1);
    }

    public fun exit_max(arg0: &Params) : u64 {
        arg0.exit_max_bps
    }

    public fun exit_min(arg0: &Params) : u64 {
        arg0.exit_min_bps
    }

    public fun funding(arg0: &Config) : 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::Rules {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::get(&arg0.id)
    }

    public fun funding_proposal(arg0: &Config) : (bool, 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::Rules, u64) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::pending(&arg0.id)
    }

    public fun hibernation(arg0: &Config) : 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::Rules {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::get(&arg0.id)
    }

    public fun hibernation_proposal(arg0: &Config) : (bool, 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::Rules, u64) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::pending(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create(arg0);
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun launch_fee(arg0: &Params) : u64 {
        arg0.launch_fee_mist
    }

    public fun lock_tier(arg0: &Params, arg1: u8) : (u64, u64) {
        assert!((arg1 as u64) < 0x1::vector::length<u64>(&arg0.lock_days), 1);
        (*0x1::vector::borrow<u64>(&arg0.lock_days, (arg1 as u64)) * 86400000, *0x1::vector::borrow<u64>(&arg0.lock_multipliers, (arg1 as u64)))
    }

    public fun max_notional_usd(arg0: &Params) : u64 {
        arg0.max_notional_usd
    }

    public fun max_positions(arg0: &Params) : u64 {
        arg0.max_positions
    }

    public fun max_trade(arg0: &Params) : u64 {
        arg0.max_trade_bps
    }

    public fun params(arg0: &Config) : &Params {
        &arg0.params
    }

    public fun pause(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        arg0.paused = true;
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun propose(arg0: &mut Config, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        authorize(arg0, arg1);
        validate(&arg2);
        let v0 = Proposal{
            params     : arg2,
            execute_ms : 0x2::clock::timestamp_ms(arg3) + arg0.params.timelock_ms,
        };
        arg0.proposal = 0x1::option::some<Proposal>(v0);
    }

    public fun propose_funding(arg0: &mut Config, arg1: &AdminCap, arg2: 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::Rules, arg3: &0x2::clock::Clock) {
        authorize(arg0, arg1);
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::funding_rules::propose(&mut arg0.id, arg2, arg0.params.timelock_ms, arg3);
    }

    public fun propose_hibernation(arg0: &mut Config, arg1: &AdminCap, arg2: 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::Rules, arg3: &0x2::clock::Clock) {
        authorize(arg0, arg1);
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation_rules::propose(&mut arg0.id, arg2, arg0.params.timelock_ms, arg3);
    }

    public fun resume(arg0: &mut Config, arg1: &AdminCap) {
        authorize(arg0, arg1);
        arg0.paused = false;
    }

    public fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun splits(arg0: &Params) : (u64, u64, u64) {
        (arg0.treasury_bps, arg0.dividend_bps, arg0.platform_bps)
    }

    public fun tau(arg0: &Params) : u64 {
        arg0.tau_ms
    }

    public fun timelock(arg0: &Params) : u64 {
        arg0.timelock_ms
    }

    public fun validate(arg0: &Params) {
        let v0 = if (arg0.base_fee_bps < 10000) {
            if (arg0.exit_max_bps < 10000) {
                arg0.exit_min_bps <= arg0.exit_max_bps
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg0.tau_ms > 0 && arg0.treasury_bps + arg0.dividend_bps + arg0.platform_bps == 10000, 1);
        assert!(arg0.timelock_ms >= 172800000 && arg0.epoch_ms >= 3600000, 1);
        let v1 = if (arg0.max_trade_bps <= 2000) {
            if (arg0.max_positions > 0) {
                arg0.max_positions <= 512
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
    }

    public fun with_launch_fee(arg0: Params, arg1: u64) : Params {
        arg0.launch_fee_mist = arg1;
        arg0
    }

    // decompiled from Move bytecode v7
}

