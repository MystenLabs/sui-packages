module 0x808c3ea6374c06961d6df1cff3fce99a1e1ad553ce300999ad56b065cd7081d8::lotto_game {
    struct GameState has key {
        id: 0x2::object::UID,
        current_round: u64,
        round_start_time: u64,
        round_end_time: u64,
        is_active: bool,
        total_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpot_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        lucky_box_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        winning_tiles: vector<u8>,
        players: vector<Player>,
    }

    struct Player has copy, drop, store {
        address: address,
        bet_amount: u64,
        selected_tiles: vector<u8>,
        timestamp: u64,
    }

    struct GameStarted has copy, drop {
        round: u64,
        start_time: u64,
        end_time: u64,
    }

    struct PlayerJoined has copy, drop {
        round: u64,
        player: address,
        bet_amount: u64,
        selected_tiles: vector<u8>,
    }

    struct GameEnded has copy, drop {
        round: u64,
        winning_tiles: vector<u8>,
        total_pool: u64,
        winners: vector<address>,
        total_winner_payout: u64,
        jackpot_added: u64,
        dev_paid: u64,
        lucky_box_added: u64,
    }

    struct PayoutSent has copy, drop {
        round: u64,
        winner: address,
        amount: u64,
    }

    struct JackpotWon has copy, drop {
        round: u64,
        winner: address,
        amount: u64,
    }

    struct LuckyBoxWon has copy, drop {
        player: address,
        amount: u64,
    }

    fun count_tile_matches(arg0: vector<u8>, arg1: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            if (0x1::vector::contains<u8>(&arg1, 0x1::vector::borrow<u8>(&arg0, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun distribute_payouts(arg0: &mut GameState, arg1: &vector<address>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * 600 / 10000;
        let v1 = arg3 * 300 / 10000;
        let v2 = arg3 * 100 / 10000;
        let v3 = arg3 * 9000 / 10000;
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v0));
        };
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.lucky_box_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v2));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v1), arg4), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        };
        let v4 = 0x1::vector::length<u8>(&arg0.winning_tiles);
        let v5 = 0x1::vector::empty<address>();
        let v6 = 0;
        let v7 = 0x1::vector::length<Player>(&arg0.players);
        let v8 = 0;
        while (v8 < v7) {
            let v9 = 0x1::vector::borrow<Player>(&arg0.players, v8);
            if (count_tile_matches(v9.selected_tiles, arg0.winning_tiles) == v4) {
                0x1::vector::push_back<address>(&mut v5, v9.address);
                v6 = v6 + v9.bet_amount;
            };
            v8 = v8 + 1;
        };
        if (0x1::vector::length<address>(&v5) > 0) {
            let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool);
            if (v10 > 0) {
                let v11 = 0;
                while (v11 < 0x1::vector::length<address>(&v5)) {
                    let v12 = *0x1::vector::borrow<address>(&v5, v11);
                    let v13 = 0;
                    let v14 = 0;
                    while (v14 < v7) {
                        let v15 = 0x1::vector::borrow<Player>(&arg0.players, v14);
                        if (v15.address == v12) {
                            v13 = v15.bet_amount;
                            break
                        };
                        v14 = v14 + 1;
                    };
                    let v16 = v10 * v13 / v6;
                    if (v16 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool) >= v16) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.jackpot_pool, v16), arg4), v12);
                        let v17 = JackpotWon{
                            round  : arg0.current_round,
                            winner : v12,
                            amount : v16,
                        };
                        0x2::event::emit<JackpotWon>(v17);
                    };
                    v11 = v11 + 1;
                };
            };
        };
        let v18 = 0x1::vector::empty<address>();
        let v19 = 0;
        let v20 = 0;
        while (v20 < v7) {
            let v21 = 0x1::vector::borrow<Player>(&arg0.players, v20);
            let v22 = count_tile_matches(v21.selected_tiles, arg0.winning_tiles);
            if (v22 * 100 / v4 >= 80 && v22 < v4) {
                0x1::vector::push_back<address>(&mut v18, v21.address);
                v19 = v19 + v21.bet_amount;
            };
            v20 = v20 + 1;
        };
        if (0x1::vector::length<address>(&v18) > 0) {
            let v23 = 0x2::balance::value<0x2::sui::SUI>(&arg0.lucky_box_pool);
            if (v23 > 0) {
                let v24 = 0;
                while (v24 < 0x1::vector::length<address>(&v18)) {
                    let v25 = *0x1::vector::borrow<address>(&v18, v24);
                    let v26 = 0;
                    let v27 = 0;
                    while (v27 < v7) {
                        let v28 = 0x1::vector::borrow<Player>(&arg0.players, v27);
                        if (v28.address == v25) {
                            v26 = v28.bet_amount;
                            break
                        };
                        v27 = v27 + 1;
                    };
                    let v29 = v23 * v26 / v19;
                    if (v29 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.lucky_box_pool) >= v29) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.lucky_box_pool, v29), arg4), v25);
                        let v30 = LuckyBoxWon{
                            player : v25,
                            amount : v29,
                        };
                        0x2::event::emit<LuckyBoxWon>(v30);
                    };
                    v24 = v24 + 1;
                };
            };
        };
        let v31 = 0x1::vector::length<address>(arg1);
        if (v31 > 0 && v3 > 0) {
            let v32 = 0;
            while (v32 < v31) {
                let v33 = *0x1::vector::borrow<address>(arg1, v32);
                let v34 = 0;
                let v35 = 0;
                while (v35 < v7) {
                    let v36 = 0x1::vector::borrow<Player>(&arg0.players, v35);
                    if (v36.address == v33) {
                        v34 = v36.bet_amount;
                        break
                    };
                    v35 = v35 + 1;
                };
                let v37 = v3 * v34 / arg2;
                if (v37 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool) >= v37) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v37), arg4), v33);
                    let v38 = PayoutSent{
                        round  : arg0.current_round,
                        winner : v33,
                        amount : v37,
                    };
                    0x2::event::emit<PayoutSent>(v38);
                };
                v32 = v32 + 1;
            };
        };
    }

    public entry fun end_round(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.round_end_time, 3);
        arg0.is_active = false;
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 6) {
            let v3 = 0x2::random::generate_u8_in_range(&mut v0, 0, 25 - 1);
            if (!0x1::vector::contains<u8>(&v1, &v3)) {
                0x1::vector::push_back<u8>(&mut v1, v3);
                v2 = v2 + 1;
            };
        };
        arg0.winning_tiles = v1;
        let v4 = 0x1::vector::empty<address>();
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<Player>(&arg0.players)) {
            let v7 = 0x1::vector::borrow<Player>(&arg0.players, v6);
            if (has_winning_tiles(v7.selected_tiles, arg0.winning_tiles)) {
                0x1::vector::push_back<address>(&mut v4, v7.address);
                v5 = v5 + v7.bet_amount;
            };
            v6 = v6 + 1;
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
        if (0x1::vector::length<address>(&v4) > 0 && v8 > 0) {
            distribute_payouts(arg0, &v4, v5, v8, arg3);
        } else if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.total_pool));
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
        let v9 = if (0x1::vector::length<address>(&v4) > 0) {
            v8 * 9000 / 10000
        } else {
            0
        };
        let v10 = GameEnded{
            round               : arg0.current_round,
            winning_tiles       : arg0.winning_tiles,
            total_pool          : v8,
            winners             : v4,
            total_winner_payout : v9,
            jackpot_added       : v8 * 600 / 10000,
            dev_paid            : v8 * 300 / 10000,
            lucky_box_added     : v8 * 100 / 10000,
        };
        0x2::event::emit<GameEnded>(v10);
    }

    public fun get_current_round(arg0: &GameState) : u64 {
        arg0.current_round
    }

    public fun get_jackpot_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool)
    }

    public fun get_lucky_box_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.lucky_box_pool)
    }

    public fun get_player_count(arg0: &GameState) : u64 {
        0x1::vector::length<Player>(&arg0.players)
    }

    public fun get_round_end_time(arg0: &GameState) : u64 {
        arg0.round_end_time
    }

    public fun get_total_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool)
    }

    public fun get_winning_tiles(arg0: &GameState) : vector<u8> {
        arg0.winning_tiles
    }

    fun has_winning_tiles(arg0: vector<u8>, arg1: vector<u8>) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            if (0x1::vector::contains<u8>(&arg1, 0x1::vector::borrow<u8>(&arg0, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0 >= 0x1::vector::length<u8>(&arg1) / 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id               : 0x2::object::new(arg0),
            current_round    : 0,
            round_start_time : 0,
            round_end_time   : 0,
            is_active        : false,
            total_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpot_pool     : 0x2::balance::zero<0x2::sui::SUI>(),
            lucky_box_pool   : 0x2::balance::zero<0x2::sui::SUI>(),
            winning_tiles    : 0x1::vector::empty<u8>(),
            players          : 0x1::vector::empty<Player>(),
        };
        0x2::transfer::share_object<GameState>(v0);
    }

    public fun is_game_active(arg0: &GameState) : bool {
        arg0.is_active
    }

    public entry fun play_game(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.round_end_time, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 50000000, 1);
        let v1 = 0x1::vector::length<u8>(&arg2);
        assert!(v1 > 0 && v1 <= (25 as u64), 5);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = Player{
            address        : v2,
            bet_amount     : v0,
            selected_tiles : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::vector::push_back<Player>(&mut arg0.players, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = PlayerJoined{
            round          : arg0.current_round,
            player         : v2,
            bet_amount     : v0,
            selected_tiles : arg2,
        };
        0x2::event::emit<PlayerJoined>(v4);
    }

    public entry fun start_round(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.current_round = arg0.current_round + 1;
        arg0.round_start_time = v0;
        arg0.round_end_time = v0 + 60000;
        arg0.is_active = true;
        arg0.players = 0x1::vector::empty<Player>();
        arg0.winning_tiles = 0x1::vector::empty<u8>();
        let v1 = GameStarted{
            round      : arg0.current_round,
            start_time : arg0.round_start_time,
            end_time   : arg0.round_end_time,
        };
        0x2::event::emit<GameStarted>(v1);
    }

    // decompiled from Move bytecode v6
}

