module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_settlement_engine {
    struct EngineAdminCap has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
    }

    struct EngineOperatorCap has store, key {
        id: 0x2::object::UID,
        engine_id: 0x2::object::ID,
    }

    struct SettlementEngine has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
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

    public fun sweep_mistaken_principal<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::sweep_mistaken_principal<T0, T1, T2>(arg2, arg3), arg0.protocol_treasury);
    }

    public fun sweep_surplus<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::sweep_surplus<T0, T1, T2>(arg2, arg3), arg0.protocol_treasury);
    }

    public fun add_liquidator(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        if (!vec_contains_addr(&arg0.liquidators, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.liquidators, arg2);
        };
    }

    public fun add_processor(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        if (!vec_contains_addr(&arg0.processors, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.processors, arg2);
        };
    }

    fun assert_admin(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
    }

    fun assert_collateral_binding<T0>(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T0>, arg1: u64) {
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::get_request_id<T0>(arg0) == arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
    }

    fun assert_default_access(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg2: address) {
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_liquidation_trigger(arg1) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::liquidation_trigger_whitelisted_only()) {
            assert!(is_liquidator(arg0, arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_liquidator());
        };
    }

    fun assert_direct_loan(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition) {
        assert!(!0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::is_vault_loan(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
    }

    fun assert_matured(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_due_at_ms(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::loan_not_matured());
    }

    fun assert_pooled_loan<T0, T1, T2: key>(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>) {
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::is_vault_loan(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_vault_id(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0) && *0x1::option::borrow<0x2::object::ID>(&v0) == 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>>(arg1), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
    }

    fun assert_price_liquidatable(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg2: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_oracle_feed_id(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::liquidation_not_configured());
        let v1 = 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed>(arg2);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::is_whitelisted_oracle(arg0, v1), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_not_whitelisted());
        let v2 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_liquidation_price(arg1);
        assert!(0x1::option::is_some<u64>(&v2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::liquidation_not_configured());
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::assert_fresh(arg2, arg3);
        assert!(v3 < *0x1::option::borrow<u64>(&v2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::liquidation_not_triggered());
        v3
    }

    fun assert_request_bindings<T0, T1, T2: key>(arg0: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg2: u64) {
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::get_request_id<T0, T1, T2>(arg0) == arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::get_request_id<T1>(arg1) == arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
    }

    fun assert_version(arg0: &SettlementEngine) {
        assert!(arg0.version == 2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::wrong_version());
    }

    fun buyout_min_payment(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: u64, arg3: u64, arg4: u64, arg5: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg6: &0x2::clock::Clock) : u64 {
        let v0 = if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_has_oracle(arg1, arg2)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::assert_request_oracle_matches(arg1, arg2, 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed>(arg5));
            (arg4 as u128) * (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::assert_fresh(arg5, arg6) as u128)
        } else {
            let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_ltv_bps(arg1, arg2);
            assert!(v1 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::ltv_not_configured());
            (arg3 as u128) * (10000 as u128) / (v1 as u128)
        };
        ((v0 * ((10000 - arg0.liquidator_surplus_bps) as u128) / (10000 as u128)) as u64)
    }

    fun calculate_interest(arg0: &vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(arg0)) {
            let v2 = 0x1::vector::borrow<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(arg0, v1);
            if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_from_seconds(v2) <= arg2) {
                v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::tier_rate_bps(v2);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        arg1 * v0 / 10000
    }

    public fun cancel_borrower_offer<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg5);
        assert!(0x2::tx_context::sender(arg7) == v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_principal(arg1, arg5) * arg0.cancel_penalty_bps / 10000;
        assert!(0x2::coin::value<T0>(&arg4) == v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(arg4);
        } else {
            let v2 = v1 * arg0.cancel_penalty_protocol_bps / 10000;
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v2, arg7), arg0.protocol_treasury);
                0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_cancel_penalty(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg6));
            };
            if (v1 - v2 > 0) {
                if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::total_shares<T0, T1, T2>(arg2) > 0) {
                    0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::receive_cancel_penalty<T0, T1, T2>(arg2, arg4);
                } else {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg0.protocol_treasury);
                };
            } else {
                0x2::coin::destroy_zero<T0>(arg4);
            };
        };
        finalize_cancel<T0, T1, T2>(arg1, arg2, arg3, arg5, v0, arg6, arg7);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_cancel_penalty_paid(arg5, v0, v1, 0x2::clock::timestamp_ms(arg6));
    }

    public fun cancel_penalty_bps(arg0: &SettlementEngine) : u64 {
        arg0.cancel_penalty_bps
    }

    public fun cancel_penalty_protocol_bps(arg0: &SettlementEngine) : u64 {
        arg0.cancel_penalty_protocol_bps
    }

    public fun claim_default<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg2);
        assert_request_bindings<T0, T1, T2>(arg1, arg3, v0);
        assert_pooled_loan<T0, T1, T2>(arg2, arg1);
        assert_default_access(arg0, arg2, 0x2::tx_context::sender(arg6));
        assert_matured(arg2, arg5);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_default(arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_last_price(arg2), arg5);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_defaulted(v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg2), 0x2::clock::timestamp_ms(arg5));
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg2) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim()) {
            seize_and_fund_vault<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5, arg6);
        };
    }

    public fun claim_default_direct<T0>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg1);
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg1);
        assert_collateral_binding<T0>(arg2, v0);
        assert_default_access(arg0, arg1, 0x2::tx_context::sender(arg4));
        assert_matured(arg1, arg3);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_default(arg1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_last_price(arg1), arg3);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_defaulted(v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg1), 0x2::clock::timestamp_ms(arg3));
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg1) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim()) {
            seize_to_lender<T0>(arg0, arg1, arg2, arg3, arg4);
        };
    }

    public fun create_engine(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (EngineAdminCap, EngineOperatorCap) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        let v1 = SettlementEngine{
            id                          : 0x2::object::new(arg2),
            version                     : 2,
            admin                       : arg0,
            operator                    : arg1,
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
        let v2 = 0x2::object::id<SettlementEngine>(&v1);
        0x2::transfer::share_object<SettlementEngine>(v1);
        let v3 = EngineAdminCap{
            id        : 0x2::object::new(arg2),
            engine_id : v2,
        };
        let v4 = EngineOperatorCap{
            id        : 0x2::object::new(arg2),
            engine_id : v2,
        };
        (v3, v4)
    }

    public fun engine_version(arg0: &SettlementEngine) : u64 {
        arg0.version
    }

    public fun expire_unfunded_offer<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg5) >= 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_created_at_ms(arg1, arg4) + 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_funding_window_secs(arg1, arg4) * 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::funding_window_active());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg4);
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

    fun finalize_cancel<T0, T1, T2: key>(arg0: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::mark_cancelled(arg0, arg3);
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collecting<T0, T1, T2>(arg1)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_closed<T0, T1, T2>(arg1, arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::unwind<T1>(arg2, arg6), arg4);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_borrow_request_cancelled(arg3, 0x2::clock::timestamp_ms(arg5));
    }

    public fun force_vault_default<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &EngineAdminCap, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_status(arg3);
        assert!(v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_defaulted() || v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_liquidated(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_default_status<T0, T1, T2>(arg2, arg4);
    }

    public fun get_admin(arg0: &SettlementEngine) : address {
        arg0.admin
    }

    public fun get_operator(arg0: &SettlementEngine) : address {
        arg0.operator
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

    public fun liquidate_by_price<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg4: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg5: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg3);
        assert_request_bindings<T0, T1, T2>(arg2, arg4, v0);
        assert_pooled_loan<T0, T1, T2>(arg3, arg2);
        assert_default_access(arg0, arg3, 0x2::tx_context::sender(arg8));
        let v1 = 0;
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg3) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim()) {
            v1 = seize_and_fund_vault<T0, T1, T2>(arg0, arg2, arg4, arg6, arg7, arg8);
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_liquidated(arg3, assert_price_liquidatable(arg1, arg3, arg5, arg7), arg7);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_liquidated(v0, v1, 0x2::clock::timestamp_ms(arg7));
    }

    public fun liquidate_by_price_direct<T0>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T0>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg2);
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg2);
        assert_collateral_binding<T0>(arg3, v0);
        assert_default_access(arg0, arg2, 0x2::tx_context::sender(arg6));
        let v1 = 0;
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg2) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_direct_claim()) {
            v1 = seize_to_lender<T0>(arg0, arg2, arg3, arg5, arg6);
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_liquidated(arg2, assert_price_liquidatable(arg1, arg2, arg4, arg5), arg5);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_liquidated(v0, v1, 0x2::clock::timestamp_ms(arg5));
    }

    public fun liquidator_buyout<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg4: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg5: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg6: 0x2::coin::Coin<T0>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg9)), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg6) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_buyout_amount());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_status(arg3);
        assert!(v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_defaulted() || v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_liquidated(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg3) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_liquidator_buyout(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg3);
        assert_request_bindings<T0, T1, T2>(arg2, arg4, v1);
        assert_pooled_loan<T0, T1, T2>(arg3, arg2);
        let v2 = 0x2::coin::value<T0>(&arg6);
        assert!(v2 >= buyout_min_payment(arg0, arg1, v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_amount(arg3), arg5, arg8), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::insufficient_buyout_amount());
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::seize_collateral<T1>(arg4, arg9);
        let v4 = v2 * arg0.fee_liq_principal_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg6, v4, arg9), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_liq_principal(), v4, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg8));
        };
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::get_mode<T0, T1, T2>(arg2) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::vault_mode_collecting()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_funded<T0, T1, T2>(arg2, arg8, arg9), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::get_borrower<T0, T1, T2>(arg2));
        };
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::record_default_buyout<T0, T1, T2>(arg2, arg6, arg8);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_default_status<T0, T1, T2>(arg2, arg8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg7);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_bought_out(arg3, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_last_price(arg3), arg8);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_liquidation_settled(v1, 0x2::tx_context::sender(arg9), v2, 0x2::coin::value<T1>(&v3), arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public fun liquidator_buyout_direct<T0, T1>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg5: 0x2::coin::Coin<T0>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg8)), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg5) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_buyout_amount());
        assert_direct_loan(arg2);
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_status(arg2);
        assert!(v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_defaulted() || v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_liquidated(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_policy(arg2) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_liquidator_buyout(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg2);
        assert_collateral_binding<T1>(arg3, v1);
        let v2 = 0x2::coin::value<T0>(&arg5);
        assert!(v2 >= buyout_min_payment(arg0, arg1, v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_collateral_amount(arg2), arg4, arg7), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::insufficient_buyout_amount());
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::seize_collateral<T1>(arg3, arg8);
        let v4 = v2 * arg0.fee_liq_principal_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v4, arg8), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_liq_principal(), v4, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg7));
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_lender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg6);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_bought_out(arg2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_last_price(arg2), arg7);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_liquidation_settled(v1, 0x2::tx_context::sender(arg8), v2, 0x2::coin::value<T1>(&v3), arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun liquidator_settle_active_request<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert!(is_liquidator(arg0, 0x2::tx_context::sender(arg8)), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_liquidator());
        assert!(0x2::coin::value<T0>(&arg5) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_buyout_amount());
        assert_request_bindings<T0, T1, T2>(arg2, arg3, arg6);
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_status(arg1, arg6) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::request_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_policy(arg1, arg6) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::collateral_policy_liquidator_buyout(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::is_locked<T1>(arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::collateral_not_pledged());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::total_shares<T0, T1, T2>(arg2) > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        assert!(0x2::clock::timestamp_ms(arg7) < 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_created_at_ms(arg1, arg6) + 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_funding_window_secs(arg1, arg6) * 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::funding_window_expired());
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= buyout_min_payment(arg0, arg1, arg6, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_principal(arg1, arg6), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_required(arg1, arg6), arg4, arg7), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::insufficient_buyout_amount());
        let v1 = v0 * arg0.fee_liq_principal_bps / 10000;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg5, v1, arg8), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_liq_principal(), v1, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg7));
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg6));
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        let v2 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::release_collateral<T1>(arg3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg8));
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::mark_cancelled(arg1, arg6);
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_collecting<T0, T1, T2>(arg2)) {
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_closed<T0, T1, T2>(arg2, arg7);
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_liquidation_settled(arg6, 0x2::tx_context::sender(arg8), v0, 0x2::coin::value<T1>(&v2), 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7));
    }

    public fun liquidator_surplus_bps(arg0: &SettlementEngine) : u64 {
        arg0.liquidator_surplus_bps
    }

    fun match_direct_internal<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert_collateral_binding<T1>(arg2, arg4);
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::is_locked<T1>(arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::collateral_not_pledged());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg4);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_principal(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_principal_amount());
        if (arg6 && arg0.min_collateral_ratio_bps > 0) {
            verify_collateralization(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_required(arg1, arg4), v2, arg5, arg0.min_collateral_ratio_bps);
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::authorize_match(arg1, arg4, v1, v1 == arg0.admin, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        let v3 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::get_posted<T1>(arg2);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_matched(arg4, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::create_for_match(arg4, v0, v1, v2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_interest_rate_schedule(arg1, arg4), v3, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_policy(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_liquidation_trigger(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_duration_secs(arg1, arg4), arg5, false, 0x1::option::none<0x2::object::ID>(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_liquidation_price(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_oracle_feed_id(arg1, arg4), arg7, arg8), 0x1::option::none<0x2::object::ID>(), false, v0, v1, v2, v3, 0x2::clock::timestamp_ms(arg7) + 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_duration_secs(arg1, arg4) * 1000, 0x2::clock::timestamp_ms(arg7));
    }

    fun match_internal<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert_request_bindings<T0, T1, T2>(arg2, arg3, arg4);
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::is_locked<T1>(arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::collateral_not_pledged());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg4);
        if (0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::is_soft_match<T0, T1, T2>(arg2)) {
            assert!(0x2::tx_context::sender(arg8) == v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        } else {
            let v1 = if (0x2::tx_context::sender(arg8) == v0) {
                true
            } else if (0x2::tx_context::sender(arg8) == arg0.admin) {
                true
            } else {
                is_processor(arg0, 0x2::tx_context::sender(arg8))
            };
            assert!(v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        };
        if (arg6 && arg0.min_collateral_ratio_bps > 0) {
            verify_collateralization(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_required(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_principal(arg1, arg4), arg5, arg0.min_collateral_ratio_bps);
        };
        let v2 = 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>>(arg2);
        let v3 = 0x2::object::id_to_address(&v2);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::authorize_match(arg1, arg4, v3, 0x2::tx_context::sender(arg8) == arg0.admin, arg7);
        let v4 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::get_posted<T1>(arg3);
        let v5 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_funded<T0, T1, T2>(arg2, arg7, arg8);
        let v6 = 0x2::coin::value<T0>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_matched(arg4, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::create_for_match(arg4, v0, v3, v6, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_interest_rate_schedule(arg1, arg4), v4, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_policy(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_liquidation_trigger(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_duration_secs(arg1, arg4), arg5, true, 0x1::option::some<0x2::object::ID>(v2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_liquidation_price(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_oracle_feed_id(arg1, arg4), arg7, arg8), 0x1::option::some<0x2::object::ID>(v2), true, v0, v3, v6, v4, 0x2::clock::timestamp_ms(arg7) + 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_duration_secs(arg1, arg4) * 1000, 0x2::clock::timestamp_ms(arg7));
    }

    public fun match_request<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_has_oracle(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(arg0.min_collateral_ratio_bps == 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_not_whitelisted());
        match_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0, false, arg5, arg6);
    }

    public fun match_request_direct<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_has_oracle(arg1, arg4), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        assert!(arg0.min_collateral_ratio_bps == 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_not_whitelisted());
        match_direct_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0, false, arg5, arg6);
    }

    public fun match_request_direct_oracle<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_has_oracle(arg1, arg5), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::assert_request_oracle_matches(arg1, arg5, 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed>(arg3));
        match_direct_internal<T0, T1>(arg0, arg1, arg2, arg4, arg5, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::assert_fresh(arg3, arg6), true, arg6, arg7);
    }

    public fun match_request_oracle<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_has_oracle(arg1, arg5), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::assert_request_oracle_matches(arg1, arg5, 0x2::object::id<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::OracleFeed>(arg4));
        match_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface::assert_fresh(arg4, arg6), true, arg6, arg7);
    }

    public fun migrate(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.engine_id == 0x2::object::id<SettlementEngine>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        let v0 = arg0.version;
        assert!(v0 < 2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.version = 2;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_object_migrated(0x2::object::id<SettlementEngine>(arg0), v0, 2, 0x2::clock::timestamp_ms(arg2));
    }

    public fun min_collateral_ratio_bps(arg0: &SettlementEngine) : u64 {
        arg0.min_collateral_ratio_bps
    }

    public fun pause(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.paused = true;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), 30, 0x2::clock::timestamp_ms(arg2));
    }

    public fun pledge_collateral<T0>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T0>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg3);
        assert!(0x2::tx_context::sender(arg6) == v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::get_request_id<T0>(arg2) == arg3, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_collateral_pledged(arg3, v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_collateral_token(arg1, arg3), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::pledge<T0>(arg2, arg4, arg6), 0x2::clock::timestamp_ms(arg5));
    }

    public fun processor_cancel_grace_secs(arg0: &SettlementEngine) : u64 {
        arg0.processor_cancel_grace_secs
    }

    public fun processor_cancel_offer<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::OfferBook, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::paused());
        assert!(is_processor(arg0, 0x2::tx_context::sender(arg6)), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg5) >= 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_created_at_ms(arg1, arg4) + 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_funding_window_secs(arg1, arg4) * 1000 + arg0.processor_cancel_grace_secs * 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::processor_cancel_too_early());
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_offer_book::request_borrower(arg1, arg4);
        finalize_cancel<T0, T1, T2>(arg1, arg2, arg3, arg4, v0, arg5, arg6);
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

    public fun remove_liquidator(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        let v0 = &mut arg0.liquidators;
        remove_address_from_vector(v0, arg2);
    }

    public fun remove_processor(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        let v0 = &mut arg0.processors;
        remove_address_from_vector(v0, arg2);
    }

    public fun repay<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg3: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_pooled_loan<T0, T1, T2>(arg2, arg1);
        assert!(0x2::tx_context::sender(arg6) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_borrower(arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg5) < 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_due_at_ms(arg2), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        if (!0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::is_interest_locked(arg2)) {
            let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_interest_rate_schedule(arg2);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::lock_interest(arg2, calculate_interest(&v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg2), (0x2::clock::timestamp_ms(arg5) - 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_opened_at_ms(arg2)) / 1000));
        };
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_interest_due(arg2);
        let v2 = 0x2::coin::value<T0>(&arg4);
        assert!(v2 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg2) + v1, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        let v3 = v1 * arg0.fee_repay_interest_bps / 10000;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v3, arg6), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_repay_interest(), v3, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg5));
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::record_repayment<T0, T1, T2>(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::release_collateral<T1>(arg3, arg6), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_borrower(arg2));
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_repaid<T0, T1, T2>(arg1, arg5);
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_repaid(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg2), v2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_repaid_full(arg2, arg5), 0x2::clock::timestamp_ms(arg5));
    }

    public fun repay_direct<T0, T1>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_direct_loan(arg1);
        assert!(0x2::tx_context::sender(arg5) == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_borrower(arg1), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(0x2::clock::timestamp_ms(arg4) < 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_due_at_ms(arg1), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        if (!0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::is_interest_locked(arg1)) {
            let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_interest_rate_schedule(arg1);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::lock_interest(arg1, calculate_interest(&v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg1), (0x2::clock::timestamp_ms(arg4) - 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_opened_at_ms(arg1)) / 1000));
        };
        let v1 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_interest_due(arg1);
        let v2 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_principal(arg1) + v1;
        assert!(0x2::coin::value<T0>(&arg3) == v2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        let v3 = v1 * arg0.fee_repay_interest_bps / 10000;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg5), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_repay_interest(), v3, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_lender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::release_collateral<T1>(arg2, arg5), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_borrower(arg1));
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_loan_repaid(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_request_id(arg1), v2, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::mark_repaid_full(arg1, arg4), 0x2::clock::timestamp_ms(arg4));
    }

    fun seize_and_fund_vault<T0, T1, T2: key>(arg0: &SettlementEngine, arg1: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::LendingVault<T0, T1, T2>, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::seize_collateral<T1>(arg2, arg5);
        let v1 = 0x2::coin::value<T1>(&v0);
        let v2 = v1 * arg0.fee_default_collateral_bps / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0, v2, arg5), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_default_collateral(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg4));
        };
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_lending_vault::mark_default<T0, T1, T2>(arg1, v0, arg3, arg4);
        v1
    }

    fun seize_to_lender<T0>(arg0: &SettlementEngine, arg1: &0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::LoanPosition, arg2: &mut 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::CollateralVault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_collateral_vault::seize_collateral<T0>(arg2, arg4);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = v1 * arg0.fee_default_collateral_bps / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v2, arg4), arg0.protocol_treasury);
            0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_protocol_fee(0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::fee_kind_default_collateral(), v2, arg0.protocol_treasury, 0x2::clock::timestamp_ms(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position::get_lender(arg1));
        v1
    }

    public fun set_admin(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        arg0.admin = arg2;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg4), 32, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_cancel_penalty_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.cancel_penalty_bps = arg2;
    }

    public fun set_cancel_penalty_protocol_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 10000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.cancel_penalty_protocol_bps = arg2;
    }

    public fun set_fee_default_collateral_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.fee_default_collateral_bps = arg2;
    }

    public fun set_fee_liq_principal_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.fee_liq_principal_bps = arg2;
    }

    public fun set_fee_repay_interest_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 50, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.fee_repay_interest_bps = arg2;
    }

    public fun set_liquidator_surplus_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 2500, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.liquidator_surplus_bps = arg2;
    }

    public fun set_min_collateral_ratio_bps(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        assert!(arg2 <= 100000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_argument());
        arg0.min_collateral_ratio_bps = arg2;
    }

    public fun set_operator(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg4);
        arg0.operator = arg2;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg4), 33, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_processor_cancel_grace_secs(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.processor_cancel_grace_secs = arg2;
    }

    public fun set_protocol_treasury(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.protocol_treasury = arg2;
    }

    public fun unpause(arg0: &mut SettlementEngine, arg1: &EngineAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1, arg3);
        arg0.paused = false;
        0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_events::emit_admin_action(0x2::object::id<SettlementEngine>(arg0), 0x2::tx_context::sender(arg3), 31, 0x2::clock::timestamp_ms(arg2));
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

    fun verify_collateralization(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg2 as u128) * (10000 as u128) >= (arg1 as u128) * (arg3 as u128), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::insufficient_collateralization());
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

