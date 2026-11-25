module 0xa3556dce1e76780f0243744f346854e3056ae95157761e01e1936867911f08b5::account {
    struct AccountCard has key {
        id: 0x2::object::UID,
        account: address,
        threshold: u16,
        public_keys: vector<vector<u8>>,
        weights: vector<u8>,
    }

    struct AccountCardsIssuedEvent has copy, drop {
        account: address,
        multisig: address,
        threshold: u16,
        public_keys: vector<vector<u8>>,
        weights: vector<u8>,
        card_ids: vector<0x2::object::ID>,
    }

    struct AccountCardDestroyedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    public fun account(arg0: &AccountCard) : address {
        arg0.account
    }

    public fun destroy(arg0: AccountCard) {
        let AccountCard {
            id          : v0,
            account     : _,
            threshold   : _,
            public_keys : _,
            weights     : _,
        } = arg0;
        let v5 = v0;
        let v6 = AccountCardDestroyedEvent{card_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<AccountCardDestroyedEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun issue(arg0: address, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 > 0, 1);
        assert!(v0 <= 10, 2);
        assert!(0x1::vector::length<u8>(&arg2) == v0, 3);
        assert!(arg3 > 0, 4);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u16>(&arg3));
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<vector<u8>>(&arg1, v3);
            let v5 = *0x1::vector::borrow<u8>(&arg2, v3);
            assert!(v5 > 0, 5);
            let v6 = 0;
            while (v6 < v3) {
                assert!(0x1::vector::borrow<vector<u8>>(&arg1, v6) != v4, 7);
                v6 = v6 + 1;
            };
            validate_public_key(v4);
            0x1::vector::append<u8>(&mut v1, *v4);
            0x1::vector::push_back<u8>(&mut v1, v5);
            v2 = v2 + (v5 as u16);
            v3 = v3 + 1;
        };
        assert!(v2 >= arg3, 6);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v1)) == arg0, 0);
        let v7 = 0x2::tx_context::sender(arg4);
        let v8 = &arg1;
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<vector<u8>>(v8)) {
            let v11 = AccountCard{
                id          : 0x2::object::new(arg4),
                account     : v7,
                threshold   : arg3,
                public_keys : arg1,
                weights     : arg2,
            };
            0x2::transfer::transfer<AccountCard>(v11, 0x2::address::from_bytes(0x2::hash::blake2b256(0x1::vector::borrow<vector<u8>>(v8, v10))));
            0x1::vector::push_back<0x2::object::ID>(&mut v9, 0x2::object::id<AccountCard>(&v11));
            v10 = v10 + 1;
        };
        let v12 = AccountCardsIssuedEvent{
            account     : v7,
            multisig    : arg0,
            threshold   : arg3,
            public_keys : arg1,
            weights     : arg2,
            card_ids    : v9,
        };
        0x2::event::emit<AccountCardsIssuedEvent>(v12);
    }

    public fun public_keys(arg0: &AccountCard) : &vector<vector<u8>> {
        &arg0.public_keys
    }

    public fun threshold(arg0: &AccountCard) : u16 {
        arg0.threshold
    }

    fun validate_public_key(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 9);
        let v1 = *0x1::vector::borrow<u8>(arg0, 0);
        if (v1 == 0) {
            assert!(v0 == 33, 9);
        } else {
            let v2 = if (v1 == 1) {
                true
            } else if (v1 == 2) {
                true
            } else {
                v1 == 6
            };
            if (v2) {
                assert!(v0 == 34, 9);
            } else {
                assert!(v1 == 5, 8);
                assert!(v0 > 2, 9);
                let v3 = (*0x1::vector::borrow<u8>(arg0, 1) as u64);
                assert!(v3 > 0, 9);
                assert!(v0 > 2 + v3, 9);
                assert!(v0 <= 2 + v3 + 32, 9);
            };
        };
    }

    public fun weights(arg0: &AccountCard) : &vector<u8> {
        &arg0.weights
    }

    // decompiled from Move bytecode v7
}

