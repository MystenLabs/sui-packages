module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::aftermath_feed_guard {
    public(friend) fun market_feed_id(arg0: vector<u8>) : u32 {
        if (arg0 == b"027792d9fed7f9844eb4839566001bb6f6cb4804f66aa2da6fe1ee242d896881::coin::COIN") {
            1
        } else {
            assert!(arg0 == b"af8cd5edc19c4512f4259f0bee101a40d41ebed738ade5874359610ef8eeced5::coin::COIN", 200);
            2
        }
    }

    public(friend) fun normalize(arg0: u128, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= arg2, 201);
        assert!(arg2 / 1000 - arg1 / 1000 < 20, 201);
        let v0 = arg0 / 10000000000;
        assert!(v0 > 0 && v0 <= 18446744073709551615, 202);
        (v0 as u64)
    }

    public(friend) fun validate_market_storage(arg0: u32, arg1: address, arg2: u32, arg3: vector<u8>, arg4: u16, arg5: address) {
        assert!(arg4 == 1, 200);
        if (arg0 == 1) {
            assert!(arg1 == @0xc729d56d7de4e22ad6e21f379f79c68d277a49789ac5b52b8df51ed16bc4a9a0, 200);
            assert!(arg2 == 0 && arg3 == b"BTCUSD", 200);
            assert!(arg5 == @0x2ee23ff1a76285979e5800a4097473f72d817ce678bc40b8143228799fefdcb3, 200);
        } else {
            assert!(arg0 == 2, 200);
            assert!(arg1 == @0xd98176408c7341a5a3efe8a9a7babcb76df555ead88948ce3927cb4cb732a711, 200);
            assert!(arg2 == 2 && arg3 == b"ETHUSD", 200);
            assert!(arg5 == @0x28df607a554ddd13ce34a163b048df9f508f88f0a4dcdd02e0ea9c63c3a71b85, 200);
        };
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

