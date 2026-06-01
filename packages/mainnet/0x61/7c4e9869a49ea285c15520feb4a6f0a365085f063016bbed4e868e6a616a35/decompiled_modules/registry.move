module 0x617c4e9869a49ea285c15520feb4a6f0a365085f063016bbed4e868e6a616a35::registry {
    struct AuditRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_audits: u64,
        audits: 0x2::table::Table<address, vector<AuditEntry>>,
    }

    struct AuditEntry has copy, drop, store {
        walrus_blob_id: 0x1::string::String,
        audit_hash: 0x1::string::String,
        auditor: address,
        epoch: u64,
        severity: u8,
        timestamp_ms: u64,
    }

    struct AuditSubmitted has copy, drop {
        contract_id: address,
        walrus_blob_id: 0x1::string::String,
        audit_hash: 0x1::string::String,
        severity: u8,
        auditor: address,
        epoch: u64,
        timestamp_ms: u64,
    }

    public fun admin(arg0: &AuditRegistry) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &AuditRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    public fun get_audits(arg0: &AuditRegistry, arg1: address) : vector<AuditEntry> {
        if (0x2::table::contains<address, vector<AuditEntry>>(&arg0.audits, arg1)) {
            *0x2::table::borrow<address, vector<AuditEntry>>(&arg0.audits, arg1)
        } else {
            0x1::vector::empty<AuditEntry>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuditRegistry{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            total_audits : 0,
            audits       : 0x2::table::new<address, vector<AuditEntry>>(arg0),
        };
        0x2::transfer::share_object<AuditRegistry>(v0);
    }

    entry fun submit_audit(arg0: &mut AuditRegistry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg6);
        assert!(arg4 <= 4, 1);
        assert!(arg5 > 0, 2);
        let v0 = AuditEntry{
            walrus_blob_id : arg2,
            audit_hash     : arg3,
            auditor        : 0x2::tx_context::sender(arg6),
            epoch          : 0x2::tx_context::epoch(arg6),
            severity       : arg4,
            timestamp_ms   : arg5,
        };
        if (0x2::table::contains<address, vector<AuditEntry>>(&arg0.audits, arg1)) {
            0x1::vector::push_back<AuditEntry>(0x2::table::borrow_mut<address, vector<AuditEntry>>(&mut arg0.audits, arg1), v0);
        } else {
            let v1 = 0x1::vector::empty<AuditEntry>();
            0x1::vector::push_back<AuditEntry>(&mut v1, v0);
            0x2::table::add<address, vector<AuditEntry>>(&mut arg0.audits, arg1, v1);
        };
        arg0.total_audits = arg0.total_audits + 1;
        let v2 = AuditSubmitted{
            contract_id    : arg1,
            walrus_blob_id : arg2,
            audit_hash     : arg3,
            severity       : arg4,
            auditor        : 0x2::tx_context::sender(arg6),
            epoch          : 0x2::tx_context::epoch(arg6),
            timestamp_ms   : arg5,
        };
        0x2::event::emit<AuditSubmitted>(v2);
    }

    public fun total_audits(arg0: &AuditRegistry) : u64 {
        arg0.total_audits
    }

    // decompiled from Move bytecode v7
}

