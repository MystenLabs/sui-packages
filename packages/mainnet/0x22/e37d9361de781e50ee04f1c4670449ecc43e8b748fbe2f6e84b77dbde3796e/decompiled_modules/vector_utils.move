module 0x22e37d9361de781e50ee04f1c4670449ecc43e8b748fbe2f6e84b77dbde3796e::vector_utils {
    public fun from_be_bytes(arg0: vector<u8>) : u64 {
        0x1::vector::reverse<u8>(&mut arg0);
        from_bytes(pad(arg0, 8, false))
    }

    fun from_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 8) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(&arg0, (v0 as u64)) as u64) << v0 * 8);
            v0 = v0 + 1;
        };
        v1
    }

    public fun from_le_bytes(arg0: vector<u8>) : u64 {
        from_bytes(pad(arg0, 8, true))
    }

    public fun initialise(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, arg1);
            arg0 = arg0 - 1;
        };
        v0
    }

    public fun pad(arg0: vector<u8>, arg1: u64, arg2: bool) : vector<u8> {
        assert!(arg1 > 0, 0);
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 < arg1) {
            let v2 = initialise(arg1 - v0, 0);
            if (arg2) {
                0x1::vector::append<u8>(&mut v2, arg0);
                v2
            } else {
                0x1::vector::append<u8>(&mut arg0, v2);
                arg0
            }
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

