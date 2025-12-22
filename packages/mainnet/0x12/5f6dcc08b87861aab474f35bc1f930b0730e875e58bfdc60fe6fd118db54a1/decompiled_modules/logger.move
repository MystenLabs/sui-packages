module 0x125f6dcc08b87861aab474f35bc1f930b0730e875e58bfdc60fe6fd118db54a1::logger {
    struct MemoEvent has copy, drop {
        sender: address,
        memo: vector<u8>,
    }

    public fun memo(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoEvent{
            sender : 0x2::tx_context::sender(arg1),
            memo   : arg0,
        };
        0x2::event::emit<MemoEvent>(v0);
    }

    public fun memo_only(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        memo(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

