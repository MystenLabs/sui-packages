module 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32 {
    struct Bytes32 has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun from_bytes(arg0: vector<u8>) : Bytes32 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        Bytes32{bytes: arg0}
    }

    public fun to_bytes(arg0: &Bytes32) : vector<u8> {
        arg0.bytes
    }

    fun create_zero_padding(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 32, 1);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32 - v0) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        v1
    }

    public fun ff_bytes32() : Bytes32 {
        Bytes32{bytes: x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"}
    }

    public fun from_address(arg0: address) : Bytes32 {
        from_bytes(0x2::address::to_bytes(arg0))
    }

    public fun from_bytes_left_padded(arg0: vector<u8>) : Bytes32 {
        let v0 = create_zero_padding(&arg0);
        0x1::vector::append<u8>(&mut v0, arg0);
        from_bytes(v0)
    }

    public fun from_bytes_right_padded(arg0: vector<u8>) : Bytes32 {
        0x1::vector::append<u8>(&mut arg0, create_zero_padding(&arg0));
        from_bytes(arg0)
    }

    public fun from_id(arg0: 0x2::object::ID) : Bytes32 {
        from_bytes(0x2::object::id_to_bytes(&arg0))
    }

    public fun is_ff(arg0: &Bytes32) : bool {
        arg0.bytes == x"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
    }

    public fun is_zero(arg0: &Bytes32) : bool {
        arg0.bytes == x"0000000000000000000000000000000000000000000000000000000000000000"
    }

    public fun to_address(arg0: &Bytes32) : address {
        0x2::address::from_bytes(arg0.bytes)
    }

    public fun to_id(arg0: &Bytes32) : 0x2::object::ID {
        0x2::object::id_from_bytes(arg0.bytes)
    }

    public fun zero_bytes32() : Bytes32 {
        Bytes32{bytes: x"0000000000000000000000000000000000000000000000000000000000000000"}
    }

    // decompiled from Move bytecode v6
}

