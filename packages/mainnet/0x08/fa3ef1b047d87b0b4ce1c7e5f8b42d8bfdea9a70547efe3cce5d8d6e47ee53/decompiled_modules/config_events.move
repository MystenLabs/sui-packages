module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_events {
    struct StrikeExposureTemplateConfigUpdated has copy, drop, store {
        backing_buffer_lambda: u64,
        base_fee: u64,
        min_fee: u64,
        min_entry_probability: u64,
        max_entry_probability: u64,
        expiry_fee_window_ms: u64,
        expiry_fee_max_multiplier: u64,
        inventory_impact_max_rate: u64,
        onchain_timestamp_ms: u64,
    }

    struct PricingConfigUpdated has copy, drop, store {
        use_pyth_spot_for_forward: bool,
        pyth_spot_freshness_ms: u64,
        block_scholes_price_freshness_ms: u64,
        block_scholes_svi_freshness_ms: u64,
        onchain_timestamp_ms: u64,
    }

    struct EwmaConfigUpdated has copy, drop, store {
        alpha: u64,
        z_score_threshold: u64,
        penalty_rate: u64,
        enabled: bool,
        onchain_timestamp_ms: u64,
    }

    struct PlpFeeRatesUpdated has copy, drop, store {
        plp_supply_fee_rate: u64,
        plp_withdraw_fee_rate: u64,
        onchain_timestamp_ms: u64,
    }

    struct NoTradeWindowUpdated has copy, drop, store {
        no_trade_window_ms: u64,
        onchain_timestamp_ms: u64,
    }

    struct TradingPausedUpdated has copy, drop, store {
        protocol_config_id: 0x2::object::ID,
        paused: bool,
    }

    struct ProtocolFrozenUpdated has copy, drop, store {
        protocol_config_id: 0x2::object::ID,
        frozen: bool,
    }

    struct MarketCreated has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        pool_vault_id: 0x2::object::ID,
        propbook_underlying_id: u32,
        expiry: u64,
        tick_size: u64,
        admission_tick_size: u64,
        max_expiry_allocation: u64,
        initial_expiry_cash: u64,
        backing_buffer_lambda: u64,
        base_fee: u64,
        min_fee: u64,
        min_entry_probability: u64,
        max_entry_probability: u64,
        expiry_fee_window_ms: u64,
        expiry_fee_max_multiplier: u64,
        inventory_impact_max_rate: u64,
    }

    struct CadenceConfigUpdated has copy, drop, store {
        registry_id: 0x2::object::ID,
        propbook_underlying_id: u32,
        cadence_id: u8,
        tick_size: u64,
        admission_tick_size: u64,
        max_expiry_allocation: u64,
        initial_expiry_cash: u64,
        window_size: u64,
    }

    struct ExpiryMarketMintPausedUpdated has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        paused: bool,
    }

    struct ReferenceTickSet has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        propbook_underlying_id: u32,
        source_timestamp_ms: u64,
        spot: u64,
        tick: u64,
        onchain_timestamp_ms: u64,
    }

    struct MarketSettled has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        propbook_underlying_id: u32,
        expiry: u64,
        settlement_price: u64,
        settlement_source: u8,
        onchain_timestamp_ms: u64,
    }

    public(friend) fun emit_cadence_config_updated(arg0: 0x2::object::ID, arg1: u32, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CadenceConfigUpdated{
            registry_id            : arg0,
            propbook_underlying_id : arg1,
            cadence_id             : arg2,
            tick_size              : arg3,
            admission_tick_size    : arg4,
            max_expiry_allocation  : arg5,
            initial_expiry_cash    : arg6,
            window_size            : arg7,
        };
        0x2::event::emit<CadenceConfigUpdated>(v0);
    }

    public(friend) fun emit_ewma_config_updated(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::EwmaConfig, arg1: u64) {
        let v0 = EwmaConfigUpdated{
            alpha                : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::alpha(arg0),
            z_score_threshold    : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::z_score_threshold(arg0),
            penalty_rate         : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::penalty_rate(arg0),
            enabled              : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::ewma_config::enabled(arg0),
            onchain_timestamp_ms : arg1,
        };
        0x2::event::emit<EwmaConfigUpdated>(v0);
    }

    public(friend) fun emit_expiry_market_mint_paused_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ExpiryMarketMintPausedUpdated{
            expiry_market_id : arg0,
            paused           : arg1,
        };
        0x2::event::emit<ExpiryMarketMintPausedUpdated>(v0);
    }

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u32, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig) {
        let v0 = MarketCreated{
            expiry_market_id          : arg0,
            pool_vault_id             : arg1,
            propbook_underlying_id    : arg2,
            expiry                    : arg3,
            tick_size                 : arg4,
            admission_tick_size       : arg5,
            max_expiry_allocation     : arg6,
            initial_expiry_cash       : arg7,
            backing_buffer_lambda     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::backing_buffer_lambda(arg8),
            base_fee                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::base_fee(arg8),
            min_fee                   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::min_fee(arg8),
            min_entry_probability     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::min_entry_probability(arg8),
            max_entry_probability     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::max_entry_probability(arg8),
            expiry_fee_window_ms      : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_window_ms(arg8),
            expiry_fee_max_multiplier : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_max_multiplier(arg8),
            inventory_impact_max_rate : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(arg8),
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_settled(arg0: 0x2::object::ID, arg1: u32, arg2: u64, arg3: u64, arg4: u8, arg5: u64) {
        let v0 = MarketSettled{
            expiry_market_id       : arg0,
            propbook_underlying_id : arg1,
            expiry                 : arg2,
            settlement_price       : arg3,
            settlement_source      : arg4,
            onchain_timestamp_ms   : arg5,
        };
        0x2::event::emit<MarketSettled>(v0);
    }

    public(friend) fun emit_no_trade_window_updated(arg0: u64, arg1: u64) {
        let v0 = NoTradeWindowUpdated{
            no_trade_window_ms   : arg0,
            onchain_timestamp_ms : arg1,
        };
        0x2::event::emit<NoTradeWindowUpdated>(v0);
    }

    public(friend) fun emit_plp_fee_rates_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = PlpFeeRatesUpdated{
            plp_supply_fee_rate   : arg0,
            plp_withdraw_fee_rate : arg1,
            onchain_timestamp_ms  : arg2,
        };
        0x2::event::emit<PlpFeeRatesUpdated>(v0);
    }

    public(friend) fun emit_pricing_config_updated(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::PricingConfig, arg1: u64) {
        let v0 = PricingConfigUpdated{
            use_pyth_spot_for_forward        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::use_pyth_spot_for_forward(arg0),
            pyth_spot_freshness_ms           : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::pyth_spot_freshness_ms(arg0),
            block_scholes_price_freshness_ms : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::block_scholes_price_freshness_ms(arg0),
            block_scholes_svi_freshness_ms   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing_config::block_scholes_svi_freshness_ms(arg0),
            onchain_timestamp_ms             : arg1,
        };
        0x2::event::emit<PricingConfigUpdated>(v0);
    }

    public(friend) fun emit_protocol_frozen_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ProtocolFrozenUpdated{
            protocol_config_id : arg0,
            frozen             : arg1,
        };
        0x2::event::emit<ProtocolFrozenUpdated>(v0);
    }

    public(friend) fun emit_reference_tick_set(arg0: 0x2::object::ID, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ReferenceTickSet{
            expiry_market_id       : arg0,
            propbook_underlying_id : arg1,
            source_timestamp_ms    : arg2,
            spot                   : arg3,
            tick                   : arg4,
            onchain_timestamp_ms   : arg5,
        };
        0x2::event::emit<ReferenceTickSet>(v0);
    }

    public(friend) fun emit_strike_exposure_template_config_updated(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::StrikeExposureConfig, arg1: u64) {
        let v0 = StrikeExposureTemplateConfigUpdated{
            backing_buffer_lambda     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::backing_buffer_lambda(arg0),
            base_fee                  : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::base_fee(arg0),
            min_fee                   : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::min_fee(arg0),
            min_entry_probability     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::min_entry_probability(arg0),
            max_entry_probability     : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::max_entry_probability(arg0),
            expiry_fee_window_ms      : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_window_ms(arg0),
            expiry_fee_max_multiplier : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::expiry_fee_max_multiplier(arg0),
            inventory_impact_max_rate : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config::inventory_impact_max_rate(arg0),
            onchain_timestamp_ms      : arg1,
        };
        0x2::event::emit<StrikeExposureTemplateConfigUpdated>(v0);
    }

    public(friend) fun emit_trading_paused_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = TradingPausedUpdated{
            protocol_config_id : arg0,
            paused             : arg1,
        };
        0x2::event::emit<TradingPausedUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

