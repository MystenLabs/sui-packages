module 0x7f03332ce10d85053a14cc198ec4437312b2b880abd6550cae1757f192100f91::vault_operation_recorder {
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

