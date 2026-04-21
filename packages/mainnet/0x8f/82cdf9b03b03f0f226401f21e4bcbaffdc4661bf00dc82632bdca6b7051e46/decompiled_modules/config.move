module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config {
    struct Config has key {
        id: 0x2::object::UID,
        risk_control: RiskControl,
        ramm_params: RammParams,
        exit_fee_bps: u64,
        protocol_fee_bps: u64,
        premium_bump_ratio_bps: u64,
        premium_change_per_day_bps: u64,
        claim_deposit_mist: u64,
        claim_voting_period_sec: u64,
        claim_cooldown_period_sec: u64,
        claim_payout_redemption_period_sec: u64,
        tranche_duration_ms: u64,
        claims_paused: bool,
        pool_paused: bool,
    }

    struct RiskControl has store {
        mcr_floor: u64,
        min_capital_ratio_bps: u64,
    }

    struct RammParams has store {
        target_liquidity: u64,
        oracle_buffer_bps: u64,
        ratchet_speed_bps: u64,
        fast_ratchet_speed_bps: u64,
        ratchet_period_ms: u64,
        liq_speed_period_ms: u64,
        liq_speed_in: u64,
        liq_speed_out: u64,
        fast_liq_speed: u64,
        initial_budget: u64,
    }

    public fun claim_cooldown_period_sec(arg0: &Config) : u64 {
        arg0.claim_cooldown_period_sec
    }

    public fun claim_deposit_mist(arg0: &Config) : u64 {
        arg0.claim_deposit_mist
    }

    public fun claim_payout_redemption_period_sec(arg0: &Config) : u64 {
        arg0.claim_payout_redemption_period_sec
    }

    public fun claim_voting_period_sec(arg0: &Config) : u64 {
        arg0.claim_voting_period_sec
    }

    public fun claims_paused(arg0: &Config) : bool {
        arg0.claims_paused
    }

    public fun exit_fee_bps(arg0: &Config) : u64 {
        arg0.exit_fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskControl{
            mcr_floor             : 1000000000000,
            min_capital_ratio_bps : 11000,
        };
        let v1 = RammParams{
            target_liquidity       : 5000000000000,
            oracle_buffer_bps      : 100,
            ratchet_speed_bps      : 400,
            fast_ratchet_speed_bps : 5000,
            ratchet_period_ms      : 86400000,
            liq_speed_period_ms    : 86400000,
            liq_speed_in           : 100000000000000,
            liq_speed_out          : 100000000000000,
            fast_liq_speed         : 1000000000000,
            initial_budget         : 5000000000000,
        };
        let v2 = Config{
            id                                 : 0x2::object::new(arg0),
            risk_control                       : v0,
            ramm_params                        : v1,
            exit_fee_bps                       : 250,
            protocol_fee_bps                   : 100,
            premium_bump_ratio_bps             : 500,
            premium_change_per_day_bps         : 200,
            claim_deposit_mist                 : 100000000000,
            claim_voting_period_sec            : 259200,
            claim_cooldown_period_sec          : 86400,
            claim_payout_redemption_period_sec : 2592000,
            tranche_duration_ms                : 7862400000,
            claims_paused                      : false,
            pool_paused                        : false,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun mcr_floor(arg0: &Config) : u64 {
        arg0.risk_control.mcr_floor
    }

    public fun min_capital_ratio_bps(arg0: &Config) : u64 {
        arg0.risk_control.min_capital_ratio_bps
    }

    public fun pool_paused(arg0: &Config) : bool {
        arg0.pool_paused
    }

    public fun premium_bump_ratio_bps(arg0: &Config) : u64 {
        arg0.premium_bump_ratio_bps
    }

    public fun premium_change_per_day_bps(arg0: &Config) : u64 {
        arg0.premium_change_per_day_bps
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun ramm_fast_liq_speed(arg0: &Config) : u64 {
        arg0.ramm_params.fast_liq_speed
    }

    public fun ramm_fast_ratchet_speed_bps(arg0: &Config) : u64 {
        arg0.ramm_params.fast_ratchet_speed_bps
    }

    public fun ramm_initial_budget(arg0: &Config) : u64 {
        arg0.ramm_params.initial_budget
    }

    public fun ramm_liq_speed_in(arg0: &Config) : u64 {
        arg0.ramm_params.liq_speed_in
    }

    public fun ramm_liq_speed_out(arg0: &Config) : u64 {
        arg0.ramm_params.liq_speed_out
    }

    public fun ramm_liq_speed_period_ms(arg0: &Config) : u64 {
        arg0.ramm_params.liq_speed_period_ms
    }

    public fun ramm_oracle_buffer_bps(arg0: &Config) : u64 {
        arg0.ramm_params.oracle_buffer_bps
    }

    public fun ramm_ratchet_period_ms(arg0: &Config) : u64 {
        arg0.ramm_params.ratchet_period_ms
    }

    public fun ramm_ratchet_speed_bps(arg0: &Config) : u64 {
        arg0.ramm_params.ratchet_speed_bps
    }

    public fun ramm_target_liquidity(arg0: &Config) : u64 {
        arg0.ramm_params.target_liquidity
    }

    public fun set_claims_paused(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: bool) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        arg0.claims_paused = arg3;
    }

    public fun set_pool_paused(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: bool) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        arg0.pool_paused = arg3;
    }

    public fun tranche_duration_ms(arg0: &Config) : u64 {
        arg0.tranche_duration_ms
    }

    public fun update_exit_fee_bps(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_exit_fee_bps();
        };
        arg0.exit_fee_bps = arg3;
    }

    public fun update_mcr_floor(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 == 0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_mcr_floor();
        };
        arg0.risk_control.mcr_floor = arg3;
    }

    public fun update_min_capital_ratio_bps(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 < 10000) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_min_capital_ratio_bps();
        };
        arg0.risk_control.min_capital_ratio_bps = arg3;
    }

    public fun update_premium_bump_ratio_bps(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 > 10000) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_premium_bump_ratio_bps();
        };
        arg0.premium_bump_ratio_bps = arg3;
    }

    public fun update_premium_change_per_day_bps(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 > 10000) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_premium_change_per_day_bps();
        };
        arg0.premium_change_per_day_bps = arg3;
    }

    public fun update_protocol_fee_bps(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 > 10000) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_protocol_fee_bps();
        };
        arg0.protocol_fee_bps = arg3;
    }

    public fun update_ramm_initial_budget(arg0: &mut Config, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        arg0.ramm_params.initial_budget = arg3;
    }

    // decompiled from Move bytecode v6
}

