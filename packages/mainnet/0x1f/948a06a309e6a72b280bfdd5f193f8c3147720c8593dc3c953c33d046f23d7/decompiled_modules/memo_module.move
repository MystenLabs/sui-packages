module 0x1f948a06a309e6a72b280bfdd5f193f8c3147720c8593dc3c953c33d046f23d7::memo_module {
    struct MemoEvent has copy, drop, store {
        sender: address,
        memo: vector<u8>,
    }

    public entry fun emit_memo(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 12, 1);
        let v0 = MemoEvent{
            sender : 0x2::tx_context::sender(arg1),
            memo   : arg0,
        };
        0x2::event::emit<MemoEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

