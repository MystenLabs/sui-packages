module 0xbb11a10bd82cd2b3bda6e024420fa79acacb0cc10247eeaa011043aad401cca0::anchor {
    struct MemoryCommitted has copy, drop {
        commitment: vector<u8>,
        schema_version: u16,
    }

    public fun commit(arg0: vector<u8>, arg1: u16) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        assert!(arg1 > 0, 1);
        let v0 = MemoryCommitted{
            commitment     : arg0,
            schema_version : arg1,
        };
        0x2::event::emit<MemoryCommitted>(v0);
    }

    // decompiled from Move bytecode v7
}

