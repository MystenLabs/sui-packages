module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::consideration {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun fill_order_ft_to_nft<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::Treasury, arg3: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::RoyaltyRegistry, arg4: u64, arg5: T0, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::assert_not_protected_fill_order<T0, T1>(v0);
        let v1 = 0x2::object::id<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(v0);
        let v2 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::take_order<T0, T1>(v0, arg4);
        let v3 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&v2);
        if (v3 == 0x2::tx_context::sender(arg8)) {
            abort 0
        };
        let (v4, v5) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_filler::fill_order_ft_to_nft(&v2, 0x2::object::id<T0>(&arg5), arg7);
        let v6 = v5;
        let v7 = v4;
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::deposit_nft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::borrow_mut_vault<T0, T1>(v0), arg5);
        let v8 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(v9, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(&v6));
        0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(v9, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(&v7));
        let v10 = 0x1::vector::empty<address>();
        let v11 = &mut v10;
        0x1::vector::push_back<address>(v11, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::recipient(&v2));
        0x1::vector::push_back<address>(v11, arg6);
        settle_order<T0, T1>(v0, arg2, arg3, &v8, v10, arg8);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_order_filled_event(v1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::order_id(&v2), v3, 0x2::tx_context::sender(arg8), &v7, &v6);
    }

    public fun fill_order_nft_to_ft<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::Treasury, arg3: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::RoyaltyRegistry, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::assert_not_protected_fill_order<T0, T1>(v0);
        let v1 = 0x2::object::id<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(v0);
        let v2 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::take_order<T0, T1>(v0, arg4);
        let v3 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&v2);
        if (v3 == 0x2::tx_context::sender(arg8)) {
            abort 0
        };
        let (v4, v5) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_filler::fill_order_nft_to_ft(&v2, 0x2::coin::value<T1>(&arg5), arg7);
        let v6 = v5;
        let v7 = v4;
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::deposit_ft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::borrow_mut_vault<T0, T1>(v0), 0x2::coin::into_balance<T1>(arg5));
        let v8 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(v9, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(&v6));
        0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(v9, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(&v7));
        let v10 = 0x1::vector::empty<address>();
        let v11 = &mut v10;
        0x1::vector::push_back<address>(v11, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::recipient(&v2));
        0x1::vector::push_back<address>(v11, arg6);
        settle_order<T0, T1>(v0, arg2, arg3, &v8, v10, arg8);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_order_filled_event(v1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::order_id(&v2), v3, 0x2::tx_context::sender(arg8), &v7, &v6);
    }

    public fun match_orders<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::Treasury, arg3: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::RoyaltyRegistry, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::assert_not_protected_match_orders<T0, T1>(v0);
        if (0x1::vector::length<u64>(&arg4) == 0 || 0x1::vector::length<u64>(&arg4) % 2 != 0) {
            abort 1
        };
        let v1 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>();
        let v2 = 0x1::vector::empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg4)) {
            let v4 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::take_order<T0, T1>(v0, *0x1::vector::borrow<u64>(&arg4, v3));
            let v5 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::take_order<T0, T1>(v0, *0x1::vector::borrow<u64>(&arg4, v3 + 1));
            if (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&v4) == 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&v5)) {
                abort 0
            };
            0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v1, v4);
            0x1::vector::push_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v2, v5);
            v3 = v3 + 2;
        };
        let (v6, v7) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_combiner::match_orders(&v1, &v2, arg5);
        let v8 = v7;
        let v9 = vector[];
        0x1::vector::reverse<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v1);
        while (!0x1::vector::is_empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&v1)) {
            let v10 = 0x1::vector::pop_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v1);
            0x1::vector::push_back<address>(&mut v9, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::recipient(&v10));
        };
        0x1::vector::destroy_empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(v1);
        let v11 = vector[];
        0x1::vector::reverse<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v2);
        while (!0x1::vector::is_empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&v2)) {
            let v12 = 0x1::vector::pop_back<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut v2);
            0x1::vector::push_back<address>(&mut v11, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::recipient(&v12));
        };
        0x1::vector::destroy_empty<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(v2);
        0x1::vector::append<address>(&mut v9, v11);
        0x1::vector::append<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(&mut v8, v6);
        settle_order<T0, T1>(v0, arg2, arg3, &v8, v9, arg6);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_orders_matched_event(0x2::object::id<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>>(v0), arg4);
    }

    fun settle_fees<T0: store + key, T1>(arg0: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::Treasury, arg1: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::RoyaltyRegistry, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(arg2);
        let v1 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::calculate<T0>(arg0, v0);
        if (v1 > 0) {
            0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::collect<T1>(arg0, 0x2::coin::split<T1>(arg2, v1, arg3));
            0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_collect_protocol_fee_event<T0>(v1);
        };
        let v2 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::calculate<T0>(arg1, v0);
        if (v2 > 0) {
            let v3 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::beneficiary<T0>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg2, v2, arg3), v3);
            0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_collect_royalty_fee_event<T0>(v3, v2);
        };
    }

    fun settle_order<T0: store + key, T1>(arg0: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::Orderbook<T0, T1>, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::treasury::Treasury, arg2: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry::RoyaltyRegistry, arg3: &vector<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(arg3)) {
            let v1 = 0x1::vector::borrow<0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item>(arg3, v0);
            if (0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(v1))) {
                let v2 = 0x2::coin::from_balance<T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::withdraw_ft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::borrow_mut_vault<T0, T1>(arg0), *0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(v1))), arg5);
                let v3 = &mut v2;
                settle_fees<T0, T1>(arg1, arg2, v3, arg5);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, *0x1::vector::borrow<address>(&arg4, v0));
            } else {
                0x2::transfer::public_transfer<T0>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::withdraw_nft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::borrow_mut_vault<T0, T1>(arg0), *0x1::option::borrow<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(v1))), *0x1::vector::borrow<address>(&arg4, v0));
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

