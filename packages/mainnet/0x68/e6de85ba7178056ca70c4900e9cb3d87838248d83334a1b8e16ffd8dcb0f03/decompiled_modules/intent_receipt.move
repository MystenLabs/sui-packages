module 0x68e6de85ba7178056ca70c4900e9cb3d87838248d83334a1b8e16ffd8dcb0f03::intent_receipt {
    struct IntentRecorded has copy, drop {
        who: address,
        descriptor: 0x1::string::String,
        timestamp_ms: u64,
    }

    public fun record(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) <= 256, 0);
        let v0 = IntentRecorded{
            who          : 0x2::tx_context::sender(arg2),
            descriptor   : arg0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<IntentRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

