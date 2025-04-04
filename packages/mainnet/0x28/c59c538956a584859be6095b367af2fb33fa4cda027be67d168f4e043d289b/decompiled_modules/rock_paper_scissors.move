module 0x28c59c538956a584859be6095b367af2fb33fa4cda027be67d168f4e043d289b::rock_paper_scissors {
    struct RockPaperScissors has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>, u64) {
        assert!(arg2 < 3, 0);
        let v0 = RockPaperScissors{dummy_field: false};
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::assert_within_risk<T0, RockPaperScissors>(arg0, v0, arg3, arg5);
        let v1 = 0;
        let v2 = (arg2 + 1) * 327;
        let v3 = if (arg2 == 0) {
            981
        } else {
            arg2 * 327
        };
        let v4 = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::ranges::from_single_range(v2 - 327 + 1, v2 + arg4);
        let v5 = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::ranges::from_single_range(v3 - 327 + 1, v3 + arg4);
        let v6 = 0x2::random::generate_u64_in_range(arg1, 1, 1000);
        if (0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::ranges::contains(&v5, v6)) {
            v1 = arg3 * 2;
        } else if (0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::ranges::contains(&v4, v6)) {
            v1 = arg3;
        };
        (0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::bet_result<T0, RockPaperScissors>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), arg3, v1, v6), v1)
    }

    entry fun play<T0>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        let v0 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v1 = 0x2::random::new_generator(arg1, arg5);
        let v2 = 0;
        let v3 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v4 = &mut v1;
            let (v5, v6) = one_game<T0>(arg0, v4, 0x1::vector::pop_back<u64>(&mut arg2), v3 / 0x1::vector::length<u64>(&arg2), 0, arg5);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v0, v5);
            v2 = v2 + v6;
        };
        settle_game_helper<T0>(arg0, arg3, v2, v3, arg5);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
    }

    entry fun play_0<T0>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        let v0 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v1 = 0x2::random::new_generator(arg1, arg10);
        let v2 = 0;
        let v3 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v4 = &mut v1;
            let (v5, v6) = one_game<T0>(arg0, v4, 0x1::vector::pop_back<u64>(&mut arg2), v3 / 0x1::vector::length<u64>(&arg2), 0, arg10);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v0, v5);
            v2 = v2 + v6;
        };
        settle_game_helper_0<T0>(arg0, arg3, v2, v3, arg5, arg6, arg7, arg8, arg9, arg10);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        assert!(0x2::kiosk::has_access(arg5, arg6), 2);
        assert!(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::contains<T1>(arg4), 3);
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
        let v3 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v4 = 0x2::random::new_generator(arg1, arg9);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg9);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v3, v8);
            v5 = v5 + v9;
        };
        settle_game_helper<T0>(arg0, arg3, v5, v6, arg9);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v3);
    }

    entry fun play_with_partner_0<T0, T1: store + key>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg10: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg11: &0x2::clock::Clock, arg12: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        assert!(0x2::kiosk::has_access(arg5, arg6), 2);
        assert!(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::contains<T1>(arg4), 3);
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
        let v3 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v4 = 0x2::random::new_generator(arg1, arg14);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg14);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v3, v8);
            v5 = v5 + v9;
        };
        settle_game_helper_0<T0>(arg0, arg3, v5, v6, arg9, arg10, arg11, arg12, arg13, arg14);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v3);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg8), 2);
        assert!(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::contains<T1>(arg4), 3);
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
        let v3 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v4 = 0x2::random::new_generator(arg1, arg8);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg8);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v3, v8);
            v5 = v5 + v9;
        };
        settle_game_helper<T0>(arg0, arg3, v5, v6, arg8);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v3);
    }

    entry fun play_with_partner_personal_kiosk_0<T0, T1: store + key>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg10: &0x2::clock::Clock, arg11: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg13), 2);
        assert!(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::partners::contains<T1>(arg4), 3);
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
        let v3 = 0x1::vector::empty<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>();
        let v4 = 0x2::random::new_generator(arg1, arg13);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg13);
            0x1::vector::push_back<0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::BetResult<T0, RockPaperScissors>>(&mut v3, v8);
            v5 = v5 + v9;
        };
        settle_game_helper_0<T0>(arg0, arg3, v5, v6, arg8, arg9, arg10, arg11, arg12, arg13);
        0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v3);
    }

    fun settle_game_helper<T0>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RockPaperScissors{dummy_field: false};
        if (arg2 >= arg3) {
            let v1 = arg2 - arg3;
            if (v1 > 0) {
                0x2::coin::join<T0>(&mut arg1, 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::take_with_fee_reimbursement<T0, RockPaperScissors>(arg0, v0, v1, arg4));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::put_with_fee<T0, RockPaperScissors>(arg0, v0, 0x2::coin::split<T0>(&mut arg1, arg3 - arg2, arg4));
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    fun settle_game_helper_0<T0>(arg0: &mut 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::SuilendPond<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: &0x2::clock::Clock, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (!0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::pipe_exists<T0, 0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::SUILEND_POND>(arg0)) {
            settle_game_helper<T0>(arg0, arg1, arg2, arg3, arg9);
            return
        };
        let v0 = RockPaperScissors{dummy_field: false};
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg5, arg8, arg6, arg7);
        if (arg2 >= arg3) {
            let v1 = arg2 - arg3;
            if (v1 > 0) {
                let (v2, v3) = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::house::pool_changes(v1);
                let v4 = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::house::pool_balance<T0>(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::borrow_house<T0>(arg0));
                if (v2 > v4) {
                    let v5 = RockPaperScissors{dummy_field: false};
                    0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, RockPaperScissors>(arg4, arg0, v2 - v4, false, v5, arg5, arg6, arg8, arg9);
                };
                let v6 = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::house::house_balance<T0>(0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::borrow_house<T0>(arg0));
                if (v3 > v6) {
                    let v7 = RockPaperScissors{dummy_field: false};
                    0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::withdraw<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, RockPaperScissors>(arg4, arg0, v3 - v6, true, v7, arg5, arg6, arg8, arg9);
                };
                0x2::coin::join<T0>(&mut arg1, 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::take_with_fee_reimbursement<T0, RockPaperScissors>(arg0, v0, v1, arg9));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg9));
        } else {
            let v8 = arg3 - arg2;
            let (v9, v10) = 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::house::pool_changes(v8);
            0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::unihouse::put_with_fee<T0, RockPaperScissors>(arg0, v0, 0x2::coin::split<T0>(&mut arg1, v8, arg9));
            let v11 = RockPaperScissors{dummy_field: false};
            0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, RockPaperScissors>(arg4, arg0, v9, false, v11, arg5, arg6, arg8, arg9);
            let v12 = RockPaperScissors{dummy_field: false};
            0xfa73072b7ca5affcc0a57af8dc47cab881cfec1dbd17e9709317ba8cf557b4f6::pond::deposit<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, RockPaperScissors>(arg4, arg0, v10, true, v12, arg5, arg6, arg8, arg9);
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg9));
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

