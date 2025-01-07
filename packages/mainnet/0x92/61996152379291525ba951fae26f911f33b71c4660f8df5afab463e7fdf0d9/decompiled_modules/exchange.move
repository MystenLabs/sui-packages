module 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::exchange {
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
        balance: 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition,
        settlementIsPositive: bool,
        settlementAmount: u128,
        price: u128,
        fundingRate: 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::Number,
    }

    entry fun add_margin(arg0: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg2: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SubAccounts, arg3: address, arg4: u128, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg0, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg3 || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::is_sub_account(arg2, arg3, v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::sender_does_not_have_permission_for_account(2));
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        assert!(arg4 > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::margin_amount_must_be_greater_than_zero());
        assert!(0x2::table::contains<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_has_no_position_in_table(2));
        let v1 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg0));
        let v2 = 0x2::table::borrow_mut<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::qPos(*v2) > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_position_size_is_zero(2));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg1, arg3, 0x2::object::id_to_address(&v1), arg4, 3);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_margin(v2, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::margin(*v2) + arg4);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::emit_position_update_event(*v2, v0, 1);
        apply_funding_rate(arg1, arg0, arg3, arg3, 0, 2);
    }

    entry fun adjust_leverage(arg0: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg2: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SubAccounts, arg3: address, arg4: u128, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg0, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg3 || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::is_sub_account(arg2, arg3, v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::sender_does_not_have_permission_for_account(2));
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        let v1 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::library::round_down(arg4);
        assert!(v1 > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::leverage_can_not_be_set_to_zero());
        let v2 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::priceOracle(arg0);
        let v3 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::checks(arg0);
        let v4 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg0));
        assert!(0x2::table::contains<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_has_no_position_in_table(2));
        apply_funding_rate(arg1, arg0, arg3, arg3, 0, 2);
        let v5 = 0x2::table::borrow_mut<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        let v6 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::margin(*v5);
        let v7 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_math::get_target_margin(*v5, v1, v2);
        if (v6 > v7) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg1, 0x2::object::id_to_address(&v4), arg3, v6 - v7, 2);
        } else if (v6 < v7) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg1, arg3, 0x2::object::id_to_address(&v4), v7 - v6, 3);
        };
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_mro(v5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::library::base_div(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::library::base_uint(), v1));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_margin(v5, v7);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::evaluator::verify_oi_open_for_account(v3, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::mro(*v5), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::oiOpen(*v5), 0);
        let v8 = *0x2::table::borrow<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::verify_collat_checks(*0x2::table::borrow<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3), v8, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::imr(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::mmr(arg0), v2, 0, 0);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::emit_position_update_event(v8, v0, 3);
    }

    fun apply_funding_rate(arg0: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg2: address, arg3: address, arg4: u8, arg5: u64) {
        let v0 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg1));
        let v1 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::fundingRate(arg1);
        let v2 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::index(v1);
        let v3 = 0x2::table::borrow_mut<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg3);
        let v4 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::index(*v3);
        if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::are_indexes_equal(v4, v2)) {
            return
        };
        let v5 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::margin(*v3);
        let v6 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::oiOpen(*v3);
        let v7 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::isPosPositive(*v3);
        let v8 = if (v7) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::sub(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::index_value(v4), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::index_value(v2))
        } else {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::sub(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::index_value(v2), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::index_value(v4))
        };
        let v9 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::library::base_mul(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::value(v8), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::qPos(*v3));
        let v10 = v9;
        if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::gt_uint(v8, 0)) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_margin(v3, v5 + v9);
        } else {
            if (arg4 == 0 || arg4 == 1) {
                assert!(v5 >= v9, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::funding_due_exceeds_margin(arg5));
            } else if (arg4 == 2) {
                if (v5 < v9) {
                    let v11 = v9 - v5;
                    0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg0, arg2, 0x2::object::id_to_address(&v0), v11, 1);
                    let v12 = LiquidatorPaidForAccountSettlementEvnet{
                        id         : v0,
                        liquidator : arg2,
                        account    : arg3,
                        amount     : v11,
                    };
                    0x2::event::emit<LiquidatorPaidForAccountSettlementEvnet>(v12);
                    v10 = v9 - v11;
                };
            } else if (v5 < v9) {
                if (v7) {
                    0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_oiOpen(v3, v6 + v9);
                } else if (v9 > v6) {
                    0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_oiOpen(v3, 0);
                    let v13 = SettlementAmountNotPaidCompletelyEvent{
                        account : arg3,
                        amount  : v9 - v6,
                    };
                    0x2::event::emit<SettlementAmountNotPaidCompletelyEvent>(v13);
                } else {
                    0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_oiOpen(v3, v6 - v9);
                };
                let v14 = SettlementAmtDueByMakerEvent{
                    account : arg3,
                    amount  : v9,
                };
                0x2::event::emit<SettlementAmtDueByMakerEvent>(v14);
                v10 = 0;
            };
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_margin(v3, v5 - v10);
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_index(v3, v2);
        };
        let v15 = AccountSettlementUpdateEvent{
            account              : arg3,
            balance              : *v3,
            settlementIsPositive : 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::sign(v8),
            settlementAmount     : v10,
            price                : 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::priceOracle(arg1),
            fundingRate          : 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::funding_rate::rate(v1),
        };
        0x2::event::emit<AccountSettlementUpdateEvent>(v15);
    }

    entry fun close_position(arg0: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_not_delisted());
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_has_no_position_in_table(2));
        let v1 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg0));
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delistingPrice(arg0);
        apply_funding_rate(arg1, arg0, v0, v0, 0, 2);
        let v4 = 0x2::table::borrow_mut<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), v0);
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::qPos(*v4) > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_position_size_is_zero(2));
        let v5 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_math::get_margin_left(*v4, v3, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::get_balance(arg1, v2));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_qPos(v4, 0);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg1, v2, v0, v5, 2);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::emit_position_closed_event(v1, v0, v5);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::emit_position_update_event(*v4, v0, 4);
    }

    entry fun create_perpetual(arg0: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::ExchangeAdminCap, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg2: vector<u8>, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: vector<u128>, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u128, arg19: address, arg20: address, arg21: u64, arg22: vector<u8>, arg23: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::initialize(arg2, arg13, arg14, arg15, arg16, arg18, arg19, arg20, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg17, arg21, arg12, 0x2::table::new<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(arg23), arg22, arg23);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::initialize_account(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::mut_accounts(arg1), 0x2::object::id_to_address(&v0));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::initialize_account(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::mut_accounts(arg1), arg19);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::initialize_account(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::mut_accounts(arg1), arg20);
    }

    entry fun deleverage(arg0: &0x2::clock::Clock, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg2: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg3: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::CapabilitiesSafe, arg4: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::DeleveragingCap, arg5: address, arg6: address, arg7: u128, arg8: bool, arg9: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg10: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg1, arg9);
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::is_trading_permitted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::startTime(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_not_started());
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::check_delevearging_operator_validity(arg3, arg4);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg1));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg5);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg6);
        apply_funding_rate(arg2, arg1, v0, arg5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::tradeType(), 0);
        apply_funding_rate(arg2, arg1, v0, arg6, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::tradeType(), 1);
        let v2 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::trade(v0, arg1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::pack_trade_data(arg5, arg6, arg7, arg8));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_trade_margin(arg2, 0x2::object::id_to_address(&v1), arg5, arg6, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::makerFundsFlow(v2), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_adl::takerFundsFlow(v2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2::table::Table<vector<u8>, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::order::OrderStatus>>(0x2::table::new<vector<u8>, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::order::OrderStatus>(arg0));
    }

    entry fun liquidate(arg0: &0x2::clock::Clock, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg2: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg3: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SubAccounts, arg4: address, arg5: address, arg6: u128, arg7: u128, arg8: bool, arg9: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg10: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg1, arg9);
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::is_trading_permitted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::startTime(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_not_started());
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(v0 == arg5 || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::is_sub_account(arg3, arg5, v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::sender_does_not_have_permission_for_account(1));
        let v1 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg1));
        let v2 = 0x2::object::id_to_address(&v1);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg4);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg5);
        apply_funding_rate(arg2, arg1, v0, arg4, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::tradeType(), 0);
        apply_funding_rate(arg2, arg1, v0, arg5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::tradeType(), 1);
        let v3 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::trade(v0, arg1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::pack_trade_data(arg5, arg4, arg6, arg7, arg8));
        let v4 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::liquidatorPortion(v3);
        let v5 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::insurancePoolPortion(v3);
        if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::gt_uint(v4, 0)) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg2, v2, arg5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::value(v4), 2);
        } else if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::lt_uint(v4, 0)) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg2, arg5, v2, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::value(v4), 1);
        };
        if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::gt_uint(v5, 0)) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg2, v2, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::insurancePool(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::signed_number::value(v5), 2);
        };
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_trade_margin(arg2, v2, arg4, arg5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::makerFundsFlow(v3), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_liquidation::takerFundsFlow(v3));
    }

    entry fun remove_margin(arg0: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg2: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SubAccounts, arg3: address, arg4: u128, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg0, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg3 || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::is_sub_account(arg2, arg3, v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::sender_does_not_have_permission_for_account(2));
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        assert!(arg4 > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::margin_amount_must_be_greater_than_zero());
        let v1 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::priceOracle(arg0);
        assert!(0x2::table::contains<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_has_no_position_in_table(2));
        let v2 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg0));
        let v3 = *0x2::table::borrow<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        let v4 = 0x2::table::borrow_mut<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::qPos(*v4) > 0, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::user_position_size_is_zero(2));
        assert!(arg4 <= 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_math::get_max_removeable_margin(*v4, v1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::margin_must_be_less_than_max_removable_margin());
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg1, 0x2::object::id_to_address(&v2), arg3, arg4, 2);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::set_margin(v4, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::margin(*v4) - arg4);
        apply_funding_rate(arg1, arg0, arg3, arg3, 0, 2);
        let v5 = *0x2::table::borrow<address, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::UserPosition>(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg0), arg3);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::verify_collat_checks(v3, v5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::imr(arg0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::mmr(arg0), v1, 0, 0);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::emit_position_update_event(v5, v0, 2);
    }

    entry fun trade(arg0: &0x2::clock::Clock, arg1: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::Perpetual, arg2: &mut 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::Bank, arg3: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::CapabilitiesSafe, arg4: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SettlementCap, arg5: &0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::SubAccounts, arg6: &mut 0x2::table::Table<vector<u8>, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::order::OrderStatus>, arg7: u8, arg8: u128, arg9: u128, arg10: u128, arg11: u64, arg12: u128, arg13: address, arg14: vector<u8>, arg15: vector<u8>, arg16: u8, arg17: u128, arg18: u128, arg19: u128, arg20: u64, arg21: u128, arg22: address, arg23: vector<u8>, arg24: vector<u8>, arg25: u128, arg26: u128, arg27: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg28: &mut 0x2::tx_context::TxContext) {
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::update_oracle_price(arg1, arg27);
        let v0 = 0x2::tx_context::sender(arg28);
        assert!(!0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::delisted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::perpetual_is_delisted());
        assert!(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::is_trading_permitted(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_is_stopped_on_perpetual());
        assert!(0x2::clock::timestamp_ms(arg0) > 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::startTime(arg1), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::trading_not_started());
        if (0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::order::flag_orderbook_only(arg7) || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::order::flag_orderbook_only(arg16)) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::check_settlement_operator_validity(arg3, arg4);
        } else {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::check_public_settlement_cap_validity(arg3, arg4);
            assert!(v0 == arg22 || 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::roles::is_sub_account(arg5, arg22, v0), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::error::only_taker_of_trade_can_execute_trade_involving_non_orderbook_orders());
        };
        let v1 = 0x2::object::uid_to_inner(0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::id(arg1));
        let v2 = 0x2::object::id_to_address(&v1);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg13);
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::position::create_position(v1, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::positions(arg1), arg22);
        apply_funding_rate(arg2, arg1, v0, arg13, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::tradeType(), 0);
        apply_funding_rate(arg2, arg1, v0, arg22, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::tradeType(), 1);
        let v3 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::trade(v0, arg1, arg6, arg5, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::pack_trade_data(arg7, arg8, arg9, arg10, arg13, arg11, arg12, arg14, arg15, arg16, arg17, arg18, arg19, arg22, arg20, arg21, arg23, arg24, arg25, arg26, 0x2::object::id_to_address(&v1), 0x2::clock::timestamp_ms(arg0)));
        0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_trade_margin(arg2, v2, arg13, arg22, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::makerFundsFlow(v3), 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::takerFundsFlow(v3));
        let v4 = 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::isolated_trading::fee(v3);
        if (v4 > 0) {
            0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::margin_bank::transfer_margin_to_account(arg2, v2, 0x9261996152379291525ba951fae26f911f33b71c4660f8df5afab463e7fdf0d9::perpetual::feePool(arg1), v4, 2);
        };
    }

    // decompiled from Move bytecode v6
}

