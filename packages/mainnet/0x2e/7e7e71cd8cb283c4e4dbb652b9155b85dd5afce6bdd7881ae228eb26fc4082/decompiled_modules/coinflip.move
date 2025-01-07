module 0x2e7e7e71cd8cb283c4e4dbb652b9155b85dd5afce6bdd7881ae228eb26fc4082::coinflip {
    struct Coinflip has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>, u64) {
        assert!(arg2 < 2, 0);
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::from_single_range(arg2 * 500, arg2 * 500 + 485 + arg4);
        let v1 = Coinflip{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Coinflip>(arg0, v1, arg3, arg5);
        let v2 = 0x2::random::generate_u64_in_range(arg1, 1, 1000);
        let v3 = if (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::contains(&v0, v2)) {
            arg3 * 2
        } else {
            0
        };
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Coinflip>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), arg3, v3, v2), v3)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 3);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg5);
        let v0 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>();
        let v1 = 0x2::random::new_generator(arg1, arg5);
        let v2 = 0;
        let v3 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v4 = &mut v1;
            let (v5, v6) = one_game<T0>(arg0, v4, 0x1::vector::pop_back<u64>(&mut arg2), v3 / 0x1::vector::length<u64>(&arg2), 0, arg5);
            v2 = v2 + v6;
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>(&mut v0, v5);
        };
        settle_game_helper<T0>(arg0, arg3, v2, v3, arg5);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 3);
        assert!(0x2::kiosk::has_access(arg5, arg6), 1);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg9);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg9);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg9);
            v5 = v5 + v9;
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>(&mut v3, v8);
        };
        settle_game_helper<T0>(arg0, arg3, v5, v6, arg9);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v3);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 3);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg8), 1);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 2);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg6);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg6)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg6)));
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg6);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg8);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg6);
        let v2 = v1;
        if (v1 > 10) {
            v2 = 10;
        };
        let v3 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>();
        let v4 = 0x2::random::new_generator(arg1, arg8);
        let v5 = 0;
        let v6 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), v6 / 0x1::vector::length<u64>(&arg2), v2, arg8);
            v5 = v5 + v9;
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>(&mut v3, v8);
        };
        settle_game_helper<T0>(arg0, arg3, v5, v6, arg8);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v3);
    }

    entry fun play_with_partners<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: vector<T1>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 3);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 2);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg7);
        let v0 = 0x1::vector::length<T1>(&arg5);
        let v1 = v0;
        if (v0 > 10) {
            v1 = 10;
        };
        while (!0x1::vector::is_empty<T1>(&arg5)) {
            0x2::transfer::public_transfer<T1>(0x1::vector::pop_back<T1>(&mut arg5), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<T1>(arg5);
        let v2 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>();
        let v3 = 0x2::random::new_generator(arg1, arg7);
        let v4 = 0;
        let v5 = 0x2::coin::value<T0>(&arg3);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v6 = &mut v3;
            let (v7, v8) = one_game<T0>(arg0, v6, 0x1::vector::pop_back<u64>(&mut arg2), v5 / 0x1::vector::length<u64>(&arg2), v1, arg7);
            v4 = v4 + v8;
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Coinflip>>(&mut v2, v7);
        };
        settle_game_helper<T0>(arg0, arg3, v4, v5, arg7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Coinflip>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg6), v2);
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Coinflip{dummy_field: false};
        if (arg2 >= arg3) {
            let v1 = arg2 - arg3;
            if (v1 > 0) {
                0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg4);
                0x2::coin::join<T0>(&mut arg1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Coinflip>(arg0, v0, v1, arg4));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Coinflip>(arg0, v0, 0x2::coin::split<T0>(&mut arg1, arg3 - arg2, arg4));
            if (0x2::coin::value<T0>(&arg1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            } else {
                0x2::coin::destroy_zero<T0>(arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

