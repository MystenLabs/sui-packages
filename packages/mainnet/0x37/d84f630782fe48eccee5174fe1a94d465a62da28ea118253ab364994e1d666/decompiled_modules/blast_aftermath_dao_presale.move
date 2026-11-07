module 0x37d84f630782fe48eccee5174fe1a94d465a62da28ea118253ab364994e1d666::blast_aftermath_dao_presale {
    struct Venue has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreation<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        package_witness: 0x1::type_name::TypeName,
        create_pool_cap: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2,
    }

    struct PoolCreationReserved<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_creation_id: 0x2::object::ID,
        package_witness: 0x1::type_name::TypeName,
    }

    struct Migrated<phantom T0, phantom T1, phantom T2> has copy, drop {
        presale_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dao_fee_pool_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        lp_coin_id: 0x2::object::ID,
        lp: u64,
    }

    fun create_pool<T0, T1, T2>(arg0: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 500000000000000000);
        0x1::vector::push_back<u64>(v1, 500000000000000000);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 100000000000000);
        0x1::vector::push_back<u64>(v3, 100000000000000);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_factory::create_pool_2_coins_v2<T0, T1, T2>(arg0, arg1, b"Blast Presale Pool", v0, 0, v2, vector[0, 0], vector[0, 0], vector[0, 0], arg2, arg3, 0x1::option::none<vector<u8>>(), false, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun migrate<T0, T1, T2>(arg0: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::Migration<T1, T2>, arg1: PoolCreation<T0, T1>, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        let (v1, v2, v3) = 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::redeem<T1, T2, Venue>(arg0, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::package_witness(&v4) == arg1.package_witness, 13835902888235040782);
        let PoolCreation {
            id              : v7,
            package_witness : _,
            create_pool_cap : v9,
        } = arg1;
        0x2::object::delete(v7);
        let (v10, v11) = if (sorts_before<T1, T2>()) {
            let v12 = 0x2::coin::from_balance<T1>(v6, arg4);
            let v13 = 0x2::coin::from_balance<T2>(v5, arg4);
            create_pool<T0, T1, T2>(v9, arg2, v12, v13, arg4)
        } else {
            let v14 = 0x2::coin::from_balance<T2>(v5, arg4);
            let v15 = 0x2::coin::from_balance<T1>(v6, arg4);
            create_pool<T0, T2, T1>(v9, arg2, v14, v15, arg4)
        };
        let v16 = v11;
        let v17 = v10;
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T1>(&v17) == 0x2::balance::value<T1>(&v6) && 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T2>(&v17) == 0x2::balance::value<T2>(&v5), 13835058755362291720);
        let (v18, v19) = 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::new<T0>(v17, arg3, 200, @0xef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598, arg4);
        let v20 = v19;
        let v21 = v18;
        assert!(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_bps<T0>(&v21) == 200 && 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_recipient<T0>(&v21) == @0xef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598, 13835340277583773706);
        let v22 = Migrated<T0, T1, T2>{
            presale_id      : 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::origin(&v4),
            pool_id         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&v17),
            dao_fee_pool_id : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(&v21),
            owner_cap_id    : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(&v20),
            lp_coin_id      : 0x2::object::id<0x2::coin::Coin<T0>>(&v16),
            lp              : 0x2::coin::value<T0>(&v16),
        };
        0x2::event::emit<Migrated<T0, T1, T2>>(v22);
        0x2::transfer::public_share_object<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(v21);
        0x2::transfer::public_transfer<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(v20, @0xef468a16dd5ff69a5d35d23ab8ea5540f1410ff34a2f2b8f3f0d573de9df3598);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, @0x0);
    }

    public fun prepare<T0, T1, T2, T3>(arg0: &AdminCap, arg1: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg2: &mut 0x2::tx_context::TxContext) : 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::VenueTicket<T1, T2> {
        let v0 = 0x1::type_name::with_original_ids<T3>();
        assert!(!0x1::type_name::is_primitive(&v0), 13835621271524278284);
        let v1 = 0x1::type_name::original_id<T3>();
        assert!(v1 != @0x1 && v1 != @0x2, 13835621280114212876);
        let v2 = PoolCreation<T0, T1>{
            id              : 0x2::object::new(arg2),
            package_witness : v0,
            create_pool_cap : arg1,
        };
        0x2::transfer::share_object<PoolCreation<T0, T1>>(v2);
        let v3 = PoolCreationReserved<T0, T1, T2>{
            pool_creation_id : 0x2::object::id<PoolCreation<T0, T1>>(&v2),
            package_witness  : v0,
        };
        0x2::event::emit<PoolCreationReserved<T0, T1, T2>>(v3);
        let v4 = Venue{dummy_field: false};
        0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::migration::issue_ticket<T1, T2, Venue>(v4)
    }

    fun sorts_before<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v2 = 0x1::u64::min(0x1::vector::length<u8>(&v0), 0x1::vector::length<u8>(&v1));
        let v3 = 0;
        while (v3 < v2 && *0x1::vector::borrow<u8>(&v0, v3) == *0x1::vector::borrow<u8>(&v1, v3)) {
            v3 = v3 + 1;
        };
        if (v3 < v2) {
            return *0x1::vector::borrow<u8>(&v0, v3) < *0x1::vector::borrow<u8>(&v1, v3)
        };
        0x1::vector::length<u8>(&v0) < 0x1::vector::length<u8>(&v1)
    }

    // decompiled from Move bytecode v7
}

