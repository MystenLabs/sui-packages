module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_combiner {
    public fun can_match(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, arg1: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order) : bool {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg0)) == 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg1)) && 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(arg0)) == 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(arg1))
    }

    public(friend) fun match_orders(arg0: &vector<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>, arg1: &vector<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>, arg2: &0x2::clock::Clock) : (vector<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>, vector<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier::verify_length<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(arg0, arg1, true);
        let v0 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>();
        let v1 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(arg0)) {
            let v3 = 0x1::vector::borrow<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(arg0, v2);
            let v4 = 0x1::vector::borrow<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(arg1, v2);
            0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_validator::validate(v3, arg2);
            0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_validator::validate(v4, arg2);
            if (!can_match(v3, v4)) {
                abort 0
            };
            let v5 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(v3);
            let v6 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(v3);
            let v7 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(v4);
            if (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(v5))) {
                if (*0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(v5)) != *0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(v4)))) {
                    abort 1
                };
                let v8 = *0x1::option::borrow<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(v7));
                if (0x1::option::get_with_default<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(v6), v8) != v8) {
                    abort 1
                };
                0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(&mut v0, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(v5));
                0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(&mut v1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(v7));
            } else {
                let v9 = *0x1::option::borrow<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(v5));
                if (v9 != 0x1::option::get_with_default<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(v4)), v9)) {
                    abort 1
                };
                if (*0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(v6)) != *0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(v7))) {
                    abort 1
                };
                0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(&mut v0, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(v5));
                0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(&mut v1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(v7));
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

