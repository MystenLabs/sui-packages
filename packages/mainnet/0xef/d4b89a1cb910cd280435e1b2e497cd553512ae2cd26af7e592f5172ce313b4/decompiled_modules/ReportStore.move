module 0xefd4b89a1cb910cd280435e1b2e497cd553512ae2cd26af7e592f5172ce313b4::ReportStore {
    struct AuditReport has store, key {
        id: 0x2::object::UID,
        owner: address,
        timestamp: u64,
        file_name: vector<u8>,
        code_hash: vector<u8>,
        result_summary: vector<u8>,
    }

    fun new_report(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : AuditReport {
        AuditReport{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            timestamp      : arg0,
            file_name      : arg1,
            code_hash      : arg2,
            result_summary : arg3,
        }
    }

    public entry fun submit(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new_report(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<AuditReport>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

