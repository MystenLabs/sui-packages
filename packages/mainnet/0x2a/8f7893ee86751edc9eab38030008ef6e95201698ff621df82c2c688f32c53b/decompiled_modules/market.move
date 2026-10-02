module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market {
    struct MarketConfig has copy, drop, store {
        price_tick_e6: u64,
        min_price_e6: u64,
        max_price_e6: u64,
        quantity_step_e6: u64,
        min_quantity_e6: u64,
        max_order_quantity_e6: u64,
        max_open_interest_e6: u64,
        max_account_position_per_outcome_e6: u64,
        taker_fee_bps: u64,
    }

    struct PythOracleSpec has copy, drop, store {
        feed_id: vector<u8>,
        comparison: u8,
        threshold_mantissa: u64,
        threshold_negative: bool,
        threshold_exponent: u8,
        target_timestamp_ms: u64,
        publish_window_ms: u64,
        max_confidence_ratio_bps: u64,
        resolve_deadline_ms: u64,
        kind: u8,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        status: u8,
        market_key: vector<u8>,
        question: vector<u8>,
        rules_hash: vector<u8>,
        metadata_uri: vector<u8>,
        open_time_ms: u64,
        match_cutoff_ms: u64,
        settlement_deadline_ms: u64,
        collateral_vault: 0x2::balance::Balance<T0>,
        yes_issued: u64,
        no_issued: u64,
        payout_yes_e6: u64,
        payout_no_e6: u64,
        fee_recipient: address,
        config: MarketConfig,
        oracle: PythOracleSpec,
    }

    struct MarketKeyPayloadV1 has copy, drop {
        collateral_type: vector<u8>,
        question: vector<u8>,
        rules_hash: vector<u8>,
        open_time_ms: u64,
        match_cutoff_ms: u64,
        settlement_deadline_ms: u64,
        fee_recipient: address,
        config: MarketConfig,
        oracle: PythOracleSpec,
    }

    struct ResolverKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: MarketConfig, arg10: PythOracleSpec, arg11: &mut 0x2::tx_context::TxContext) : Market<T0> {
        Market<T0>{
            id                     : 0x2::object::new(arg11),
            protocol_id            : arg0,
            status                 : 0,
            market_key             : arg1,
            question               : arg2,
            rules_hash             : arg3,
            metadata_uri           : arg4,
            open_time_ms           : arg5,
            match_cutoff_ms        : arg6,
            settlement_deadline_ms : arg7,
            collateral_vault       : 0x2::balance::zero<T0>(),
            yes_issued             : 0,
            no_issued              : 0,
            payout_yes_e6          : 0,
            payout_no_e6           : 0,
            fee_recipient          : arg8,
            config                 : arg9,
            oracle                 : arg10,
        }
    }

    public fun assert_mergeable<T0>(arg0: &Market<T0>) {
        assert!(!is_terminal_status(arg0.status), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_terminal());
    }

    public fun assert_open_for_trading<T0>(arg0: &Market<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_active());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.open_time_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_open());
        assert!(v0 < arg0.match_cutoff_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_closing());
    }

    public fun assert_redeemable<T0>(arg0: &Market<T0>) {
        let v0 = if (arg0.status == 3) {
            true
        } else if (arg0.status == 4) {
            true
        } else {
            arg0.status == 5
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_resolved());
    }

    public fun assert_settleable<T0>(arg0: &Market<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_active());
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.settlement_deadline_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::settlement_window_closed());
    }

    public(friend) fun bind_resolver<T0>(arg0: &mut Market<T0>, arg1: 0x2::object::ID) {
        let v0 = ResolverKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<ResolverKey>(&arg0.id, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolver_already_bound());
        let v1 = ResolverKey{dummy_field: false};
        0x2::dynamic_field::add<ResolverKey, 0x2::object::ID>(&mut arg0.id, v1, arg1);
    }

    public fun bound_resolver<T0>(arg0: &Market<T0>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ResolverKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ResolverKey>(&arg0.id, v0)) {
            let v2 = ResolverKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<ResolverKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun cancel_market<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut Market<T0>, arg3: &0x2::clock::Clock) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(arg2.protocol_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(arg2.status == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_active());
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.open_time_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_cancellable());
        let v0 = if (0x2::balance::value<T0>(&arg2.collateral_vault) == 0) {
            if (arg2.yes_issued == 0) {
                arg2.no_issued == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_cancellable());
        arg2.status = 6;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_cancelled(arg2.protocol_id, 0x2::object::id<Market<T0>>(arg2));
    }

    public fun collateral_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_vault)
    }

    public fun compute_market_key<T0>(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &MarketConfig, arg7: &PythOracleSpec) : vector<u8> {
        let v0 = MarketKeyPayloadV1{
            collateral_type        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            question               : *arg0,
            rules_hash             : *arg1,
            open_time_ms           : arg2,
            match_cutoff_ms        : arg3,
            settlement_deadline_ms : arg4,
            fee_recipient          : arg5,
            config                 : *arg6,
            oracle                 : *arg7,
        };
        let v1 = 0x2::bcs::to_bytes<MarketKeyPayloadV1>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun config<T0>(arg0: &Market<T0>) : MarketConfig {
        arg0.config
    }

    public fun create_market<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry::MarketRegistry<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: MarketConfig, arg11: PythOracleSpec, arg12: &mut 0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry::protocol_id<T0>(arg2) == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::is_paused<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::pause_market_creation_flag()), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        validate_config(&arg10);
        validate_oracle(&arg11);
        if (arg11.kind != 0) {
            assert!(arg11.feed_id == arg4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        };
        assert!(arg6 < arg7, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_times());
        assert!(arg7 < arg8, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_times());
        assert!(arg8 <= arg11.target_timestamp_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_times());
        assert!(arg11.target_timestamp_ms < arg11.resolve_deadline_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_times());
        let v0 = compute_market_key<T0>(&arg3, &arg4, arg6, arg7, arg8, arg9, &arg10, &arg11);
        let v1 = new<T0>(0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry::register_market<T0>(arg2, v0, 0x2::object::id<Market<T0>>(&v1));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_created(0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2::object::id<Market<T0>>(&v1), v0, arg3, arg4, arg5, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg6, arg7, arg8, arg10.price_tick_e6, arg10.min_price_e6, arg10.max_price_e6, arg10.quantity_step_e6, arg10.min_quantity_e6, arg10.max_order_quantity_e6, arg10.max_open_interest_e6, arg10.max_account_position_per_outcome_e6, arg10.taker_fee_bps, arg9, arg11.feed_id, arg11.comparison, arg11.threshold_mantissa, arg11.threshold_negative, arg11.threshold_exponent, arg11.target_timestamp_ms, arg11.publish_window_ms, arg11.max_confidence_ratio_bps, arg11.resolve_deadline_ms, arg11.kind);
        0x2::transfer::share_object<Market<T0>>(v1);
    }

    public fun fee_recipient<T0>(arg0: &Market<T0>) : address {
        arg0.fee_recipient
    }

    public(friend) fun group_burn_no<T0>(arg0: &mut Market<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.oracle.kind == 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::oracle_kind_mismatch());
        assert!(arg0.no_issued >= arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
        arg0.no_issued = arg0.no_issued - arg1;
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg1)
    }

    public(friend) fun group_mint_yes<T0>(arg0: &mut Market<T0>, arg1: u64) {
        assert!(arg0.oracle.kind == 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::oracle_kind_mismatch());
        arg0.yes_issued = arg0.yes_issued + arg1;
    }

    public(friend) fun group_top_up<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg1);
    }

    public fun is_terminal_status(arg0: u8) : bool {
        if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 6
        }
    }

    public fun market_key<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.market_key
    }

    public fun match_cutoff_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.match_cutoff_ms
    }

    public fun max_account_position_per_outcome_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.max_account_position_per_outcome_e6
    }

    public fun max_open_interest_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.max_open_interest_e6
    }

    public fun max_order_quantity_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.max_order_quantity_e6
    }

    public fun max_price_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.max_price_e6
    }

    public fun min_price_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.min_price_e6
    }

    public fun min_quantity_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.min_quantity_e6
    }

    public fun new_group_oracle_spec(arg0: vector<u8>, arg1: u64, arg2: u64) : PythOracleSpec {
        PythOracleSpec{
            feed_id                  : arg0,
            comparison               : 1,
            threshold_mantissa       : 0,
            threshold_negative       : false,
            threshold_exponent       : 0,
            target_timestamp_ms      : arg1,
            publish_window_ms        : 1,
            max_confidence_ratio_bps : 1,
            resolve_deadline_ms      : arg2,
            kind                     : 2,
        }
    }

    public fun new_market_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : MarketConfig {
        MarketConfig{
            price_tick_e6                       : arg0,
            min_price_e6                        : arg1,
            max_price_e6                        : arg2,
            quantity_step_e6                    : arg3,
            min_quantity_e6                     : arg4,
            max_order_quantity_e6               : arg5,
            max_open_interest_e6                : arg6,
            max_account_position_per_outcome_e6 : arg7,
            taker_fee_bps                       : arg8,
        }
    }

    public fun new_optimistic_oracle_spec(arg0: vector<u8>, arg1: u64, arg2: u64) : PythOracleSpec {
        PythOracleSpec{
            feed_id                  : arg0,
            comparison               : 1,
            threshold_mantissa       : 0,
            threshold_negative       : false,
            threshold_exponent       : 0,
            target_timestamp_ms      : arg1,
            publish_window_ms        : 1,
            max_confidence_ratio_bps : 1,
            resolve_deadline_ms      : arg2,
            kind                     : 1,
        }
    }

    public fun new_pyth_oracle_spec(arg0: vector<u8>, arg1: u8, arg2: u64, arg3: bool, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : PythOracleSpec {
        PythOracleSpec{
            feed_id                  : arg0,
            comparison               : arg1,
            threshold_mantissa       : arg2,
            threshold_negative       : arg3,
            threshold_exponent       : arg4,
            target_timestamp_ms      : arg5,
            publish_window_ms        : arg6,
            max_confidence_ratio_bps : arg7,
            resolve_deadline_ms      : arg8,
            kind                     : 0,
        }
    }

    public fun no_issued<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_issued
    }

    public fun open_time_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.open_time_ms
    }

    public fun oracle<T0>(arg0: &Market<T0>) : PythOracleSpec {
        arg0.oracle
    }

    public fun oracle_comparison(arg0: &PythOracleSpec) : u8 {
        arg0.comparison
    }

    public fun oracle_feed_id(arg0: &PythOracleSpec) : vector<u8> {
        arg0.feed_id
    }

    public fun oracle_kind<T0>(arg0: &Market<T0>) : u8 {
        arg0.oracle.kind
    }

    public fun oracle_kind_group() : u8 {
        2
    }

    public fun oracle_kind_optimistic() : u8 {
        1
    }

    public fun oracle_kind_pyth() : u8 {
        0
    }

    public fun oracle_max_confidence_ratio_bps(arg0: &PythOracleSpec) : u64 {
        arg0.max_confidence_ratio_bps
    }

    public fun oracle_publish_window_ms(arg0: &PythOracleSpec) : u64 {
        arg0.publish_window_ms
    }

    public fun oracle_resolve_deadline_ms(arg0: &PythOracleSpec) : u64 {
        arg0.resolve_deadline_ms
    }

    public fun oracle_spec_kind(arg0: &PythOracleSpec) : u8 {
        arg0.kind
    }

    public fun oracle_target_timestamp_ms(arg0: &PythOracleSpec) : u64 {
        arg0.target_timestamp_ms
    }

    public fun oracle_threshold_exponent(arg0: &PythOracleSpec) : u8 {
        arg0.threshold_exponent
    }

    public fun oracle_threshold_mantissa(arg0: &PythOracleSpec) : u64 {
        arg0.threshold_mantissa
    }

    public fun oracle_threshold_negative(arg0: &PythOracleSpec) : bool {
        arg0.threshold_negative
    }

    public fun pause_market<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut Market<T0>) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(arg2.protocol_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(arg2.status == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_active());
        arg2.status = 2;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_paused(arg2.protocol_id, 0x2::object::id<Market<T0>>(arg2), true);
    }

    public fun payout_full_e6() : u64 {
        1000000
    }

    public fun payout_half_e6() : u64 {
        500000
    }

    public fun payout_no_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.payout_no_e6
    }

    public fun payout_yes_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.payout_yes_e6
    }

    public fun price_tick_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.price_tick_e6
    }

    public fun protocol_id<T0>(arg0: &Market<T0>) : 0x2::object::ID {
        arg0.protocol_id
    }

    public fun quantity_step_e6<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.quantity_step_e6
    }

    public fun resolve_deadline_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.oracle.resolve_deadline_ms
    }

    public(friend) fun set_resolution<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!is_terminal_status(arg0.status), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_terminal());
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.settlement_deadline_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::settlement_window_open());
        let v0 = if (arg1 == 3) {
            true
        } else if (arg1 == 4) {
            true
        } else {
            arg1 == 5
        };
        assert!(v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        arg0.status = arg1;
        arg0.payout_yes_e6 = arg2;
        arg0.payout_no_e6 = arg3;
    }

    public fun settlement_deadline_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.settlement_deadline_ms
    }

    public fun status<T0>(arg0: &Market<T0>) : u8 {
        arg0.status
    }

    public fun status_cancelled() : u8 {
        6
    }

    public fun status_invalid() : u8 {
        5
    }

    public fun status_open() : u8 {
        1
    }

    public fun status_paused() : u8 {
        2
    }

    public fun status_resolved_no() : u8 {
        4
    }

    public fun status_resolved_yes() : u8 {
        3
    }

    public fun status_scheduled() : u8 {
        0
    }

    public fun taker_fee_bps<T0>(arg0: &Market<T0>) : u64 {
        arg0.config.taker_fee_bps
    }

    public fun target_timestamp_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.oracle.target_timestamp_ms
    }

    public fun unpause_market<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::AdminCap<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg2: &mut Market<T0>) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::assert_admin<T0>(arg0, arg1);
        assert!(arg2.protocol_id == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(arg2.status == 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_not_active());
        arg2.status = 0;
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_paused(arg2.protocol_id, 0x2::object::id<Market<T0>>(arg2), false);
    }

    fun validate_config(arg0: &MarketConfig) {
        assert!(arg0.price_tick_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.min_price_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.min_price_e6 < arg0.max_price_e6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_price_e6 < 1000000, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.min_price_e6 % arg0.price_tick_e6 == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_price_e6 % arg0.price_tick_e6 == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.quantity_step_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.min_quantity_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.min_quantity_e6 % arg0.quantity_step_e6 == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_order_quantity_e6 >= arg0.min_quantity_e6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_order_quantity_e6 % arg0.quantity_step_e6 == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_open_interest_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_account_position_per_outcome_e6 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.taker_fee_bps <= 100, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
    }

    fun validate_oracle(arg0: &PythOracleSpec) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.feed_id), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.comparison <= 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.publish_window_ms > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.max_confidence_ratio_bps > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
        assert!(arg0.kind <= 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_market_params());
    }

    public(friend) fun vault_join_and_issue<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg1);
        arg0.yes_issued = arg0.yes_issued + v0;
        arg0.no_issued = arg0.no_issued + v0;
    }

    public(friend) fun vault_split_and_burn<T0>(arg0: &mut Market<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        arg0.yes_issued = arg0.yes_issued - arg1;
        arg0.no_issued = arg0.no_issued - arg1;
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg1)
    }

    public(friend) fun vault_split_for_redeem<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            arg0.yes_issued = arg0.yes_issued - arg2;
        } else {
            arg0.no_issued = arg0.no_issued - arg2;
        };
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg3)
    }

    public fun yes_issued<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_issued
    }

    // decompiled from Move bytecode v7
}

