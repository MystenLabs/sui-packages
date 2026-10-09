module 0xac58d338925ac96304ca573a4dab80d442df6f2427291bcddbea7fc65279678e::blast_aftermath_dao_presale {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreation<phantom T0> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        create_pool_cap: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2,
    }

    struct PoolCreationReserved<phantom T0, phantom T1, phantom T2> has copy, drop {
        presale_id: 0x2::object::ID,
        pool_creation_id: 0x2::object::ID,
    }

    struct Migrated<phantom T0, phantom T1, phantom T2> has copy, drop {
        presale_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dao_fee_pool_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        lp_coin_id: 0x2::object::ID,
        lp: u64,
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::creation_policy::CreationPolicy, arg3: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy) : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleInitializer<T0, T1> {
        let v0 = Witness{dummy_field: false};
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::new<T0, T1, Witness>(arg1, v0, arg2, arg3)
    }

    public fun finalize<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleInitializer<T1, T2>, arg2: &mut 0x2::coin_registry::Currency<T1>, arg3: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg4: &mut 0x2::tx_context::TxContext) : 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T1, T2> {
        assert!(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::migration_witness<T1, T2>(&arg1) == 0x1::type_name::with_original_ids<Witness>(), 13835902767976022031);
        let v0 = 0x1::vector::empty<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::RecipientShare>();
        0x1::vector::push_back<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::RecipientShare>(&mut v0, 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::recipient_share(@0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8, 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::new(10000)));
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::set_fee_split<T1, T2>(&mut arg1, 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::fee_split(v0, 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::bps::new(0)));
        let (v1, v2) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::finalize<T1, T2>(arg1, arg2, arg4);
        let v3 = v1;
        let v4 = PoolCreation<T0>{
            id              : 0x2::object::new(arg4),
            presale_id      : 0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T1, T2>>(&v3),
            create_pool_cap : arg3,
        };
        let v5 = PoolCreationReserved<T0, T1, T2>{
            presale_id       : v4.presale_id,
            pool_creation_id : 0x2::object::id<PoolCreation<T0>>(&v4),
        };
        0x2::event::emit<PoolCreationReserved<T0, T1, T2>>(v5);
        0x2::transfer::public_transfer<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::PresaleCap>(v2, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        0x2::transfer::share_object<PoolCreation<T0>>(v4);
        v3
    }

    public fun migrate<T0, T1, T2>(arg0: &mut 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T1, T2>, arg1: PoolCreation<T0>, arg2: &0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::fee_policy::FeePolicy, arg3: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let PoolCreation {
            id              : v0,
            presale_id      : v1,
            create_pool_cap : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T1, T2>>(arg0), 13835621477682774029);
        0x2::object::delete(v0);
        let v3 = Witness{dummy_field: false};
        let (v4, v5) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::migrate<T1, T2, Witness>(arg0, arg2, v3, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = if (sorts_before<T1, T2>()) {
            let v10 = 0x2::coin::from_balance<T1>(v7, arg6);
            let v11 = 0x2::coin::from_balance<T2>(v6, arg6);
            create_pool<T0, T1, T2>(v2, arg3, v10, v11, arg6)
        } else {
            let v12 = 0x2::coin::from_balance<T2>(v6, arg6);
            let v13 = 0x2::coin::from_balance<T1>(v7, arg6);
            create_pool<T0, T2, T1>(v2, arg3, v12, v13, arg6)
        };
        let v14 = v9;
        let v15 = v8;
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T1>(&v15) == 0x2::balance::value<T1>(&v7) && 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T2>(&v15) == 0x2::balance::value<T2>(&v6), 13835058639398240265);
        let (v16, v17) = 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::new<T0>(v15, arg4, 200, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8, arg6);
        let v18 = v17;
        let v19 = v16;
        assert!(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_bps<T0>(&v19) == 200 && 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_recipient<T0>(&v19) == @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8, 13835340170209656843);
        let v20 = Migrated<T0, T1, T2>{
            presale_id      : 0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::Presale<T1, T2>>(arg0),
            pool_id         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&v15),
            dao_fee_pool_id : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(&v19),
            owner_cap_id    : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(&v18),
            lp_coin_id      : 0x2::object::id<0x2::coin::Coin<T0>>(&v14),
            lp              : 0x2::coin::value<T0>(&v14),
        };
        0x2::event::emit<Migrated<T0, T1, T2>>(v20);
        0x2::transfer::public_share_object<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(v19);
        0x2::transfer::public_transfer<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(v18, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, @0x0);
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

