module 0x3447aa85c3dec959b647576087d5cd5dcddd7794ecd21c411d0ae6a00e2cb3c3::game {
    struct ScoreSubmitted has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        score: u64,
    }

    struct GamePool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        host: address,
        winners_config: u8,
        state: u8,
        players: vector<address>,
        pending_rewards: 0x2::table::Table<address, u64>,
        start_timestamp_ms: u64,
        scores: 0x2::table::Table<address, u64>,
    }

    public fun claim_reward(arg0: &mut GamePool, arg1: &mut 0x3447aa85c3dec959b647576087d5cd5dcddd7794ecd21c411d0ae6a00e2cb3c3::avatar::Avatar, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.pending_rewards, v0), 4);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.pending_rewards, v0);
        let v2 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg2);
        0x3447aa85c3dec959b647576087d5cd5dcddd7794ecd21c411d0ae6a00e2cb3c3::avatar::inject_liquidity(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v1 / 10, arg2)));
        0x3447aa85c3dec959b647576087d5cd5dcddd7794ecd21c411d0ae6a00e2cb3c3::avatar::update_stats(arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
    }

    public fun create_game(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 1);
        let v0 = GamePool{
            id                 : 0x2::object::new(arg2),
            balance            : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            host               : 0x2::tx_context::sender(arg2),
            winners_config     : arg1,
            state              : 0,
            players            : 0x1::vector::empty<address>(),
            pending_rewards    : 0x2::table::new<address, u64>(arg2),
            start_timestamp_ms : 0,
            scores             : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<GamePool>(v0);
    }

    public fun finalize_game(arg0: &mut GamePool, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.host, 0);
        assert!(arg0.state == 1, 2);
        arg0.state = 2;
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0;
            if (v0 == 1) {
                v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
            } else if (v0 == 2) {
                if (v1 == 0) {
                    v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 40 / 100;
                } else {
                    v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 60 / 100;
                };
            } else if (v0 == 3) {
                if (v1 == 0) {
                    v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 20 / 100;
                } else if (v1 == 1) {
                    v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 30 / 100;
                } else {
                    v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 50 / 100;
                };
            };
            if (v2 > 0) {
                0x2::table::add<address, u64>(&mut arg0.pending_rewards, 0x1::vector::pop_back<address>(&mut arg1), v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun join_game(arg0: &mut GamePool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.players, &v0), 5);
        0x1::vector::push_back<address>(&mut arg0.players, v0);
    }

    public fun start_game(arg0: &mut GamePool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.host, 0);
        assert!(arg0.state == 0, 3);
        arg0.state = 1;
        arg0.start_timestamp_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun submit_score(arg0: &mut GamePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.scores, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.scores, v0);
        };
        0x2::table::add<address, u64>(&mut arg0.scores, v0, arg1);
        let v1 = ScoreSubmitted{
            game_id : 0x2::object::uid_to_inner(&arg0.id),
            player  : v0,
            score   : arg1,
        };
        0x2::event::emit<ScoreSubmitted>(v1);
    }

    // decompiled from Move bytecode v6
}

