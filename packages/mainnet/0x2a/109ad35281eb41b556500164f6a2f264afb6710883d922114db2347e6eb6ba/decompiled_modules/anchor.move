module 0x2a109ad35281eb41b556500164f6a2f264afb6710883d922114db2347e6eb6ba::anchor {
    struct ReceiptAnchored has copy, drop {
        receipt_id: 0x1::string::String,
        wire_hash: 0x1::string::String,
        workload_id: 0x1::string::String,
        served_at_ms: u64,
        anchored_at_ms: u64,
        anchored_by: address,
    }

    public fun anchor_receipt(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = ReceiptAnchored{
            receipt_id     : arg0,
            wire_hash      : arg1,
            workload_id    : arg2,
            served_at_ms   : arg3,
            anchored_at_ms : 0x2::clock::timestamp_ms(arg4),
            anchored_by    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ReceiptAnchored>(v0);
    }

    // decompiled from Move bytecode v6
}

