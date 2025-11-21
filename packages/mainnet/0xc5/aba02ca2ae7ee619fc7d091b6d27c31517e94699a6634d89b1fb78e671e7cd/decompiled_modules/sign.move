module 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::sign {
    fun encode_withdraw_message(arg0: vector<u8>, arg1: u64, arg2: address, arg3: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg1);
        let v1 = 0x1::bcs::to_bytes<address>(&arg2);
        let v2 = 0x1::bcs::to_bytes<u64>(&arg3);
        0x1::vector::push_back<u8>(&mut arg0, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(&mut arg0, v0);
        0x1::vector::push_back<u8>(&mut arg0, (0x1::vector::length<u8>(&v1) as u8));
        0x1::vector::append<u8>(&mut arg0, v1);
        0x1::vector::push_back<u8>(&mut arg0, (0x1::vector::length<u8>(&v2) as u8));
        0x1::vector::append<u8>(&mut arg0, v2);
        arg0
    }

    fun recover_eth_address(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg0, arg1, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 12) {
            0x1::vector::push_back<u8>(&mut v4, 0);
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v4, slice_range(v2, v3 - 20, v3));
        0x2::address::from_bytes(v4)
    }

    public fun slice_range(arg0: vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun verify_withdraw_message(arg0: u64, arg1: address, arg2: u64, arg3: &vector<u8>, arg4: address) {
        let v0 = encode_withdraw_message(b"SUI_SUIL_WITHDRAW_MESSAGE2", arg0, arg1, arg2);
        assert!(recover_eth_address(arg3, &v0) == arg4, 1);
    }

    // decompiled from Move bytecode v6
}

