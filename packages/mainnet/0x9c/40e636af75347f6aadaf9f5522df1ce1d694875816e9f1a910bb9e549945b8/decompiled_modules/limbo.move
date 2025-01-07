module 0x9c40e636af75347f6aadaf9f5522df1ce1d694875816e9f1a910bb9e549945b8::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    public fun get_threshold(arg0: u64) : u64 {
        10000000 - ((1000000000 / (arg0 as u128)) as u64)
    }

    fun one_game<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo> {
        assert!(arg2 >= 101 && arg2 <= 10000, 3);
        let v0 = 0;
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = payout_amount(v1, arg2);
        let v3 = Limbo{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, Limbo>(arg0, v3, v2, arg5);
        let v4 = 0x2::random::generate_u64_in_range(arg1, 0, 10150000 - arg4 * 5000);
        if (v4 > get_threshold(arg2) && v4 <= 10000000) {
            0x2::coin::join<T0>(&mut arg3, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Limbo>(arg0, v3, v2, arg5));
            v0 = 0x2::coin::value<T0>(&arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, Limbo>(arg0, v3, arg3);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Limbo>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), v1, v0, v4)
    }

    fun one_game_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo> {
        if (!0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::pipe_exists<T0, 0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SUILEND_POND>(arg0)) {
            return one_game<T0>(arg0, arg1, arg2, arg3, arg4, arg10)
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg6, arg9, arg7, arg8);
        assert!(arg2 >= 101 && arg2 <= 10000, 3);
        let v0 = 0;
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = payout_amount(v1, arg2);
        let v3 = Limbo{dummy_field: false};
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::assert_within_risk<T0, Limbo>(arg0, v3, v2, arg10);
        let v4 = 0x2::random::generate_u64_in_range(arg1, 0, 10150000 - arg4 * 5000);
        if (v4 > get_threshold(arg2) && v4 <= 10000000) {
            let (v5, v6) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(v2);
            let v7 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v5 > v7) {
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Limbo>(arg5, arg0, v5 - v7, false, v3, arg6, arg7, arg9, arg10);
            };
            let v8 = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::house_balance<T0>(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::borrow_house<T0>(arg0));
            if (v6 > v8) {
                0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Limbo>(arg5, arg0, v6 - v8, true, v3, arg6, arg7, arg9, arg10);
            };
            0x2::coin::join<T0>(&mut arg3, 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::take_with_fee_reimbursement<T0, Limbo>(arg0, v3, v2, arg10));
            v0 = 0x2::coin::value<T0>(&arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg10));
        } else {
            let (v9, v10) = 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::house::pool_changes(0x2::coin::value<T0>(&arg3));
            0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::put_with_fee<T0, Limbo>(arg0, v3, arg3);
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Limbo>(arg5, arg0, v9, false, v3, arg6, arg7, arg9, arg10);
            0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, Limbo>(arg5, arg0, v10, true, v3, arg6, arg7, arg9, arg10);
        };
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::bet_result<T0, Limbo>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg10), arg2, 0x1::option::none<u64>(), v1, v0, v4)
    }

    public fun payout_amount(arg0: u64, arg1: u64) : u64 {
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::math::mul_and_div(arg0, arg1 - 100, 100)
    }

    entry fun play<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0x1::vector::length<u64>(&arg3), 1);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) <= 100, 2);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v2 = &mut v0;
            let v3 = one_game<T0>(arg0, v2, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0, arg5);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v1, v3);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v1);
    }

    entry fun play_0<T0>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0x1::vector::length<u64>(&arg3), 1);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) <= 100, 2);
        let v0 = 0x2::random::new_generator(arg1, arg10);
        let v1 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            let v2 = &mut v0;
            let v3 = one_game_0<T0>(arg0, v2, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2), 0, arg5, arg6, arg7, arg8, arg9, arg10);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v1, v3);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v1);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 2);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 1);
        assert!(0x2::kiosk::has_access(arg5, arg6), 4);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 5);
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
        let v3 = 0x2::random::new_generator(arg1, arg9);
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v3;
            let v6 = one_game<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg9);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v4, v6);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v4);
    }

    entry fun play_with_partner_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg11: &0x2::clock::Clock, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 2);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 1);
        assert!(0x2::kiosk::has_access(arg5, arg6), 4);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 5);
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
        let v3 = 0x2::random::new_generator(arg1, arg14);
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v3;
            let v6 = one_game_0<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg9, arg10, arg11, arg12, arg13, arg14);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v4, v6);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v4);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 2);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg8), 4);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 5);
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
        let v3 = 0x2::random::new_generator(arg1, arg8);
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v3;
            let v6 = one_game<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg8);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v4, v6);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v4);
    }

    entry fun play_with_partner_personal_kiosk_0<T0, T1: store + key>(arg0: &mut 0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: vector<0x2::coin::Coin<T0>>, arg4: &0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &0x2c192c334aa921a507830b3d15f569682a08b574b59fb87314c9081758f1e247::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 2);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x2::coin::Coin<T0>>(&arg3), 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg13), 4);
        assert!(0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::partners::contains<T1>(arg4), 5);
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
        let v3 = 0x2::random::new_generator(arg1, arg13);
        let v4 = 0x1::vector::empty<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg3)) {
            let v5 = &mut v3;
            let v6 = one_game_0<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg3), v2, arg8, arg9, arg10, arg11, arg12, arg13);
            0x1::vector::push_back<0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::BetResult<T0, Limbo>>(&mut v4, v6);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        0x45fa42682c23a9f27a17ebf868a9c7c9b069ef3014be825f1be37facc34ca963::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v4);
    }

    // decompiled from Move bytecode v6
}

