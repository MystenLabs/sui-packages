module 0xe6db548d9064223e676aed600bc343a82ec041711846bbba5f5c303ff1906f0e::vektorlog {
    struct IntentExecuted has copy, drop {
        intent_id: vector<u8>,
        sender: address,
        protocol: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    public fun log_execution(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = IntentExecuted{
            intent_id    : arg0,
            sender       : 0x2::tx_context::sender(arg5),
            protocol     : arg1,
            amount_in    : arg2,
            amount_out   : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<IntentExecuted>(v0);
    }

    // decompiled from Move bytecode v7
}

