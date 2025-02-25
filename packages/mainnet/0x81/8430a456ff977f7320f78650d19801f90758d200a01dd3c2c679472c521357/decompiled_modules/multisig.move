module 0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::multisig {
    fun address_from_bytes(arg0: &vector<u8>, arg1: u8) : address {
        assert!(0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::pk_util::is_valid_key(arg0), 2);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == arg1, 2);
        0x2::address::from_bytes(0x2::hash::blake2b256(arg0))
    }

    public fun derive_multisig_address(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16) : address {
        let v0 = b"";
        let v1 = 0x1::vector::length<vector<u8>>(&arg0);
        let v2 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 == v2, 0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            v3 = v3 + (*0x1::vector::borrow<u8>(&arg1, v4) as u16);
            v4 = v4 + 1;
        };
        assert!(arg2 > 0 && arg2 <= v3, 1);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg2));
        v4 = 0;
        while (v4 < v1) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0, v4));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v4));
            v4 = v4 + 1;
        };
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun ed25519_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 0)
    }

    public fun is_sender_multisig(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16, arg3: &0x2::tx_context::TxContext) : bool {
        derive_multisig_address(arg0, arg1, arg2) == 0x2::tx_context::sender(arg3)
    }

    public fun secp256k1_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 1)
    }

    public fun secp256r1_key_to_address(arg0: &vector<u8>) : address {
        address_from_bytes(arg0, 2)
    }

    // decompiled from Move bytecode v6
}

