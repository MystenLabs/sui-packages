module 0xf03bf161b3f338f1bdff745d642be98c5b5b0246539ff37a87bce54b389fc979::payment_memo {
    struct PaymentMemo has copy, drop {
        sender: address,
        memo: 0x1::string::String,
        timestamp: u64,
    }

    public fun emit_memo(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = PaymentMemo{
            sender    : 0x2::tx_context::sender(arg2),
            memo      : arg0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PaymentMemo>(v0);
    }

    // decompiled from Move bytecode v6
}

