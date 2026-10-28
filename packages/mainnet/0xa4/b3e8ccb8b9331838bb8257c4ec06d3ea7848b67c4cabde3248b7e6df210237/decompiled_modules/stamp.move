module 0xa4b3e8ccb8b9331838bb8257c4ec06d3ea7848b67c4cabde3248b7e6df210237::stamp {
    struct Stamped has copy, drop {
        kind: u8,
        hash: vector<u8>,
        ref_id: vector<u8>,
        timestamp_ms: u64,
        recorder: address,
    }

    public fun record(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0 == 1 || arg0 == 2, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        assert!(0x1::vector::length<u8>(&arg2) <= 64, 2);
        let v0 = Stamped{
            kind         : arg0,
            hash         : arg1,
            ref_id       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            recorder     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Stamped>(v0);
    }

    // decompiled from Move bytecode v7
}

