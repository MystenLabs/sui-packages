module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gatekeeper_helper {
    struct PublicKeys has store, key {
        id: 0x2::object::UID,
        public_keys: vector<vector<u8>>,
        nonce_list: 0x2::table::Table<vector<u8>, u64>,
    }

    public fun add_publickey(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut PublicKeys, arg2: vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(&arg2, v0);
            0x1::vector::push_back<vector<u8>>(&mut arg1.public_keys, v1);
            0x2::table::add<vector<u8>, u64>(&mut arg1.nonce_list, v1, 0);
            v0 = v0 + 1;
        };
    }

    public fun create_publickey_list(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicKeys{
            id          : 0x2::object::new(arg2),
            public_keys : arg1,
            nonce_list  : 0x2::table::new<vector<u8>, u64>(arg2),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&v0.public_keys)) {
            0x2::table::add<vector<u8>, u64>(&mut v0.nonce_list, *0x1::vector::borrow<vector<u8>>(&v0.public_keys, v1), 0);
            v1 = v1 + 1;
        };
        0x2::transfer::share_object<PublicKeys>(v0);
    }

    public fun remove_publickey(arg0: &0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::cap::AdminCap, arg1: &mut PublicKeys, arg2: vector<u8>) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1.public_keys)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg1.public_keys, v0) == arg2) {
                0x1::vector::swap_remove<vector<u8>>(&mut arg1.public_keys, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 2);
        if (0x2::table::contains<vector<u8>, u64>(&arg1.nonce_list, arg2)) {
            0x2::table::remove<vector<u8>, u64>(&mut arg1.nonce_list, arg2);
        };
    }

    public entry fun verify_platform(arg0: &mut PublicKeys, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 64, 5);
        let v0 = false;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0.public_keys)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v2);
            assert!(0x2::table::contains<vector<u8>, u64>(&arg0.nonce_list, v3), 3);
            let v4 = *0x2::table::borrow<vector<u8>, u64>(&arg0.nonce_list, v3);
            0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&v4));
            if (0x2::ed25519::ed25519_verify(&arg1, &v3, &arg2)) {
                v0 = true;
                v1 = v3;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v0, 1);
        0x2::table::remove<vector<u8>, u64>(&mut arg0.nonce_list, v1);
        0x2::table::add<vector<u8>, u64>(&mut arg0.nonce_list, v1, *0x2::table::borrow<vector<u8>, u64>(&arg0.nonce_list, v1) + 1);
    }

    // decompiled from Move bytecode v6
}

