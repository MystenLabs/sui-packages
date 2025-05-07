module 0x7ddddfb46d78335e8b61aa2a328497d01cef88c718e7d0d819c1559fa712d1ac::verification {
    public fun create_merkle_root_message_hash(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg1));
        0x1::hash::sha2_256(v0)
    }

    public fun create_swap_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>) : vector<u8> {
        let v0 = if (0x1::type_name::into_string(arg0) == 0x1::ascii::string(b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")) {
            b"buy"
        } else {
            b"sell"
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0)));
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(arg3));
        0x1::hash::sha2_256(v1)
    }

    public fun create_withdrawal_message_hash(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0)));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::hash::sha2_256(v0)
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 / 2 ^ 56) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 48) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 40) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 32) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 24) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 16) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, (((arg0 / 2 ^ 8) % 2 ^ 8) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 % 2 ^ 8) as u8));
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

