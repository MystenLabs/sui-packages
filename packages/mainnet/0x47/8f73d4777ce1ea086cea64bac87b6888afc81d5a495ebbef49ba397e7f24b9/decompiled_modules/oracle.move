module 0x478f73d4777ce1ea086cea64bac87b6888afc81d5a495ebbef49ba397e7f24b9::oracle {
    public fun get_price(arg0: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: u64) : u256 {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price::newest_price_from_sources_above_confidence(arg0, arg1, v0, 0, arg4, true, arg2)
    }

    // decompiled from Move bytecode v6
}

