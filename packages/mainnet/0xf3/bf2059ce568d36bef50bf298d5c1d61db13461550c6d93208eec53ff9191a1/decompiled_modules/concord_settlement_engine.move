module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_settlement_engine {
    struct EngineAdminCap has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
    }

    struct ProcessorCancelPermitV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        request_id: u64,
        borrower: address,
        expires_at_ms: u64,
        max_penalty: u64,
        escrow: 0x2::balance::Balance<T0>,
    }

    struct TreasuryClaim has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
        treasury: address,
    }

    struct SettlementEngine has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        processors: vector<address>,
        liquidators: vector<address>,
        min_collateral_ratio_bps: u64,
        fee_repay_interest_bps: u64,
        cancel_penalty_bps: u64,
        cancel_penalty_protocol_bps: u64,
        fee_liq_principal_bps: u64,
        fee_default_collateral_bps: u64,
        liquidator_surplus_bps: u64,
        processor_cancel_grace_secs: u64,
        protocol_treasury: address,
        paused: bool,
    }

    public fun sweep_mistaken_principal<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        emit_and_send_surplus<T0, T1, T2>(arg0, arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::sweep_mistaken_principal<T0, T1, T2>(arg2, arg3));
    }

    public fun sweep_surplus<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        emit_and_send_surplus<T0, T1, T2>(arg0, arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::sweep_surplus<T0, T1, T2>(arg2, arg3));
    }

    public fun accept_admin(arg0: &mut SettlementEngine, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg2) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_transferred(0x2::object::id<SettlementEngine>(arg0), arg0.admin, v0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun add_liquidator(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        if (!vec_contains_addr(&arg0.liquidators, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.liquidators, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_liquidator_added(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun add_processor(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        if (!vec_contains_addr(&arg0.processors, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.processors, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_processor_added(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    fun apply_cancel_penalty<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::total_assets<T0, T1, T2>(arg1);
        let v1 = if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::is_locked<T1>(arg2) && v0 > 0) {
            bps_of(v0, arg0.cancel_penalty_bps)
        } else {
            0
        };
        assert!(0x2::coin::value<T0>(&arg3) == v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            let v2 = bps_of(v1, arg0.cancel_penalty_protocol_bps);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg7), arg0.protocol_treasury);
                0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_cancel_penalty(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg6));
            };
            if (v1 - v2 > 0) {
                if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::total_shares<T0, T1, T2>(arg1) > 0) {
                    0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::receive_cancel_penalty<T0, T1, T2>(arg1, arg3);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.protocol_treasury);
                };
            } else {
                0x2::coin::destroy_zero<T0>(arg3);
            };
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_cancel_penalty_paid(arg4, arg5, v1, v0, 0x2::clock::timestamp_ms(arg6));
        };
    }

    fun assert_admin(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
    }

    fun assert_collateral_binding<T0>(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg2: u64) {
        assert_collateral_request_id<T0>(arg1, arg2);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::registered_collateral_vault(arg0, arg2);
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>>(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        };
    }

    fun assert_collateral_request_id<T0>(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg1: u64) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_request_id<T0>(arg0) == arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
    }

    fun assert_default_access(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg2: address) {
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_liquidation_trigger(arg1) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::liquidation_trigger_whitelisted_only()) {
            assert!(is_liquidator(arg0, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_liquidator());
        };
    }

    fun assert_direct_loan(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition) {
        assert!(!0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::is_vault_loan(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
    }

    fun assert_matured(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_due_at_ms(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::loan_not_matured());
    }

    fun assert_pooled_loan<T0, T1, T2: key>(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::is_vault_loan(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_vault_id(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>>(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
    }

    fun assert_price_liquidatable(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_oracle_feed_id(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        let v1 = 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg2);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::is_whitelisted_oracle(arg0, v1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_not_whitelisted());
        let v2 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_liquidation_price(arg1);
        assert!(0x1::option::is_some<u64>(&v2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::assert_fresh_with_reference(arg2, arg3);
        assert!(v3 < *0x1::option::borrow<u64>(&v2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_triggered());
        v3
    }

    fun assert_request_bindings<T0, T1, T2: key>(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: u64) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::get_request_id<T0, T1, T2>(arg1) == arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_request_id<T1>(arg2) == arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::registered_collateral_vault(arg0, arg3);
        if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>>(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        };
    }

    fun assert_version(arg0: &SettlementEngine) {
        assert!(arg0.version == 1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::wrong_version());
    }

    fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun buyout_min_payment(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: u64, arg3: u64, arg4: u64, arg5: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg6: &0x2::clock::Clock) : u64 {
        let v0 = if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg2)) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::assert_request_oracle_matches(arg1, arg2, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg5));
            require_oracle_whitelisted(arg1, arg5);
            let (v1, v2) = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::assert_buyout_prices_with_reference(arg5, arg6);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::buyout_anchor_principal_atoms(arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token_decimals(arg1, arg2), v1, v2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal_token_decimals(arg1, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::get_decimals(arg5))
        } else {
            let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_ltv_bps(arg1, arg2);
            assert!(v3 > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::ltv_not_configured());
            (arg3 as u128) * (10000 as u128) / (v3 as u128)
        };
        ((v0 * ((10000 - arg0.liquidator_surplus_bps) as u128) / (10000 as u128)) as u64)
    }

    fun calculate_interest(arg0: &vector<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0)) {
            let v2 = 0x1::vector::borrow<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::InterestRateTier>(arg0, v1);
            if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_from_seconds(v2) <= arg2) {
                v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::tier_rate_bps(v2);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        bps_of(arg1, v0)
    }

    public fun cancel_borrower_offer<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg5);
        assert!(0x2::tx_context::sender(arg7) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        apply_cancel_penalty<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, v0, arg6, arg7);
        finalize_cancel<T0, T1, T2>(arg1, arg2, arg3, arg5, v0, arg6, arg7);
    }

    public fun cancel_penalty_bps(arg0: &SettlementEngine) : u64 {
        arg0.cancel_penalty_bps
    }

    public fun cancel_penalty_protocol_bps(arg0: &SettlementEngine) : u64 {
        arg0.cancel_penalty_protocol_bps
    }

    public fun claim_default<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg4: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg3);
        assert_request_bindings<T0, T1, T2>(arg1, arg2, arg4, v0);
        assert_pooled_loan<T0, T1, T2>(arg3, arg2);
        assert_default_access(arg0, arg3, 0x2::tx_context::sender(arg6));
        assert_matured(arg3, arg5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_default(arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_last_price(arg3), arg5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_defaulted(v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg3), 0x2::clock::timestamp_ms(arg5));
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg3) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim()) {
            seize_and_fund_vault<T0, T1, T2>(arg0, arg2, arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token(arg1, v0), arg5, arg6);
        };
    }

    public fun claim_default_direct<T0>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg1);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg1);
        assert_collateral_request_id<T0>(arg2, v0);
        assert_default_access(arg0, arg1, 0x2::tx_context::sender(arg4));
        assert_matured(arg1, arg3);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_default(arg1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_last_price(arg1), arg3);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_defaulted(v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg1), 0x2::clock::timestamp_ms(arg3));
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg1) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim()) {
            seize_to_lender<T0>(arg0, arg1, arg2, arg3, arg4);
        };
    }

    public fun create_engine(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : EngineAdminCap {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        let v1 = SettlementEngine{
            id                          : 0x2::object::new(arg2),
            version                     : 1,
            admin                       : arg0,
            pending_admin               : 0x1::option::none<address>(),
            processors                  : v0,
            liquidators                 : vector[],
            min_collateral_ratio_bps    : 0,
            fee_repay_interest_bps      : 0,
            cancel_penalty_bps          : 0,
            cancel_penalty_protocol_bps : 0,
            fee_liq_principal_bps       : 0,
            fee_default_collateral_bps  : 0,
            liquidator_surplus_bps      : 0,
            processor_cancel_grace_secs : 0,
            protocol_treasury           : arg0,
            paused                      : false,
        };
        0x2::transfer::share_object<SettlementEngine>(v1);
        EngineAdminCap{
            id        : 0x2::object::new(arg2),
            engine_id : 0x2::object::id<SettlementEngine>(&v1),
        }
    }

    public fun create_processor_cancel_permit_v2<T0>(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ProcessorCancelPermitV2<T0> {
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg0, arg1);
        assert!(0x2::tx_context::sender(arg6) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        ProcessorCancelPermitV2<T0>{
            id            : 0x2::object::new(arg6),
            request_id    : arg1,
            borrower      : v0,
            expires_at_ms : arg2,
            max_penalty   : arg3,
            escrow        : 0x2::coin::into_balance<T0>(arg4),
        }
    }

    public fun create_treasury_claim(arg0: &SettlementEngine, arg1: &mut 0x2::tx_context::TxContext) : TreasuryClaim {
        TreasuryClaim{
            id        : 0x2::object::new(arg1),
            engine_id : 0x2::object::id<SettlementEngine>(arg0),
            treasury  : 0x2::tx_context::sender(arg1),
        }
    }

    fun emit_and_send_surplus<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        let v0 = arg0.protocol_treasury;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_surplus_swept(0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>>(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::get_principal_token<T0, T1, T2>(arg1), 0x2::coin::value<T0>(&arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
    }

    public fun engine_version(arg0: &SettlementEngine) : u64 {
        arg0.version
    }

    public fun expire_unfunded_offer<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg5) >= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_created_at_ms(arg1, arg4) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_funding_window_secs(arg1, arg4) * 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::funding_window_active());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg4);
        finalize_cancel<T0, T1, T2>(arg1, arg2, arg3, arg4, v0, arg5, arg6);
    }

    public fun fee_default_collateral_bps(arg0: &SettlementEngine) : u64 {
        arg0.fee_default_collateral_bps
    }

    public fun fee_liq_principal_bps(arg0: &SettlementEngine) : u64 {
        arg0.fee_liq_principal_bps
    }

    public fun fee_repay_interest_bps(arg0: &SettlementEngine) : u64 {
        arg0.fee_repay_interest_bps
    }

    fun finalize_cancel<T0, T1, T2: key>(arg0: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::mark_cancelled(arg0, arg3);
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::is_collecting<T0, T1, T2>(arg1)) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_closed<T0, T1, T2>(arg1, arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::unwind<T1>(arg2, arg6), arg4);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_borrow_request_cancelled(arg3, 0x2::clock::timestamp_ms(arg5));
    }

    public fun force_vault_default<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_status(arg3);
        assert!(v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_defaulted() || v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_liquidated(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_default_status<T0, T1, T2>(arg2, arg4);
    }

    public fun get_admin(arg0: &SettlementEngine) : address {
        arg0.admin
    }

    public fun is_liquidator(arg0: &SettlementEngine, arg1: address) : bool {
        vec_contains_addr(&arg0.liquidators, arg1)
    }

    public fun is_paused(arg0: &SettlementEngine) : bool {
        arg0.paused
    }

    public fun is_processor(arg0: &SettlementEngine, arg1: address) : bool {
        vec_contains_addr(&arg0.processors, arg1)
    }

    public fun liquidate_by_price<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg4: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg5: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg3);
        assert_request_bindings<T0, T1, T2>(arg1, arg2, arg4, v0);
        assert_pooled_loan<T0, T1, T2>(arg3, arg2);
        assert_default_access(arg0, arg3, 0x2::tx_context::sender(arg7));
        let v1 = assert_price_liquidatable(arg1, arg3, arg5, arg6);
        let v2 = 0;
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg3) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim()) {
            v2 = seize_and_fund_vault<T0, T1, T2>(arg0, arg2, arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token(arg1, v0), arg6, arg7);
        };
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_liquidation_price(arg3);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_liquidated(arg3, v1, arg6);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_liquidated(v0, v2, v1, *0x1::option::borrow<u64>(&v3), 0x2::clock::timestamp_ms(arg6));
    }

    public fun liquidate_by_price_direct<T0>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg4: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg2);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg2);
        assert_collateral_binding<T0>(arg1, arg3, v0);
        assert_default_access(arg0, arg2, 0x2::tx_context::sender(arg6));
        let v1 = assert_price_liquidatable(arg1, arg2, arg4, arg5);
        let v2 = 0;
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg2) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_direct_claim()) {
            v2 = seize_to_lender<T0>(arg0, arg2, arg3, arg5, arg6);
        };
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_liquidation_price(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_liquidated(arg2, v1, arg5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_liquidated(v0, v2, v1, *0x1::option::borrow<u64>(&v3), 0x2::clock::timestamp_ms(arg5));
    }

    public fun liquidator_buyout<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg4: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg5: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg9)), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg6) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_buyout_amount());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_status(arg3);
        assert!(v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_defaulted() || v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_liquidated(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg3) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_liquidator_buyout(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg3);
        assert_request_bindings<T0, T1, T2>(arg1, arg2, arg4, v1);
        assert_pooled_loan<T0, T1, T2>(arg3, arg2);
        let v2 = 0x2::coin::value<T0>(&arg6);
        assert!(v2 >= buyout_min_payment(arg0, arg1, v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_amount(arg3), arg5, arg8), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_buyout_amount());
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::seize_collateral<T1>(arg4, arg7, arg9);
        let v4 = bps_of(v2, arg0.fee_liq_principal_bps);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg6, v4, arg9), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_liq_principal(), v4, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg8));
        };
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::get_mode<T0, T1, T2>(arg2) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::vault_mode_collecting()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_funded<T0, T1, T2>(arg2, arg8, arg9), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::get_borrower<T0, T1, T2>(arg2));
        };
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::record_default_buyout<T0, T1, T2>(arg2, arg6, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_default_status<T0, T1, T2>(arg2, arg8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg7);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_bought_out(arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_last_price(arg3), arg8);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_liquidation_settled(v1, 0x2::tx_context::sender(arg9), v2, 0x2::coin::value<T1>(&v3), arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public fun liquidator_buyout_direct<T0, T1>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg8)), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg5) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_buyout_amount());
        assert_direct_loan(arg2);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_status(arg2);
        assert!(v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_defaulted() || v0 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::loan_liquidated(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_policy(arg2) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_liquidator_buyout(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg2);
        assert_collateral_binding<T1>(arg1, arg3, v1);
        let v2 = 0x2::coin::value<T0>(&arg5);
        assert!(v2 >= buyout_min_payment(arg0, arg1, v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_collateral_amount(arg2), arg4, arg7), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_buyout_amount());
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::seize_collateral<T1>(arg3, arg6, arg8);
        let v4 = bps_of(v2, arg0.fee_liq_principal_bps);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v4, arg8), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_liq_principal(), v4, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg7));
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_lender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg6);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_bought_out(arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_last_price(arg2), arg7);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_liquidation_settled(v1, 0x2::tx_context::sender(arg8), v2, 0x2::coin::value<T1>(&v3), arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun liquidator_settle_active_request<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg8)), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg5) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_buyout_amount());
        assert_request_bindings<T0, T1, T2>(arg1, arg2, arg3, arg6);
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_status(arg1, arg6) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::request_active(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_policy(arg1, arg6) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_types::collateral_policy_liquidator_buyout(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::is_locked<T1>(arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::collateral_not_pledged());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::total_shares<T0, T1, T2>(arg2) > 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        assert!(0x2::clock::timestamp_ms(arg7) < 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_created_at_ms(arg1, arg6) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_funding_window_secs(arg1, arg6) * 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::funding_window_expired());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg6), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::assert_request_oracle_matches(arg1, arg6, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg4));
        require_oracle_whitelisted(arg1, arg4);
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_price(arg1, arg6);
        assert!(0x1::option::is_some<u64>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::assert_fresh_with_reference(arg4, arg7) < *0x1::option::borrow<u64>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_triggered());
        let v1 = 0x2::coin::value<T0>(&arg5);
        assert!(v1 >= buyout_min_payment(arg0, arg1, arg6, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal(arg1, arg6), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_required(arg1, arg6), arg4, arg7), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_buyout_amount());
        let v2 = bps_of(v1, arg0.fee_liq_principal_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v2, arg8), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_liq_principal(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg7));
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::seize_collateral<T1>(arg3, 0x2::tx_context::sender(arg8), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg8));
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::mark_cancelled(arg1, arg6);
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::is_collecting<T0, T1, T2>(arg2)) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_closed<T0, T1, T2>(arg2, arg7);
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_liquidation_settled(arg6, 0x2::tx_context::sender(arg8), v1, 0x2::coin::value<T1>(&v3), 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7));
    }

    public fun liquidator_surplus_bps(arg0: &SettlementEngine) : u64 {
        arg0.liquidator_surplus_bps
    }

    fun match_direct_internal<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert_collateral_binding<T1>(arg1, arg2, arg4);
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::is_locked<T1>(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::collateral_not_pledged());
        if (!arg8) {
            let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_price(arg1, arg4);
            assert!(0x1::option::is_none<u64>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        };
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg4);
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_principal_amount());
        let v4 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_posted<T1>(arg2);
        assert!(v4 >= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_required(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_collateral());
        if (arg8 && arg0.min_collateral_ratio_bps > 0) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::verify_oracle_collateralization(v4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token_decimals(arg1, arg4), arg5, v3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal_token_decimals(arg1, arg4), arg6, arg7, arg0.min_collateral_ratio_bps);
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::authorize_match(arg1, arg4, v2, v2 == arg0.admin, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_matched(arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::create_for_match(arg4, v1, v2, v3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_interest_rate_schedule(arg1, arg4), v4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_policy(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_trigger(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_duration_secs(arg1, arg4), arg5, false, 0x1::option::none<0x2::object::ID>(), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_price(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_oracle_feed_id(arg1, arg4), arg9, arg10), 0x1::option::none<0x2::object::ID>(), false, v1, v2, v3, v4, 0x2::clock::timestamp_ms(arg9) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_duration_secs(arg1, arg4) * 1000, 0x2::clock::timestamp_ms(arg9));
    }

    fun match_internal<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert_request_bindings<T0, T1, T2>(arg1, arg2, arg3, arg4);
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::is_locked<T1>(arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::collateral_not_pledged());
        if (!arg8) {
            let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_price(arg1, arg4);
            assert!(0x1::option::is_none<u64>(&v0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::liquidation_not_configured());
        };
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg4);
        if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::is_soft_match<T0, T1, T2>(arg2)) {
            assert!(0x2::tx_context::sender(arg10) == v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        } else {
            let v2 = if (0x2::tx_context::sender(arg10) == v1) {
                true
            } else if (0x2::tx_context::sender(arg10) == arg0.admin) {
                true
            } else {
                is_processor(arg0, 0x2::tx_context::sender(arg10))
            };
            assert!(v2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        };
        let v3 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_posted<T1>(arg3);
        assert!(v3 >= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_required(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_collateral());
        if (arg8 && arg0.min_collateral_ratio_bps > 0) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::verify_oracle_collateralization(v3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token_decimals(arg1, arg4), arg5, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal_token_decimals(arg1, arg4), arg6, arg7, arg0.min_collateral_ratio_bps);
        };
        let v4 = 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>>(arg2);
        let v5 = 0x2::object::id_to_address(&v4);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::authorize_match(arg1, arg4, v5, 0x2::tx_context::sender(arg10) == arg0.admin, arg9);
        let v6 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_funded<T0, T1, T2>(arg2, arg9, arg10);
        let v7 = 0x2::coin::value<T0>(&v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v1);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_matched(arg4, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::create_for_match(arg4, v1, v5, v7, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_interest_rate_schedule(arg1, arg4), v3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_policy(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_trigger(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_duration_secs(arg1, arg4), arg5, true, 0x1::option::some<0x2::object::ID>(v4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_liquidation_price(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_oracle_feed_id(arg1, arg4), arg9, arg10), 0x1::option::some<0x2::object::ID>(v4), true, v1, v5, v7, v3, 0x2::clock::timestamp_ms(arg9) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_duration_secs(arg1, arg4) * 1000, 0x2::clock::timestamp_ms(arg9));
    }

    public fun match_request<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(arg0.min_collateral_ratio_bps == 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_not_whitelisted());
        match_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0, 0, 0, false, arg5, arg6);
    }

    public fun match_request_direct<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg4), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(arg0.min_collateral_ratio_bps == 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_not_whitelisted());
        match_direct_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, 0, 0, false, arg5, arg6);
    }

    public fun match_request_direct_oracle<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg5), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::assert_request_oracle_matches(arg1, arg5, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg3));
        require_oracle_whitelisted(arg1, arg3);
        let (v0, v1) = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::assert_buyout_prices_with_reference(arg3, arg6);
        match_direct_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, v0, v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::get_decimals(arg3), true, arg6, arg7);
    }

    public fun match_request_oracle<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_has_oracle(arg1, arg5), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::assert_request_oracle_matches(arg1, arg5, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg4));
        require_oracle_whitelisted(arg1, arg4);
        let (v0, v1) = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::assert_buyout_prices_with_reference(arg4, arg6);
        match_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, v0, v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::get_decimals(arg4), true, arg6, arg7);
    }

    public fun migrate(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = arg0.version;
        assert!(v0 < 1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        if (v0 < 3) {
            arg0.pending_admin = 0x1::option::none<address>();
        };
        arg0.version = 1;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_object_migrated(0x2::object::id<SettlementEngine>(arg0), v0, 1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun min_collateral_ratio_bps(arg0: &SettlementEngine) : u64 {
        arg0.min_collateral_ratio_bps
    }

    public fun pause(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.paused = true;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), 30, v0);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_paused(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), v0);
    }

    public fun pledge_collateral<T0>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg3);
        assert!(0x2::tx_context::sender(arg6) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_request_id<T0>(arg2) == arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token(arg1, arg3);
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_collateral_token<T0>(arg2) == v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::get_required<T0>(arg2) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_required(arg1, arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::insufficient_collateral());
        let v2 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::registered_collateral_vault(arg1, arg3);
        if (0x1::option::is_none<0x2::object::ID>(&v2)) {
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::register_collateral_vault(arg1, arg3, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>>(arg2));
        } else {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>>(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_collateral_pledged(arg3, v0, v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::pledge<T0>(arg2, arg4, arg6), 0x2::clock::timestamp_ms(arg5));
    }

    public fun processor_cancel_grace_secs(arg0: &SettlementEngine) : u64 {
        arg0.processor_cancel_grace_secs
    }

    public fun processor_cancel_offer_v2<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: ProcessorCancelPermitV2<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::paused());
        assert!(is_processor(arg0, 0x2::tx_context::sender(arg7)), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(arg4.request_id == arg5, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg5);
        assert!(arg4.borrower == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg6) < arg4.expires_at_ms, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::processor_cancel_permit_expired());
        assert!(0x2::clock::timestamp_ms(arg6) >= 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_created_at_ms(arg1, arg5) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_funding_window_secs(arg1, arg5) * 1000 + arg0.processor_cancel_grace_secs * 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::processor_cancel_too_early());
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::total_assets<T0, T1, T2>(arg2);
        let v2 = if (0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::is_locked<T1>(arg3) && v1 > 0) {
            bps_of(v1, arg0.cancel_penalty_bps)
        } else {
            0
        };
        assert!(v2 <= arg4.max_penalty, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::cancel_penalty_exceeds_permit());
        assert!(0x2::balance::value<T0>(&arg4.escrow) >= v2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v3 = if (v2 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg4.escrow, v2), arg7)
        } else {
            0x2::coin::zero<T0>(arg7)
        };
        apply_cancel_penalty<T0, T1, T2>(arg0, arg2, arg3, v3, arg5, v0, arg6, arg7);
        let ProcessorCancelPermitV2 {
            id            : v4,
            request_id    : _,
            borrower      : _,
            expires_at_ms : _,
            max_penalty   : _,
            escrow        : v9,
        } = arg4;
        0x2::object::delete(v4);
        let v10 = 0x2::coin::from_balance<T0>(v9, arg7);
        if (0x2::coin::value<T0>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v10);
        };
        finalize_cancel<T0, T1, T2>(arg1, arg2, arg3, arg5, v0, arg6, arg7);
    }

    public fun propose_admin(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        assert!(0x1::option::is_none<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        arg0.pending_admin = 0x1::option::some<address>(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_proposed(0x2::object::id<SettlementEngine>(arg0), arg0.admin, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun protocol_treasury(arg0: &SettlementEngine) : address {
        arg0.protocol_treasury
    }

    fun remove_address_from_vector(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_liquidator(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        if (vec_contains_addr(&arg0.liquidators, arg2)) {
            let v0 = &mut arg0.liquidators;
            remove_address_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_liquidator_removed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun remove_processor(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        if (vec_contains_addr(&arg0.processors, arg2)) {
            let v0 = &mut arg0.processors;
            remove_address_from_vector(v0, arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_processor_removed(arg2, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun repay<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg3: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_pooled_loan<T0, T1, T2>(arg2, arg1);
        assert!(0x2::tx_context::sender(arg6) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_borrower(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg5) < 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_due_at_ms(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        if (!0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::is_interest_locked(arg2)) {
            let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_interest_rate_schedule(arg2);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::lock_interest(arg2, calculate_interest(&v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg2), (0x2::clock::timestamp_ms(arg5) - 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_opened_at_ms(arg2)) / 1000));
        };
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_interest_due(arg2);
        assert!(0x2::coin::value<T0>(&arg4) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg2) + v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v2 = bps_of(v1, arg0.fee_repay_interest_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v2, arg6), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_repay_interest(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg5));
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::record_repayment<T0, T1, T2>(arg1, arg4);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_repaid_full(arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::release_collateral<T1>(arg3, arg6), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_borrower(arg2));
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_repaid<T0, T1, T2>(arg1, arg5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_repaid(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg2), v1, 0x2::clock::timestamp_ms(arg5));
    }

    public fun repay_direct<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg1);
        assert!(0x2::tx_context::sender(arg5) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_borrower(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg4) < 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_due_at_ms(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        if (!0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::is_interest_locked(arg1)) {
            let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_interest_rate_schedule(arg1);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::lock_interest(arg1, calculate_interest(&v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg1), (0x2::clock::timestamp_ms(arg4) - 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_opened_at_ms(arg1)) / 1000));
        };
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_interest_due(arg1);
        assert!(0x2::coin::value<T0>(&arg3) == 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg1) + v1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        let v2 = bps_of(v1, arg0.fee_repay_interest_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg5), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_repay_interest(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_lender(arg1));
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::mark_repaid_full(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::release_collateral<T1>(arg2, arg5), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_borrower(arg1));
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_loan_repaid(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_request_id(arg1), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_principal(arg1), v1, 0x2::clock::timestamp_ms(arg4));
    }

    fun require_oracle_whitelisted(arg0: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed) {
        assert!(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::is_whitelisted_oracle(arg0, 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_oracle_iface::OracleFeed>(arg1)), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::oracle_not_whitelisted());
    }

    public fun revoke_processor_cancel_permit_v2<T0>(arg0: ProcessorCancelPermitV2<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.borrower, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let ProcessorCancelPermitV2 {
            id            : v0,
            request_id    : _,
            borrower      : _,
            expires_at_ms : _,
            max_penalty   : _,
            escrow        : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v5, arg1)
    }

    fun seize_and_fund_vault<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>>(arg1);
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::seize_collateral<T1>(arg2, 0x2::object::id_to_address(&v0), arg5);
        let v2 = 0x2::coin::value<T1>(&v1);
        let v3 = bps_of(v2, arg0.fee_default_collateral_bps);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1, v3, arg5), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_default_collateral(), v3, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg4));
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::mark_default<T0, T1, T2>(arg1, v1, arg3, arg4);
        v2
    }

    fun seize_to_lender<T0>(arg0: &SettlementEngine, arg1: &0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::LoanPosition, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::CollateralVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_collateral_vault::seize_collateral<T0>(arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_lender(arg1), arg4);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = bps_of(v1, arg0.fee_default_collateral_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v2, arg4), arg0.protocol_treasury);
            0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_fee(0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::fee_kind_default_collateral(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_loan_position::get_lender(arg1));
        v1
    }

    public fun set_cancel_penalty_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.cancel_penalty_bps = arg2;
    }

    public fun set_cancel_penalty_protocol_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 10000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.cancel_penalty_protocol_bps = arg2;
    }

    public fun set_fee_default_collateral_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.fee_default_collateral_bps = arg2;
    }

    public fun set_fee_liq_principal_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.fee_liq_principal_bps = arg2;
    }

    public fun set_fee_repay_interest_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 50, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.fee_repay_interest_bps = arg2;
    }

    public fun set_lending_vault_deposits_paused<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg5);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::set_deposits_paused<T0, T1, T2>(arg2, arg3);
        let v0 = if (arg3) {
            32
        } else {
            33
        };
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg5), v0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_liquidator_surplus_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 2500, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.liquidator_surplus_bps = arg2;
    }

    public fun set_min_collateral_ratio_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 100000, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_argument());
        arg0.min_collateral_ratio_bps = arg2;
    }

    public fun set_processor_cancel_grace_secs(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.processor_cancel_grace_secs = arg2;
    }

    public fun set_protocol_treasury_with_claim(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: TreasuryClaim, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        let TreasuryClaim {
            id        : v0,
            engine_id : v1,
            treasury  : v2,
        } = arg2;
        assert!(v1 == 0x2::object::id<SettlementEngine>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        0x2::object::delete(v0);
        arg0.protocol_treasury = v2;
    }

    public fun unpause(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.paused = false;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), 31, v0);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_protocol_unpaused(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), v0);
    }

    fun vec_contains_addr(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

