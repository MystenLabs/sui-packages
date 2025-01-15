module 0x8344f367f814e4fae351cec2844102085765ce589bf3df43ab26a9fa4584ad70::memo {
    struct ScallopMemoEvent has copy, drop {
        sender: address,
        timestamp: u64,
        memo: 0x1::string::String,
    }

    public fun create_memo(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = ScallopMemoEvent{
            sender    : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
            memo      : arg0,
        };
        0x2::event::emit<ScallopMemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

