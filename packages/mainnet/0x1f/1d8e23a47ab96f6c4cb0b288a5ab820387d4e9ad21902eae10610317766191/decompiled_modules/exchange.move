module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::exchange {
    struct LiquidatorPaidForAccountSettlementEvnet has copy, drop {
        id: 0x2::object::ID,
        liquidator: address,
        account: address,
        amount: u128,
    }

    struct SettlementAmountNotPaidCompletelyEvent has copy, drop {
        account: address,
        amount: u128,
    }

    struct SettlementAmtDueByMakerEvent has copy, drop {
        account: address,
        amount: u128,
    }

    struct AccountSettlementUpdateEvent has copy, drop {
        account: address,
        balance: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition,
        settlementIsPositive: bool,
        settlementAmount: u128,
        price: u128,
        fundingRate: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::Number,
    }

    struct LiquidatorPaidForAccountSettlementEvnetV2 has copy, drop {
        tx_index: u128,
        id: 0x2::object::ID,
        liquidator: address,
        account: address,
        amount: u128,
    }

    struct SettlementAmountNotPaidCompletelyEventV2 has copy, drop {
        tx_index: u128,
        account: address,
        amount: u128,
    }

    struct SettlementAmtDueByMakerEventV2 has copy, drop {
        tx_index: u128,
        account: address,
        amount: u128,
    }

    struct AccountSettlementUpdateEventV2 has copy, drop {
        tx_index: u128,
        account: address,
        balance: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition,
        settlementIsPositive: bool,
        settlementAmount: u128,
        price: u128,
        fundingRate: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::Number,
    }

    entry fun add_margin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg4: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: u128, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_sub_accounts_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg4, arg8);
        let v1 = arg7 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg5, arg0);
        let v2 = 0x2::tx_context::sender(arg9);
        assert!(v2 == arg6 || 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::is_sub_account_v2(arg3, arg6, v2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::sender_does_not_have_permission_for_account(2));
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        assert!(v1 > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::margin_amount_must_be_greater_than_zero());
        assert!(0x2::table::contains<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_position_in_table(2));
        let v3 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        let v4 = 0x2::table::borrow_mut<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::qPos(*v4) > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_position_size_is_zero(2));
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, arg6, 0x2::object::id_to_address(&v3), v1, 3, v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_margin(v4, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::margin(*v4) + v1);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::emit_position_update_event(*v4, v2, 1, v0);
        apply_funding_rate<T0>(v0, arg2, arg1, arg6, arg6, 0, 2);
    }

    entry fun adjust_leverage<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg4: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: u128, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_sub_accounts_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg4, arg8);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg5, arg0);
        let v1 = 0x2::tx_context::sender(arg9);
        assert!(v1 == arg6 || 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::is_sub_account_v2(arg3, arg6, v1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::sender_does_not_have_permission_for_account(2));
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        let v2 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::round_down(arg7 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
        assert!(v2 > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::leverage_can_not_be_set_to_zero());
        let v3 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::priceOracle_v2(arg1);
        let v4 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::checks_v2(arg1);
        let v5 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        assert!(0x2::table::contains<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_position_in_table(2));
        apply_funding_rate<T0>(v0, arg2, arg1, arg6, arg6, 0, 2);
        let v6 = 0x2::table::borrow_mut<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        let v7 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::margin(*v6);
        let v8 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_math::get_target_margin(*v6, v2, v3);
        if (v7 > v8) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, 0x2::object::id_to_address(&v5), arg6, v7 - v8, 2, v0);
        } else if (v7 < v8) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, arg6, 0x2::object::id_to_address(&v5), v8 - v7, 3, v0);
        };
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_mro(v6, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_div(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), v2));
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_margin(v6, v8);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::verify_oi_open_for_account(v4, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::mro(*v6), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::oiOpen(*v6), 0);
        let v9 = *0x2::table::borrow<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::verify_collat_checks(*0x2::table::borrow<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6), v9, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::imr_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::mmr_v2(arg1), v3, 0, 0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::emit_position_update_event(v9, v1, 3, v0);
    }

    fun apply_funding_rate<T0>(arg0: u128, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg3: address, arg4: address, arg5: u8, arg6: u64) {
        let v0 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg2));
        let v1 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::fundingRate_v2(arg2);
        let v2 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index(v1);
        let v3 = 0x2::table::borrow_mut<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg2), arg4);
        let v4 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::index(*v3);
        let v5 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::margin(*v3);
        let v6 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::qPos(*v3);
        let v7 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::oiOpen(*v3);
        let v8 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::isPosPositive(*v3);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_index(v3, v2);
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::are_indexes_equal(v4, v2) || v6 == 0) {
            return
        };
        let v9 = if (v8) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::sub(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index_value(v4), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index_value(v2))
        } else {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::sub(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index_value(v2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index_value(v4))
        };
        let v10 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_mul(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(v9), v6);
        let v11 = v10;
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::gt_uint(v9, 0)) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_margin(v3, v5 + v10);
        } else {
            if (arg5 == 0 || arg5 == 1) {
                assert!(v5 >= v10, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::funding_due_exceeds_margin(arg6));
            } else if (arg5 == 2) {
                if (v5 < v10) {
                    let v12 = v10 - v5;
                    0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg1, arg3, 0x2::object::id_to_address(&v0), v12, 1, arg0);
                    let v13 = LiquidatorPaidForAccountSettlementEvnetV2{
                        tx_index   : arg0,
                        id         : v0,
                        liquidator : arg3,
                        account    : arg4,
                        amount     : v12,
                    };
                    0x2::event::emit<LiquidatorPaidForAccountSettlementEvnetV2>(v13);
                    v11 = v10 - v12;
                };
            } else if (v5 < v10) {
                if (v8) {
                    0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_oiOpen(v3, v7 + v10);
                } else if (v10 > v7) {
                    0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_oiOpen(v3, 0);
                    let v14 = SettlementAmountNotPaidCompletelyEventV2{
                        tx_index : arg0,
                        account  : arg4,
                        amount   : v10 - v7,
                    };
                    0x2::event::emit<SettlementAmountNotPaidCompletelyEventV2>(v14);
                } else {
                    0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_oiOpen(v3, v7 - v10);
                };
                let v15 = SettlementAmtDueByMakerEventV2{
                    tx_index : arg0,
                    account  : arg4,
                    amount   : v10,
                };
                0x2::event::emit<SettlementAmtDueByMakerEventV2>(v15);
                v11 = 0;
            };
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_margin(v3, v5 - v11);
        };
        let v16 = AccountSettlementUpdateEventV2{
            tx_index             : arg0,
            account              : arg4,
            balance              : *v3,
            settlementIsPositive : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::sign(v9),
            settlementAmount     : v11,
            price                : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::priceOracle_v2(arg2),
            fundingRate          : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::rate(v1),
        };
        0x2::event::emit<AccountSettlementUpdateEventV2>(v16);
    }

    entry fun close_position<T0>(arg0: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg0) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg2, arg3);
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_not_delisted());
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg0), v1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_position_in_table(2));
        let v2 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg0));
        let v3 = 0x2::object::id_to_address(&v2);
        let v4 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delistingPrice_v2(arg0);
        apply_funding_rate<T0>(v0, arg1, arg0, v1, v1, 0, 2);
        let v5 = 0x2::table::borrow_mut<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg0), v1);
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::qPos(*v5) > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_position_size_is_zero(2));
        let v6 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_math::get_margin_left(*v5, v4, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_balance_v2<T0>(arg1, v3));
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_qPos(v5, 0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg1, v3, v1, v6, 2, v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::emit_position_closed_event(v2, v1, v6, v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::emit_position_update_event(*v5, v1, 4, v0);
    }

    entry fun create_perpetual<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: vector<u128>, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u128, arg19: address, arg20: address, arg21: u64, arg22: vector<u8>, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::initialize(arg2, arg13 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg14 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg15 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg16 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg18 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg19, arg20, arg3 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg4 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg5 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg6 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg7 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg8 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg9 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg10 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg11 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg17 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg21, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::to_1x9_vec(arg12), arg22, arg23);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg1), 0x2::object::id_to_address(&v0));
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg1), arg19);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg1), arg20);
    }

    entry fun deleverage<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg4: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg5: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::DeleveragingCap, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: address, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg4, arg11);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg6, arg0);
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::is_trading_permitted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::startTime_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_not_started());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_delevearging_operator_validity_v2(arg3, arg5);
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg7);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg8);
        apply_funding_rate<T0>(v0, arg2, arg1, v1, arg7, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::tradeType(), 0);
        apply_funding_rate<T0>(v0, arg2, arg1, v1, arg8, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::tradeType(), 1);
        let v3 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::trade(v1, arg1, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::pack_trade_data(arg7, arg8, arg9 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg10), v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_trade_margin<T0>(arg2, 0x2::object::id_to_address(&v2), arg7, arg8, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::makerFundsFlow(v3), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_adl::takerFundsFlow(v3), v0);
    }

    entry fun liquidate<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg4: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: u128, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_sub_accounts_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg4, arg11);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg5, arg0);
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::is_trading_permitted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::startTime_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_not_started());
        let v1 = 0x2::tx_context::sender(arg12);
        assert!(v1 == arg7 || 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::is_sub_account_v2(arg3, arg7, v1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::sender_does_not_have_permission_for_account(1));
        assert!(arg7 != arg6, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::self_liquidation_not_allowed());
        let v2 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        let v3 = 0x2::object::id_to_address(&v2);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg7);
        apply_funding_rate<T0>(v0, arg2, arg1, arg7, arg6, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::tradeType(), 0);
        apply_funding_rate<T0>(v0, arg2, arg1, arg7, arg7, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::tradeType(), 1);
        let v4 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::trade(v1, arg1, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::pack_trade_data(arg7, arg6, arg8 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg9 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg10), v0);
        let v5 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::liquidatorPortion(v4);
        let v6 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::insurancePoolPortion(v4);
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::gt_uint(v5, 0)) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, v3, arg7, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(v5), 2, v0);
        } else if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::lt_uint(v5, 0)) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, arg7, v3, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(v5), 1, v0);
        };
        if (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::gt_uint(v6, 0)) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, v3, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::insurancePool_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::signed_number::value(v6), 2, v0);
        };
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_trade_margin<T0>(arg2, v3, arg6, arg7, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::makerFundsFlow(v4), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_liquidation::takerFundsFlow(v4), v0);
    }

    entry fun remove_margin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg4: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: u128, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_sub_accounts_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg4, arg8);
        let v1 = arg7 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg5, arg0);
        let v2 = 0x2::tx_context::sender(arg9);
        assert!(v2 == arg6 || 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::is_sub_account_v2(arg3, arg6, v2), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::sender_does_not_have_permission_for_account(2));
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        assert!(v1 > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::margin_amount_must_be_greater_than_zero());
        let v3 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::priceOracle_v2(arg1);
        assert!(0x2::table::contains<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_has_no_position_in_table(2));
        let v4 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        let v5 = *0x2::table::borrow<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        let v6 = 0x2::table::borrow_mut<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::qPos(*v6) > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::user_position_size_is_zero(2));
        assert!(v1 <= 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_math::get_max_removeable_margin(*v6, v3), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::margin_must_be_less_than_max_removable_margin());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, 0x2::object::id_to_address(&v4), arg6, v1, 2, v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::set_margin(v6, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::margin(*v6) - v1);
        apply_funding_rate<T0>(v0, arg2, arg1, arg6, arg6, 0, 2);
        let v7 = *0x2::table::borrow<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg6);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::verify_collat_checks(v5, v7, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::imr_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::mmr_v2(arg1), v3, 0, 0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::emit_position_update_event(v7, v2, 2, v0);
    }

    entry fun trade<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::PerpetualV2, arg2: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg3: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg4: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SubAccountsV2, arg5: &mut 0x2::table::Table<vector<u8>, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::order::OrderStatus>, arg6: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::Sequencer, arg7: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::SettlementCap, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: u64, arg14: u128, arg15: address, arg16: vector<u8>, arg17: vector<u8>, arg18: u8, arg19: u128, arg20: u128, arg21: u128, arg22: u64, arg23: u128, arg24: address, arg25: vector<u8>, arg26: vector<u8>, arg27: u128, arg28: u128, arg29: vector<u8>, arg30: &0x2::tx_context::TxContext) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::get_version(arg1) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::get_version<T0>(arg2) == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_sub_accounts_version(arg4);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg3);
        let v0 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_unique_tx_v2(arg6, arg29);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::update_oracle_price(arg1, arg8, arg0);
        let v1 = 0x2::tx_context::sender(arg30);
        assert!(!0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::delisted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_is_delisted());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::is_trading_permitted_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::startTime_v2(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::trading_not_started());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_settlement_operator_validity_v2(arg3, arg7);
        let v2 = 0x2::object::uid_to_inner(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::id_v2(arg1));
        let v3 = 0x2::object::id_to_address(&v2);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg15);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::create_position(v2, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::positions(arg1), arg24);
        apply_funding_rate<T0>(v0, arg2, arg1, v1, arg15, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::tradeType(), 0);
        apply_funding_rate<T0>(v0, arg2, arg1, v1, arg24, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::tradeType(), 1);
        let v4 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::trade(v1, arg1, arg5, arg4, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::pack_trade_data(arg9, arg10, arg11, arg12, arg15, arg13, arg14, arg16, arg17, arg18, arg19, arg20, arg21, arg24, arg22, arg23, arg25, arg26, arg27, arg28, 0x2::object::id_to_address(&v2), 0x2::clock::timestamp_ms(arg0)), v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_trade_margin<T0>(arg2, v3, arg15, arg24, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::makerFundsFlow(v4), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::takerFundsFlow(v4), v0);
        let v5 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::fee(v4);
        if (v5 > 0) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, v3, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual::feePool_v2(arg1), v5, 2, v0);
        };
        let v6 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::isolated_trading::taker_gas_charges(v4);
        if (v6 > 0) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::transfer_margin_to_account_v2<T0>(arg2, arg24, @0xfddf022ecb6ec6667131e560ba3c24de3464181792312fcc468521ee0a49c7c5, v6, 1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

