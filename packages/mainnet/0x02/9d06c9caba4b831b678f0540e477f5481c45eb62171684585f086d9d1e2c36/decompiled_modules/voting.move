module 0x29d06c9caba4b831b678f0540e477f5481c45eb62171684585f086d9d1e2c36::voting {
    struct Vote has key {
        id: 0x2::object::UID,
        voters: vector<address>,
        votes: vector<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>,
        result: 0x1::option::Option<vector<0x1::option::Option<u8>>>,
        key_servers: vector<0x2::object::ID>,
        threshold: u8,
    }

    public fun id(arg0: &Vote) : vector<u8> {
        let v0 = 0x2::object::id<Vote>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public fun cast_vote(arg0: &mut Vote, arg1: 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg2));
        assert!(0x1::option::borrow<vector<u8>>(0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::aad(&arg1)) == &v0, 1);
        let v1 = &arg0.key_servers;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
            0x1::vector::push_back<address>(&mut v2, 0x2::object::id_to_address(0x1::vector::borrow<0x2::object::ID>(v1, v3)));
            v3 = v3 + 1;
        };
        assert!(0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::services(&arg1) == &v2, 13906834505055862783);
        assert!(0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::threshold(&arg1) == arg0.threshold, 13906834509350830079);
        let v4 = &arg0.voters;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<address>(v4)) {
            let v7 = 0x2::tx_context::sender(arg2);
            if (0x1::vector::borrow<address>(v4, v5) == &v7) {
                v6 = 0x1::option::some<u64>(v5);
                /* label 19 */
                0x1::option::fill<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>(0x1::vector::borrow_mut<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(&mut arg0.votes, 0x1::option::extract<u64>(&mut v6)), arg1);
                return
            };
            v5 = v5 + 1;
        };
        v6 = 0x1::option::none<u64>();
        /* goto 19 */
    }

    public fun create_vote(arg0: vector<address>, arg1: vector<0x2::object::ID>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Vote {
        assert!(arg2 <= (0x1::vector::length<0x2::object::ID>(&arg1) as u8), 13906834423451484159);
        let v0 = 0x1::vector::empty<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x1::vector::push_back<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(&mut v0, 0x1::option::none<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>());
            v1 = v1 + 1;
        };
        Vote{
            id          : 0x2::object::new(arg3),
            voters      : arg0,
            votes       : v0,
            result      : 0x1::option::none<vector<0x1::option::Option<u8>>>(),
            key_servers : arg1,
            threshold   : arg2,
        }
    }

    public fun finalize_vote(arg0: &mut Vote, arg1: &vector<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::VerifiedDerivedKey>, arg2: &vector<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::PublicKey>) {
        assert!(0x1::option::is_none<vector<0x1::option::Option<u8>>>(&arg0.result), 3);
        let v0 = &arg0.votes;
        let v1 = 0x1::vector::empty<0x1::option::Option<u8>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(v0)) {
            let v3 = 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::decrypt(0x1::option::borrow<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>(0x1::vector::borrow<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(v0, v2)), arg1, arg2);
            let v4;
            if (0x1::option::is_some<vector<u8>>(&v3)) {
                let v5 = 0x1::option::borrow<vector<u8>>(&v3);
                if (0x1::vector::length<u8>(v5) == 1) {
                    v4 = 0x1::option::some<u8>(*0x1::vector::borrow<u8>(v5, 0));
                };
            };
            v4 = 0x1::option::none<u8>();
            0x1::vector::push_back<0x1::option::Option<u8>>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x1::option::fill<vector<0x1::option::Option<u8>>>(&mut arg0.result, v1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Vote) {
        let v0 = 0x2::object::id<Vote>(arg1);
        assert!(arg0 == 0x2::object::id_to_bytes(&v0), 1);
        let v1 = &arg1.votes;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(v1)) {
            if (!0x1::option::is_some<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>(0x1::vector::borrow<0x1::option::Option<0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::bf_hmac_encryption::EncryptedObject>>(v1, v2))) {
                v3 = false;
                /* label 9 */
                assert!(v3, 2);
                return
            };
            v2 = v2 + 1;
        };
        v3 = true;
        /* goto 9 */
    }

    // decompiled from Move bytecode v6
}

