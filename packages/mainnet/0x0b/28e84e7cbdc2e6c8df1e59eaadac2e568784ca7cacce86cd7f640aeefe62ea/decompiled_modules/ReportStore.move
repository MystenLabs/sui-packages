module 0xb28e84e7cbdc2e6c8df1e59eaadac2e568784ca7cacce86cd7f640aeefe62ea::ReportStore {
    struct AuditReport has store, key {
        id: 0x2::object::UID,
        owner: address,
        code_hash: vector<u8>,
        result_summary: vector<u8>,
    }

    fun new_report(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : AuditReport {
        AuditReport{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            code_hash      : arg0,
            result_summary : arg1,
        }
    }

    public entry fun submit(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_report(arg0, arg1, arg2);
        0x2::transfer::public_transfer<AuditReport>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

