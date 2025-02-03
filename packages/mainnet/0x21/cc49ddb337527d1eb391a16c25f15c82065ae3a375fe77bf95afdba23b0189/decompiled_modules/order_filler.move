module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_filler {
    public(friend) fun fill_order_ft_to_nft(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_validator::validate(arg0, arg2);
        if (!0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg0))) || !0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_non_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)))) {
            abort 0
        };
        if (0x1::option::get_with_default<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)), arg1) != arg1) {
            abort 1
        };
        (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg0)), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::new(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)), 0x1::option::some<0x2::object::ID>(arg1), 0x1::option::none<u64>()))
    }

    public(friend) fun fill_order_nft_to_ft(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, arg1: u64, arg2: &0x2::clock::Clock) : (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_validator::validate(arg0, arg2);
        if (!0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_non_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg0))) || !0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)))) {
            abort 0
        };
        if (arg1 != *0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)))) {
            abort 1
        };
        (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg0)), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)))
    }

    // decompiled from Move bytecode v6
}

