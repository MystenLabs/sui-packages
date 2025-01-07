module 0xf12bc1e17b2c58e1ab714f9df8d0b498551a58e05faa73de64c5dbe24d585a13::signer_verify {
    struct Signer has store, key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
    }

    struct SignerOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct MintRules has store, key {
        id: 0x2::object::UID,
        mint_signer: Signer,
        claimed_mints: 0x2::vec_set::VecSet<vector<u8>>,
    }

    entry fun generateEthMessage(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = generateMessage(arg0, arg1, arg2);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::append<u8>(&mut v1, b"660x");
        0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(0x2::hash::keccak256(&v0)));
        v1
    }

    entry fun generateMessage(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        v0
    }

    public fun get_signer(arg0: &MintRules) : &Signer {
        &arg0.mint_signer
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SignerOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SignerOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Signer{
            id      : 0x2::object::new(arg0),
            pub_key : 0x2::hex::decode(b"2EAA8BF8f7c633560a149d9952D5D74c04207314"),
        };
        let v2 = MintRules{
            id            : 0x2::object::new(arg0),
            mint_signer   : v1,
            claimed_mints : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<MintRules>(v2);
    }

    entry fun is_new_signature_(arg0: &MintRules, arg1: vector<u8>) : bool {
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.claimed_mints, &arg1), 1);
        true
    }

    public fun mint_with_cap(arg0: &mut MintRules, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : bool {
        assert!(is_new_signature_(arg0, arg4), 1);
        assert!(verify_signature(arg1, arg2, arg3, arg4, &arg0.mint_signer), 2);
        set_minted_rule_(arg0, arg4);
        true
    }

    entry fun set_minted_rule_(arg0: &mut MintRules, arg1: vector<u8>) {
        if (0x2::vec_set::size<vector<u8>>(&arg0.claimed_mints) > 50) {
            let v0 = 0x2::vec_set::into_keys<vector<u8>>(arg0.claimed_mints);
            let v1 = 0;
            while (v1 < 25) {
                0x2::vec_set::remove<vector<u8>>(&mut arg0.claimed_mints, 0x1::vector::borrow<vector<u8>>(&v0, v1));
                v1 = v1 + 1;
            };
        };
        0x2::vec_set::insert<vector<u8>>(&mut arg0.claimed_mints, arg1);
    }

    public entry fun set_signer(arg0: &SignerOwnerCap, arg1: &mut MintRules, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_signer.pub_key = 0x2::hex::decode(arg2);
    }

    entry fun verify_signature(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &Signer) : bool {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = generateEthMessage(v0, arg1, arg2);
        let v2 = 0x2::hex::decode(arg3);
        let v3 = 0x1::vector::borrow_mut<u8>(&mut v2, 64);
        if (*v3 == 27) {
            *v3 = 0;
        } else if (*v3 == 28) {
            *v3 = 1;
        } else if (*v3 > 35) {
            *v3 = (*v3 - 1) % 2;
        };
        let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v2, &v1, 0);
        let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 1;
        while (v7 < 65) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        let v8 = 0x2::hash::keccak256(&v6);
        let v9 = 0x1::vector::empty<u8>();
        let v10 = 12;
        while (v10 < 32) {
            0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&v8, v10));
            v10 = v10 + 1;
        };
        &v9 == &arg4.pub_key
    }

    // decompiled from Move bytecode v6
}

