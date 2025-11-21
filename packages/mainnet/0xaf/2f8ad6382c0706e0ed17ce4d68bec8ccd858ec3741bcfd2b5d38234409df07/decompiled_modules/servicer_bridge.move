module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::servicer_bridge {
    struct ServicerReport has store, key {
        id: 0x2::object::UID,
        servicer_code: 0x1::string::String,
        report_date: u64,
        total_loans: u64,
        total_current: u64,
        total_delinquent: u64,
        total_scheduled_payments: u64,
        total_actual_payments: u64,
        match_rate_percentage: u64,
        report_hash: vector<u8>,
        generated_by: address,
    }

    struct LoanPerformance has store, key {
        id: 0x2::object::UID,
        loan_id: 0x1::string::String,
        servicer_code: 0x1::string::String,
        payment_number: u64,
        scheduled_payment: u64,
        actual_payment: u64,
        payment_date: u64,
        delinquency_days: u64,
        loan_status: 0x1::string::String,
        current_balance: u64,
        recorded_at: u64,
        recorded_by: address,
    }

    struct PaymentReconciliation has store, key {
        id: 0x2::object::UID,
        servicer_code: 0x1::string::String,
        reconciliation_date: u64,
        total_expected: u64,
        total_received: u64,
        discrepancies_count: u64,
        match_rate_percentage: u64,
        reconciliation_hash: vector<u8>,
        reconciled_by: address,
    }

    struct LossMitigationTrigger has store, key {
        id: 0x2::object::UID,
        loan_id: 0x1::string::String,
        trigger_type: 0x1::string::String,
        severity: 0x1::string::String,
        trigger_date: u64,
        details: 0x1::string::String,
        servicer_code: 0x1::string::String,
        action_required: 0x1::string::String,
        resolved: bool,
        resolved_date: u64,
    }

    struct LoanHealthScore has store, key {
        id: 0x2::object::UID,
        loan_id: 0x1::string::String,
        servicer_code: 0x1::string::String,
        health_score: u64,
        rating: 0x1::string::String,
        payment_history_score: u64,
        dti_score: u64,
        collateral_score: u64,
        status_score: u64,
        calculated_at: u64,
        calculated_by: address,
    }

    struct DefaultReport has store, key {
        id: 0x2::object::UID,
        loan_id: 0x1::string::String,
        servicer_code: 0x1::string::String,
        missed_payments: u64,
        days_past_due: u64,
        default_risk: 0x1::string::String,
        current_balance: u64,
        reported_at: u64,
        reported_by: address,
    }

    public fun assess_default_risk(arg0: u64, arg1: u64) : u8 {
        if (arg1 > 120 || arg0 >= 4) {
            3
        } else if (arg1 > 90 || arg0 >= 3) {
            2
        } else if (arg1 > 30 || arg0 >= 1) {
            1
        } else {
            0
        }
    }

    public fun get_delinquency_severity(arg0: u64) : u8 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 30) {
            1
        } else if (arg0 <= 60) {
            2
        } else if (arg0 <= 90) {
            3
        } else {
            4
        }
    }

    public fun is_loan_current(arg0: u64) : bool {
        arg0 == 0
    }

    public entry fun record_daily_report(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 > 0) {
            arg5 * 10000 / arg4
        } else {
            0
        };
        let v1 = ServicerReport{
            id                       : 0x2::object::new(arg7),
            servicer_code            : 0x1::string::utf8(arg0),
            report_date              : 0x2::tx_context::epoch_timestamp_ms(arg7),
            total_loans              : arg1,
            total_current            : arg2,
            total_delinquent         : arg3,
            total_scheduled_payments : arg4,
            total_actual_payments    : arg5,
            match_rate_percentage    : v0,
            report_hash              : arg6,
            generated_by             : 0x2::tx_context::sender(arg7),
        };
        0x2::transfer::public_share_object<ServicerReport>(v1);
    }

    public entry fun record_default(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DefaultReport{
            id              : 0x2::object::new(arg6),
            loan_id         : 0x1::string::utf8(arg0),
            servicer_code   : 0x1::string::utf8(arg1),
            missed_payments : arg2,
            days_past_due   : arg3,
            default_risk    : 0x1::string::utf8(arg4),
            current_balance : arg5,
            reported_at     : 0x2::tx_context::epoch_timestamp_ms(arg6),
            reported_by     : 0x2::tx_context::sender(arg6),
        };
        0x2::transfer::public_share_object<DefaultReport>(v0);
    }

    public entry fun record_health_score(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 2);
        let v0 = LoanHealthScore{
            id                    : 0x2::object::new(arg8),
            loan_id               : 0x1::string::utf8(arg0),
            servicer_code         : 0x1::string::utf8(arg1),
            health_score          : arg2,
            rating                : 0x1::string::utf8(arg3),
            payment_history_score : arg4,
            dti_score             : arg5,
            collateral_score      : arg6,
            status_score          : arg7,
            calculated_at         : 0x2::tx_context::epoch_timestamp_ms(arg8),
            calculated_by         : 0x2::tx_context::sender(arg8),
        };
        0x2::transfer::public_share_object<LoanHealthScore>(v0);
    }

    public entry fun record_loan_performance(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = LoanPerformance{
            id                : 0x2::object::new(arg8),
            loan_id           : 0x1::string::utf8(arg0),
            servicer_code     : 0x1::string::utf8(arg1),
            payment_number    : arg2,
            scheduled_payment : arg3,
            actual_payment    : arg4,
            payment_date      : 0x2::tx_context::epoch_timestamp_ms(arg8),
            delinquency_days  : arg5,
            loan_status       : 0x1::string::utf8(arg6),
            current_balance   : arg7,
            recorded_at       : 0x2::tx_context::epoch_timestamp_ms(arg8),
            recorded_by       : 0x2::tx_context::sender(arg8),
        };
        0x2::transfer::public_share_object<LoanPerformance>(v0);
    }

    public entry fun record_loss_mitigation_trigger(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = LossMitigationTrigger{
            id              : 0x2::object::new(arg6),
            loan_id         : 0x1::string::utf8(arg0),
            trigger_type    : 0x1::string::utf8(arg1),
            severity        : 0x1::string::utf8(arg2),
            trigger_date    : 0x2::tx_context::epoch_timestamp_ms(arg6),
            details         : 0x1::string::utf8(arg3),
            servicer_code   : 0x1::string::utf8(arg4),
            action_required : 0x1::string::utf8(arg5),
            resolved        : false,
            resolved_date   : 0,
        };
        0x2::transfer::public_share_object<LossMitigationTrigger>(v0);
    }

    public entry fun record_reconciliation(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 > 0) {
            arg2 * 10000 / arg1
        } else {
            0
        };
        let v1 = PaymentReconciliation{
            id                    : 0x2::object::new(arg5),
            servicer_code         : 0x1::string::utf8(arg0),
            reconciliation_date   : 0x2::tx_context::epoch_timestamp_ms(arg5),
            total_expected        : arg1,
            total_received        : arg2,
            discrepancies_count   : arg3,
            match_rate_percentage : v0,
            reconciliation_hash   : arg4,
            reconciled_by         : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_share_object<PaymentReconciliation>(v1);
    }

    public entry fun resolve_loss_mitigation(arg0: &mut LossMitigationTrigger, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.resolved = true;
        arg0.resolved_date = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

