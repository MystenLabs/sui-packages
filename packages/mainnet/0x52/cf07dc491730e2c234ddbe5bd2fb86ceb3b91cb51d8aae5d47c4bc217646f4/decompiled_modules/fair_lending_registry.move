module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::fair_lending_registry {
    struct FairLendingRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_applications: u64,
        total_approved: u64,
        total_rejected: u64,
        bias_audit_enabled: bool,
        minimum_credit_score: u64,
        maximum_dti_ratio: u64,
        decisions: 0x2::table::Table<address, LendingDecision>,
    }

    struct LendingDecision has copy, drop, store {
        borrower: address,
        application_timestamp: u64,
        decision_timestamp: u64,
        approved: bool,
        loan_amount: u64,
        credit_score: u64,
        debt_to_income_ratio: u64,
        crypto_collateral_value: u64,
        collateral_to_loan_ratio: u64,
        verified_income: u64,
        income_source: vector<u8>,
        decision_algorithm_version: vector<u8>,
        fairness_score: u64,
        rejection_reason: vector<u8>,
        demographic_data_excluded: bool,
    }

    struct FairnessAudit has store, key {
        id: 0x2::object::UID,
        audit_timestamp: u64,
        total_decisions_audited: u64,
        approval_rate: u64,
        average_fairness_score: u64,
        bias_detected: bool,
        audit_report_ipfs_hash: vector<u8>,
        auditor: address,
    }

    struct InclusiveMortgageApplication has key {
        id: 0x2::object::UID,
        borrower: address,
        home_price: u64,
        cash_down_payment: u64,
        crypto_collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        future_earnings_pledge: u64,
        community_guarantee: u64,
        traditional_income: u64,
        crypto_earnings: u64,
        gig_economy_income: u64,
        rental_income: u64,
        monthly_payment_capacity: u64,
        total_debt_obligations: u64,
        application_status: vector<u8>,
        decision: 0x1::option::Option<LendingDecision>,
    }

    struct CommunityGuaranteePool has key {
        id: 0x2::object::UID,
        total_pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_guaranteed: u64,
        active_guarantees: 0x2::table::Table<address, u64>,
        contributors: 0x2::table::Table<address, u64>,
        success_rate: u64,
    }

    struct AlternativeCreditScore has copy, drop, store {
        traditional_credit_score: u64,
        wallet_age_months: u64,
        transaction_history_score: u64,
        defi_participation_score: u64,
        community_endorsements: u64,
        payment_history_on_chain: u64,
        composite_score: u64,
    }

    struct ApplicationSubmitted has copy, drop {
        borrower: address,
        application_id: 0x2::object::ID,
        home_price: u64,
        total_down_payment_equivalent: u64,
        timestamp: u64,
    }

    struct DecisionMade has copy, drop {
        borrower: address,
        approved: bool,
        fairness_score: u64,
        decision_factors: vector<u8>,
        timestamp: u64,
    }

    struct FairnessAuditCompleted has copy, drop {
        audit_id: 0x2::object::ID,
        total_decisions_audited: u64,
        approval_rate: u64,
        bias_detected: bool,
        timestamp: u64,
    }

    struct CommunityGuaranteeUsed has copy, drop {
        borrower: address,
        guarantee_amount: u64,
        pool_remaining: u64,
        timestamp: u64,
    }

    public fun apply_community_guarantee(arg0: &mut InclusiveMortgageApplication, arg1: &mut CommunityGuaranteePool, arg2: u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.total_pool_balance);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        arg0.community_guarantee = v1;
        arg1.total_guaranteed = arg1.total_guaranteed + v1;
        0x2::table::add<address, u64>(&mut arg1.active_guarantees, arg0.borrower, v1);
        let v2 = CommunityGuaranteeUsed{
            borrower         : arg0.borrower,
            guarantee_amount : v1,
            pool_remaining   : v0 - v1,
            timestamp        : 0,
        };
        0x2::event::emit<CommunityGuaranteeUsed>(v2);
    }

    public fun calculate_alternative_credit_score(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : AlternativeCreditScore {
        let v0 = arg0 * 40 / 100 + arg1 * 5 + arg2 * 15 / 100 + arg3 * 10 / 100 + arg4 * 2 + arg5 * 10 / 100;
        let v1 = if (v0 > 850) {
            850
        } else {
            v0
        };
        AlternativeCreditScore{
            traditional_credit_score  : arg0,
            wallet_age_months         : arg1,
            transaction_history_score : arg2,
            defi_participation_score  : arg3,
            community_endorsements    : arg4,
            payment_history_on_chain  : arg5,
            composite_score           : v1,
        }
    }

    fun calculate_fairness_score(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 < 3000) {
            30
        } else {
            (5000 - arg1) * 30 / 2000
        };
        let v1 = if (arg2 > 2000) {
            30
        } else {
            arg2 * 30 / 2000
        };
        arg0 * 40 / 850 + v0 + v1
    }

    public fun conduct_fairness_audit(arg0: &FairLendingRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : FairnessAudit {
        let v0 = arg0.total_applications;
        let v1 = if (v0 > 0) {
            arg0.total_approved * 10000 / v0
        } else {
            0
        };
        let v2 = false;
        let v3 = FairnessAudit{
            id                      : 0x2::object::new(arg4),
            audit_timestamp         : 0x2::clock::timestamp_ms(arg3),
            total_decisions_audited : v0,
            approval_rate           : v1,
            average_fairness_score  : 75,
            bias_detected           : v2,
            audit_report_ipfs_hash  : arg2,
            auditor                 : arg1,
        };
        let v4 = FairnessAuditCompleted{
            audit_id                : 0x2::object::id<FairnessAudit>(&v3),
            total_decisions_audited : v0,
            approval_rate           : v1,
            bias_detected           : v2,
            timestamp               : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FairnessAuditCompleted>(v4);
        v3
    }

    public fun contribute_to_pool(arg0: &mut CommunityGuaranteePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_pool_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::table::contains<address, u64>(&arg0.contributors, v0)) {
            0x2::table::add<address, u64>(&mut arg0.contributors, v0, 0x2::table::remove<address, u64>(&mut arg0.contributors, v0) + 0x2::coin::value<0x2::sui::SUI>(&arg1));
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributors, v0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        };
    }

    public fun get_decision(arg0: &FairLendingRegistry, arg1: address) : LendingDecision {
        *0x2::table::borrow<address, LendingDecision>(&arg0.decisions, arg1)
    }

    public fun get_statistics(arg0: &FairLendingRegistry) : (u64, u64, u64, u64) {
        let v0 = if (arg0.total_applications > 0) {
            arg0.total_approved * 10000 / arg0.total_applications
        } else {
            0
        };
        (arg0.total_applications, arg0.total_approved, arg0.total_rejected, v0)
    }

    public fun init_community_pool(arg0: &mut 0x2::tx_context::TxContext) : CommunityGuaranteePool {
        CommunityGuaranteePool{
            id                 : 0x2::object::new(arg0),
            total_pool_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            total_guaranteed   : 0,
            active_guarantees  : 0x2::table::new<address, u64>(arg0),
            contributors       : 0x2::table::new<address, u64>(arg0),
            success_rate       : 10000,
        }
    }

    public fun init_registry(arg0: &mut 0x2::tx_context::TxContext) : FairLendingRegistry {
        FairLendingRegistry{
            id                   : 0x2::object::new(arg0),
            admin                : 0x2::tx_context::sender(arg0),
            total_applications   : 0,
            total_approved       : 0,
            total_rejected       : 0,
            bias_audit_enabled   : true,
            minimum_credit_score : 580,
            maximum_dti_ratio    : 5000,
            decisions            : 0x2::table::new<address, LendingDecision>(arg0),
        }
    }

    public fun make_fair_lending_decision(arg0: &mut FairLendingRegistry, arg1: &mut InclusiveMortgageApplication, arg2: AlternativeCreditScore, arg3: &0x2::clock::Clock) : LendingDecision {
        let v0 = arg1.borrower;
        let v1 = arg1.home_price - arg1.cash_down_payment;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.crypto_collateral) + arg1.future_earnings_pledge + arg1.community_guarantee;
        let v3 = arg1.traditional_income + arg1.crypto_earnings + arg1.gig_economy_income + arg1.rental_income;
        let v4 = if (v3 / 12 > 0) {
            arg1.total_debt_obligations * 10000 / v3
        } else {
            10000
        };
        let v5 = v2 * 10000 / v1;
        let v6 = arg2.composite_score >= arg0.minimum_credit_score;
        let v7 = v4 <= arg0.maximum_dti_ratio;
        let v8 = v5 >= 1500;
        let v9 = if (v6) {
            if (v7) {
                v8
            } else {
                false
            }
        } else {
            false
        };
        let v10 = calculate_fairness_score(arg2.composite_score, v4, v5);
        let v11 = if (!v6) {
            b"Credit score below minimum threshold. Consider building on-chain reputation."
        } else if (!v7) {
            b"Debt-to-income ratio exceeds maximum. Consider debt consolidation."
        } else if (!v8) {
            b"Collateral equivalent below 15%. Consider community guarantee pool."
        } else {
            b""
        };
        let v12 = LendingDecision{
            borrower                   : v0,
            application_timestamp      : 0x2::clock::timestamp_ms(arg3) - 1000,
            decision_timestamp         : 0x2::clock::timestamp_ms(arg3),
            approved                   : v9,
            loan_amount                : v1,
            credit_score               : arg2.composite_score,
            debt_to_income_ratio       : v4,
            crypto_collateral_value    : v2,
            collateral_to_loan_ratio   : v5,
            verified_income            : v3,
            income_source              : b"hybrid",
            decision_algorithm_version : b"FAIR_LEND_V1_0",
            fairness_score             : v10,
            rejection_reason           : v11,
            demographic_data_excluded  : true,
        };
        if (v9) {
            arg0.total_approved = arg0.total_approved + 1;
        } else {
            arg0.total_rejected = arg0.total_rejected + 1;
        };
        0x2::table::add<address, LendingDecision>(&mut arg0.decisions, v0, v12);
        0x1::option::fill<LendingDecision>(&mut arg1.decision, v12);
        let v13 = if (v9) {
            b"approved"
        } else {
            b"rejected"
        };
        arg1.application_status = v13;
        let v14 = DecisionMade{
            borrower         : v0,
            approved         : v9,
            fairness_score   : v10,
            decision_factors : b"credit_score, dti, collateral_ratio",
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DecisionMade>(v14);
        v12
    }

    public fun submit_inclusive_application(arg0: &mut FairLendingRegistry, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : InclusiveMortgageApplication {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = InclusiveMortgageApplication{
            id                       : 0x2::object::new(arg11),
            borrower                 : v0,
            home_price               : arg1,
            cash_down_payment        : arg2,
            crypto_collateral        : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            future_earnings_pledge   : arg4,
            community_guarantee      : 0,
            traditional_income       : arg5,
            crypto_earnings          : arg6,
            gig_economy_income       : arg7,
            rental_income            : arg8,
            monthly_payment_capacity : (arg5 + arg6 + arg7 + arg8) * 35 / 100,
            total_debt_obligations   : arg9,
            application_status       : b"pending",
            decision                 : 0x1::option::none<LendingDecision>(),
        };
        arg0.total_applications = arg0.total_applications + 1;
        let v2 = ApplicationSubmitted{
            borrower                      : v0,
            application_id                : 0x2::object::id<InclusiveMortgageApplication>(&v1),
            home_price                    : arg1,
            total_down_payment_equivalent : arg2 + 0x2::coin::value<0x2::sui::SUI>(&arg3) + arg4,
            timestamp                     : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<ApplicationSubmitted>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

