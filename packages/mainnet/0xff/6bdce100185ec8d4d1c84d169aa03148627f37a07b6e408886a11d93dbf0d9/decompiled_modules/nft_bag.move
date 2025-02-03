module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::nft_bag {
    struct NftBag has store {
        id: 0x2::object::UID,
        authorities: vector<0x1::type_name::TypeName>,
        nfts: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    struct Key has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: &NftBag, arg1: 0x2::object::ID) : &T0 {
        assert_composed_type<T0>(arg0, arg1);
        let v0 = Key{id: arg1};
        0x2::dynamic_object_field::borrow<Key, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut NftBag, arg1: 0x2::object::ID) : &mut T0 {
        assert_composed_type<T0>(arg0, arg1);
        let v0 = Key{id: arg1};
        0x2::dynamic_object_field::borrow_mut<Key, T0>(&mut arg0.id, v0)
    }

    public fun delete(arg0: NftBag) {
        let NftBag {
            id          : v0,
            authorities : _,
            nfts        : v2,
        } = arg0;
        let v3 = v2;
        assert!(0x2::vec_map::is_empty<0x2::object::ID, u64>(&v3), 5);
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : NftBag {
        NftBag{
            id          : 0x2::object::new(arg0),
            authorities : 0x1::vector::empty<0x1::type_name::TypeName>(),
            nfts        : 0x2::vec_map::empty<0x2::object::ID, u64>(),
        }
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: NftBag) {
        assert_no_nft_bag(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<NftBag>, NftBag>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<NftBag>(), arg1);
    }

    public fun add_new(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        add_domain(arg0, new(arg1));
    }

    public fun assert_composed(arg0: &NftBag, arg1: 0x2::object::ID) {
        assert!(has(arg0, arg1), 3);
    }

    public fun assert_composed_type<T0: store + key>(arg0: &NftBag, arg1: 0x2::object::ID) {
        assert_composed(arg0, arg1);
        let v0 = Key{id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<Key, T0>(&arg0.id, v0), 4);
    }

    public fun assert_nft_bag(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun assert_no_nft_bag(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &NftBag {
        assert_nft_bag(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<NftBag>, NftBag>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<NftBag>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut NftBag {
        assert_nft_bag(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<NftBag>, NftBag>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<NftBag>())
    }

    public fun borrow_nft<T0: store + key>(arg0: &0x2::object::UID, arg1: 0x2::object::ID) : &T0 {
        borrow<T0>(borrow_domain(arg0), arg1)
    }

    public fun borrow_nft_mut<T0: store + key>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : &mut T0 {
        let v0 = borrow_domain_mut(arg0);
        borrow_mut<T0>(v0, arg1)
    }

    public fun compose<T0: store + key, T1: drop>(arg0: T1, arg1: &mut NftBag, arg2: T0) {
        let v0 = get_or_insert_authority_idx(0x1::type_name::get<T1>(), arg1);
        let v1 = 0x2::object::id<T0>(&arg2);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg1.nfts, v1, v0);
        let v2 = Key{id: v1};
        0x2::dynamic_object_field::add<Key, T0>(&mut arg1.id, v2, arg2);
    }

    public fun compose_into_nft<T0: store + key, T1: drop>(arg0: T1, arg1: &mut 0x2::object::UID, arg2: T0) {
        let v0 = borrow_domain_mut(arg1);
        compose<T0, T1>(arg0, v0, arg2);
    }

    public fun count<T0>(arg0: &NftBag) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = get_authority_idx(&v0, arg0);
        if (0x1::option::is_none<u64>(&v1)) {
            return 0
        };
        let v2 = 0;
        let v3 = 0x1::option::destroy_some<u64>(v1);
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x2::object::ID, u64>(&arg0.nfts)) {
            let (_, v6) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(&arg0.nfts, v4);
            if (v6 == &v3) {
                v2 = v2 + 1;
            };
            v4 = v4 + 1;
        };
        v2
    }

    public fun decompose<T0: store + key, T1: drop>(arg0: T1, arg1: &mut NftBag, arg2: 0x2::object::ID) : T0 {
        let v0 = 0x2::vec_map::get_idx_opt<0x2::object::ID, u64>(&arg1.nfts, &arg2);
        assert!(0x1::option::is_some<u64>(&v0), 3);
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(&arg1.nfts, v1);
        let v4 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.authorities, *v3) == &v4, 5);
        let (_, _) = 0x2::vec_map::remove_entry_by_idx<0x2::object::ID, u64>(&mut arg1.nfts, v1);
        assert_composed_type<T0>(arg1, arg2);
        let v7 = Key{id: arg2};
        0x2::dynamic_object_field::remove<Key, T0>(&mut arg1.id, v7)
    }

    public fun decompose_and_transfer<T0: store + key, T1: drop>(arg0: T1, arg1: &mut NftBag, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(decompose<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun decompose_from_nft<T0: store + key, T1: drop>(arg0: T1, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID) : T0 {
        let v0 = borrow_domain_mut(arg1);
        decompose<T0, T1>(arg0, v0, arg2)
    }

    public fun decompose_from_nft_and_transfer<T0: store + key, T1: drop>(arg0: T1, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(decompose_from_nft<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun get_authorities(arg0: &NftBag) : &vector<0x1::type_name::TypeName> {
        &arg0.authorities
    }

    fun get_authority_idx(arg0: &0x1::type_name::TypeName, arg1: &NftBag) : 0x1::option::Option<u64> {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.authorities, arg0);
        if (v0) {
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_nfts(arg0: &NftBag) : &0x2::vec_map::VecMap<0x2::object::ID, u64> {
        &arg0.nfts
    }

    fun get_or_insert_authority_idx(arg0: 0x1::type_name::TypeName, arg1: &mut NftBag) : u64 {
        let v0 = get_authority_idx(&arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.authorities, arg0);
            0x1::vector::length<0x1::type_name::TypeName>(&arg1.authorities)
        }
    }

    public fun has(arg0: &NftBag, arg1: 0x2::object::ID) : bool {
        let v0 = Key{id: arg1};
        0x2::dynamic_object_field::exists_<Key>(&arg0.id, v0)
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<NftBag>, NftBag>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<NftBag>())
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : NftBag {
        assert_nft_bag(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<NftBag>, NftBag>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<NftBag>())
    }

    // decompiled from Move bytecode v6
}

