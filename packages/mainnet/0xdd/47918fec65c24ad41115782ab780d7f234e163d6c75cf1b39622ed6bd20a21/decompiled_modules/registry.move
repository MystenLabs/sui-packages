module 0xdd47918fec65c24ad41115782ab780d7f234e163d6c75cf1b39622ed6bd20a21::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

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
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AuditRegistry>(v0);
    }

    public fun submit_audit(arg0: &AdminCap, arg1: &mut AuditRegistry, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 4, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = AuditEntry{
            walrus_blob_id : arg4,
            audit_hash     : arg5,
            auditor        : 0x2::tx_context::sender(arg7),
            epoch          : 0x2::tx_context::epoch(arg7),
            severity       : arg6,
            timestamp_ms   : v0,
        };
        if (0x2::table::contains<address, vector<AuditEntry>>(&arg1.audits, arg3)) {
            0x1::vector::push_back<AuditEntry>(0x2::table::borrow_mut<address, vector<AuditEntry>>(&mut arg1.audits, arg3), v1);
        } else {
            let v2 = 0x1::vector::empty<AuditEntry>();
            0x1::vector::push_back<AuditEntry>(&mut v2, v1);
            0x2::table::add<address, vector<AuditEntry>>(&mut arg1.audits, arg3, v2);
        };
        arg1.total_audits = arg1.total_audits + 1;
        let v3 = AuditSubmitted{
            contract_id    : arg3,
            walrus_blob_id : arg4,
            audit_hash     : arg5,
            severity       : arg6,
            auditor        : 0x2::tx_context::sender(arg7),
            epoch          : 0x2::tx_context::epoch(arg7),
            timestamp_ms   : v0,
        };
        0x2::event::emit<AuditSubmitted>(v3);
    }

    public fun total_audits(arg0: &AuditRegistry) : u64 {
        arg0.total_audits
    }

    // decompiled from Move bytecode v7
}

