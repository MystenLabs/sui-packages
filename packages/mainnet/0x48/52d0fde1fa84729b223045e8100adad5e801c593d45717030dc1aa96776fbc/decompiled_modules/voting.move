module 0x4852d0fde1fa84729b223045e8100adad5e801c593d45717030dc1aa96776fbc::voting {
    struct Vote has key {
        id: 0x2::object::UID,
        voters: vector<address>,
        options: u8,
        votes: vector<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>,
        is_finalized: bool,
        key_servers: vector<address>,
        public_keys: vector<vector<u8>>,
        threshold: u8,
    }

    struct VoteResult has drop, store {
        vote_id: address,
        result: vector<u64>,
    }

    public fun id(arg0: &Vote) : vector<u8> {
        let v0 = 0x2::object::id<Vote>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public fun cast_vote(arg0: &mut Vote, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::parse_encrypted_object(arg1);
        let v1 = 0x2::address::to_bytes(0x2::tx_context::sender(arg2));
        assert!(0x1::option::borrow<vector<u8>>(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::aad(&v0)) == &v1, 1);
        let v2 = arg0.key_servers;
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::services(&v0) == &v2, 1);
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::threshold(&v0) == arg0.threshold, 1);
        let v3 = id(arg0);
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::id(&v0) == &v3, 1);
        let v4 = @0x0;
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::package_id(&v0) == &v4, 1);
        let v5 = &arg0.voters;
        let v6 = 0;
        let v7;
        while (v6 < 0x1::vector::length<address>(v5)) {
            let v8 = 0x2::tx_context::sender(arg2);
            if (0x1::vector::borrow<address>(v5, v6) == &v8) {
                v7 = 0x1::option::some<u64>(v6);
                /* label 17 */
                0x1::option::fill<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>(0x1::vector::borrow_mut<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(&mut arg0.votes, 0x1::option::destroy_some<u64>(v7)), v0);
                return
            };
            v6 = v6 + 1;
        };
        v7 = 0x1::option::none<u64>();
        /* goto 17 */
    }

    public fun create_vote(arg0: vector<address>, arg1: u8, arg2: vector<address>, arg3: vector<vector<u8>>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Vote {
        assert!(arg4 <= (0x1::vector::length<address>(&arg2) as u8), 13906834603840110591);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3), 13906834608135077887);
        let v0 = 0x1::vector::empty<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::push_back<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(&mut v0, 0x1::option::none<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>());
            v1 = v1 + 1;
        };
        Vote{
            id           : 0x2::object::new(arg5),
            voters       : arg0,
            options      : arg1,
            votes        : v0,
            is_finalized : false,
            key_servers  : arg2,
            public_keys  : arg3,
            threshold    : arg4,
        }
    }

    public fun finalize_vote(arg0: &mut Vote, arg1: &vector<vector<u8>>, arg2: &vector<address>) : VoteResult {
        assert!(!arg0.is_finalized, 3);
        assert!(0x1::vector::length<address>(arg2) == 0x1::vector::length<vector<u8>>(arg1), 13906834835768344575);
        assert!((0x1::vector::length<vector<u8>>(arg1) as u8) >= arg0.threshold, 4);
        let v0 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::G1>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v0, 0x2::bls12381::g1_from_bytes(0x1::vector::borrow<vector<u8>>(arg1, v1)));
            v1 = v1 + 1;
        };
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(arg2)) {
            let v4 = 0x1::vector::borrow<address>(arg2, v3);
            let v5 = &arg0.key_servers;
            let v6 = 0;
            let v7;
            while (v6 < 0x1::vector::length<address>(v5)) {
                if (v4 == 0x1::vector::borrow<address>(v5, v6)) {
                    v7 = 0x1::option::some<u64>(v6);
                    /* label 21 */
                    0x1::vector::push_back<u64>(&mut v2, 0x1::option::destroy_some<u64>(v7));
                    v3 = v3 + 1;
                    /* goto 13 */
                    continue
                };
                v6 = v6 + 1;
            };
            v7 = 0x1::option::none<u64>();
            /* goto 21 */
        };
        let v8 = 0x1::vector::empty<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>();
        0x1::vector::reverse<u64>(&mut v2);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v2)) {
            let v10 = 0x1::vector::pop_back<u64>(&mut v2);
            0x1::vector::push_back<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>(&mut v8, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0.key_servers, v10)), *0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v10)));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        let v11 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::verify_derived_keys(&v0, @0x0, id(arg0), &v8);
        let v12 = 0x1::vector::empty<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>();
        let v13 = arg0.key_servers;
        let v14 = arg0.public_keys;
        0x1::vector::reverse<vector<u8>>(&mut v14);
        assert!(0x1::vector::length<address>(&v13) == 0x1::vector::length<vector<u8>>(&v14), 13906834900192854015);
        0x1::vector::reverse<address>(&mut v13);
        let v15 = 0;
        while (v15 < 0x1::vector::length<address>(&v13)) {
            0x1::vector::push_back<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>(&mut v12, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(0x1::vector::pop_back<address>(&mut v13)), 0x1::vector::pop_back<vector<u8>>(&mut v14)));
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<address>(v13);
        0x1::vector::destroy_empty<vector<u8>>(v14);
        let v16 = vector[];
        let v17 = 0;
        while (v17 < (arg0.options as u64)) {
            0x1::vector::push_back<u64>(&mut v16, 0);
            v17 = v17 + 1;
        };
        let v18 = &arg0.votes;
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(v18)) {
            let v20 = 0x1::vector::borrow<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(v18, v19);
            let v21 = if (0x1::option::is_some<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>(v20)) {
                0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::decrypt(0x1::option::borrow<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>(v20), &v11, &v12)
            } else {
                0x1::option::none<vector<u8>>()
            };
            let v22 = v21;
            let v23 = &v22;
            if (0x1::option::is_some<vector<u8>>(v23)) {
                let v24 = 0x1::option::borrow<vector<u8>>(v23);
                if (0x1::vector::length<u8>(v24) == 1 && *0x1::vector::borrow<u8>(v24, 0) < arg0.options) {
                    let v25 = (*0x1::vector::borrow<u8>(v24, 0) as u64);
                    *0x1::vector::borrow_mut<u64>(&mut v16, v25) = *0x1::vector::borrow<u64>(&v16, v25) + 1;
                };
            };
            v19 = v19 + 1;
        };
        arg0.is_finalized = true;
        VoteResult{
            vote_id : 0x2::object::uid_to_address(&arg0.id),
            result  : v16,
        }
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Vote) {
        assert!(arg0 == id(arg1), 1);
        let v0 = &arg1.votes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(v0)) {
            if (!0x1::option::is_some<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>(0x1::vector::borrow<0x1::option::Option<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject>>(v0, v1))) {
                v2 = false;
                /* label 9 */
                assert!(v2, 2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 9 */
    }

    public fun vote_id(arg0: &VoteResult) : address {
        arg0.vote_id
    }

    public fun votes_for_option(arg0: &VoteResult, arg1: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.result, (arg1 as u64))
    }

    public fun winner(arg0: &VoteResult) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.result)) {
            if (*0x1::vector::borrow<u64>(&arg0.result, v1) > 0) {
                v0 = (v1 as u8);
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

