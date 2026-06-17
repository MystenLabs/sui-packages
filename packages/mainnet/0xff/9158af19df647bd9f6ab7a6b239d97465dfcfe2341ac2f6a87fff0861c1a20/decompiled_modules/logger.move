module 0xff9158af19df647bd9f6ab7a6b239d97465dfcfe2341ac2f6a87fff0861c1a20::logger {
    struct GuardianReport has store, key {
        id: 0x2::object::UID,
        user_address: address,
        intent_hash: vector<u8>,
        risk_level: u8,
        slippage_bps: u64,
        pool_liq_usd: u64,
        report_hash: vector<u8>,
        intent_blob_id: 0x1::string::String,
        report_blob_id: 0x1::string::String,
        timestamp_ms: u64,
        confirmed: bool,
    }

    struct ExecutionLog has store, key {
        id: 0x2::object::UID,
        guardian_report_id: 0x2::object::ID,
        user_address: address,
        tx_digest: vector<u8>,
        confirmed_at_ms: u64,
        executed_at_ms: u64,
        success: bool,
    }

    struct GuardianReportCreatedEvent has copy, drop {
        report_id: 0x2::object::ID,
        user_address: address,
        risk_level: u8,
        timestamp_ms: u64,
    }

    struct UserConfirmedEvent has copy, drop {
        report_id: 0x2::object::ID,
        user_address: address,
        timestamp_ms: u64,
    }

    struct TransactionExecutedEvent has copy, drop {
        log_id: 0x2::object::ID,
        tx_digest: vector<u8>,
        success: bool,
        timestamp_ms: u64,
    }

    public fun confirm_intent(arg0: &mut GuardianReport, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.user_address, 0);
        assert!(!arg0.confirmed, 1);
        arg0.confirmed = true;
        let v0 = UserConfirmedEvent{
            report_id    : 0x2::object::uid_to_inner(&arg0.id),
            user_address : arg0.user_address,
            timestamp_ms : arg1,
        };
        0x2::event::emit<UserConfirmedEvent>(v0);
    }

    public fun emit_guardian_report(arg0: address, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 3, 3);
        let v0 = GuardianReport{
            id             : 0x2::object::new(arg9),
            user_address   : arg0,
            intent_hash    : arg1,
            risk_level     : arg2,
            slippage_bps   : arg3,
            pool_liq_usd   : arg4,
            report_hash    : arg5,
            intent_blob_id : arg6,
            report_blob_id : arg7,
            timestamp_ms   : arg8,
            confirmed      : false,
        };
        let v1 = GuardianReportCreatedEvent{
            report_id    : 0x2::object::uid_to_inner(&v0.id),
            user_address : arg0,
            risk_level   : arg2,
            timestamp_ms : arg8,
        };
        0x2::event::emit<GuardianReportCreatedEvent>(v1);
        0x2::transfer::public_share_object<GuardianReport>(v0);
    }

    public fun log_execution(arg0: &GuardianReport, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.user_address, 0);
        assert!(arg0.confirmed, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = ExecutionLog{
            id                 : 0x2::object::new(arg5),
            guardian_report_id : 0x2::object::uid_to_inner(&arg0.id),
            user_address       : arg0.user_address,
            tx_digest          : arg1,
            confirmed_at_ms    : arg2,
            executed_at_ms     : arg3,
            success            : arg4,
        };
        let v1 = TransactionExecutedEvent{
            log_id       : 0x2::object::uid_to_inner(&v0.id),
            tx_digest    : arg1,
            success      : arg4,
            timestamp_ms : arg3,
        };
        0x2::event::emit<TransactionExecutedEvent>(v1);
        0x2::transfer::public_share_object<ExecutionLog>(v0);
    }

    // decompiled from Move bytecode v7
}

