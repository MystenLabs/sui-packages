module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::position {
    public fun merge<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::assert_owner<T0>(arg1, arg3);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::protocol_id<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_mergeable<T0>(arg0);
        assert!(arg2 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(arg2 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        let v0 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v0, 0) >= arg2 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v0, 1) >= arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg1, v0, 0, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg1, v0, 1, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::vault_split_and_burn<T0>(arg0, arg2));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_position_merged(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0), v0, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg1), arg2, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::collateral_value<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::yes_issued<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::no_issued<T0>(arg0));
    }

    fun payout_per_share_e6<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: u8) : u64 {
        if (arg1 == 0) {
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_yes_e6<T0>(arg0)
        } else {
            0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_no_e6<T0>(arg0)
        }
    }

    public fun redeem<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::assert_owner<T0>(arg1, arg4);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::protocol_id<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_redeemable<T0>(arg0);
        assert!(arg2 <= 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(arg3 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(arg3 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        let v0 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v0, arg2) >= arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_position());
        let v1 = payout_per_share_e6<T0>(arg0, arg2);
        redeem_into_collateral<T0>(arg0, arg1, v0, arg2, arg3, v1);
    }

    public fun redeem_all<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: u8) {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::protocol_id<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_redeemable<T0>(arg0);
        assert!(arg2 <= 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        let v0 = payout_per_share_e6<T0>(arg0, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0);
        let v2 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg1, v1, arg2);
        if (v2 == 0) {
            return
        };
        assert!(v2 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg0) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        redeem_into_collateral<T0>(arg0, arg1, v1, arg2, v2, v0);
    }

    fun redeem_into_collateral<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = (((arg4 as u128) * (arg5 as u128) / 1000000) as u64);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_position<T0>(arg1, arg2, arg3, arg4);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_collateral<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::vault_split_for_redeem<T0>(arg0, arg3, arg4, v0));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_position_redeemed(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0), arg2, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg1), arg3, arg4, v0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::collateral_value<T0>(arg0));
    }

    public fun split<T0>(arg0: &0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>, arg1: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg2: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::assert_owner<T0>(arg2, arg5);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::assert_same_protocol<T0>(arg2, arg0);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg1) == 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::ProtocolConfig<T0>>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::wrong_protocol());
        assert!(!0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::is_paused<T0>(arg0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::admin::pause_deposit_and_split_flag()), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::paused());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::assert_open_for_trading<T0>(arg1, arg4);
        assert!(arg3 > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::zero_amount());
        assert!(arg3 % 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::quantity_step_e6<T0>(arg1) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_quantity());
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::collateral_value<T0>(arg2) >= arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::insufficient_collateral());
        let v0 = 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg1);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::collateral_value<T0>(arg1) + arg3 <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_open_interest_e6<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::open_interest_exceeded());
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::max_account_position_per_outcome_e6<T0>(arg1);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v0, 0) + arg3 <= v1 && 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::position_of<T0>(arg2, v0, 1) + arg3 <= v1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::position_limit_exceeded());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::vault_join_and_issue<T0>(arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::debit_collateral<T0>(arg2, arg3));
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg2, v0, 0, arg3);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::credit_position<T0>(arg2, v0, 1, arg3);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_position_split(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg1), v0, 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::account::TradingAccount<T0>>(arg2), arg3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::collateral_value<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::yes_issued<T0>(arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::no_issued<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

