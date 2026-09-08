module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::protocol_config {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        pricing_config: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::PricingConfig,
        protocol_reserve_profit_share: u64,
        referral_fee_rate: u64,
        plp_supply_fee_rate: u64,
        plp_withdraw_fee_rate: u64,
        lp_request_limit_flush_attempts: u64,
        max_lp_pool_value: u64,
        max_valuation_window_ms: u64,
        no_trade_window_ms: u64,
        strike_exposure_template_config: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::StrikeExposureConfig,
        ewma_config: 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::ewma_config::EwmaConfig,
        version_watermark: u64,
        trading_paused: bool,
        frozen: bool,
        valuation_in_progress: bool,
        snapshot_in_progress: bool,
        flush_seq: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : ProtocolConfig {
        ProtocolConfig{
            id                              : 0x2::object::new(arg0),
            pricing_config                  : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::new(),
            protocol_reserve_profit_share   : 100000000,
            referral_fee_rate               : 100000000,
            plp_supply_fee_rate             : 0,
            plp_withdraw_fee_rate           : 2000000,
            lp_request_limit_flush_attempts : 1,
            max_lp_pool_value               : 500000000000,
            max_valuation_window_ms         : 300000,
            no_trade_window_ms              : 2000,
            strike_exposure_template_config : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::new(),
            ewma_config                     : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::ewma_config::new(),
            version_watermark               : 1,
            trading_paused                  : false,
            frozen                          : false,
            valuation_in_progress           : false,
            snapshot_in_progress            : false,
            flush_seq                       : 0,
        }
    }

    public(friend) fun ewma_config(arg0: &ProtocolConfig) : &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::ewma_config::EwmaConfig {
        &arg0.ewma_config
    }

    public(friend) fun pricing_config(arg0: &ProtocolConfig) : &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::PricingConfig {
        &arg0.pricing_config
    }

    public fun set_block_scholes_price_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::set_block_scholes_price_freshness_ms(&mut arg0.pricing_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_pricing_config_updated(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_block_scholes_svi_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::set_block_scholes_svi_freshness_ms(&mut arg0.pricing_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_pricing_config_updated(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_pyth_spot_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::set_pyth_spot_freshness_ms(&mut arg0.pricing_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_pricing_config_updated(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_use_pyth_spot_for_forward(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pricing_config::set_use_pyth_spot_for_forward(&mut arg0.pricing_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_pricing_config_updated(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    fun assert_not_trading_paused(arg0: &ProtocolConfig) {
        assert!(!arg0.trading_paused, 0);
    }

    public(friend) fun assert_not_valuation_in_progress(arg0: &ProtocolConfig) {
        assert!(!arg0.valuation_in_progress, 1);
    }

    public(friend) fun assert_snapshot_not_in_progress(arg0: &ProtocolConfig) {
        assert!(!arg0.snapshot_in_progress, 6);
    }

    public(friend) fun assert_trade_window_open(arg0: &ProtocolConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = no_trade_window_ms(arg0);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 < arg1 && arg1 - v1 > v0, 7);
    }

    public(friend) fun assert_trading_allowed(arg0: &ProtocolConfig) {
        assert_not_trading_paused(arg0);
    }

    public(friend) fun assert_valuation_in_progress(arg0: &ProtocolConfig) {
        assert!(arg0.valuation_in_progress, 2);
    }

    public(friend) fun assert_version(arg0: &ProtocolConfig) {
        assert!(!arg0.frozen, 5);
        assert!(1 >= arg0.version_watermark, 3);
    }

    public(friend) fun begin_snapshot(arg0: &mut ProtocolConfig) {
        arg0.snapshot_in_progress = true;
    }

    public(friend) fun begin_valuation(arg0: &mut ProtocolConfig) {
        assert_not_valuation_in_progress(arg0);
        arg0.flush_seq = arg0.flush_seq + 1;
        arg0.valuation_in_progress = true;
    }

    public fun bump_version_watermark(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap) {
        let v0 = 1;
        assert!(v0 > arg0.version_watermark, 4);
        arg0.version_watermark = v0;
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg0);
        0x2::transfer::share_object<ProtocolConfig>(v0);
        id(&v0)
    }

    public(friend) fun current_flush_seq(arg0: &ProtocolConfig) : u64 {
        arg0.flush_seq
    }

    public(friend) fun end_snapshot(arg0: &mut ProtocolConfig) {
        arg0.snapshot_in_progress = false;
    }

    public(friend) fun end_valuation(arg0: &mut ProtocolConfig) {
        assert_valuation_in_progress(arg0);
        arg0.valuation_in_progress = false;
    }

    public(friend) fun freeze_protocol(arg0: &mut ProtocolConfig) {
        set_frozen_internal(arg0, true);
    }

    public fun frozen(arg0: &ProtocolConfig) : bool {
        arg0.frozen
    }

    public fun id(arg0: &ProtocolConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_current_flush(arg0: &ProtocolConfig, arg1: u64) : bool {
        arg0.valuation_in_progress && arg0.flush_seq == arg1
    }

    public(friend) fun lp_request_limit_flush_attempts(arg0: &ProtocolConfig) : u64 {
        arg0.lp_request_limit_flush_attempts
    }

    public(friend) fun max_lp_pool_value(arg0: &ProtocolConfig) : u64 {
        arg0.max_lp_pool_value
    }

    public(friend) fun max_valuation_window_ms(arg0: &ProtocolConfig) : u64 {
        arg0.max_valuation_window_ms
    }

    public fun no_trade_window_ms(arg0: &ProtocolConfig) : u64 {
        arg0.no_trade_window_ms
    }

    public(friend) fun pause_trading(arg0: &mut ProtocolConfig) {
        set_trading_paused_internal(arg0, true);
    }

    public(friend) fun plp_supply_fee_rate(arg0: &ProtocolConfig) : u64 {
        arg0.plp_supply_fee_rate
    }

    public(friend) fun plp_withdraw_fee_rate(arg0: &ProtocolConfig) : u64 {
        arg0.plp_withdraw_fee_rate
    }

    public(friend) fun protocol_reserve_profit_share(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_reserve_profit_share
    }

    public fun referral_fee_rate(arg0: &ProtocolConfig) : u64 {
        arg0.referral_fee_rate
    }

    public fun set_ewma_enabled(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::ewma_config::set_enabled(&mut arg0.ewma_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_ewma_config_updated(&arg0.ewma_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_ewma_params(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::ewma_config::set_params(&mut arg0.ewma_config, arg2, arg3, arg4);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_ewma_config_updated(&arg0.ewma_config, 0x2::clock::timestamp_ms(arg5));
    }

    public fun set_frozen(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: bool) {
        set_frozen_internal(arg0, arg2);
    }

    fun set_frozen_internal(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.frozen = arg1;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_protocol_frozen_updated(id(arg0), arg1);
    }

    public fun set_lp_request_limit_flush_attempts(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_lp_request_limit_flush_attempts(arg2);
        arg0.lp_request_limit_flush_attempts = arg2;
    }

    public fun set_max_lp_pool_value(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_max_lp_pool_value(arg2);
        arg0.max_lp_pool_value = arg2;
    }

    public fun set_max_valuation_window_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_max_valuation_window_ms(arg2);
        arg0.max_valuation_window_ms = arg2;
    }

    public fun set_no_trade_window_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_no_trade_window_ms(arg2);
        arg0.no_trade_window_ms = arg2;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_no_trade_window_updated(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_plp_supply_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_plp_supply_fee_rate(arg2);
        arg0.plp_supply_fee_rate = arg2;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_plp_fee_rates_updated(arg0.plp_supply_fee_rate, arg0.plp_withdraw_fee_rate, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_plp_withdraw_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_plp_withdraw_fee_rate(arg2);
        arg0.plp_withdraw_fee_rate = arg2;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_plp_fee_rates_updated(arg0.plp_supply_fee_rate, arg0.plp_withdraw_fee_rate, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_protocol_reserve_profit_share(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_not_valuation_in_progress(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_protocol_reserve_profit_share(arg2);
        arg0.protocol_reserve_profit_share = arg2;
    }

    public fun set_referral_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_referral_fee_rate(arg2);
        arg0.referral_fee_rate = arg2;
    }

    public fun set_template_backing_buffer_lambda(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_backing_buffer_lambda(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_base_fee(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_base_fee(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_expiry_fee_max_multiplier(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_expiry_fee_max_multiplier(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_expiry_fee_window_ms(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_expiry_fee_window_ms(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_inventory_impact_max_rate(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_inventory_impact_max_rate(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_max_entry_probability(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_max_entry_probability(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_min_entry_probability(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_min_entry_probability(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_min_fee(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version(arg0);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::set_min_fee(&mut arg0.strike_exposure_template_config, arg2);
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_strike_exposure_template_config_updated(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_trading_paused(arg0: &mut ProtocolConfig, arg1: &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::admin::AdminCap, arg2: bool) {
        assert_version(arg0);
        set_trading_paused_internal(arg0, arg2);
    }

    fun set_trading_paused_internal(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.trading_paused = arg1;
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_events::emit_trading_paused_updated(id(arg0), arg1);
    }

    public(friend) fun strike_exposure_config_snapshot(arg0: &ProtocolConfig) : 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::StrikeExposureConfig {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::snapshot(&arg0.strike_exposure_template_config)
    }

    public(friend) fun strike_exposure_template_config(arg0: &ProtocolConfig) : &0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config::StrikeExposureConfig {
        &arg0.strike_exposure_template_config
    }

    public fun trading_paused(arg0: &ProtocolConfig) : bool {
        arg0.trading_paused
    }

    public fun valuation_in_progress(arg0: &ProtocolConfig) : bool {
        arg0.valuation_in_progress
    }

    // decompiled from Move bytecode v7
}

