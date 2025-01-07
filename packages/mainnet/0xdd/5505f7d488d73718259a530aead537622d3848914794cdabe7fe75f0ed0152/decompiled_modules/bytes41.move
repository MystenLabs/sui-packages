module 0xdd5505f7d488d73718259a530aead537622d3848914794cdabe7fe75f0ed0152::bytes41 {
    struct Bytes41 has copy, drop, store {
        data: vector<u8>,
    }

    public fun length() : u64 {
        41
    }

    public fun data(arg0: &Bytes41) : vector<u8> {
        arg0.data
    }

    public fun default() : Bytes41 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 41) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        new(v0)
    }

    fun is_valid(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 41
    }

    public fun new(arg0: vector<u8>) : Bytes41 {
        assert!(is_valid(&arg0), 0);
        Bytes41{data: arg0}
    }

    public fun to_bytes(arg0: Bytes41) : vector<u8> {
        let Bytes41 { data: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

