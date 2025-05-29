module 0xcaf0accdaf364de8cbc94b38b94f4d6188a9d6c682713ef98d4fa795a2614276::rock_paper_scissors {
    struct RockPaperScissors has copy, drop, store {
        dummy_field: bool,
    }

    fun one_game<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, RockPaperScissors>, u64) {
        assert!(arg2 < 3, 0);
        let v0 = RockPaperScissors{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_within_risk<T0, RockPaperScissors>(arg0, v0, arg3, arg5);
        let v1 = 0;
        let v2 = (arg2 + 1) * 327;
        let v3 = if (arg2 == 0) {
            981
        } else {
            arg2 * 327
        };
        let v4 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::from_single_range(v2 - 327 + 1, v2 + arg4);
        let v5 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::from_single_range(v3 - 327 + 1, v3 + arg4);
        let v6 = 0x2::random::generate_u64_in_range(arg1, 1, 1000);
        if (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::contains(&v5, v6)) {
            v1 = arg3 * 2;
        } else if (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::ranges::contains(&v4, v6)) {
            v1 = arg3;
        };
        (0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::bet_result<T0, RockPaperScissors>(0x1::option::none<0x2::object::ID>(), 0x2::tx_context::sender(arg5), arg2, 0x1::option::none<u64>(), arg3, v1, v6), v1)
    }

    entry fun play<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: &0x2::random::Random, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) <= 10, 1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::random_compute(arg1, arg5);
        let v0 = 0x1::vector::empty<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, RockPaperScissors>>();
        let v1 = 0x2::random::new_generator(arg1, arg5);
        let v2 = 0;
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v3 = &mut v1;
            let (v4, v5) = one_game<T0>(arg0, v3, 0x1::vector::pop_back<u64>(&mut arg2), 0x2::coin::value<T0>(&arg3) / 0x1::vector::length<u64>(&arg2), 0, arg5);
            0x1::vector::push_back<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::BetResult<T0, RockPaperScissors>>(&mut v0, v4);
            v2 = v2 + v5;
        };
        settle_game_helper<T0>(arg0, arg3, v2, arg5);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::emit_bet_results<T0, RockPaperScissors>(arg0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), 0x1::option::some<0x1::string::String>(arg4), v0);
    }

    fun settle_game_helper<T0>(arg0: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RockPaperScissors{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::put_with_fee<T0, RockPaperScissors>(arg0, v0, arg1);
        if (arg2 > 0) {
            0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::create_and_transfer_gas_obj(0x1::bcs::to_bytes<u64>(&arg2), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::take_with_fee_reimbursement<T0, RockPaperScissors>(arg0, v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

