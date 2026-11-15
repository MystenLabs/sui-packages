module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard {
    public(friend) fun normalize(arg0: u128, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= arg2, 201);
        assert!(arg2 / 1000 - arg1 / 1000 < 20, 201);
        let v0 = arg0 / 10000000000;
        assert!(v0 > 0 && v0 <= 18446744073709551615, 202);
        (v0 as u64)
    }

    public(friend) fun validate_storage(arg0: bool, arg1: address, arg2: u32, arg3: vector<u8>, arg4: u16, arg5: address) {
        assert!(arg4 == 1, 200);
        if (arg0) {
            assert!(arg1 == @0xa963d9abc71d27918befc697d0b584aa7906fd8fa698e8c8d0e982acc288d97c, 200);
            assert!(arg2 == 3 && arg3 == b"SUIUSD", 200);
            assert!(arg5 == @0x1c48fd005399187fcdb76f88801e2b3aa13d0b02e7fbe30d6d5c563dd159638e, 200);
        } else {
            assert!(arg1 == @0x96ea92a33842446845c38992f5de53971471156e26b269c19a1f5864109ada03, 200);
            assert!(arg2 == 1 && arg3 == b"USDCUSD", 200);
            assert!(arg5 == @0x20471fe9485a08a3ec5115ba24337dbda38571ab218b766f28de3b1a26e184da, 200);
        };
    }

    // decompiled from Move bytecode v7
}

