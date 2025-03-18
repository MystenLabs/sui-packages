module 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::limbo {
    struct LimboGame<phantom T0> has key {
        id: 0x2::object::UID,
        min_bet: u64,
        max_bet: u64,
        max_payout: u64,
        min_target_multiplier: 0x1::uq32_32::UQ32_32,
        max_target_multiplier: 0x1::uq32_32::UQ32_32,
        max_number_of_bets: u8,
        min_rtp: 0x1::uq32_32::UQ32_32,
        max_rtp: 0x1::uq32_32::UQ32_32,
        bets: 0x2::vec_map::VecMap<0x2::object::ID, Bet<T0>>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        gambler: address,
        target_multiplier: 0x1::uq32_32::UQ32_32,
        number_of_bets: u8,
        total_stake_value: u64,
        fund: 0x2::balance::Balance<T0>,
    }

    public fun bet<T0>(arg0: &mut LimboGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        place_bet<T0>(arg0, arg1, arg2, 0x1::uq32_32::from_quotient(arg3, arg4), arg5, arg6);
    }

    entry fun bet_and_reveal_onchain_randomness<T0>(arg0: &mut LimboGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = place_bet<T0>(arg0, arg1, arg2, 0x1::uq32_32::from_quotient(arg3, arg4), arg5, arg7);
        reveal_bet<T0>(arg0, arg1, v0, arg6, arg7);
    }

    public fun create_limbo_game<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::uq32_32::UQ32_32, arg5: 0x1::uq32_32::UQ32_32, arg6: u8, arg7: 0x1::uq32_32::UQ32_32, arg8: 0x1::uq32_32::UQ32_32, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = LimboGame<T0>{
            id                    : 0x2::object::new(arg9),
            min_bet               : arg1,
            max_bet               : arg2,
            max_payout            : arg3,
            min_target_multiplier : arg4,
            max_target_multiplier : arg5,
            max_number_of_bets    : arg6,
            min_rtp               : arg7,
            max_rtp               : arg8,
            bets                  : 0x2::vec_map::empty<0x2::object::ID, Bet<T0>>(),
        };
        0x2::transfer::share_object<LimboGame<T0>>(v0);
    }

    public fun edit_limbo_game<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: &mut LimboGame<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::uq32_32::UQ32_32, arg6: 0x1::uq32_32::UQ32_32, arg7: u8, arg8: 0x1::uq32_32::UQ32_32, arg9: 0x1::uq32_32::UQ32_32) {
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.max_payout = arg4;
        arg1.min_target_multiplier = arg5;
        arg1.max_target_multiplier = arg6;
        arg1.max_number_of_bets = arg7;
        arg1.min_rtp = arg8;
        arg1.max_rtp = arg9;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LimboGame<0x2::sui::SUI>{
            id                    : 0x2::object::new(arg0),
            min_bet               : 100000000,
            max_bet               : 1000000000000,
            max_payout            : 100000000000,
            min_target_multiplier : 0x1::uq32_32::from_quotient(101, 100),
            max_target_multiplier : 0x1::uq32_32::from_int(100),
            max_number_of_bets    : 10,
            min_rtp               : 0x1::uq32_32::from_quotient(97, 100),
            max_rtp               : 0x1::uq32_32::from_quotient(97, 100),
            bets                  : 0x2::vec_map::empty<0x2::object::ID, Bet<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<LimboGame<0x2::sui::SUI>>(v0);
    }

    fun place_bet<T0>(arg0: &mut LimboGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::uq32_32::UQ32_32, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 / (arg4 as u64);
        assert!(arg4 <= arg0.max_number_of_bets, 7);
        assert!(0x1::uq32_32::int_mul(v1, arg3) <= arg0.max_payout, 4);
        assert!(v1 >= arg0.min_bet, 4);
        assert!(v1 <= arg0.max_bet, 4);
        assert!(0x1::uq32_32::ge(arg3, arg0.min_target_multiplier), 6);
        assert!(0x1::uq32_32::le(arg3, arg0.max_target_multiplier), 6);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::deposit<T0>(arg1, arg2);
        let v2 = Bet<T0>{
            id                : 0x2::object::new(arg5),
            gambler           : 0x2::tx_context::sender(arg5),
            target_multiplier : arg3,
            number_of_bets    : arg4,
            total_stake_value : v0,
            fund              : 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::take_fund_balance<T0>(arg1, 0x1::uq32_32::int_mul(v0, arg3)),
        };
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::distribute_referral_rewards<T0>(arg1, v0, 0x2::tx_context::sender(arg5));
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_limbo_bet_event(0x2::object::uid_to_inner(&v2.id), v0, arg3, arg4, 0x2::tx_context::sender(arg5));
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::vec_map::insert<0x2::object::ID, Bet<T0>>(&mut arg0.bets, v3, v2);
        v3
    }

    fun reveal_bet<T0>(arg0: &mut LimboGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Bet<T0>>(&arg0.bets, &arg2), 5);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Bet<T0>>(&mut arg0.bets, &arg2);
        let Bet {
            id                : v2,
            gambler           : v3,
            target_multiplier : v4,
            number_of_bets    : v5,
            total_stake_value : v6,
            fund              : v7,
        } = v1;
        let v8 = v7;
        let v9 = 0x2::random::new_generator(arg3, arg4);
        let v10 = 0;
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x1::vector::empty<bool>();
        let v13 = 0x1::vector::empty<0x1::uq32_32::UQ32_32>();
        let v14 = 1000000;
        let v15 = 0;
        while (v15 < v5) {
            let v16 = 0x1::uq32_32::mul(0x1::uq32_32::from_quotient(v14, 0x2::random::generate_u64_in_range(&mut v9, 0, v14 - 1) + 1), 0x1::uq32_32::sub(arg0.max_rtp, 0x1::uq32_32::mul(0x1::uq32_32::div(0x1::uq32_32::sub(v4, 0x1::uq32_32::from_int(1)), 0x1::uq32_32::sub(arg0.max_target_multiplier, 0x1::uq32_32::from_int(1))), 0x1::uq32_32::sub(arg0.max_rtp, arg0.min_rtp))));
            let v17 = 0x1::uq32_32::le(v4, v16);
            let v18 = if (v17) {
                0x2::balance::value<T0>(&v8) / (v5 as u64)
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v11, v18);
            0x1::vector::push_back<bool>(&mut v12, v17);
            0x1::vector::push_back<0x1::uq32_32::UQ32_32>(&mut v13, v16);
            v10 = v10 + v18;
            v15 = v15 + 1;
        };
        let v19 = 0x2::coin::from_balance<T0>(v8, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v19, v10, arg4), v3);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::deposit<T0>(arg1, v19);
        while (0x1::vector::length<u64>(&v11) > 0) {
            let v20 = 0x1::vector::pop_back<bool>(&mut v12);
            let v21 = if (v20) {
                v4
            } else {
                0x1::uq32_32::from_int(0)
            };
            0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_revealed_limbo_bet_event(arg2, v6 / (v5 as u64), v21, v4, 0x1::vector::pop_back<0x1::uq32_32::UQ32_32>(&mut v13), v20, 0x1::vector::pop_back<u64>(&mut v11), v3);
        };
        0x2::object::delete(v2);
    }

    entry fun reveal_bet_onchain_randomness<T0>(arg0: &mut LimboGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        reveal_bet<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

