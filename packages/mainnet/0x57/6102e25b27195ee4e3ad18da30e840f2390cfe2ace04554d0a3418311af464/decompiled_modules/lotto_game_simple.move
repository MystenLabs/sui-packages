module 0x576102e25b27195ee4e3ad18da30e840f2390cfe2ace04554d0a3418311af464::lotto_game_simple {
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
        winners_count: u64,
    }

    fun distribute_payouts(arg0: &mut GameState, arg1: &vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v0 * 600 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.lucky_box_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v0 * 100 / 10000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v0 * 300 / 10000), arg3), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = *0x1::vector::borrow<address>(arg1, v1);
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<Player>(&arg0.players)) {
                let v5 = 0x1::vector::borrow<Player>(&arg0.players, v4);
                if (v5.address == v2) {
                    v3 = v5.bet_amount;
                    break
                };
                v4 = v4 + 1;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_pool, v0 * 9000 / 10000 * v3 / arg2), arg3), v2);
            v1 = v1 + 1;
        };
    }

    public entry fun end_round(arg0: &mut GameState, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.round_end_time, 3);
        arg0.is_active = false;
        arg0.winning_tiles = arg1;
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Player>(&arg0.players)) {
            let v3 = 0x1::vector::borrow<Player>(&arg0.players, v2);
            if (has_winning_tiles(v3.selected_tiles, arg0.winning_tiles)) {
                0x1::vector::push_back<address>(&mut v0, v3.address);
                v1 = v1 + v3.bet_amount;
            };
            v2 = v2 + 1;
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
        if (0x1::vector::length<address>(&v0) > 0) {
            distribute_payouts(arg0, &v0, v1, arg3);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.total_pool));
        };
        let v5 = GameEnded{
            round         : arg0.current_round,
            winning_tiles : arg0.winning_tiles,
            total_pool    : v4,
            winners_count : 0x1::vector::length<address>(&v0),
        };
        0x2::event::emit<GameEnded>(v5);
    }

    public fun get_current_round(arg0: &GameState) : u64 {
        arg0.current_round
    }

    public fun get_jackpot_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool)
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

