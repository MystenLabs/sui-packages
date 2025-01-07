module 0x614dd485f8a1d6ec373b6ccd61be01c18bb2f5266053b39150eb80f2c419bf48::coinflip {
    struct Coinflip has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip> {
        assert!(arg2 < 2, 0);
        let v0 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::from_single_range(arg2 * 500, arg2 * 500 + 485 + arg4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = Coinflip{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, Coinflip>(arg0, v2, v1, arg5);
        let v3 = 0x2::random::generate_u64_in_range(arg1, 1, 1000);
        let v4 = if (0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::contains(&v0, v3)) {
            v1 * 2
        } else {
            0
        };
        if (0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::contains(&v0, v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Coinflip>(arg0, v2, v1, arg5), 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, Coinflip>(arg0, v2, arg3);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Coinflip>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), v1, v4, v3)
    }

    fun one_game_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip> {
        if (!0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::pipe_exists<T0, 0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SUILEND_POND>(arg0)) {
            return one_game<T0>(arg0, arg1, arg2, arg3, arg4, arg10)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg6, arg9, arg7, arg8);
        assert!(arg2 < 2, 0);
        let v0 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::from_single_range(arg2 * 500, arg2 * 500 + 485 + arg4);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = Coinflip{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, Coinflip>(arg0, v2, v1, arg10);
        let v3 = 0x2::random::generate_u64_in_range(arg1, 1, 1000);
        let v4 = if (0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::contains(&v0, v3)) {
            v1 * 2
        } else {
            0
        };
        if (0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::ranges::contains(&v0, v3)) {
            let (v5, v6) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(v1);
            let v7 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v5 > v7) {
                let v8 = Coinflip{dummy_field: false};
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Coinflip>(arg5, arg0, v5 - v7, false, v8, arg6, arg7, arg9, arg10);
            };
            let v9 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v6 > v9) {
                let v10 = Coinflip{dummy_field: false};
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Coinflip>(arg5, arg0, v6 - v9, true, v10, arg6, arg7, arg9, arg10);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Coinflip>(arg0, v2, v1, arg10), 0x2::tx_context::sender(arg10));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg10));
        } else {
            let (v11, v12) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(0x2::coin::value<T0>(&arg3));
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, Coinflip>(arg0, v2, arg3);
            let v13 = Coinflip{dummy_field: false};
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Coinflip>(arg5, arg0, v11, false, v13, arg6, arg7, arg9, arg10);
            let v14 = Coinflip{dummy_field: false};
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Coinflip>(arg5, arg0, v12, true, v14, arg6, arg7, arg9, arg10);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Coinflip>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg10), arg2, 0x1::option::none<u64>(), v1, v4, v3)
    }

    entry fun play<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        let v0 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v1 = 0x2::random::new_generator(arg1, arg5);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v2 = &mut v1;
            let v3 = one_game<T0>(arg0, v2, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), 0, arg5);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v0, v3);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    entry fun play_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: 0x1::string::String, arg5: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        let v0 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v1 = 0x2::random::new_generator(arg1, arg10);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v2 = &mut v1;
            let v3 = one_game_0<T0>(arg0, v2, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), 0, arg5, arg6, arg7, arg8, arg9, arg10);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v0, v3);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        assert!(0x2::kiosk::has_access(arg5, arg6), 1);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg9);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v4;
            let v6 = one_game<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg9);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v3, v6);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    entry fun play_with_partner_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg11: &0x2::clock::Clock, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        assert!(0x2::kiosk::has_access(arg5, arg6), 1);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg14);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v4;
            let v6 = one_game_0<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg9, arg10, arg11, arg12, arg13, arg14);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v3, v6);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg8), 1);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg6);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg6)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg6)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg6);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg6);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg8);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v4;
            let v6 = one_game<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg8);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v3, v6);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    entry fun play_with_partner_personal_kiosk_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 4);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 3);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg13), 1);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg6);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg6)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg6)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg6);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg6);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg13);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v4;
            let v6 = one_game_0<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg8, arg9, arg10, arg11, arg12, arg13);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Coinflip>>(&mut v3, v6);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v3);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
    }

    // decompiled from Move bytecode v6
}

