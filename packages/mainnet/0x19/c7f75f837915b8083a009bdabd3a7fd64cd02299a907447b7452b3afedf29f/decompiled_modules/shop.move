module 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::shop {
    struct ItemPurchased has copy, drop {
        buyer: address,
        item_name: 0x1::string::String,
        cost: u64,
        target: u64,
        num_uses: u64,
    }

    public fun bomb_usage_limit(arg0: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::Game, arg1: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::Shop) : (u64, u64) {
        let v0 = 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_limit_rate(arg1, 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_name2index(arg1, 0x1::string::utf8(b"bomb"))) * 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::total_pool(arg0) / 100;
        let v1 = 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::total_bomb_used(arg0);
        let v2 = if (v1 >= v0) {
            0
        } else {
            v0 - v1
        };
        (v0, v2)
    }

    public fun buy_and_use_bomb(arg0: &0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::Shop, arg1: &mut 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::UserProfile, arg2: u64, arg3: &mut 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::Game, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_name2index(arg0, 0x1::string::utf8(b"bomb"));
        let v1 = 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_cost(arg0, v0) * arg4;
        assert!(0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::get_user_level(arg1) >= 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_req_lv(arg0, v0), 0);
        assert!(0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::get_user_points(arg1) >= v1, 1);
        0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::deduct_user_points(arg1, v1);
        assert!(0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::total_bomb_used(arg3) + arg4 <= 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_limit_rate(arg0, v0) * 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::total_pool(arg3) / 100, 2);
        0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority::use_item_bomb(arg3, arg2, arg4, arg5);
        let v2 = ItemPurchased{
            buyer     : 0x2::tx_context::sender(arg6),
            item_name : 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::sbt::item_name(arg0, v0),
            cost      : v1,
            target    : arg2,
            num_uses  : arg4,
        };
        0x2::event::emit<ItemPurchased>(v2);
    }

    // decompiled from Move bytecode v6
}

