module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::registration {
    public fun verify_signature_evm(arg0: vector<u8>, arg1: address, arg2: address, arg3: 0x1::option::Option<address>, arg4: vector<u8>, arg5: u64, arg6: &vector<u8>, arg7: &0x2::clock::Clock) : bool {
        if (0x2::clock::timestamp_ms(arg7) > arg5 && 0x2::clock::timestamp_ms(arg7) - arg5 > 30000) {
            return false
        };
        let v0 = x"4c696e6b20796f7572206163636f756e74733a0a42726f777365723a3078";
        let v1 = x"19457468657265756d205369676e6564204d6573736167653a0a";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::address::to_bytes(arg1)));
        0x1::vector::append<u8>(&mut v0, x"0a4d6f62696c6520416464726573733a3078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::address::to_bytes(arg2)));
        if (0x1::option::is_some<address>(&arg3)) {
            0x1::vector::append<u8>(&mut v0, x"0a5265636f7665727920416464726573733a3078");
            0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::address::to_bytes(*0x1::option::borrow<address>(&arg3))));
        };
        0x1::vector::append<u8>(&mut v0, x"0a4d6f62696c65205075626c6963206b65793a3078");
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(arg4));
        0x1::vector::append<u8>(&mut v0, x"0a54696d657374616d703a");
        let v2 = 0x1::u64::to_string(arg5);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        let v3 = 0x1::u64::to_string(0x1::vector::length<u8>(&v0));
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v1, v0);
        let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg6, &v1, 0);
        let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 1;
        while (v7 < 65) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        let v8 = 0x2::hash::keccak256(&v6);
        let v9 = 0x1::vector::empty<u8>();
        let v10 = 0;
        while (v10 < 20) {
            0x1::vector::push_back<u8>(&mut v9, 0x1::vector::pop_back<u8>(&mut v8));
            v10 = v10 + 1;
        };
        0x1::vector::reverse<u8>(&mut v9);
        v9 == arg0
    }

    // decompiled from Move bytecode v6
}

