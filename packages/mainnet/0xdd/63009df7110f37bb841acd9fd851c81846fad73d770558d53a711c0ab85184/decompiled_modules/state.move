module 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::state {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LockedKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct UnlockedKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct ExtensionMetadataV1 has store, key {
        id: 0x2::object::UID,
        sub_vault_ids: vector<0x2::object::ID>,
        lp_coins: 0x2::object_bag::ObjectBag,
        lp_coin_types: vector<0x1::type_name::TypeName>,
        amounts: vector<u64>,
    }

    public(friend) fun join<T0>(arg0: &mut ExtensionMetadataV1, arg1: 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::Locked<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.lp_coin_types;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v4) = *0x1::vector::borrow<u64>(&arg0.amounts, v4) + arg2;
                if (0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::is_unlocked<0x2::coin::Coin<T0>>(&arg1, arg3)) {
                    let v5 = UnlockedKey{pos0: v0};
                    0x2::coin::join<T0>(0x2::object_bag::borrow_mut<UnlockedKey, 0x2::coin::Coin<T0>>(&mut arg0.lp_coins, v5), 0x9c688ea952547e8d3ebfe13e97668659dd3aebd6c5a854048655ba8f253e7a26::locked::unlock<0x2::coin::Coin<T0>>(arg1, arg3));
                } else {
                    let v6 = LockedKey{pos0: v0};
                    0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::join<T0>(0x2::object_bag::borrow_mut<LockedKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::LockedCoins<T0>>(&mut arg0.lp_coins, v6), arg1);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun split<T0>(arg0: &mut ExtensionMetadataV1, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.lp_coin_types;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                let v4 = 0x1::option::extract<u64>(&mut v3);
                let v5 = UnlockedKey{pos0: v0};
                let v6 = 0x2::object_bag::borrow_mut<UnlockedKey, 0x2::coin::Coin<T0>>(&mut arg0.lp_coins, v5);
                assert!(arg1 <= 0x2::coin::value<T0>(v6), 3);
                *0x1::vector::borrow_mut<u64>(&mut arg0.amounts, v4) = *0x1::vector::borrow<u64>(&arg0.amounts, v4) - arg1;
                return 0x2::coin::split<T0>(v6, arg1, arg2)
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ExtensionMetadataV1 {
        ExtensionMetadataV1{
            id            : 0x2::object::new(arg0),
            sub_vault_ids : 0x1::vector::empty<0x2::object::ID>(),
            lp_coins      : 0x2::object_bag::new(arg0),
            lp_coin_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
            amounts       : vector[],
        }
    }

    public(friend) fun add_sub_vault<T0>(arg0: &mut ExtensionMetadataV1, arg1: &0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x77032ea15c0f29ae6c6f6d8f76de0071841af4a92ed42f5e91a13ef6d9cdb906::vault::Vault<T0>>(arg1);
        assert_sub_vault_has_not_already_been_added(arg0, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.sub_vault_ids, v0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.lp_coin_types, v1);
        let v2 = LockedKey{pos0: v1};
        0x2::object_bag::add<LockedKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::LockedCoins<T0>>(&mut arg0.lp_coins, v2, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::new<T0>(arg2));
        let v3 = UnlockedKey{pos0: v1};
        0x2::object_bag::add<UnlockedKey, 0x2::coin::Coin<T0>>(&mut arg0.lp_coins, v3, 0x2::coin::zero<T0>(arg2));
        0x1::vector::push_back<u64>(&mut arg0.amounts, 0);
    }

    public(friend) fun assert_sub_vault_has_not_already_been_added(arg0: &ExtensionMetadataV1, arg1: 0x2::object::ID) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.sub_vault_ids, &arg1), 1);
    }

    public(friend) fun crank_unlocks<T0>(arg0: &mut ExtensionMetadataV1, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.lp_coin_types, &v0), 2);
        let v1 = LockedKey{pos0: v0};
        let v2 = UnlockedKey{pos0: v0};
        0x2::pay::join_vec<T0>(0x2::object_bag::borrow_mut<UnlockedKey, 0x2::coin::Coin<T0>>(&mut arg0.lp_coins, v2), 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::unlock_unlockable<T0>(0x2::object_bag::borrow_mut<LockedKey, 0xdd63009df7110f37bb841acd9fd851c81846fad73d770558d53a711c0ab85184::locked_coins::LockedCoins<T0>>(&mut arg0.lp_coins, v1), arg1));
    }

    public(friend) fun create_extension_key() : ExtensionKey {
        ExtensionKey{dummy_field: false}
    }

    public(friend) fun destroy(arg0: ExtensionMetadataV1) {
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&arg0.lp_coin_types), 0);
        let ExtensionMetadataV1 {
            id            : v0,
            sub_vault_ids : _,
            lp_coins      : v2,
            lp_coin_types : _,
            amounts       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::object_bag::destroy_empty(v2);
    }

    public(friend) fun sub_vault_ids(arg0: &ExtensionMetadataV1) : vector<0x2::object::ID> {
        arg0.sub_vault_ids
    }

    public(friend) fun total_amount<T0>(arg0: &ExtensionMetadataV1) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.lp_coin_types;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 2
                };
                return *0x1::vector::borrow<u64>(&arg0.amounts, 0x1::option::extract<u64>(&mut v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

