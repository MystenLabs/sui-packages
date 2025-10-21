module 0x80c32cc47ba314ceddc8b5ea899a29c88cc088189734be1d02be9f7484d8caf7::vault_operation_recorder {
    struct VaultOperationRecorded has copy, drop {
        operator: address,
        operation_type: 0x1::string::String,
        vault_id: address,
        timestamp: u64,
    }

    public fun record_operation(arg0: address, arg1: 0x1::string::String, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = VaultOperationRecorded{
            operator       : arg0,
            operation_type : arg1,
            vault_id       : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultOperationRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

