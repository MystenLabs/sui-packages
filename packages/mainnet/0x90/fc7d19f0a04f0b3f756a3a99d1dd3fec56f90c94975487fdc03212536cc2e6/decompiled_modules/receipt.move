module 0x90fc7d19f0a04f0b3f756a3a99d1dd3fec56f90c94975487fdc03212536cc2e6::receipt {
    struct PaymentReceipt has copy, drop {
        ref_hash: vector<u8>,
        sender: address,
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public fun emit(arg0: vector<u8>, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = PaymentReceipt{
            ref_hash  : arg0,
            sender    : arg1,
            recipient : arg2,
            amount    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PaymentReceipt>(v0);
    }

    // decompiled from Move bytecode v6
}

