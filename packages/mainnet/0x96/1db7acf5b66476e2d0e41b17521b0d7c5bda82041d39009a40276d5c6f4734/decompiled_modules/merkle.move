module 0x961db7acf5b66476e2d0e41b17521b0d7c5bda82041d39009a40276d5c6f4734::merkle {
    struct MerkleVerifier has key {
        id: 0x2::object::UID,
        expected_root: vector<u8>,
        owner: address,
    }

    public entry fun create_merkle_verifier(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerkleVerifier{
            id            : 0x2::object::new(arg0),
            expected_root : 0x1::vector::empty<u8>(),
            owner         : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<MerkleVerifier>(v0);
    }

    public fun set_expected_root(arg0: &mut MerkleVerifier, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.expected_root = arg1;
    }

    public fun verify_merkle(arg0: &MerkleVerifier, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>) : bool {
        assert!(!0x1::vector::is_empty<u8>(&arg0.expected_root), 4);
        let v0 = 0;
        let v1 = arg1;
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v3 = *0x1::vector::borrow<u8>(&arg3, v0);
            if (v3 == 0) {
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
                0x1::vector::append<u8>(&mut v2, v1);
                v1 = 0x1::hash::sha2_256(v2);
                v2 = 0x1::vector::empty<u8>();
            } else {
                assert!(v3 == 1, 2);
                0x1::vector::append<u8>(&mut v2, v1);
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
                v1 = 0x1::hash::sha2_256(v2);
                v2 = 0x1::vector::empty<u8>();
            };
            v0 = v0 + 1;
        };
        v1 == arg0.expected_root
    }

    // decompiled from Move bytecode v6
}

