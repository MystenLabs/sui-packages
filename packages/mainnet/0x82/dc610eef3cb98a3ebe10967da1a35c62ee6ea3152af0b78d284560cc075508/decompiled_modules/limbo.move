module 0x82dc610eef3cb98a3ebe10967da1a35c62ee6ea3152af0b78d284560cc075508::limbo {
    struct Limbo has copy, drop, store {
        dummy_field: bool,
    }

    public fun get_threshold(arg0: u64) : u64 {
        10000000 - ((1000000000 / (arg0 as u128)) as u64)
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>, u64) {
        assert!(arg2 >= 101 && arg2 <= 10000, 2);
        let v0 = payout_amount(arg3, arg2);
        let v1 = Limbo{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, Limbo>(arg0, v1, v0, arg5);
        let v2 = 0;
        let v3 = 0x2::random::generate_u64_in_range(arg1, 0, 10300000 - arg4 * 5000);
        if (v3 > get_threshold(arg2) && v3 <= 10000000) {
            v2 = v0 + arg3;
        };
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, Limbo>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), arg3, v2, v3), v2)
    }

    public fun payout_amount(arg0: u64, arg1: u64) : u64 {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::math::mul_and_div(arg0, arg1 - 100, 100)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg3) <= 100, 1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg5);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let v1 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>();
        let v2 = 0;
        while (!0x1::vector::is_empty<u64>(&arg3)) {
            let v3 = &mut v0;
            let (v4, v5) = one_game<T0>(arg0, v3, 0x1::vector::pop_back<u64>(&mut arg3), 0x2::coin::value<T0>(&arg2) / 0x1::vector::length<u64>(&arg3), 0, arg5);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&mut v1, v4);
            v2 = v2 + v5;
        };
        settle_game_helper<T0>(arg0, arg2, v2, arg5);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v1);
    }

    entry fun play_with_partner<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: vector<0x2::object::ID>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 1);
        assert!(0x2::kiosk::has_access(arg5, arg6), 3);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 4);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg7);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg7)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg7)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg9);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg7);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x2::random::new_generator(arg1, arg9);
        let v5 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>();
        let v6 = 0;
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), 0x2::coin::value<T0>(&arg3) / 0x1::vector::length<u64>(&arg2), v3, arg9);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&mut v5, v8);
            v6 = v6 + v9;
        };
        settle_game_helper<T0>(arg0, arg3, v6, arg9);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg8), v5);
    }

    entry fun play_with_partner_personal_kiosk<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: &0x2::kiosk::Kiosk, arg6: vector<0x2::object::ID>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 100, 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg8), 3);
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 4);
        let v0 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg6)) {
            0x1::vector::push_back<bool>(&mut v0, 0x2::kiosk::has_item_with_type<T1>(arg5, 0x1::vector::pop_back<0x2::object::ID>(&mut arg6)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg6);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg8);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg6);
        let v3 = v2;
        if (v2 > 10) {
            v3 = 10;
        };
        let v4 = 0x2::random::new_generator(arg1, arg8);
        let v5 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>();
        let v6 = 0;
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v7 = &mut v4;
            let (v8, v9) = one_game<T0>(arg0, v7, 0x1::vector::pop_back<u64>(&mut arg2), 0x2::coin::value<T0>(&arg3) / 0x1::vector::length<u64>(&arg2), v3, arg8);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&mut v5, v8);
            v6 = v6 + v9;
        };
        settle_game_helper<T0>(arg0, arg3, v6, arg8);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg7), v5);
    }

    entry fun play_with_partners<T0, T1: store + key>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::PartnerList, arg5: vector<T1>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::partners::contains<T1>(arg4), 4);
        let v0 = 0x1::vector::length<T1>(&arg5);
        let v1 = v0;
        if (v0 > 10) {
            v1 = 10;
        };
        while (!0x1::vector::is_empty<T1>(&arg5)) {
            0x2::transfer::public_transfer<T1>(0x1::vector::pop_back<T1>(&mut arg5), 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<T1>(arg5);
        let v2 = 0x2::random::new_generator(arg1, arg7);
        let v3 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>();
        let v4 = 0;
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v5 = &mut v2;
            let (v6, v7) = one_game<T0>(arg0, v5, 0x1::vector::pop_back<u64>(&mut arg2), 0x2::coin::value<T0>(&arg3) / 0x1::vector::length<u64>(&arg2), v1, arg7);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, Limbo>>(&mut v3, v6);
            v4 = v4 + v7;
        };
        settle_game_helper<T0>(arg0, arg3, v4, arg7);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, Limbo>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg6), v3);
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Limbo{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, Limbo>(arg0, v0, arg1);
        if (arg2 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, Limbo>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

