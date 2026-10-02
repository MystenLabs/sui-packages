module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::settlement {
    struct MatchAuthorizationV1 has copy, drop {
        version: u8,
        chain_identifier: vector<u8>,
        package_id: address,
        exchange_id: address,
        market_id: address,
        matcher_key_epoch: u64,
        route: u8,
        maker_order_hash: vector<u8>,
        taker_order_hash: vector<u8>,
        maker_total_filled_before_e6: u64,
        taker_total_filled_before_e6: u64,
        maker_order_state_before_hash: vector<u8>,
        taker_order_state_before_hash: vector<u8>,
        fill_quantity_e6: u64,
        authorized_at_ms: u64,
        authorization_expiration_ms: u64,
    }

    struct EffectiveOrderStateV1 has copy, drop {
        order_hash: vector<u8>,
        expiration_ms: u64,
        total_filled_quantity_e6: u64,
        total_executed_quote_e6: u64,
        maker_filled_quantity_e6: u64,
        taker_executed_quote_e6: u64,
        taker_risk_base_e6: u64,
        taker_fee_paid_e6: u64,
        cancelled: bool,
    }

    struct SidePrep has copy, drop {
        order_hash: vector<u8>,
        state_before_hash: vector<u8>,
        total_filled_before_e6: u64,
        total_quote_before_e6: u64,
        maker_filled_before_e6: u64,
        taker_quote_before_e6: u64,
        taker_risk_base_before_e6: u64,
        taker_fee_before_e6: u64,
    }

    fun apply_transfer_fill<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg4: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg5: vector<u8>, arg6: vector<u8>, arg7: &vector<u8>, arg8: &vector<u8>, arg9: &vector<u8>, arg10: address, arg11: address, arg12: address, arg13: bool, arg14: u64, arg15: &vector<u8>, arg16: u64) {
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(arg3);
        let v1 = snapshot_side<T0>(arg1, arg3, arg5);
        let v2 = snapshot_side<T0>(arg2, arg4, arg6);
        let v3 = validate_authorization_core(arg7, arg8, *arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0, &v1.order_hash, &v2.order_hash, v1.total_filled_before_e6, v2.total_filled_before_e6, &v1.state_before_hash, &v2.state_before_hash, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::match_cutoff_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::settlement_deadline_ms<T0>(arg0), arg16);
        let v4 = v3.fill_quantity_e6;
        assert!(v4 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(v4 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(v1.total_filled_before_e6 + v4 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::quantity_e6(arg3) && v2.total_filled_before_e6 + v4 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::quantity_e6(arg4), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::overfill());
        let v5 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(arg3);
        let v6 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(arg4);
        if (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg3) == 0) {
            assert!(v5 >= v6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::price_not_crossing());
        } else {
            assert!(v5 <= v6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::price_not_crossing());
        };
        let v7 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::maker_quote_delta(v1.maker_filled_before_e6, v4, v5);
        assert!(v7 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_quote());
        let v8 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::taker_fee_bps<T0>(arg0);
        assert!(v8 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::max_fee_bps(arg4), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
        let v9 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::risk_base_delta(v5, v4);
        let v10 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::taker_fee_delta(v2.taker_risk_base_before_e6, v9, v2.taker_fee_before_e6, v8);
        assert!(v2.taker_fee_before_e6 + v10 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::fee_cap_upper_bound(v2.taker_risk_base_before_e6 + v9, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::max_fee_bps(arg4)), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
        check_cumulative_limit(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg3), v1.total_quote_before_e6 + v7, v1.total_filled_before_e6 + v4, v5);
        check_cumulative_limit(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg4), v2.total_quote_before_e6 + v7, v2.total_filled_before_e6 + v4, v6);
        let v11 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        let v12 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg4) == 0;
        if (v12) {
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::settleable_value<T0>(arg2) >= v7 + v10, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v11, v0) >= v4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v11, v0) + v4 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_account_position_per_outcome_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::position_limit_exceeded());
        } else {
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::settleable_value<T0>(arg1) >= v7, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
            assert!(v7 >= v10, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v11, v0) >= v4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v11, v0) + v4 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_account_position_per_outcome_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::position_limit_exceeded());
        };
        if (v12) {
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg2, v7));
            if (v10 > 0) {
                0x2::balance::send_funds<T0>(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg2, v10), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::fee_recipient<T0>(arg0));
            };
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg1, v11, v0, v4);
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg2, v11, v0, v4);
        } else {
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg1, v7));
            if (v10 > 0) {
                0x2::balance::send_funds<T0>(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg2, v10), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::fee_recipient<T0>(arg0));
            };
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg2, v11, v0, v4);
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg1, v11, v0, v4);
        };
        update_order_state<T0>(arg1, arg3, v1.order_hash, v4, v7, true, 0, 0);
        update_order_state<T0>(arg2, arg4, v2.order_hash, v4, v7, false, v9, v10);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_trade_settled(match_id(arg7), v3.matcher_key_epoch, 0, v11, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::new_trade_leg(0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg1), v1.order_hash, v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg3), v1.state_before_hash, v1.total_filled_before_e6, v1.total_filled_before_e6 + v4, v5, v7), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::new_trade_leg(0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg2), v2.order_hash, v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg4), v2.state_before_hash, v2.total_filled_before_e6, v2.total_filled_before_e6 + v4, v5, v7), v4, v10, arg16, 0, 0);
    }

    public fun auth_authorized_at_ms(arg0: &MatchAuthorizationV1) : u64 {
        arg0.authorized_at_ms
    }

    public fun auth_fill_quantity_e6(arg0: &MatchAuthorizationV1) : u64 {
        arg0.fill_quantity_e6
    }

    public fun auth_maker_order_hash(arg0: &MatchAuthorizationV1) : vector<u8> {
        arg0.maker_order_hash
    }

    public fun auth_maker_total_filled_before_e6(arg0: &MatchAuthorizationV1) : u64 {
        arg0.maker_total_filled_before_e6
    }

    public fun auth_matcher_key_epoch(arg0: &MatchAuthorizationV1) : u64 {
        arg0.matcher_key_epoch
    }

    public fun auth_route(arg0: &MatchAuthorizationV1) : u8 {
        arg0.route
    }

    public fun auth_taker_order_hash(arg0: &MatchAuthorizationV1) : vector<u8> {
        arg0.taker_order_hash
    }

    public fun auth_taker_total_filled_before_e6(arg0: &MatchAuthorizationV1) : u64 {
        arg0.taker_total_filled_before_e6
    }

    fun check_cumulative_limit(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 == 0) {
            assert!(arg1 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::buy_quote_upper_bound(arg2, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::limit_violated());
        } else {
            assert!(arg1 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::sell_quote_lower_bound(arg2, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::limit_violated());
        };
    }

    fun check_order_domain(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg1: &vector<u8>, arg2: address, arg3: address, arg4: address) {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::chain_identifier(arg0) == *arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::package_id(arg0) == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::exchange_id(arg0) == arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::market_id(arg0) == arg4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
    }

    public fun decode_match_authorization(arg0: vector<u8>) : MatchAuthorizationV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 == 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = &mut v0;
        let v5 = &mut v0;
        let v6 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v6 <= 2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        let v7 = &mut v0;
        let v8 = &mut v0;
        let v9 = &mut v0;
        let v10 = &mut v0;
        let v11 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v11), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        MatchAuthorizationV1{
            version                       : v1,
            chain_identifier              : peel_fixed_bytes(v2, 4),
            package_id                    : peel_address_vec(v3),
            exchange_id                   : peel_address_vec(v4),
            market_id                     : peel_address_vec(v5),
            matcher_key_epoch             : 0x2::bcs::peel_u64(&mut v0),
            route                         : v6,
            maker_order_hash              : peel_fixed_bytes(v7, 32),
            taker_order_hash              : peel_fixed_bytes(v8, 32),
            maker_total_filled_before_e6  : 0x2::bcs::peel_u64(&mut v0),
            taker_total_filled_before_e6  : 0x2::bcs::peel_u64(&mut v0),
            maker_order_state_before_hash : peel_fixed_bytes(v9, 32),
            taker_order_state_before_hash : peel_fixed_bytes(v10, 32),
            fill_quantity_e6              : 0x2::bcs::peel_u64(&mut v0),
            authorized_at_ms              : 0x2::bcs::peel_u64(&mut v0),
            authorization_expiration_ms   : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    fun emit_complementary_event<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &SidePrep, arg4: &SidePrep, arg5: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg6: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg7: &vector<u8>, arg8: &MatchAuthorizationV1, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8) {
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(arg5);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_trade_settled(match_id(arg7), arg8.matcher_key_epoch, arg14, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::new_trade_leg(arg1, arg3.order_hash, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(arg5), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg5), arg3.state_before_hash, arg3.total_filled_before_e6, arg3.total_filled_before_e6 + arg9, v0, arg10), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::new_trade_leg(arg2, arg4.order_hash, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(arg6), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(arg6), arg4.state_before_hash, arg4.total_filled_before_e6, arg4.total_filled_before_e6 + arg9, 1000000 - v0, arg11), arg9, arg12, arg13, arg14, arg9);
    }

    public fun initial_order_state_hash(arg0: vector<u8>, arg1: u64) : vector<u8> {
        order_state_hash_from_parts(arg0, arg1, 0, 0, 0, 0, 0, 0, false)
    }

    public fun match_id(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"FATHOM_MATCH_V1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun order_state_hash(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState) : vector<u8> {
        order_state_hash_from_parts(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_order_hash(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_expiration_ms(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_total_filled(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_total_executed_quote(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_maker_filled(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_executed_quote(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_risk_base(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_fee_paid(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_cancelled(arg0))
    }

    public fun order_state_hash_from_parts(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : vector<u8> {
        let v0 = EffectiveOrderStateV1{
            order_hash               : arg0,
            expiration_ms            : arg1,
            total_filled_quantity_e6 : arg2,
            total_executed_quote_e6  : arg3,
            maker_filled_quantity_e6 : arg4,
            taker_executed_quote_e6  : arg5,
            taker_risk_base_e6       : arg6,
            taker_fee_paid_e6        : arg7,
            cancelled                : arg8,
        };
        let v1 = b"FATHOM_ORDER_STATE_V1";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<EffectiveOrderStateV1>(&v0));
        0x2::hash::blake2b256(&v1)
    }

    fun peel_address_vec(arg0: &mut 0x2::bcs::BCS) : address {
        0x2::address::from_bytes(peel_fixed_bytes(arg0, 32))
    }

    fun peel_fixed_bytes(arg0: &mut 0x2::bcs::BCS, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::peel_vec_u8(arg0);
        assert!(0x1::vector::length<u8>(&v0) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        v0
    }

    fun prepare_complementary<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: &vector<u8>, arg8: &vector<u8>, arg9: vector<u8>, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: bool, arg16: u64, arg17: &vector<u8>, arg18: u8, arg19: u8, arg20: bool, arg21: u64) : (u64, u64, u64, u64, SidePrep, SidePrep, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, MatchAuthorizationV1) {
        assert!(!arg20, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg1) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::self_trade());
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(*arg3);
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(*arg5);
        check_order_domain(&v0, &arg9, arg10, arg11, arg12);
        check_order_domain(&v1, &arg9, arg10, arg11, arg12);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v0) == arg13 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v1) == arg14, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v0) != 3 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v1) != 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unsupported_order_type());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v0) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(&v0) == arg19 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(&v1) == arg19, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
        validate_order_against_market<T0>(arg0, &v0);
        validate_order_against_market<T0>(arg0, &v1);
        let v2 = prepare_side<T0>(arg1, &v0, arg3, arg4, arg21);
        let v3 = prepare_side<T0>(arg2, &v1, arg5, arg6, arg21);
        let v4 = validate_authorization_core(arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18, &v2.order_hash, &v3.order_hash, v2.total_filled_before_e6, v3.total_filled_before_e6, &v2.state_before_hash, &v3.state_before_hash, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::match_cutoff_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::settlement_deadline_ms<T0>(arg0), arg21);
        let v5 = v4.fill_quantity_e6;
        assert!(v5 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(v5 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(v2.total_filled_before_e6 + v5 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::quantity_e6(&v0) && v3.total_filled_before_e6 + v5 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::quantity_e6(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::overfill());
        let v6 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(&v0);
        let v7 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(&v1);
        if (arg19 == 0) {
            assert!(v6 + v7 >= 1000000, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::price_not_crossing());
        } else {
            assert!(v6 + v7 <= 1000000, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::price_not_crossing());
        };
        let v8 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::maker_quote_delta(v2.maker_filled_before_e6, v5, v6);
        assert!(v8 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_quote());
        let v9 = v5 - v8;
        assert!(v9 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_quote());
        let v10 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::taker_fee_bps<T0>(arg0);
        assert!(v10 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::max_fee_bps(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
        let v11 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::risk_base_delta(v6, v5);
        let v12 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::taker_fee_delta(v3.taker_risk_base_before_e6, v11, v3.taker_fee_before_e6, v10);
        assert!(v3.taker_fee_before_e6 + v12 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::fee_cap_upper_bound(v3.taker_risk_base_before_e6 + v11, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::max_fee_bps(&v1)), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
        check_cumulative_limit(arg19, v2.total_quote_before_e6 + v8, v2.total_filled_before_e6 + v5, v6);
        check_cumulative_limit(arg19, v3.total_quote_before_e6 + v9, v3.total_filled_before_e6 + v5, v7);
        (v5, v8, v9, v12, v2, v3, v0, v1, v4)
    }

    fun prepare_side<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u64) : SidePrep {
        snapshot_side<T0>(arg0, arg1, verify_order_side<T0>(arg0, arg1, arg2, arg3, arg4))
    }

    public fun route_merge() : u8 {
        2
    }

    public fun route_mint() : u8 {
        1
    }

    public fun route_transfer() : u8 {
        0
    }

    public(friend) fun settle_complementary_merge_core<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: bool, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg19);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_settleable<T0>(arg0, arg19);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9) = prepare_complementary<T0>(arg0, arg1, arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &arg17, 2, 1, arg18, v0);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = v6;
        let v14 = v5;
        let v15 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        let v16 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v12);
        let v17 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v11);
        assert!(v3 >= v4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::fee_cap_exceeded());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v15, v16) >= v1 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v15, v17) >= v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg1, v15, v16, v1);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg2, v15, v17, v1);
        let v18 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::vault_split_and_burn<T0>(arg0, v1);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg1, 0x2::balance::split<T0>(&mut v18, v2));
        if (v4 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v18, v4), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::fee_recipient<T0>(arg0));
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg2, v18);
        update_order_state<T0>(arg1, &v12, v14.order_hash, v1, v2, true, 0, 0);
        update_order_state<T0>(arg2, &v11, v13.order_hash, v1, v3, false, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::risk_base_delta(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(&v12), v1), v4);
        emit_complementary_event<T0>(arg0, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg1), 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg2), &v14, &v13, &v12, &v11, &arg7, &v10, v1, v2, v3, v4, v0, 2);
    }

    public(friend) fun settle_complementary_mint_core<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: bool, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg19);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_settleable<T0>(arg0, arg19);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9) = prepare_complementary<T0>(arg0, arg1, arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, &arg17, 1, 0, arg18, v0);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = v6;
        let v14 = v5;
        let v15 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        let v16 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v12);
        let v17 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v11);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::settleable_value<T0>(arg1) >= v2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::settleable_value<T0>(arg2) >= v3 + v4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::collateral_value<T0>(arg0) + v1 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_open_interest_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::open_interest_exceeded());
        let v18 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_account_position_per_outcome_e6<T0>(arg0);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v15, v16) + v1 <= v18 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v15, v17) + v1 <= v18, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::position_limit_exceeded());
        let v19 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg1, v2);
        0x2::balance::join<T0>(&mut v19, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg2, v3));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::vault_join_and_issue<T0>(arg0, v19);
        if (v4 > 0) {
            0x2::balance::send_funds<T0>(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_for_settlement<T0>(arg2, v4), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::fee_recipient<T0>(arg0));
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg1, v15, v16, v1);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg2, v15, v17, v1);
        update_order_state<T0>(arg1, &v12, v14.order_hash, v1, v2, true, 0, 0);
        update_order_state<T0>(arg2, &v11, v13.order_hash, v1, v3, false, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::math::risk_base_delta(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(&v12), v1), v4);
        emit_complementary_event<T0>(arg0, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg1), 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg2), &v14, &v13, &v12, &v11, &arg7, &v10, v1, v2, v3, v4, v0, 1);
    }

    public(friend) fun settle_transfer_chain_core<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: vector<u8>, arg12: address, arg13: address, arg14: address, arg15: address, arg16: address, arg17: bool, arg18: u64, arg19: vector<u8>, arg20: bool, arg21: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg21);
        assert!(!arg20, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_settleable<T0>(arg0, arg21);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg1) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::self_trade());
        let v1 = 0x1::vector::length<vector<u8>>(&arg9);
        assert!(v1 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        let v2 = if (0x1::vector::length<vector<u8>>(&arg10) == v1) {
            if (0x1::vector::length<u64>(&arg7) == v1) {
                0x1::vector::length<u64>(&arg8) == v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        let v3 = if (0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4)) {
            if (0x1::vector::length<vector<u8>>(&arg5) == 0x1::vector::length<vector<u8>>(&arg6)) {
                if (0x1::vector::length<vector<u8>>(&arg3) > 0) {
                    0x1::vector::length<vector<u8>>(&arg5) > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
        let v4 = 0x1::vector::empty<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>();
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v7 = *0x1::vector::borrow<vector<u8>>(&arg3, v6);
            let v8 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(v7);
            check_order_domain(&v8, &arg11, arg12, arg13, arg14);
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v8) == arg15, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v8) != 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unsupported_order_type());
            validate_order_against_market<T0>(arg0, &v8);
            0x1::vector::push_back<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&mut v4, v8);
            0x1::vector::push_back<vector<u8>>(&mut v5, verify_order_side<T0>(arg1, &v8, &v7, 0x1::vector::borrow<vector<u8>>(&arg4, v6), v0));
            v6 = v6 + 1;
        };
        let v9 = 0x1::vector::empty<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>();
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<vector<u8>>(&arg5)) {
            let v12 = *0x1::vector::borrow<vector<u8>>(&arg5, v11);
            let v13 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(v12);
            check_order_domain(&v13, &arg11, arg12, arg13, arg14);
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v13) == arg16, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v13) != 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unsupported_order_type());
            validate_order_against_market<T0>(arg0, &v13);
            0x1::vector::push_back<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&mut v9, v13);
            0x1::vector::push_back<vector<u8>>(&mut v10, verify_order_side<T0>(arg2, &v13, &v12, 0x1::vector::borrow<vector<u8>>(&arg6, v11), v0));
            v11 = v11 + 1;
        };
        let v14 = 0;
        while (v14 < v1) {
            let v15 = *0x1::vector::borrow<u64>(&arg7, v14);
            let v16 = *0x1::vector::borrow<u64>(&arg8, v14);
            assert!(v15 < 0x1::vector::length<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&v4) && v16 < 0x1::vector::length<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&v9), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_auth_bytes());
            let v17 = 0x1::vector::borrow<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&v4, v15);
            let v18 = 0x1::vector::borrow<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1>(&v9, v16);
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(v17) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(v18), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(v17) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(v18), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
            apply_transfer_fill<T0>(arg0, arg1, arg2, v17, v18, *0x1::vector::borrow<vector<u8>>(&v5, v15), *0x1::vector::borrow<vector<u8>>(&v10, v16), 0x1::vector::borrow<vector<u8>>(&arg9, v14), 0x1::vector::borrow<vector<u8>>(&arg10, v14), &arg11, arg12, arg13, arg14, arg17, arg18, &arg19, v0);
            v14 = v14 + 1;
        };
    }

    public(friend) fun settle_transfer_core<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: address, arg11: address, arg12: address, arg13: address, arg14: address, arg15: bool, arg16: u64, arg17: vector<u8>, arg18: bool, arg19: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg19);
        assert!(!arg18, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_settleable<T0>(arg0, arg19);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg1) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::owner<T0>(arg2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::self_trade());
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(arg3);
        let v2 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::decode_order(arg5);
        check_order_domain(&v1, &arg9, arg10, arg11, arg12);
        check_order_domain(&v2, &arg9, arg10, arg11, arg12);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v1) == arg13, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_id(&v2) == arg14, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v1) != 3 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_type(&v2) != 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unsupported_order_type());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v1) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::outcome(&v2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(&v1) != 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::side(&v2), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_pair_mismatch());
        validate_order_against_market<T0>(arg0, &v1);
        validate_order_against_market<T0>(arg0, &v2);
        let v3 = verify_order_side<T0>(arg1, &v1, &arg3, &arg4, v0);
        let v4 = verify_order_side<T0>(arg2, &v2, &arg5, &arg6, v0);
        apply_transfer_fill<T0>(arg0, arg1, arg2, &v1, &v2, v3, v4, &arg7, &arg8, &arg9, arg10, arg11, arg12, arg15, arg16, &arg17, v0);
    }

    fun snapshot_side<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg2: vector<u8>) : SidePrep {
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_order_key(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_epoch(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::session_key_id(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::nonce(arg1));
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::order_states<T0>(arg0);
        if (0x2::table::contains<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(v1, v0)) {
            let v3 = 0x2::table::borrow<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderKey, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderState>(v1, v0);
            assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_order_hash(v3) == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::nonce_conflict());
            assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_cancelled(v3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_cancelled());
            SidePrep{order_hash: arg2, state_before_hash: order_state_hash(v3), total_filled_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_total_filled(v3), total_quote_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_total_executed_quote(v3), maker_filled_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_maker_filled(v3), taker_quote_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_executed_quote(v3), taker_risk_base_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_risk_base(v3), taker_fee_before_e6: 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::state_taker_fee_paid(v3)}
        } else {
            SidePrep{order_hash: arg2, state_before_hash: initial_order_state_hash(arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::expiration_ms(arg1)), total_filled_before_e6: 0, total_quote_before_e6: 0, maker_filled_before_e6: 0, taker_quote_before_e6: 0, taker_risk_base_before_e6: 0, taker_fee_before_e6: 0}
        }
    }

    fun update_order_state<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::apply_fill(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::bind_or_check_order_state<T0>(arg0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::new_order_key(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_epoch(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::session_key_id(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::nonce(arg1)), arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::expiration_ms(arg1)), arg3, arg4, arg5, arg6, arg7);
    }

    public fun validate_authorization_core(arg0: &vector<u8>, arg1: &vector<u8>, arg2: vector<u8>, arg3: address, arg4: address, arg5: address, arg6: bool, arg7: u64, arg8: &vector<u8>, arg9: u8, arg10: &vector<u8>, arg11: &vector<u8>, arg12: u64, arg13: u64, arg14: &vector<u8>, arg15: &vector<u8>, arg16: u64, arg17: u64, arg18: u64) : MatchAuthorizationV1 {
        let v0 = decode_match_authorization(*arg0);
        assert!(v0.chain_identifier == arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(v0.package_id == arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(v0.exchange_id == arg4, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(v0.market_id == arg5, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_domain());
        assert!(arg6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::matcher_disabled());
        assert!(v0.matcher_key_epoch == arg7, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::epoch_mismatch());
        let v1 = if (0x1::vector::length<u8>(arg1) == 64) {
            let v2 = match_id(arg0);
            0x2::ed25519::ed25519_verify(arg1, arg8, &v2)
        } else {
            false
        };
        assert!(v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_signature());
        assert!(v0.route == arg9, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_route());
        assert!(v0.maker_order_hash == *arg10 && v0.taker_order_hash == *arg11, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_order_mismatch());
        assert!(v0.maker_total_filled_before_e6 == arg12 && v0.taker_total_filled_before_e6 == arg13, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_state_mismatch());
        assert!(v0.maker_order_state_before_hash == *arg14 && v0.taker_order_state_before_hash == *arg15, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_state_mismatch());
        if (v0.authorized_at_ms < arg16) {
            assert!(arg18 < v0.authorization_expiration_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_window());
            assert!(v0.authorization_expiration_ms <= arg17, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_window());
            return v0
        } else {
            abort if (arg18 >= arg16) {
                0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_window_expired()
            } else {
                0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::auth_window()
            }
        };
    }

    fun validate_order_against_market<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1) {
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::limit_price_e6(arg1);
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::min_price_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_order_price());
        assert!(v0 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_price_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_order_price());
        assert!(v0 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::price_tick_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_order_price());
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::quantity_e6(arg1);
        assert!(v1 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::min_quantity_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(v1 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_order_quantity_e6<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(v1 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
    }

    fun verify_order_side<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg1: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::OrderV1, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u64) : vector<u8> {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::account_epoch(arg1) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::order_epoch<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_epoch_mismatch());
        let v0 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::session_key_id(arg1);
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::session_keys<T0>(arg0);
        assert!(0x2::table::contains<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(v1, v0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_not_found());
        let v2 = 0x2::table::borrow<vector<u8>, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::SessionKey>(v1, v0);
        let v3 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::order_hash(arg2);
        let v4 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::key_public_key(v2);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::verify_order_signature(&v4, &v3, arg3), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_signature());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::assert_session_key_authorizes(v2, arg1, arg4);
        assert!(arg4 < 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order::expiration_ms(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::order_expired());
        v3
    }

    // decompiled from Move bytecode v7
}

