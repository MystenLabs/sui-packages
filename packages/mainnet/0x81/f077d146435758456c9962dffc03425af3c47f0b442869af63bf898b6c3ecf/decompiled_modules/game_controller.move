module 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::game_controller {
    struct Game has store, key {
        id: 0x2::object::UID,
        player: address,
        amount: u64,
        bet: u64,
        game: u64,
    }

    struct BetEvent has copy, drop {
        player: address,
        amount: u64,
        bet: u64,
        game: u64,
        round: u64,
    }

    struct GamePlay has copy, drop {
        game_id: u64,
        player: address,
        amount: u64,
        result: u64,
        random_number: u64,
        profit: u64,
        reward: u64,
        boost: u64,
    }

    struct Round has store, key {
        id: 0x2::object::UID,
        games: 0x2::table_vec::TableVec<Game>,
        status: u64,
    }

    struct Controller has store, key {
        id: 0x2::object::UID,
        rounds: 0x2::bag::Bag,
    }

    fun coin_flip<T0, T1, T2>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::Reward<T2>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::random::rand_u64_range_with_seed(arg5, 0, 99);
        let v1 = 0;
        let v2 = 0;
        if (arg4 == 0 && v0 < 49 || arg4 == 1 && v0 > 50) {
            v1 = 1;
            let v3 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lose<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg6);
            v2 = 0x2::coin::value<T0>(&v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2);
        };
        let (v4, v5) = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::get_reward<T2>(arg1, arg5, arg3, arg2, arg6);
        let v6 = GamePlay{
            game_id       : 1,
            player        : arg2,
            amount        : arg3,
            result        : v1,
            random_number : v0,
            profit        : v2,
            reward        : v4,
            boost         : v5,
        };
        0x2::event::emit<GamePlay>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Controller{
            id     : 0x2::object::new(arg0),
            rounds : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Controller>(v0);
    }

    public(friend) fun new_game(arg0: &mut Controller, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg6),
            player : arg2,
            amount : arg3,
            bet    : arg4,
            game   : arg5,
        };
        let v1 = (0x2::clock::timestamp_ms(arg1) / 1000 - 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::get_genesis_time()) / 30 + 2;
        if (0x2::bag::contains<u64>(&arg0.rounds, v1)) {
            0x2::table_vec::push_back<Game>(&mut 0x2::bag::borrow_mut<u64, Round>(&mut arg0.rounds, v1).games, v0);
        } else {
            let v2 = 0x2::table_vec::empty<Game>(arg6);
            0x2::table_vec::push_back<Game>(&mut v2, v0);
            let v3 = Round{
                id     : 0x2::object::new(arg6),
                games  : v2,
                status : 0,
            };
            0x2::bag::add<u64, Round>(&mut arg0.rounds, v1, v3);
        };
        let v4 = BetEvent{
            player : arg2,
            amount : arg3,
            bet    : arg4,
            game   : arg5,
            round  : v1,
        };
        0x2::event::emit<BetEvent>(v4);
    }

    public entry fun provide<T0, T1, T2>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut Controller, arg2: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::Reward<T2>, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::verify_drand_signature(arg4, arg5, arg6);
        assert!(0x2::bag::contains<u64>(&arg1.rounds, arg6), 3);
        let v0 = 0x2::bag::borrow_mut<u64, Round>(&mut arg1.rounds, arg6);
        assert!(v0.status != 1, 2);
        v0.status = 1;
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<Game>(&v0.games)) {
            let v2 = 0x2::table_vec::borrow<Game>(&v0.games, v1);
            if (v2.game == 1) {
                coin_flip<T0, T1, T2>(arg0, arg2, v2.player, v2.amount, v2.bet, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::derive_randomness(arg4), arg7);
            } else if (v2.game == 2) {
                raffle<T0, T1, T2>(arg0, arg2, v2.player, v2.amount, v2.bet, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::derive_randomness(arg4), arg7);
            } else if (v2.game == 3) {
                range<T0, T1, T2>(arg0, arg2, v2.player, v2.amount, v2.bet, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::derive_randomness(arg4), arg7);
            } else if (v2.game == 4) {
                wheel<T0, T1, T2>(arg0, arg2, v2.player, v2.amount, v2.bet, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::drand::derive_randomness(arg4), arg7);
            };
            v1 = v1 + 1;
        };
    }

    fun raffle<T0, T1, T2>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::Reward<T2>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::random::rand_u64_range_with_seed(arg5, 0, 99);
        let v1 = 0;
        let v2 = 0;
        if (arg4 == 0 && v0 < 49 || arg4 == 1 && v0 > 50) {
            v1 = 1;
            let v3 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lose<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg6);
            v2 = 0x2::coin::value<T0>(&v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2);
        };
        let (v4, v5) = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::get_reward<T2>(arg1, arg5, arg3, arg2, arg6);
        let v6 = GamePlay{
            game_id       : 2,
            player        : arg2,
            amount        : arg3,
            result        : v1,
            random_number : v0,
            profit        : v2,
            reward        : v4,
            boost         : v5,
        };
        0x2::event::emit<GamePlay>(v6);
    }

    fun range<T0, T1, T2>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::Reward<T2>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::random::rand_u64_range_with_seed(arg5, 0, 99);
        let v1 = v0;
        let v2 = 0;
        let v3 = 0;
        if (v0 <= 95) {
            v1 = v0 + 2;
        };
        if (arg4 >= v1) {
            v2 = 1;
            let v4 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lose_amount<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), 0x2::math::divide_and_round_up(arg3 * 0x2::math::divide_and_round_up(1000000, arg4), 10000) - arg3, arg6);
            v3 = 0x2::coin::value<T0>(&v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg2);
        };
        let (v5, v6) = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::get_reward<T2>(arg1, arg5, arg3, arg2, arg6);
        let v7 = GamePlay{
            game_id       : 3,
            player        : arg2,
            amount        : arg3,
            result        : v2,
            random_number : v1,
            profit        : v3,
            reward        : v5,
            boost         : v6,
        };
        0x2::event::emit<GamePlay>(v7);
    }

    fun wheel<T0, T1, T2>(arg0: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::Vault<T0, T1>, arg1: &mut 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::Reward<T2>, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::random::rand_u64_range_with_seed(arg5, 0, 4900);
        if (arg4 == 2 && v2 < 2352) {
            v0 = 1;
            let v3 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lost_multiple_times<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg4, arg6);
            v1 = 0x2::coin::value<T0>(&v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2);
        } else if (arg4 == 3 && v2 >= 2400 && v2 < 3968) {
            v0 = 1;
            let v4 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lost_multiple_times<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg4, arg6);
            v1 = 0x2::coin::value<T0>(&v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg2);
        } else if (arg4 == 6 && v2 >= 4000 && v2 < 4784) {
            v0 = 1;
            let v5 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lost_multiple_times<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg4, arg6);
            v1 = 0x2::coin::value<T0>(&v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg2);
        } else if (arg4 == 48 && v2 >= 4800) {
            v0 = 1;
            let v6 = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::lost_multiple_times<T0, T1>(arg0, 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault::return_bet<T0, T1>(arg0, arg3, arg6), arg4, arg6);
            v1 = 0x2::coin::value<T0>(&v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg2);
        };
        let (v7, v8) = 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::xluck_reward::get_reward<T2>(arg1, arg5, arg3, arg2, arg6);
        let v9 = GamePlay{
            game_id       : 4,
            player        : arg2,
            amount        : arg3,
            result        : v0,
            random_number : v2,
            profit        : v1,
            reward        : v7,
            boost         : v8,
        };
        0x2::event::emit<GamePlay>(v9);
    }

    // decompiled from Move bytecode v6
}

