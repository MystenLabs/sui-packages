module 0xa0f385140be5d43e7a5f2aec732a632eea4910c4648deada1767c012a0cdb74a::verification {
    public fun be_bytes_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0 * 256;
            v0 = v2 + ((*0x1::vector::borrow<u8>(&arg0, v1) as u64) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_invalidation_message_hash(arg0: u64, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg0 / 1000));
        0x1::hash::sha2_256(v0)
    }

    public fun create_merkle_root_message_hash(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg1));
        0x1::hash::sha2_256(v0)
    }

    public fun create_swap_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: bool) : vector<u8> {
        let v0 = if (arg5) {
            b"buy"
        } else {
            b"sell"
        };
        let v1 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v2, arg4);
        0x1::vector::append<u8>(&mut v2, u64_to_be_bytes(arg3 / 1000));
        0x1::vector::append<u8>(&mut v2, v0);
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(v1));
        0x1::vector::append<u8>(&mut v2, u256_to_be_bytes((arg1 as u256)));
        0x1::vector::append<u8>(&mut v2, u256_to_be_bytes((arg2 as u256)));
        0x1::hash::sha2_256(v2)
    }

    public fun create_withdrawal_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: address, arg4: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v1, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(101));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, u64_to_be_bytes(arg2 / 1000));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(v1));
        0x1::vector::append<u8>(&mut v0, u256_to_be_bytes((arg1 as u256)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::hash::sha2_256(v0)
    }

    public fun u256_to_be_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        while (0x1::vector::length<u8>(&v0) > 0 && *0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x1::vector::remove<u8>(&mut v0, 0);
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 32;
        let v3 = if (0x1::vector::length<u8>(&v0) < v2) {
            v2 - 0x1::vector::length<u8>(&v0)
        } else {
            0
        };
        let v4 = 0;
        while (v4 < v3) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(&mut v1, v0);
        v1
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 56)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 48) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 40) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 32) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 24) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 16) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 / 0x1::u64::pow(2, 8) % 0x1::u64::pow(2, 8)) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 % 0x1::u64::pow(2, 8)) as u8));
        v0
    }

    public fun verify_merkle_aggregation(arg0: u64, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"00");
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v3 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v3, x"01");
            let v4 = if (arg0 % 2 == 0) {
                0x1::vector::append<u8>(&mut v3, v1);
                0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&arg2, v2));
                0x1::hash::sha2_256(v3)
            } else {
                0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&arg2, v2));
                0x1::vector::append<u8>(&mut v3, v1);
                0x1::hash::sha2_256(v3)
            };
            v1 = v4;
            arg0 = arg0 / 2;
            v2 = v2 + 1;
        };
        v1 == arg3
    }

    // decompiled from Move bytecode v6
}

