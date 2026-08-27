module 0x4ce4f59f74b9df0be4b70ac8c6c7675e37447197c85b48b7a0cec482a537dda9::anchor {
    struct AnchorEvent has copy, drop {
        digest: vector<u8>,
        head_id: u64,
        head_ts_ms: u64,
        sender: address,
    }

    entry fun anchor(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        let v0 = AnchorEvent{
            digest     : arg0,
            head_id    : arg1,
            head_ts_ms : arg2,
            sender     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AnchorEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

