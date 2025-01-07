module 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes20 {
    struct Bytes20 has copy, drop, store {
        data: vector<u8>,
    }

    public fun length() : u64 {
        20
    }

    public fun data(arg0: &Bytes20) : vector<u8> {
        arg0.data
    }

    public fun default() : Bytes20 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 20) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        new(v0)
    }

    public fun from_bytes(arg0: vector<u8>) : Bytes20 {
        if (0x1::vector::length<u8>(&arg0) > 20) {
            let v1 = &mut arg0;
            trim_nonzero_left(v1);
            new(arg0)
        } else {
            new(pad_left(&arg0, false))
        }
    }

    public fun is_nonzero(arg0: &Bytes20) : bool {
        let v0 = 0;
        while (v0 < 20) {
            if (*0x1::vector::borrow<u8>(&arg0.data, v0) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_valid(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 20
    }

    public fun new(arg0: vector<u8>) : Bytes20 {
        assert!(is_valid(&arg0), 0);
        Bytes20{data: arg0}
    }

    fun pad_left(arg0: &vector<u8>, arg1: bool) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(arg0);
        while (v1 < 20) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        if (arg1) {
            let v2 = 0;
            while (v2 < v1) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1 - v2 - 1));
                v2 = v2 + 1;
            };
        } else {
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        v0
    }

    public fun take(arg0: &mut 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::cursor::Cursor<u8>) : Bytes20 {
        new(0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes::take_bytes(arg0, 20))
    }

    public fun to_bytes(arg0: Bytes20) : vector<u8> {
        let Bytes20 { data: v0 } = arg0;
        v0
    }

    fun trim_nonzero_left(arg0: &mut vector<u8>) {
        0x1::vector::reverse<u8>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0) - 20) {
            assert!(0x1::vector::pop_back<u8>(arg0) == 0, 1);
            v0 = v0 + 1;
        };
        0x1::vector::reverse<u8>(arg0);
    }

    // decompiled from Move bytecode v6
}

