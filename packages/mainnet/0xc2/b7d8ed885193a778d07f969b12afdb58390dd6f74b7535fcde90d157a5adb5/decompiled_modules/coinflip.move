module 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::coinflip {
    struct CoinFlipGame<phantom T0> has key {
        id: 0x2::object::UID,
        max_bet: u64,
        threshold: u64,
        bets: 0x2::vec_map::VecMap<0x2::object::ID, Bet<T0>>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        gambler: address,
        fund: 0x2::balance::Balance<T0>,
    }

    public fun bet<T0>(arg0: &mut CoinFlipGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 <= arg0.max_bet, 4);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::deposit<T0>(arg1, arg2);
        let v1 = Bet<T0>{
            id      : 0x2::object::new(arg3),
            gambler : 0x2::tx_context::sender(arg3),
            fund    : 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::take_fund_balance<T0>(arg1, v0 * 2),
        };
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::distribute_referral_rewards<T0>(arg1, v0, 0x2::tx_context::sender(arg3));
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_bet_event(0x2::object::uid_to_inner(&v1.id), v0, 0x2::tx_context::sender(arg3));
        0x2::vec_map::insert<0x2::object::ID, Bet<T0>>(&mut arg0.bets, 0x2::object::uid_to_inner(&v1.id), v1);
    }

    public fun create_coinflip_game<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFlipGame<T0>{
            id        : 0x2::object::new(arg3),
            max_bet   : arg1,
            threshold : arg2,
            bets      : 0x2::vec_map::empty<0x2::object::ID, Bet<T0>>(),
        };
        0x2::transfer::share_object<CoinFlipGame<T0>>(v0);
    }

    public fun edit_coinflip_game<T0>(arg0: &0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::AdminCap, arg1: &mut CoinFlipGame<T0>, arg2: u64, arg3: u64) {
        arg1.max_bet = arg2;
        arg1.threshold = arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFlipGame<0x2::sui::SUI>{
            id        : 0x2::object::new(arg0),
            max_bet   : 51000000000,
            threshold : 53000000,
            bets      : 0x2::vec_map::empty<0x2::object::ID, Bet<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<CoinFlipGame<0x2::sui::SUI>>(v0);
    }

    entry fun place_bet_and_reveal_onchain_randomness<T0>(arg0: &CoinFlipGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0 <= arg0.max_bet, 4);
        assert!(v0 >= 100000000, 4);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::deposit<T0>(arg1, arg2);
        let v2 = 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::take_fund_balance<T0>(arg1, v0 * 2);
        let v3 = 0x2::object::new(arg4);
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::distribute_referral_rewards<T0>(arg1, v0, v1);
        let v4 = 0x2::random::new_generator(arg3, arg4);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, 0, 100000000) > arg0.threshold;
        let v6 = if (v5) {
            0x2::balance::value<T0>(&v2)
        } else {
            0
        };
        if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg4), v1);
            0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::join_balance<T0>(arg1, 0x2::balance::zero<T0>());
        } else {
            0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::join_balance<T0>(arg1, v2);
        };
        let v7 = if (v5) {
            0x1::uq32_32::from_int(2)
        } else {
            0x1::uq32_32::from_int(0)
        };
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_revealed_coinflip_bet_event(0x2::object::uid_to_inner(&v3), v5, v0, v7, v6, v1);
        0x2::object::delete(v3);
    }

    entry fun reveal_bet_onchain_randomness<T0>(arg0: &mut CoinFlipGame<T0>, arg1: &mut 0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::House<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Bet<T0>>(&arg0.bets, &arg2), 5);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Bet<T0>>(&mut arg0.bets, &arg2);
        let Bet {
            id      : v2,
            gambler : v3,
            fund    : v4,
        } = v1;
        let v5 = v4;
        let v6 = 0x2::random::new_generator(arg3, arg4);
        let v7 = 0x2::random::generate_u64_in_range(&mut v6, 0, 100000000) > arg0.threshold;
        let v8 = if (v7) {
            0x2::balance::value<T0>(&v5)
        } else {
            0
        };
        if (v7) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), v3);
            0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::join_balance<T0>(arg1, 0x2::balance::zero<T0>());
        } else {
            0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::house::join_balance<T0>(arg1, v5);
        };
        0x611e724cbd74e740ab0ae4fbbf1b57f44d9e75be7d0135704ad86eab7e518a12::events::emit_revealed_bet_event(arg2, v7, v8, v3);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

