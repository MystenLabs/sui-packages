module 0xb839a26383cefb6fb8361d8461949d6d01742c3220854ffbf17a1842224c00bd::ufo_range {
    struct UFORange has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame {
        assert!(arg3 == 0 || arg3 == 1, 0);
        assert!(arg4 <= 10000, 1);
        assert!(arg5 >= 1, 2);
        assert!(arg4 >= arg5, 3);
        let v0 = 0;
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = if (arg3 == 0) {
            arg4 - arg5 + 1
        } else {
            10000 - arg4 - arg5 + 1
        };
        assert!(v2 >= 100, 9);
        let v3 = ((10000 * 1000000 * (v1 as u128) / (v2 as u128) / 1000000) as u64) - v1;
        let v4 = UFORange{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, UFORange>(arg0, v4, v3, arg7);
        let v5 = 0x2::random::generate_u64_in_range(arg1, 1, 10150 - arg6 * 5);
        if (v5 > 10000 && false || arg3 == 0 && v5 >= arg5 && v5 <= arg4 || v5 < arg5 || v5 > arg4) {
            0x2::coin::join<T0>(&mut arg2, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, UFORange>(arg0, v4, v3, arg7));
            v0 = 0x2::coin::value<T0>(&arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg7));
        } else {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, UFORange>(arg0, v4, arg2);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::range_game(v1, v0, arg3, arg5, arg4, v5)
    }

    fun one_game_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg9: &0x2::clock::Clock, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame {
        if (!0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::pipe_exists<T0, 0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SUILEND_POND>(arg0)) {
            return one_game<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg12)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg8, arg11, arg9, arg10);
        assert!(arg3 == 0 || arg3 == 1, 0);
        assert!(arg4 <= 10000, 1);
        assert!(arg5 >= 1, 2);
        assert!(arg4 >= arg5, 3);
        let v0 = 0;
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = if (arg3 == 0) {
            arg4 - arg5 + 1
        } else {
            10000 - arg4 - arg5 + 1
        };
        assert!(v2 >= 100, 9);
        let v3 = ((10000 * 1000000 * (v1 as u128) / (v2 as u128) / 1000000) as u64) - v1;
        let v4 = UFORange{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, UFORange>(arg0, v4, v3, arg12);
        let v5 = 0x2::random::generate_u64_in_range(arg1, 1, 10150 - arg6 * 5);
        if (v5 > 10000 && false || arg3 == 0 && v5 >= arg5 && v5 <= arg4 || v5 < arg5 || v5 > arg4) {
            let (v6, v7) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(v3);
            let v8 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v6 > v8) {
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg7, arg0, v6 - v8, false, v4, arg8, arg9, arg11, arg12);
            };
            let v9 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v7 > v9) {
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg7, arg0, v7 - v9, true, v4, arg8, arg9, arg11, arg12);
            };
            0x2::coin::join<T0>(&mut arg2, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, UFORange>(arg0, v4, v3, arg12));
            v0 = 0x2::coin::value<T0>(&arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg12));
        } else {
            let (v10, v11) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(0x2::coin::value<T0>(&arg2));
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, UFORange>(arg0, v4, arg2);
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg7, arg0, v10, false, v4, arg8, arg9, arg11, arg12);
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, UFORange>(arg7, arg0, v11, true, v4, arg8, arg9, arg11, arg12);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::range_game(v1, v0, arg3, arg5, arg4, v5)
    }

    entry fun play<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        let v1 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v2 = 0x2::random::new_generator(arg1, arg6);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v3 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v3) == 2, 6);
            let v4 = &mut v2;
            let v5 = one_game<T0>(arg0, v4, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v3, 1), *0x1::vector::borrow<u64>(&v3, 0), 0, arg6);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v1, v5);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg6), arg5, v1);
    }

    entry fun play_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: 0x1::string::String, arg6: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg8: &0x2::clock::Clock, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        let v1 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v2 = 0x2::random::new_generator(arg1, arg11);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v3 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v3) == 2, 6);
            let v4 = &mut v2;
            let v5 = one_game_0<T0>(arg0, v4, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v3, 1), *0x1::vector::borrow<u64>(&v3, 0), 0, arg6, arg7, arg8, arg9, arg10, arg11);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v1, v5);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg11), arg5, v1);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: vector<0x2::object::ID>, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        assert!(0x2::kiosk::has_access(arg6, arg7), 7);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg5), 8);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg8);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            0x1::vector::push_back<bool>(&mut v1, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg8)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg8);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg8);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg10);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v6 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v6) == 2, 6);
            let v7 = &mut v5;
            let v8 = one_game<T0>(arg0, v7, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 0), v3, arg10);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v4, v8);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg10), arg9, v4);
    }

    entry fun play_with_partner_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: vector<0x2::object::ID>, arg9: 0x1::string::String, arg10: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg11: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg12: &0x2::clock::Clock, arg13: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        assert!(0x2::kiosk::has_access(arg6, arg7), 7);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg5), 8);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg8);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg8)) {
            0x1::vector::push_back<bool>(&mut v1, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg8)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg8);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg8);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg15);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v6 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v6) == 2, 6);
            let v7 = &mut v5;
            let v8 = one_game_0<T0>(arg0, v7, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 0), v3, arg10, arg11, arg12, arg13, arg14, arg15);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v4, v8);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg15), arg9, v4);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg6: &0x2::kiosk::Kiosk, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == 0x2::tx_context::sender(arg9), 7);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg5), 8);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v1, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg9);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v6 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v6) == 2, 6);
            let v7 = &mut v5;
            let v8 = one_game<T0>(arg0, v7, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 0), v3, arg9);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v4, v8);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg9), arg8, v4);
    }

    entry fun play_with_partner_personal_kiosk_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg6: &0x2::kiosk::Kiosk, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg11: &0x2::clock::Clock, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 <= 100, 4);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == v0 && 0x1::vector::length<vector<u64>>(&arg4) == v0, 5);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == 0x2::tx_context::sender(arg14), 7);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg5), 8);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v1, 0x2::kiosk::has_item_with_type<T1>(arg6, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>();
        let v5 = 0x2::random::new_generator(arg1, arg14);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v6 = 0x1::vector::pop_back<vector<u64>>(&mut arg4);
            assert!(0x1::vector::length<u64>(&v6) == 2, 6);
            let v7 = &mut v5;
            let v8 = one_game_0<T0>(arg0, v7, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 0), v3, arg9, arg10, arg11, arg12, arg13, arg14);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::game_structs::RangeGame>(&mut v4, v8);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_range_game_results<T0, UFORange>(arg0, 0x2::tx_context::sender(arg14), arg8, v4);
    }

    // decompiled from Move bytecode v6
}

