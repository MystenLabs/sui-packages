module 0xc7bb1087170732a31d392f20974ba5f3dac8c4081b39f7a8677ff7d28ada84c4::recall {
    struct PickCommitted has copy, drop {
        hash: vector<u8>,
        pick_id: vector<u8>,
        committer: address,
    }

    public fun commit(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg1) <= 64, 1);
        let v0 = PickCommitted{
            hash      : arg0,
            pick_id   : arg1,
            committer : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PickCommitted>(v0);
    }

    // decompiled from Move bytecode v7
}

