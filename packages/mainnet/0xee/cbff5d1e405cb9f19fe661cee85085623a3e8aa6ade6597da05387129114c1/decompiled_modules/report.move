module 0xeecbff5d1e405cb9f19fe661cee85085623a3e8aa6ade6597da05387129114c1::report {
    struct EncryptedReport has store, key {
        id: 0x2::object::UID,
        nickname_id: 0x1::string::String,
        ciphertext_sha256: 0x1::string::String,
        encrypted_report_id: 0x1::string::String,
        sealed_at_ms: u64,
    }

    struct ReportCreatedEvent has copy, drop {
        object_id: address,
        nickname_id: 0x1::string::String,
        ciphertext_sha256: 0x1::string::String,
        encrypted_report_id: 0x1::string::String,
        company_address: address,
        sealed_at_ms: u64,
    }

    public entry fun create_encrypted_report(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::tx_context::sender(arg5) == arg3, 1);
        let v1 = EncryptedReport{
            id                  : 0x2::object::new(arg5),
            nickname_id         : arg0,
            ciphertext_sha256   : arg1,
            encrypted_report_id : arg2,
            sealed_at_ms        : v0,
        };
        let v2 = ReportCreatedEvent{
            object_id           : 0x2::object::uid_to_address(&v1.id),
            nickname_id         : arg0,
            ciphertext_sha256   : arg1,
            encrypted_report_id : arg2,
            company_address     : arg3,
            sealed_at_ms        : v0,
        };
        0x2::event::emit<ReportCreatedEvent>(v2);
        0x2::transfer::transfer<EncryptedReport>(v1, arg3);
    }

    public fun get_report_details(arg0: &EncryptedReport) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.nickname_id, arg0.ciphertext_sha256, arg0.encrypted_report_id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun sealed_at_ms(arg0: &EncryptedReport) : u64 {
        arg0.sealed_at_ms
    }

    // decompiled from Move bytecode v7
}

