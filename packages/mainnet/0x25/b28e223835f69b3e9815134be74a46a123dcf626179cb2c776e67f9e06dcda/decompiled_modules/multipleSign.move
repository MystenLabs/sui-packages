module 0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::multipleSign {
    struct MultipleSigner has store, key {
        id: 0x2::object::UID,
        addresses: vector<vector<u8>>,
    }

    public fun RemoveMultipleSigner(arg0: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg1: MultipleSigner, arg2: &mut 0x2::tx_context::TxContext) {
        let MultipleSigner {
            id        : v0,
            addresses : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun createMultipleSigner(arg0: &0x908c65c9be54883fd28d1f3e65de06496d66ae579d66e174af2ad9c1d180076b::admin::AdminCap, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MultipleSigner{
            id        : 0x2::object::new(arg2),
            addresses : arg1,
        };
        0x2::transfer::public_share_object<MultipleSigner>(v0);
    }

    fun ecrecover_to_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0;
        while (v7 < 32) {
            if (v7 > 11) {
                0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            };
            v7 = v7 + 1;
        };
        v6
    }

    public(friend) fun verifySignatures(arg0: &MultipleSigner, arg1: vector<vector<u8>>, arg2: vector<u8>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg0.addresses), 1000);
        let v1 = 0;
        let v2 = 0x1::vector::empty<vector<u8>>();
        while (v1 < v0) {
            let v3 = ecrecover_to_address(0x1::vector::pop_back<vector<u8>>(&mut arg1), arg2);
            assert!(0x1::vector::contains<vector<u8>>(&arg0.addresses, &v3), 1001);
            assert!(!0x1::vector::contains<vector<u8>>(&v2, &v3), 1002);
            0x1::vector::push_back<vector<u8>>(&mut v2, v3);
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

