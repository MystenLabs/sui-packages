module 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes32 {
    struct Bytes32 has copy, drop, store {
        data: vector<u8>,
    }

    public fun length() : u64 {
        32
    }

    public fun from_bytes(arg0: vector<u8>) : Bytes32 {
        if (0x1::vector::length<u8>(&arg0) > 32) {
            let v1 = &mut arg0;
            trim_nonzero_left(v1);
            new(arg0)
        } else {
            new(pad_left(&arg0, false))
        }
    }

    public fun to_bytes(arg0: Bytes32) : vector<u8> {
        let Bytes32 { data: v0 } = arg0;
        v0
    }

    public fun take_bytes(arg0: &mut 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::cursor::Cursor<u8>) : Bytes32 {
        new(0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes::take_bytes(arg0, 32))
    }

    public fun data(arg0: &Bytes32) : vector<u8> {
        arg0.data
    }

    public fun default() : Bytes32 {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        new(v0)
    }

    public fun from_address(arg0: address) : Bytes32 {
        new(0x2::address::to_bytes(arg0))
    }

    public fun from_u256_be(arg0: u256) : Bytes32 {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        new(v0)
    }

    public fun from_u64_be(arg0: u64) : Bytes32 {
        from_u256_be((arg0 as u256))
    }

    public fun from_utf8(arg0: 0x1::string::String) : Bytes32 {
        let v0 = *0x1::string::bytes(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        if (v1 > 32) {
            while (v1 > 32) {
                0x1::vector::pop_back<u8>(&mut v0);
                v1 = v1 - 1;
            };
        } else {
            while (v1 < 32) {
                0x1::vector::push_back<u8>(&mut v0, 0);
                v1 = v1 + 1;
            };
        };
        new(v0)
    }

    public fun is_nonzero(arg0: &Bytes32) : bool {
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(&arg0.data, v0) > 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_valid(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 32
    }

    public fun new(arg0: vector<u8>) : Bytes32 {
        assert!(is_valid(&arg0), 0);
        Bytes32{data: arg0}
    }

    fun pad_left(arg0: &vector<u8>, arg1: bool) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(arg0);
        while (v1 < 32) {
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

    public fun to_address(arg0: Bytes32) : address {
        0x2::address::from_bytes(to_bytes(arg0))
    }

    public fun to_u16_be(arg0: Bytes32) : u16 {
        let v0 = to_u256_be(arg0);
        assert!(v0 < 65536, 4);
        (v0 as u16)
    }

    public fun to_u256_be(arg0: Bytes32) : u256 {
        let v0 = 0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::cursor::new<u8>(to_bytes(arg0));
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::cursor::destroy_empty<u8>(v0);
        0xa3a5417331e03374a97fef6fc09056e0909e0fe91895de2465754dfd5c7616b9::bytes::take_u256_be(&mut v0)
    }

    public fun to_u32_be(arg0: Bytes32) : u32 {
        let v0 = to_u256_be(arg0);
        assert!(v0 < 4294967296, 3);
        (v0 as u32)
    }

    public fun to_u64_be(arg0: Bytes32) : u64 {
        let v0 = to_u256_be(arg0);
        assert!(v0 < 18446744073709551616, 2);
        (v0 as u64)
    }

    public fun to_u8_be(arg0: Bytes32) : u8 {
        let v0 = to_u256_be(arg0);
        assert!(v0 < 256, 5);
        (v0 as u8)
    }

    public fun to_utf8(arg0: Bytes32) : 0x1::string::String {
        let v0 = to_bytes(arg0);
        let v1 = 0x1::string::try_utf8(v0);
        while (0x1::option::is_none<0x1::string::String>(&v1)) {
            0x1::vector::pop_back<u8>(&mut v0);
            v1 = 0x1::string::try_utf8(v0);
        };
        let v2 = 0x1::option::extract<0x1::string::String>(&mut v1);
        let v3 = *0x1::string::bytes(&v2);
        while (*0x1::vector::borrow<u8>(&v3, 0x1::vector::length<u8>(&v3) - 1) == 0) {
            0x1::vector::pop_back<u8>(&mut v3);
        };
        0x1::string::utf8(v3)
    }

    fun trim_nonzero_left(arg0: &mut vector<u8>) {
        0x1::vector::reverse<u8>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0) - 32) {
            assert!(0x1::vector::pop_back<u8>(arg0) == 0, 1);
            v0 = v0 + 1;
        };
        0x1::vector::reverse<u8>(arg0);
    }

    // decompiled from Move bytecode v6
}

