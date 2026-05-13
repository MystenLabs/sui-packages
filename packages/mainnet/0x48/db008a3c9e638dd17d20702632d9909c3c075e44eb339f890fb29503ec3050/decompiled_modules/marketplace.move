module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x2::object::ID, u64>,
        sellers: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct PackListed has copy, drop {
        pack_id: 0x2::object::ID,
        seller: address,
        price_mist: u64,
    }

    struct PackSold has copy, drop {
        pack_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price_mist: u64,
        marketplace_fee_mist: u64,
        royalty_mist: u64,
    }

    public fun buy_pack(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.prices, arg1), 2);
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.prices, arg1);
        let v1 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.sellers, arg1);
        assert!(0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg2) >= v0, 1);
        let v2 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::royalty::take_fee(v0);
        let v3 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg0.id, arg1);
        let v4 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::royalty::take_royalty(v0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::royalty_bps(&v3));
        let v5 = 0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg2, v0, arg3);
        let v6 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::creator(&v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut v5, v2, arg3), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut v5, v4, arg3), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(v5, v1);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.prices, arg1);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.sellers, arg1);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut v3, false);
        let v7 = PackSold{
            pack_id              : arg1,
            buyer                : 0x2::tx_context::sender(arg3),
            seller               : v1,
            price_mist           : v0,
            marketplace_fee_mist : v2,
            royalty_mist         : v4,
        };
        0x2::event::emit<PackSold>(v7);
        v3
    }

    public fun cancel_listing(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.prices, arg1), 2);
        assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg0.sellers, arg1) == 0x2::tx_context::sender(arg2), 3);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.prices, arg1);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.sellers, arg1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg0.id, arg1);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut v0, false);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::share_to_sender(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id      : 0x2::object::new(arg0),
            prices  : 0x2::table::new<0x2::object::ID, u64>(arg0),
            sellers : 0x2::table::new<0x2::object::ID, address>(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun list_pack(arg0: &mut Marketplace, arg1: 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(&arg1);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut arg1, true);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg0.id, v1, arg1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.prices, v1, arg2);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.sellers, v1, v0);
        let v2 = PackListed{
            pack_id    : v1,
            seller     : v0,
            price_mist : arg2,
        };
        0x2::event::emit<PackListed>(v2);
    }

    // decompiled from Move bytecode v7
}

