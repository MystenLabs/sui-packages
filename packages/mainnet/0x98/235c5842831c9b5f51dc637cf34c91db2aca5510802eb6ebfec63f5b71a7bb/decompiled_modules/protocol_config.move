module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        pricing_config: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig,
        protocol_reserve_profit_share: u64,
        referral_fee_rate: u64,
        plp_supply_fee_rate: u64,
        plp_withdraw_fee_rate: u64,
        lp_request_limit_flush_attempts: u64,
        max_lp_pool_value: u64,
        max_valuation_window_ms: u64,
        no_trade_window_ms: u64,
        strike_exposure_template_config: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig,
        ewma_config: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::EwmaConfig,
        version_watermark: u64,
        trading_paused: bool,
        frozen: bool,
        valuation_in_progress: bool,
        snapshot_in_progress: bool,
        flush_seq: u64,
    }

    struct SettledRedeemKeepersKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeIncentiveSubsidyRateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeIncentiveLiveTargetRateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeIncentiveLifetimeCapRateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FlushOperatorsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OrderFlowKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : ProtocolConfig {
        ProtocolConfig{
            id                              : 0x2::object::new(arg0),
            pricing_config                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::new(),
            protocol_reserve_profit_share   : 100000000,
            referral_fee_rate               : 100000000,
            plp_supply_fee_rate             : 0,
            plp_withdraw_fee_rate           : 2000000,
            lp_request_limit_flush_attempts : 1,
            max_lp_pool_value               : 500000000000,
            max_valuation_window_ms         : 300000,
            no_trade_window_ms              : 2000,
            strike_exposure_template_config : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::new(),
            ewma_config                     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::new(),
            version_watermark               : 4,
            trading_paused                  : false,
            frozen                          : false,
            valuation_in_progress           : false,
            snapshot_in_progress            : false,
            flush_seq                       : 0,
        }
    }

    fun rates_upd(arg0: &ProtocolConfig, arg1: &0x2::clock::Clock) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::rates_upd(fee_incentive_live_target_rate(arg0), fee_incentive_lifetime_cap_rate(arg0), 0x2::clock::timestamp_ms(arg1));
    }

    public fun set_block_scholes_price_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::set_block_scholes_price_freshness_ms(&mut arg0.pricing_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::pricing_upd(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_block_scholes_svi_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::set_block_scholes_svi_freshness_ms(&mut arg0.pricing_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::pricing_upd(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_pyth_spot_freshness_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::set_pyth_spot_freshness_ms(&mut arg0.pricing_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::pricing_upd(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_use_pyth_spot_for_forward(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::set_use_pyth_spot_for_forward(&mut arg0.pricing_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::pricing_upd(&arg0.pricing_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun add_flush_operator(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        let v0 = FlushOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FlushOperatorsKey>(&arg0.id, v0)) {
            let v1 = FlushOperatorsKey{dummy_field: false};
            0x2::dynamic_field::add<FlushOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = FlushOperatorsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<FlushOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v2);
        assert!(!0x2::vec_set::contains<address>(v3, &arg2), 10);
        0x2::vec_set::insert<address>(v3, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::operator_upd(arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public fun add_settled_redeem_keeper(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: address) {
        chk_version(arg0);
        let v0 = SettledRedeemKeepersKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SettledRedeemKeepersKey>(&arg0.id, v0)) {
            let v1 = SettledRedeemKeepersKey{dummy_field: false};
            0x2::dynamic_field::add<SettledRedeemKeepersKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = SettledRedeemKeepersKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<SettledRedeemKeepersKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v2);
        assert!(!0x2::vec_set::contains<address>(v3, &arg2), 8);
        0x2::vec_set::insert<address>(v3, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::keeper_upd(arg2, true);
    }

    public(friend) fun begin_val(arg0: &mut ProtocolConfig) {
        chk_no_val(arg0);
        arg0.flush_seq = arg0.flush_seq + 1;
        arg0.valuation_in_progress = true;
    }

    public fun bump_version_watermark(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap) {
        let v0 = 4;
        assert!(v0 > arg0.version_watermark, 4);
        arg0.version_watermark = v0;
    }

    public(friend) fun chk_cutover(arg0: &ProtocolConfig) {
        assert!(arg0.version_watermark >= 4, 13);
    }

    public(friend) fun chk_floor(arg0: &ProtocolConfig) {
        assert!(4 >= arg0.version_watermark, 3);
    }

    public(friend) fun chk_flow<T0: drop>(arg0: &ProtocolConfig) {
        assert!(is_order_flow<T0>(arg0), 15);
    }

    public(friend) fun chk_no_snap(arg0: &ProtocolConfig) {
        assert!(!arg0.snapshot_in_progress, 6);
    }

    public(friend) fun chk_no_val(arg0: &ProtocolConfig) {
        assert!(!arg0.valuation_in_progress, 1);
    }

    public(friend) fun chk_operator(arg0: &ProtocolConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(is_flush_operator(arg0, 0x2::tx_context::sender(arg1)), 12);
    }

    public(friend) fun chk_trading(arg0: &ProtocolConfig) {
        chk_unpaused(arg0);
    }

    fun chk_unpaused(arg0: &ProtocolConfig) {
        assert!(!arg0.trading_paused, 0);
    }

    public(friend) fun chk_val(arg0: &ProtocolConfig) {
        assert!(arg0.valuation_in_progress, 2);
    }

    public(friend) fun chk_version(arg0: &ProtocolConfig) {
        assert!(!arg0.frozen, 5);
        assert!(4 >= arg0.version_watermark, 3);
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg0);
        0x2::transfer::share_object<ProtocolConfig>(v0);
        id(&v0)
    }

    public(friend) fun end_snapshot(arg0: &mut ProtocolConfig) {
        arg0.snapshot_in_progress = false;
    }

    public(friend) fun end_val(arg0: &mut ProtocolConfig) {
        chk_val(arg0);
        arg0.valuation_in_progress = false;
    }

    public fun fee_incentive_lifetime_cap_rate(arg0: &ProtocolConfig) : u64 {
        let v0 = FeeIncentiveLifetimeCapRateKey{dummy_field: false};
        u64_field_or<FeeIncentiveLifetimeCapRateKey>(arg0, v0, 100000000)
    }

    public fun fee_incentive_live_target_rate(arg0: &ProtocolConfig) : u64 {
        let v0 = FeeIncentiveLiveTargetRateKey{dummy_field: false};
        u64_field_or<FeeIncentiveLiveTargetRateKey>(arg0, v0, 20000000)
    }

    public fun fee_incentive_subsidy_rate(arg0: &ProtocolConfig) : u64 {
        let v0 = FeeIncentiveSubsidyRateKey{dummy_field: false};
        u64_field_or<FeeIncentiveSubsidyRateKey>(arg0, v0, 200000000)
    }

    public(friend) fun flush_seq(arg0: &ProtocolConfig) : u64 {
        arg0.flush_seq
    }

    public(friend) fun freeze_all(arg0: &mut ProtocolConfig) {
        put_frozen(arg0, true);
    }

    public fun frozen(arg0: &ProtocolConfig) : bool {
        arg0.frozen
    }

    public fun id(arg0: &ProtocolConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun is_cur_flush(arg0: &ProtocolConfig, arg1: u64) : bool {
        arg0.valuation_in_progress && arg0.flush_seq == arg1
    }

    public fun is_flush_operator(arg0: &ProtocolConfig, arg1: address) : bool {
        let v0 = FlushOperatorsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FlushOperatorsKey>(&arg0.id, v0)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<FlushOperatorsKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0), &arg1)
    }

    public(friend) fun is_keeper(arg0: &ProtocolConfig, arg1: address) : bool {
        let v0 = SettledRedeemKeepersKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SettledRedeemKeepersKey>(&arg0.id, v0)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<SettledRedeemKeepersKey, 0x2::vec_set::VecSet<address>>(&arg0.id, v0), &arg1)
    }

    public fun is_order_flow<T0: drop>(arg0: &ProtocolConfig) : bool {
        let v0 = OrderFlowKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<OrderFlowKey<T0>>(&arg0.id, v0)
    }

    public(friend) fun max_pool(arg0: &ProtocolConfig) : u64 {
        arg0.max_lp_pool_value
    }

    public fun no_trade_window_ms(arg0: &ProtocolConfig) : u64 {
        arg0.no_trade_window_ms
    }

    public(friend) fun open_snap(arg0: &mut ProtocolConfig) {
        arg0.snapshot_in_progress = true;
    }

    public(friend) fun pause_all(arg0: &mut ProtocolConfig) {
        put_paused(arg0, true);
    }

    public(friend) fun pricing_cfg(arg0: &ProtocolConfig) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig {
        &arg0.pricing_config
    }

    fun put_frozen(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.frozen = arg1;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::frozen_upd(id(arg0), arg1);
    }

    fun put_paused(arg0: &mut ProtocolConfig, arg1: bool) {
        arg0.trading_paused = arg1;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::paused_upd(id(arg0), arg1);
    }

    public fun referral_fee_rate(arg0: &ProtocolConfig) : u64 {
        arg0.referral_fee_rate
    }

    public fun remove_flush_operator(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(is_flush_operator(arg0, arg2), 11);
        let v0 = FlushOperatorsKey{dummy_field: false};
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<FlushOperatorsKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0), &arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::operator_upd(arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun remove_settled_redeem_keeper(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: address) {
        assert!(is_keeper(arg0, arg2), 9);
        let v0 = SettledRedeemKeepersKey{dummy_field: false};
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<SettledRedeemKeepersKey, 0x2::vec_set::VecSet<address>>(&mut arg0.id, v0), &arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::keeper_upd(arg2, false);
    }

    public(friend) fun req_attempts(arg0: &ProtocolConfig) : u64 {
        arg0.lp_request_limit_flush_attempts
    }

    public(friend) fun rsv_share(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_reserve_profit_share
    }

    public(friend) fun se_snapshot(arg0: &ProtocolConfig) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::snapshot(&arg0.strike_exposure_template_config)
    }

    public(friend) fun se_template(arg0: &ProtocolConfig) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig {
        &arg0.strike_exposure_template_config
    }

    public fun set_ewma_enabled(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        abort 14
    }

    public fun set_ewma_params(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        abort 14
    }

    public fun set_fee_incentive_live_target_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_live_tgt(arg2);
        let v0 = FeeIncentiveLiveTargetRateKey{dummy_field: false};
        set_u64<FeeIncentiveLiveTargetRateKey>(arg0, v0, arg2);
        rates_upd(arg0, arg3);
    }

    public fun set_fee_incentive_subsidy_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_subsidy(arg2);
        let v0 = FeeIncentiveSubsidyRateKey{dummy_field: false};
        set_u64<FeeIncentiveSubsidyRateKey>(arg0, v0, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::subsidy_upd(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_frozen(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: bool) {
        put_frozen(arg0, arg2);
    }

    public fun set_lp_request_limit_flush_attempts(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_attempts(arg2);
        arg0.lp_request_limit_flush_attempts = arg2;
    }

    public fun set_max_lp_pool_value(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_max_pool(arg2);
        arg0.max_lp_pool_value = arg2;
    }

    public fun set_max_valuation_window_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_val_win(arg2);
        arg0.max_valuation_window_ms = arg2;
    }

    public fun set_no_trade_window_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_no_trade(arg2);
        arg0.no_trade_window_ms = arg2;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::no_trade_upd(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_order_flow<T0: drop>(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        if (arg2) {
            chk_version(arg0);
        };
        let v0 = OrderFlowKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::exists<OrderFlowKey<T0>>(&arg0.id, v0);
        if (arg2 && !v1) {
            0x2::dynamic_field::add<OrderFlowKey<T0>, bool>(&mut arg0.id, v0, true);
        } else if (!arg2 && v1) {
            0x2::dynamic_field::remove<OrderFlowKey<T0>, bool>(&mut arg0.id, v0);
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::flow_upd(0x1::type_name::with_defining_ids<T0>(), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_plp_supply_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_sup_fee(arg2);
        arg0.plp_supply_fee_rate = arg2;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::plp_fees_upd(arg0.plp_supply_fee_rate, arg0.plp_withdraw_fee_rate, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_plp_withdraw_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_wd_fee(arg2);
        arg0.plp_withdraw_fee_rate = arg2;
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::plp_fees_upd(arg0.plp_supply_fee_rate, arg0.plp_withdraw_fee_rate, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_protocol_reserve_profit_share(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64) {
        chk_version(arg0);
        chk_no_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_rsv_shr(arg2);
        arg0.protocol_reserve_profit_share = arg2;
    }

    public fun set_referral_fee_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_referral(arg2);
        arg0.referral_fee_rate = arg2;
    }

    public fun set_template_backing_buffer_lambda(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_lambda(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_base_fee(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_base_fee(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_expiry_fee_max_multiplier(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_fee_mult(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_expiry_fee_window_ms(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_fee_win(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_fee_incentive_lifetime_cap_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_life_cap(arg2);
        let v0 = FeeIncentiveLifetimeCapRateKey{dummy_field: false};
        set_u64<FeeIncentiveLifetimeCapRateKey>(arg0, v0, arg2);
        rates_upd(arg0, arg3);
    }

    public fun set_template_inventory_impact_max_rate(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_impact(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_max_entry_probability(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_max_prob(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_min_entry_probability(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_min_prob(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_template_min_fee(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::set_min_fee(&mut arg0.strike_exposure_template_config, arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events::template_upd(&arg0.strike_exposure_template_config, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_trading_paused(arg0: &mut ProtocolConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: bool) {
        chk_version(arg0);
        put_paused(arg0, arg2);
    }

    fun set_u64<T0: copy + drop + store>(arg0: &mut ProtocolConfig, arg1: T0, arg2: u64) {
        if (0x2::dynamic_field::exists<T0>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<T0, u64>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<T0, u64>(&mut arg0.id, arg1, arg2);
        };
    }

    public(friend) fun sup_fee(arg0: &ProtocolConfig) : u64 {
        arg0.plp_supply_fee_rate
    }

    public fun trading_paused(arg0: &ProtocolConfig) : bool {
        arg0.trading_paused
    }

    fun u64_field_or<T0: copy + drop + store>(arg0: &ProtocolConfig, arg1: T0, arg2: u64) : u64 {
        if (!0x2::dynamic_field::exists<T0>(&arg0.id, arg1)) {
            return arg2
        };
        *0x2::dynamic_field::borrow<T0, u64>(&arg0.id, arg1)
    }

    public(friend) fun val_window(arg0: &ProtocolConfig) : u64 {
        arg0.max_valuation_window_ms
    }

    public fun valuation_in_progress(arg0: &ProtocolConfig) : bool {
        arg0.valuation_in_progress
    }

    public fun version_watermark(arg0: &ProtocolConfig) : u64 {
        arg0.version_watermark
    }

    public(friend) fun wd_fee(arg0: &ProtocolConfig) : u64 {
        arg0.plp_withdraw_fee_rate
    }

    // decompiled from Move bytecode v7
}

