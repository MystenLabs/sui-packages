module 0xd5b857e378db92047ddee56b8d0779e0794c37f1421191708928d4cb90b17b08::ufo_range {
    struct UFORange has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) : (0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame, u64) {
        assert!(arg3 == 0 || arg3 == 1, 0);
        assert!(arg4 <= 10000, 1);
        assert!(arg5 >= 1, 2);
        assert!(arg4 >= arg5, 3);
        let v0 = if (arg3 == 0) {
            arg4 - arg5 + 1
        } else {
            10000 - arg4 - arg5 + 1
        };
        let v1 = 0;
        assert!(v0 >= 100, 9);
        let v2 = ((10000 * 1000000 * (arg2 as u128) / (v0 as u128) / 1000000) as u64) - arg2;
        let v3 = UFORange{dummy_field: false};
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::assert_within_risk<T0, UFORange>(arg0, v3, v2, arg7);
        let v4 = 0x2::random::generate_u64_in_range(arg1, 1, 10150 - arg6 * 5);
        if (v4 > 10000 && false || arg3 == 0 && v4 >= arg5 && v4 <= arg4 || v4 < arg5 || v4 > arg4) {
            v1 = v2 + arg2;
        };
        (0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::range_game(arg2, v1, arg3, arg5, arg4, v4), v1)
    }

    entry fun play<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        let v1 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v2 = 0x2::random::new_generator(arg1, arg6);
        let v3 = 0;
        let v4 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v5 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v5) == 2, 6);
            let v6 = &mut v2;
            let (v7, v8) = one_game<T0>(arg0, v6, v4 / v0, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v5, 1), *0x1::vector::borrow<u64>(&v5, 0), 0, arg6);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v1, v7);
            v3 = v3 + v8;
        };
        settle_game_helper<T0>(arg0, arg2, v3, v4, arg6);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg6), arg5, v1);
    }

    entry fun play_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: 0x1::string::String, arg6: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        let v1 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v2 = 0x2::random::new_generator(arg1, arg11);
        let v3 = 0;
        let v4 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v5 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v5) == 2, 6);
            let v6 = &mut v2;
            let (v7, v8) = one_game<T0>(arg0, v6, v4 / v0, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v5, 1), *0x1::vector::borrow<u64>(&v5, 0), 0, arg11);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v1, v7);
            v3 = v3 + v8;
        };
        settle_game_helper_0<T0>(arg0, arg2, v3, v4, arg6, arg7, arg8, arg9, arg10, arg11);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg11), arg5, v1);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::PartnerList, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: vector<0x2::object::ID>, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg6, arg7), 7);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::contains<T1>(arg5), 8);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg8);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg8)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg8);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg8);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::length<u64>(&arg3);
        assert!(v3 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v3, 5);
        let v4 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg10);
        let v6 = 0;
        let v7 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v8 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v8) == 2, 6);
            let v9 = &mut v5;
            let (v10, v11) = one_game<T0>(arg0, v9, v7 / v3, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 0), v2, arg10);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v4, v10);
            v6 = v6 + v11;
        };
        settle_game_helper<T0>(arg0, arg2, v6, v7, arg10);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg10), arg9, v4);
    }

    entry fun play_with_partner_0<T0, T1: store + key>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::PartnerList, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: vector<0x2::object::ID>, arg9: 0x1::string::String, arg10: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg11: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg12: &0x2::clock::Clock, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg6, arg7), 7);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::contains<T1>(arg5), 8);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg8);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg8)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg8);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg8);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::length<u64>(&arg3);
        assert!(v3 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v3, 5);
        let v4 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg15);
        let v6 = 0;
        let v7 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v8 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v8) == 2, 6);
            let v9 = &mut v5;
            let (v10, v11) = one_game<T0>(arg0, v9, v7 / v3, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 0), v2, arg15);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v4, v10);
            v6 = v6 + v11;
        };
        settle_game_helper_0<T0>(arg0, arg2, v6, v7, arg10, arg11, arg12, arg13, arg14, arg15);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg15), arg9, v4);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::PartnerList, arg6: &0x2::kiosk::Kiosk, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == 0x2::tx_context::sender(arg9), 7);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::contains<T1>(arg5), 8);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::length<u64>(&arg3);
        assert!(v3 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v3, 5);
        let v4 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg9);
        let v6 = 0;
        let v7 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v8 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v8) == 2, 6);
            let v9 = &mut v5;
            let (v10, v11) = one_game<T0>(arg0, v9, v7 / v3, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 0), v2, arg9);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v4, v10);
            v6 = v6 + v11;
        };
        settle_game_helper<T0>(arg0, arg2, v6, v7, arg9);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg9), arg8, v4);
    }

    entry fun play_with_partner_personal_kiosk_0<T0, T1: store + key>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::PartnerList, arg6: &0x2::kiosk::Kiosk, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg11: &0x2::clock::Clock, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == 0x2::tx_context::sender(arg14), 7);
        assert!(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::partners::contains<T1>(arg5), 8);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::length<u64>(&arg3);
        assert!(v3 <= 100, 4);
        assert!(0x1::vector::length<vector<u64>>(&arg4) == v3, 5);
        let v4 = 0x1::vector::empty<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg14);
        let v6 = 0;
        let v7 = 0x2::coin::value<T0>(&arg2);
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v8 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v8) == 2, 6);
            let v9 = &mut v5;
            let (v10, v11) = one_game<T0>(arg0, v9, v7 / v3, 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 0), v2, arg14);
            0x1::vector::push_back<0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::game_structs::RangeGame>(&mut v4, v10);
            v6 = v6 + v11;
        };
        settle_game_helper_0<T0>(arg0, arg2, v6, v7, arg9, arg10, arg11, arg12, arg13, arg14);
        0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg14), arg8, v4);
    }

    fun settle_game_helper<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = UFORange{dummy_field: false};
        if (arg2 >= arg3) {
            let v1 = arg2 - arg3;
            if (v1 > 0) {
                0x2::coin::join<T0>(&mut arg1, 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, UFORange>(arg0, v0, v1, arg4));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, UFORange>(arg0, v0, 0x2::coin::split<T0>(&mut arg1, arg3 - arg2, arg4));
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    fun settle_game_helper_0<T0>(arg0: &mut 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (!0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::pipe_exists<T0, 0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::SUILEND_POND>(arg0)) {
            settle_game_helper<T0>(arg0, arg1, arg2, arg3, arg9);
            return
        };
        let v0 = UFORange{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg8, arg6, arg7);
        if (arg2 >= arg3) {
            let v1 = arg2 - arg3;
            if (v1 > 0) {
                let (v2, v3) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(v1);
                let v4 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg0));
                if (v2 > v4) {
                    let v5 = UFORange{dummy_field: false};
                    0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg4, arg0, v2 - v4, false, v5, arg5, arg6, arg8, arg9);
                };
                let v6 = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::house_balance<T0>(0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::borrow_house<T0>(arg0));
                if (v3 > v6) {
                    let v7 = UFORange{dummy_field: false};
                    0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg4, arg0, v3 - v6, true, v7, arg5, arg6, arg8, arg9);
                };
                0x2::coin::join<T0>(&mut arg1, 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::take_with_fee_reimbursement<T0, UFORange>(arg0, v0, v1, arg9));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg9));
        } else {
            let v8 = arg3 - arg2;
            let (v9, v10) = 0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::house::pool_changes(v8);
            0x90ebe312f8cdfc6eb719513b19e200fd68b06e340487c2a7a69be6554979e7e2::unihouse::put_with_fee<T0, UFORange>(arg0, v0, 0x2::coin::split<T0>(&mut arg1, v8, arg9));
            let v11 = UFORange{dummy_field: false};
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg4, arg0, v9, false, v11, arg5, arg6, arg8, arg9);
            let v12 = UFORange{dummy_field: false};
            0xee0150555a187970285efd82153b0fc87ed0fb53844a3001f4dff3a5e73d70af::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg4, arg0, v10, true, v12, arg5, arg6, arg8, arg9);
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg9));
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

