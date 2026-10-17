module 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::aftermath {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Venue has drop {
        dummy_field: bool,
    }

    struct PoolCreation<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        presale_id: 0x2::object::ID,
        create_pool_cap: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2,
    }

    struct PoolCreationReserved<phantom T0, phantom T1, phantom T2> has copy, drop {
        presale_id: 0x2::object::ID,
        pool_creation_id: 0x2::object::ID,
        create_pool_cap_id: 0x2::object::ID,
    }

    struct DaoFeePoolCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dao_fee_pool_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        lp_coin_id: 0x2::object::ID,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::creation_policy::CreationPolicy, arg2: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::fee_policy::FeePolicy, arg3: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::venue_config::VenueConfig, arg4: u16) : 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::PresaleInitializer<T0, T1> {
        assert!(arg4 > 0 && arg4 <= 10000, 13835902725026152460);
        let v0 = Venue{dummy_field: false};
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::venue_config::add_pool_tier<T0, T1, Venue>(arg3, &v0, 0, (arg4 as u64));
        let v1 = Witness{dummy_field: false};
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::new<T0, T1, Witness>(arg0, v1, arg1, arg2)
    }

    public fun collect_fees<T0, T1>(arg0: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>, arg1: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::fee_policy::FeePolicy, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T1>>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        assert!(0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::has_position<T0, T1, Venue>(arg0, &v0), 13836466181785976848);
        let v1 = receive_fees<T0, T1, T0>(arg0, arg2);
        let v2 = receive_fees<T0, T1, T1>(arg0, arg3);
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::split_fees<T0, T1>(arg0, arg1, v1, v2, arg4);
    }

    fun create_pool<T0, T1, T2>(arg0: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        if (sorts_before<T1, T2>()) {
            create_pool_2_coins<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
        } else {
            create_pool_2_coins<T0, T2, T1>(arg0, arg1, arg3, arg2, arg4)
        }
    }

    fun create_pool_2_coins<T0, T1, T2>(arg0: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
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

    public fun finalize<T0, T1, T2>(arg0: 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::PresaleInitializer<T1, T2>, arg1: &mut 0x2::coin_registry::Currency<T1>, arg2: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2, arg3: &mut 0x2::tx_context::TxContext) : (0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::Presale<T1, T2>, 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::PresaleCap, PoolCreation<T0, T1, T2>) {
        assert!(0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::migration_witness<T1, T2>(&arg0) == 0x1::type_name::with_original_ids<Witness>(), 13836184277312405518);
        let (v0, v1) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::finalize<T1, T2>(arg0, arg1, arg3);
        let v2 = v0;
        let v3 = PoolCreation<T0, T1, T2>{
            id              : 0x2::object::new(arg3),
            presale_id      : 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::Presale<T1, T2>>(&v2),
            create_pool_cap : arg2,
        };
        let v4 = PoolCreationReserved<T0, T1, T2>{
            presale_id         : v3.presale_id,
            pool_creation_id   : 0x2::object::uid_to_inner(&v3.id),
            create_pool_cap_id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2>(&v3.create_pool_cap),
        };
        0x2::event::emit<PoolCreationReserved<T0, T1, T2>>(v4);
        (v2, v1, v3)
    }

    public fun migrate<T0, T1, T2>(arg0: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::Presale<T1, T2>, arg1: PoolCreation<T0, T1, T2>, arg2: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::fee_policy::FeePolicy, arg3: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::venue_config::VenueConfig, arg4: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg5: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let PoolCreation {
            id              : v0,
            presale_id      : v1,
            create_pool_cap : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::Presale<T1, T2>>(arg0), 13835621503452381194);
        0x2::object::delete(v0);
        let (_, v4) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::venue_config::pool_tier<T1>(arg3);
        let v5 = (v4 as u16);
        let v6 = Witness{dummy_field: false};
        let (v7, v8) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::migrate<T1, T2, Witness>(arg0, arg2, v6, arg6, arg7);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::coin::from_balance<T1>(v10, arg7);
        let v12 = 0x2::coin::from_balance<T2>(v9, arg7);
        let (v13, v14) = create_pool<T0, T1, T2>(v2, arg4, v11, v12, arg7);
        let v15 = v14;
        let v16 = v13;
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T1>(&v16) == 0x2::balance::value<T1>(&v10) && 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<T0, T2>(&v16) == 0x2::balance::value<T2>(&v9), 13835058626513141766);
        let v17 = 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(&v16);
        let v18 = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::new<T1, T2>(arg0, v17, 0x2::balance::zero<T1>(), 0x2::balance::zero<T2>(), arg7);
        let v19 = 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T1, T2>>(&v18);
        let v20 = 0x2::object::id_to_address(&v19);
        let (v21, v22) = 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::new<T0>(v16, arg5, v5, v20, arg7);
        let v23 = v22;
        let v24 = v21;
        assert!(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_bps<T0>(&v24) == v5 && 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::fee_recipient<T0>(&v24) == v20, 13835340165914492936);
        let v25 = DaoFeePoolCreated<T0, T1, T2>{
            vault_id        : 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T1, T2>>(&v18),
            pool_id         : v17,
            dao_fee_pool_id : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(&v24),
            owner_cap_id    : 0x2::object::id<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(&v23),
            lp_coin_id      : 0x2::object::id<0x2::coin::Coin<T0>>(&v15),
        };
        0x2::event::emit<DaoFeePoolCreated<T0, T1, T2>>(v25);
        let v26 = Venue{dummy_field: false};
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::share_with_position<T1, T2, Venue, 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::OwnerCap<T0>>(v18, &v26, v23, (0x2::coin::value<T0>(&v15) as u128));
        0x2::transfer::public_share_object<0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>>(v24);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v15, @0x0);
    }

    fun receive_fees<T0, T1, T2>(arg0: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>, arg1: vector<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::balance::zero<T2>();
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(&arg1)) {
            0x2::balance::join<T2>(&mut v0, 0x2::coin::into_balance<T2>(0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::receive_fee<T0, T1, T2>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(&mut arg1))));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T2>>>(arg1);
        v0
    }

    public fun share<T0, T1, T2>(arg0: PoolCreation<T0, T1, T2>) {
        0x2::transfer::share_object<PoolCreation<T0, T1, T2>>(arg0);
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

