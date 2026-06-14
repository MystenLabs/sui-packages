module 0x822057b8bee4b0afc0e9d6b923f5b2c15fb7e303a710bbf11065e0868038a92e::audit {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuditConfig has store, key {
        id: 0x2::object::UID,
        price_mist: u64,
        operator: address,
    }

    struct AuditJob has store, key {
        id: 0x2::object::UID,
        payer: address,
        package_id: vector<u8>,
        package_digest: vector<u8>,
        price_paid: u64,
        status: u8,
        created_at_ms: u64,
        report_id: 0x1::option::Option<address>,
    }

    struct AuditReport has store, key {
        id: 0x2::object::UID,
        job_id: address,
        package_id: vector<u8>,
        package_snapshot_blob_id: vector<u8>,
        package_snapshot_hash: vector<u8>,
        report_blob_id: vector<u8>,
        report_hash: vector<u8>,
        findings_hash: vector<u8>,
        risk_score: u64,
        visibility: u8,
        created_at_ms: u64,
    }

    struct AuditJobCreated has copy, drop {
        job_id: address,
        payer: address,
        package_id: vector<u8>,
        price_paid: u64,
    }

    struct AuditReportFinalized has copy, drop {
        report_id: address,
        job_id: address,
        risk_score: u64,
        visibility: u8,
    }

    entry fun create_audit_job(arg0: &AuditConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.price_mist, 0);
        let v1 = AuditJob{
            id             : 0x2::object::new(arg5),
            payer          : 0x2::tx_context::sender(arg5),
            package_id     : arg1,
            package_digest : arg2,
            price_paid     : v0,
            status         : 1,
            created_at_ms  : 0x2::clock::timestamp_ms(arg4),
            report_id      : 0x1::option::none<address>(),
        };
        let v2 = AuditJobCreated{
            job_id     : 0x2::object::uid_to_address(&v1.id),
            payer      : 0x2::tx_context::sender(arg5),
            package_id : v1.package_id,
            price_paid : v0,
        };
        0x2::event::emit<AuditJobCreated>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.operator);
        0x2::transfer::share_object<AuditJob>(v1);
    }

    entry fun finalize_report(arg0: &OperatorCap, arg1: &mut AuditJob, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 1);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = AuditReport{
            id                       : 0x2::object::new(arg10),
            job_id                   : v0,
            package_id               : arg1.package_id,
            package_snapshot_blob_id : arg2,
            package_snapshot_hash    : arg3,
            report_blob_id           : arg4,
            report_hash              : arg5,
            findings_hash            : arg6,
            risk_score               : arg7,
            visibility               : arg8,
            created_at_ms            : 0x2::clock::timestamp_ms(arg9),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        arg1.status = 3;
        arg1.report_id = 0x1::option::some<address>(v2);
        let v3 = AuditReportFinalized{
            report_id  : v2,
            job_id     : v0,
            risk_score : arg7,
            visibility : arg8,
        };
        0x2::event::emit<AuditReportFinalized>(v3);
        0x2::transfer::transfer<AuditReport>(v1, arg1.payer);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v1, v0);
        let v2 = AuditConfig{
            id         : 0x2::object::new(arg0),
            price_mist : 1000000,
            operator   : v0,
        };
        0x2::transfer::share_object<AuditConfig>(v2);
    }

    public fun job_report_id(arg0: &AuditJob) : 0x1::option::Option<address> {
        arg0.report_id
    }

    public fun job_status(arg0: &AuditJob) : u8 {
        arg0.status
    }

    entry fun set_operator(arg0: &OperatorCap, arg1: &mut AuditConfig, arg2: address) {
        assert!(arg2 != @0x0, 2);
        arg1.operator = arg2;
    }

    entry fun set_price(arg0: &OperatorCap, arg1: &mut AuditConfig, arg2: u64) {
        arg1.price_mist = arg2;
    }

    // decompiled from Move bytecode v7
}

