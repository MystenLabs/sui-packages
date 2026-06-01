module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::marketplace_v2 {
    struct MarketplaceV2 has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x2::object::ID, u64>,
        sellers: 0x2::table::Table<0x2::object::ID, address>,
    }

    public fun bootstrap(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceV2{
            id      : 0x2::object::new(arg1),
            prices  : 0x2::table::new<0x2::object::ID, u64>(arg1),
            sellers : 0x2::table::new<0x2::object::ID, address>(arg1),
        };
        0x2::transfer::share_object<MarketplaceV2>(v0);
    }

    public fun buy_pack_v2(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: &mut MarketplaceV2, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg1.prices, arg2), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_listed());
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg1.prices, arg2);
        let v1 = *0x2::table::borrow<0x2::object::ID, address>(&arg1.sellers, arg2);
        assert!(0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg3) >= v0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_price_too_low());
        let v2 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg1.id, arg2);
        let (v3, v4, v5) = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::royalty::split_fee_and_royalties(arg3, v0, arg2, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::creator(&v2), v1, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::royalty_bps(&v2), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_ext::read_lineage(&v2), arg0, arg4);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg1.prices, arg2);
        0x2::table::remove<0x2::object::ID, address>(&mut arg1.sellers, arg2);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut v2, false);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_pack_sold_v2(arg2, 0x2::tx_context::sender(arg4), v1, v0, v3, v4, v5);
        v2
    }

    public fun cancel_listing_v2(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: &mut MarketplaceV2, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg1.prices, arg2), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_listed());
        let v0 = *0x2::table::borrow<0x2::object::ID, address>(&arg1.sellers, arg2);
        assert!(v0 == 0x2::tx_context::sender(arg3), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_seller());
        0x2::table::remove<0x2::object::ID, u64>(&mut arg1.prices, arg2);
        0x2::table::remove<0x2::object::ID, address>(&mut arg1.sellers, arg2);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg1.id, arg2);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut v1, false);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_pack_unlisted(arg2, v0);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::share_to_sender(v1, arg3);
    }

    public fun list_pack_v2(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: &mut MarketplaceV2, arg2: 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(arg3 > 0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_price_too_low());
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(&arg2);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_listed(&mut arg2, true);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack>(&mut arg1.id, v1, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.prices, v1, arg3);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.sellers, v1, v0);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_pack_listed_v2(v1, v0, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun update_price(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: &mut MarketplaceV2, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg1.prices, arg2), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_listed());
        assert!(arg3 > 0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_price_too_low());
        assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg1.sellers, arg2) == 0x2::tx_context::sender(arg4), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_seller());
        0x2::table::remove<0x2::object::ID, u64>(&mut arg1.prices, arg2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.prices, arg2, arg3);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_pack_price_updated(arg2, *0x2::table::borrow<0x2::object::ID, u64>(&arg1.prices, arg2), arg3);
    }

    // decompiled from Move bytecode v7
}

