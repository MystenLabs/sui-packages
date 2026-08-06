module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::exchange {
    struct LiquidatorPaidForAccountSettlementEvent has copy, drop {
        tx_index: u128,
        id: 0x2::object::ID,
        liquidator: address,
        account: address,
        amount: u128,
    }

    struct SettlementAmountNotPaidCompletelyEvent has copy, drop {
        tx_index: u128,
        account: address,
        amount: u128,
    }

    struct SettlementAmtDueByMakerEvent has copy, drop {
        tx_index: u128,
        account: address,
        amount: u128,
    }

    struct AccountSettlementUpdateEvent has copy, drop {
        tx_index: u128,
        account: address,
        balance: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position,
        settlement_is_positive: bool,
        settlement_amount: u128,
        price: u128,
        funding_rate: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128,
    }

    public fun add_margin<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: vector<u8>, arg10: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun adjust_leverage<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: vector<u8>, arg10: &0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun cancel_order<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg5: address, arg6: u8, arg7: u128, arg8: u128, arg9: u128, arg10: u64, arg11: u128, arg12: vector<u8>, arg13: u128, arg14: u64, arg15: vector<u8>, arg16: vector<u8>, arg17: &0x2::clock::Clock, arg18: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg17, arg14, 34);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg12);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg2, &v0, arg18);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::cancel_order(arg5, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14);
        let v2 = verify_user_signature(arg2, &v0, v1, arg15, arg16, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg1, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"CancelOrder"), v3, arg18);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::cancel(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_json_bytes(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::pack_order(arg5, arg6, arg7, arg8, arg9, v0, arg10, arg11), 2)), arg5, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2), v3);
    }

    entry fun close_position<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun remove_margin<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: vector<u8>, arg10: &0x2::tx_context::TxContext) {
        abort 999
    }

    fun verify_user_signature(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg1: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::verify_user_signature(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::get_all_sub_accounts(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg1)), arg2, arg3, arg4, arg5)
    }

    fun add_margin_impl<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: u128, arg3: address, arg4: u128, arg5: address) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg0), 61);
        assert!(arg4 > 0, 500);
        assert!(0x2::table::contains<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3), 507);
        let v0 = sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>());
        let v1 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v1) > 0, 512);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg0), arg4, 3, arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v1) + arg4);
        apply_funding_rate<T0>(arg2, arg1, arg0, arg3, 0, 2);
        assert!(v0 == sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>()), 99989);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(*0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3), arg5, 1, arg2);
    }

    public fun add_margin_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun add_margin_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun add_margin_v4<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg1, arg10, 34);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg6, arg1);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg4, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::add_margin(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), v0, arg8, arg9, arg10);
        let v2 = verify_user_signature(arg4, &v0, v1, arg11, arg12, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg3, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"AddMargin"), v3, arg13);
        add_margin_impl<T0>(arg2, arg3, v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), arg8 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2));
    }

    fun adjust_leverage_impl<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: u128, arg4: address, arg5: u128, arg6: address) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg1), 61);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::round_down(arg5);
        assert!(v0 > 0, 504);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg1);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::checks(arg1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg1);
        assert!(0x2::table::contains<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg1), arg4), 507);
        let v4 = sum_transaction_balance<T0>(arg2, arg1, arg4, 0x1::option::none<address>());
        apply_funding_rate<T0>(arg3, arg2, arg1, arg4, 0, 2);
        let v5 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg1), arg4);
        let v6 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg1), arg4);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v6);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::get_target_margin(v6, v0, v1);
        if (v7 > v8) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, v3, arg4, v7 - v8, 2, arg3);
        } else if (v7 < v8) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg2, arg4, v3, v8 - v7, 3, arg3);
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_mro(v6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), v0));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v6, v8);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_oi_open_for_account(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(v6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(v6), 0, 0x2::vec_set::contains<address>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::privileged_addresses(arg0), &arg4));
        let v9 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg1), arg4);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v5, &v9, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::imr(arg1), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::mmr(arg1), v1, 0, 0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v9, arg6, 3, arg3);
        assert!(v4 == sum_transaction_balance<T0>(arg2, arg1, arg4, 0x1::option::none<address>()), 99989);
    }

    public fun adjust_leverage_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun adjust_leverage_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun adjust_leverage_v4<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg1, arg10, 34);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg6, arg1);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg4, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::adjust_leverage(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), v0, arg8, arg9, arg10);
        let v2 = verify_user_signature(arg4, &v0, v1, arg11, arg12, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg3, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"AdjustLeverage"), v3, arg13);
        adjust_leverage_impl<T0>(arg0, arg2, arg3, v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), arg8 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2));
    }

    fun apply_funding_rate<T0>(arg0: u128, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: address, arg4: u8, arg5: u64) {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg2);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::funding_rate(arg2);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index(v1);
        let v3 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), arg3);
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::index(v3);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v3);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v3);
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(v3);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(v3);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_index(v3, v2);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::are_indexes_equal(v4, v2) || v6 == 0) {
            return
        };
        let v9 = if (v8) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(v4), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(v2))
        } else {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sub(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(v2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index_value(v4))
        };
        let v10 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v9), v6);
        let v11 = v10;
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(v9, 0)) {
            if (v0 == arg3) {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), arg3, v10, 2, arg0);
            } else {
                0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v3, v5 + v10);
            };
        } else {
            assert!(arg4 <= 3, 99999);
            let v12 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul_up(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v9), v6);
            v11 = v12;
            if (arg4 == 0 || arg4 == 1) {
                if (v0 == arg3) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), v12, arg5, arg0);
                    v11 = 0;
                } else {
                    assert!(v5 >= v12, 53 + arg5);
                };
            } else if (arg4 == 2) {
                if (arg5 == 1 && v5 > 0) {
                    abort 99999
                };
                if (v5 < v12) {
                    let v13 = v12 - v5;
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), v13, 1, arg0);
                    if (!(v0 == arg3)) {
                        let v14 = LiquidatorPaidForAccountSettlementEvent{
                            tx_index   : arg0,
                            id         : 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2)),
                            liquidator : v0,
                            account    : arg3,
                            amount     : v13,
                        };
                        0x2::event::emit<LiquidatorPaidForAccountSettlementEvent>(v14);
                    };
                    v11 = v12 - v13;
                };
            } else if (v5 < v12) {
                if (v8) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(v3, v7 + v12);
                } else if (v12 > v7) {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(v3, 0);
                    let v15 = SettlementAmountNotPaidCompletelyEvent{
                        tx_index : arg0,
                        account  : arg3,
                        amount   : v12 - v7,
                    };
                    0x2::event::emit<SettlementAmountNotPaidCompletelyEvent>(v15);
                } else {
                    0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_oi_open(v3, v7 - v12);
                };
                let v16 = SettlementAmtDueByMakerEvent{
                    tx_index : arg0,
                    account  : arg3,
                    amount   : v12,
                };
                0x2::event::emit<SettlementAmtDueByMakerEvent>(v16);
                v11 = 0;
            };
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v3, v5 - v11);
        };
        let v17 = AccountSettlementUpdateEvent{
            tx_index               : arg0,
            account                : arg3,
            balance                : *v3,
            settlement_is_positive : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::sign(v9),
            settlement_amount      : v11,
            price                  : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg2),
            funding_rate           : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::rate(v1),
        };
        0x2::event::emit<AccountSettlementUpdateEvent>(v17);
    }

    fun close_position_impl<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: u128, arg3: address, arg4: address) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg0), 62);
        assert!(0x2::table::contains<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3), 507);
        let v0 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg0));
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg0);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisting_price(arg0);
        let v3 = sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>());
        apply_funding_rate<T0>(arg2, arg1, arg0, arg3, 0, 2);
        let v4 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v4) > 0, 512);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::get_margin_left(v4, v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg1, v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_size(v4, 0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, v1, arg3, v5, 2, arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_closed_event(v0, arg3, v5, arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(*v4, arg4, 4, arg2);
        assert!(v3 == sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>()), 99989);
    }

    entry fun close_position_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun close_position_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: u128, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg5, arg8, 34);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg6);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg3, &v0, arg11);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::close_position(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg1), v0, arg7, arg8);
        let v2 = verify_user_signature(arg3, &v0, v1, arg9, arg10, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg2, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"ClosePosition"), v3, arg11);
        close_position_impl<T0>(arg1, arg2, v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2));
    }

    entry fun create_perpetual<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: vector<u8>, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: vector<u128>, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u128, arg19: address, arg20: address, arg21: address, arg22: address, arg23: u64, arg24: vector<u8>, arg25: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    entry fun create_perpetual_v2<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg4: vector<u8>, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128, arg14: vector<u128>, arg15: u128, arg16: u128, arg17: u128, arg18: u128, arg19: u128, arg20: address, arg21: address, arg22: address, arg23: address, arg24: u64, arg25: &mut 0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg22 != @0x0, 105);
        assert!(arg23 != @0x0, 105);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::create(arg4, arg15 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg16 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg17 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg18 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg20, arg21, arg22, arg23, arg5 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg6 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg7 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg8 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg9 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg10 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg11 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg12 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg13 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg19 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg24, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::to_1x9_vec(arg14), b"", 86400000, 1000000 * 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg25);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::register_perpetual(arg0, v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::insert_price_info(arg3, v0, 0, 0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, 0x2::object::id_to_address(&v0));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg20);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg21);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg22);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg23);
    }

    public fun deleverage<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::DeleveragingCap, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: address, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        abort 999
    }

    fun deleverage_impl<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::DeleveragingCap, arg5: u128, arg6: address, arg7: address, arg8: u128, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg2), 61);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::is_trading_permitted(arg2), 63);
        assert!(0x2::clock::timestamp_ms(arg1) > 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::start_time(arg2), 56);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_deleveraging_operator_validity(arg0, arg4);
        let v0 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2));
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), arg6);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), arg7);
        let v2 = sum_transaction_balance<T0>(arg3, arg2, arg6, 0x1::option::some<address>(arg7));
        apply_funding_rate<T0>(arg5, arg3, arg2, arg6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::trade_type(), 0);
        apply_funding_rate<T0>(arg5, arg3, arg2, arg7, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::trade_type(), 1);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::trade<T0>(0x2::tx_context::sender(arg10), arg2, arg3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::pack_trade_data(arg6, arg7, arg8, arg9), arg5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::trade_margin_settlement<T0>(arg3, v1, arg6, arg7, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::maker_funds_flow(v3), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_adl::taker_funds_flow(v3), arg5);
        assert!(v2 == sum_transaction_balance<T0>(arg3, arg2, arg6, 0x1::option::some<address>(arg7)), 99989);
    }

    public fun deleverage_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg5: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::DeleveragingCap, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: address, arg8: address, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg6, arg1);
        deleverage_impl<T0>(arg0, arg1, arg2, arg3, arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg4, arg11), arg7, arg8, arg9 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg10, arg12);
    }

    public fun liquidate<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) {
        abort 999
    }

    fun liquidate_impl<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: u128, arg6: address, arg7: u128, arg8: bool, arg9: &0x2::tx_context::TxContext) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg2), 61);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::is_trading_permitted(arg2), 63);
        assert!(0x2::clock::timestamp_ms(arg1) > 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::start_time(arg2), 56);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg2);
        assert!(v0 == v1 || 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::is_sub_account(arg4, v1, v0), 51);
        assert!(v1 != arg6, 704);
        let v2 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2));
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), arg6);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), v1);
        let v4 = sum_transaction_balance<T0>(arg3, arg2, arg6, 0x1::option::none<address>());
        apply_funding_rate<T0>(arg5, arg3, arg2, arg6, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::trade_type(), 0);
        apply_funding_rate<T0>(arg5, arg3, arg2, v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::trade_type(), 1);
        let v5 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), v1);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v5);
        if (v6 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v3, v1, v6, 2, arg5);
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v5, 0);
        };
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::trade(v0, arg2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::pack_trade_data(v1, arg6, arg7, arg8), arg5);
        let v8 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::premium(v7);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(v8, 0)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v3, v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v8), 2, arg5);
        } else if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::lt_u128(v8, 0)) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v1, v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(v8), 1, arg5);
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::trade_margin_settlement<T0>(arg3, v3, arg6, v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::maker_funds_flow(v7), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_liquidation::taker_funds_flow(v7), arg5);
        assert!(v4 == sum_transaction_balance<T0>(arg3, arg2, arg6, 0x1::option::none<address>()), 99989);
    }

    public fun liquidate_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: address, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg6, arg1);
        liquidate_impl<T0>(arg0, arg1, arg2, arg3, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, arg10), arg7, arg8 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg9, arg11);
    }

    fun remove_margin_impl<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg1: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg2: u128, arg3: address, arg4: u128, arg5: address) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg0), 61);
        assert!(arg4 > 0, 500);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::price_oracle(arg0);
        assert!(0x2::table::contains<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3), 507);
        let v1 = sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>());
        let v2 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3);
        let v3 = 0x2::table::borrow_mut<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(v3) > 0, 512);
        assert!(arg4 <= 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::get_max_removeable_margin(*v3, v0), 503);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg0), arg3, arg4, 2, arg2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::set_margin(v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(v3) - arg4);
        apply_funding_rate<T0>(arg2, arg1, arg0, arg3, 0, 2);
        let v4 = *0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg0), arg3);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::verify_collat_checks(&v2, &v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::imr(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::mmr(arg0), v0, 0, 0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::emit_position_update_event(v4, arg5, 2, arg2);
        assert!(v1 == sum_transaction_balance<T0>(arg1, arg0, arg3, 0x1::option::none<address>()), 99989);
    }

    public fun remove_margin_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun remove_margin_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: address, arg8: u128, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun remove_margin_v4<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg6: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg7: vector<u8>, arg8: u128, arg9: u128, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg1, arg10, 34);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg6, arg1);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg7);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::assert_signed_action_sender_authorized(arg0, arg4, &v0, arg13);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::remove_margin(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2), v0, arg8, arg9, arg10);
        let v2 = verify_user_signature(arg4, &v0, v1, arg11, arg12, 52);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_hash(v1));
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::charge_relayer_gas_fee<T0>(arg3, arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), 0x1::string::utf8(b"RemoveMargin"), v3, arg13);
        remove_margin_impl<T0>(arg2, arg3, v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v0), arg8 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(&v2));
    }

    public(friend) fun sum_transaction_balance<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg2: address, arg3: 0x1::option::Option<address>) : u128 {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::insurance_active_pool(arg1);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg1)) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::fee_pool(arg1)) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::gas_pool(arg1)) + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, v0);
        let v2 = v1;
        if (arg2 != v0) {
            v2 = v1 + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, arg2);
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v3 = *0x1::option::borrow<address>(&arg3);
            if (v3 != v0 && v3 != arg2) {
                v2 = v2 + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::get_balance<T0>(arg0, v3);
            };
        };
        v2
    }

    public fun trade<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg6: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg7: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::SettlementCap, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: u64, arg14: u128, arg15: address, arg16: vector<u8>, arg17: vector<u8>, arg18: u8, arg19: u128, arg20: u128, arg21: u128, arg22: u64, arg23: u128, arg24: address, arg25: vector<u8>, arg26: vector<u8>, arg27: u128, arg28: u128, arg29: vector<u8>, arg30: &0x2::tx_context::TxContext) {
        abort 999
    }

    fun trade_impl<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg5: u128, arg6: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg7: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg8: u32, arg9: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderV2, arg10: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg11: u32, arg12: u128, arg13: u128, arg14: &0x2::tx_context::TxContext) {
        assert!(!0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::delisted(arg2), 61);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::is_trading_permitted(arg2), 63);
        assert!(0x2::clock::timestamp_ms(arg1) > 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::start_time(arg2), 56);
        let v0 = 0x2::object::uid_to_inner(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::id(arg2));
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator_identifier(&arg6);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator_identifier(&arg9);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::create_position(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::positions(arg2), v3);
        let v4 = sum_transaction_balance<T0>(arg3, arg2, v2, 0x1::option::some<address>(v3));
        apply_funding_rate<T0>(arg5, arg3, arg2, v2, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::trade_type(), 0);
        apply_funding_rate<T0>(arg5, arg3, arg2, v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::trade_type(), 1);
        let v5 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::trade(arg0, 0x2::tx_context::sender(arg14), arg2, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::pack_trade_data(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2::clock::timestamp_ms(arg1)), arg5);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement::trade_margin_settlement<T0>(arg3, v1, v2, v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::maker_funds_flow(v5), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::taker_funds_flow(v5), arg5);
        let v6 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::trade_fee(v5);
        if (v6 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::fee_pool(arg2), v6, 2, arg5);
        };
        let v7 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::isolated_trading::gas_fee(v5);
        if (v7 > 0) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg3, v1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::gas_pool(arg2), v7, 2, arg5);
        };
        assert!(v4 == sum_transaction_balance<T0>(arg3, arg2, v2, 0x1::option::some<address>(v3)), 99989);
    }

    public fun trade_v2<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg6: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg7: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::SettlementCap, arg8: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: u64, arg14: u128, arg15: address, arg16: vector<u8>, arg17: vector<u8>, arg18: u8, arg19: u128, arg20: u128, arg21: u128, arg22: u64, arg23: u128, arg24: address, arg25: vector<u8>, arg26: vector<u8>, arg27: u128, arg28: u128, arg29: vector<u8>, arg30: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun trade_v3<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg6: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg7: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::SettlementCap, arg8: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg9: u8, arg10: u128, arg11: u128, arg12: u128, arg13: u64, arg14: u128, arg15: vector<u8>, arg16: u32, arg17: vector<u8>, arg18: vector<u8>, arg19: u8, arg20: u128, arg21: u128, arg22: u128, arg23: u64, arg24: u128, arg25: vector<u8>, arg26: u32, arg27: vector<u8>, arg28: vector<u8>, arg29: u128, arg30: u128, arg31: vector<u8>, arg32: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun trade_v4<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::Perpetual, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg4: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::SubAccounts, arg5: &mut 0x2::table::Table<vector<u8>, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::OrderStatus>, arg6: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg7: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::price_feed::PriceFeed, arg8: u8, arg9: u128, arg10: u128, arg11: u128, arg12: u64, arg13: u128, arg14: vector<u8>, arg15: u32, arg16: vector<u8>, arg17: vector<u8>, arg18: u8, arg19: u128, arg20: u128, arg21: u128, arg22: u64, arg23: u128, arg24: vector<u8>, arg25: u32, arg26: vector<u8>, arg27: vector<u8>, arg28: u128, arg29: u128, arg30: vector<u8>, arg31: &0x2::tx_context::TxContext) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::update_oracle_price_v2(arg2, arg7, arg1);
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual::perp_address(arg2);
        let v1 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::pack_order(v0, arg8, arg9, arg10, arg11, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg14), arg12, arg13);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::pack_order(v0, arg18, arg19, arg20, arg21, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg24), arg22, arg23);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator(v1);
        let v4 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::creator(v2);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_settlement_sender_validity(arg0, 0x2::tx_context::sender(arg31));
        trade_impl<T0>(arg0, arg1, arg2, arg3, arg5, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::validate_unique_tx(arg6, arg30), v1, verify_user_signature(arg4, &v3, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_json_bytes(v1, arg15), arg16, arg17, 30), arg15, v2, verify_user_signature(arg4, &v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::order::to_json_bytes(v2, arg25), arg26, arg27, 31), arg25, arg28, arg29, arg31);
    }

    // decompiled from Move bytecode v7
}

