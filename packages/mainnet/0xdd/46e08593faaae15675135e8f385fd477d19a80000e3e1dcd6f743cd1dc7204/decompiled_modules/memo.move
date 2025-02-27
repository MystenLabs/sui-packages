module 0xdd46e08593faaae15675135e8f385fd477d19a80000e3e1dcd6f743cd1dc7204::memo {
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

