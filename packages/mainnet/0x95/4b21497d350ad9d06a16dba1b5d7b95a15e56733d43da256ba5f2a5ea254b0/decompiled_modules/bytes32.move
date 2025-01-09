module 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32 {
    struct Bytes32 has copy, drop, store {
        data: vector<u8>,
    }

    public fun empty() : Bytes32 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        new(v0)
    }

    public fun data(arg0: &Bytes32) : vector<u8> {
        arg0.data
    }

    public fun from_address(arg0: address) : Bytes32 {
        new(0x2::address::to_bytes(arg0))
    }

    public fun from_ascii_hex(arg0: 0x1::ascii::String) : Bytes32 {
        new(0x2::hex::decode(0x1::ascii::into_bytes(arg0)))
    }

    public fun from_hex(arg0: 0x1::string::String) : Bytes32 {
        new(0x2::hex::decode(0x1::string::into_bytes(arg0)))
    }

    public fun from_id(arg0: &0x2::object::ID) : Bytes32 {
        new(0x2::object::id_to_bytes(arg0))
    }

    public fun from_uid(arg0: &0x2::object::UID) : Bytes32 {
        new(0x2::object::uid_to_bytes(arg0))
    }

    public fun is_zero(arg0: &Bytes32) : bool {
        let v0 = &arg0.data;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = 0;
            if (!(0x1::vector::borrow<u8>(v0, v1) == &v3)) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    public fun new(arg0: vector<u8>) : Bytes32 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 == 0) {
            empty()
        } else if (v0 < 32) {
            new_from_partial(arg0)
        } else {
            assert!(v0 == 32, 0);
            Bytes32{data: arg0}
        }
    }

    fun new_from_partial(arg0: vector<u8>) : Bytes32 {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32 - 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, arg0);
        Bytes32{data: v0}
    }

    public fun to_address(arg0: &Bytes32) : address {
        0x2::address::from_bytes(data(arg0))
    }

    public fun to_ascii_hex(arg0: &Bytes32) : 0x1::ascii::String {
        0x1::ascii::string(0x2::hex::encode(arg0.data))
    }

    public fun to_hex(arg0: &Bytes32) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(arg0.data))
    }

    public fun to_id(arg0: &Bytes32) : 0x2::object::ID {
        0x2::object::id_from_bytes(arg0.data)
    }

    // decompiled from Move bytecode v6
}

