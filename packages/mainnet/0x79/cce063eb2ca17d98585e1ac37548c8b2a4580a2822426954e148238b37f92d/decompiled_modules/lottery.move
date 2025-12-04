module 0x79cce063eb2ca17d98585e1ac37548c8b2a4580a2822426954e148238b37f92d::lottery {
    struct GameState has key {
        id: 0x2::object::UID,
        admin: address,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpot_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        current_game_id: u64,
        total_games: u64,
        last_jackpot_time: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        game_id: u64,
        players: vector<address>,
        bets: 0x2::table::Table<address, u64>,
        total_pool: u64,
        is_active: bool,
        start_time: u64,
        winner: 0x1::option::Option<address>,
    }

    struct PlayerStats has key {
        id: 0x2::object::UID,
        player: address,
        total_plays: u64,
        total_wins: u64,
        total_losses: u64,
        total_wagered: u64,
        total_winnings: u64,
    }

    struct JackpotWinner has key {
        id: 0x2::object::UID,
        winner: address,
        amount: u64,
        timestamp: u64,
    }

    struct GameCreated has copy, drop {
        game_id: u64,
        timestamp: u64,
    }

    struct PlayerJoined has copy, drop {
        game_id: u64,
        player: address,
        bet_amount: u64,
    }

    struct GameEnded has copy, drop {
        game_id: u64,
        winner: address,
        prize: u64,
        timestamp: u64,
    }

    struct JackpotWon has copy, drop {
        winner: address,
        amount: u64,
        timestamp: u64,
    }

    public fun create_game(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        let v0 = arg0.current_game_id + 1;
        arg0.current_game_id = v0;
        arg0.total_games = arg0.total_games + 1;
        let v1 = Game{
            id         : 0x2::object::new(arg2),
            game_id    : v0,
            players    : 0x1::vector::empty<address>(),
            bets       : 0x2::table::new<address, u64>(arg2),
            total_pool : 0,
            is_active  : true,
            start_time : 0x2::clock::timestamp_ms(arg1),
            winner     : 0x1::option::none<address>(),
        };
        let v2 = GameCreated{
            game_id   : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GameCreated>(v2);
        0x2::transfer::share_object<Game>(v1);
    }

    public fun end_game(arg0: &mut Game, arg1: &mut GameState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 4);
        assert!(arg0.is_active, 2);
        assert!(0x1::vector::length<address>(&arg0.players) > 0, 3);
        arg0.is_active = false;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = *0x1::vector::borrow<address>(&arg0.players, v0 % 0x1::vector::length<address>(&arg0.players));
        arg0.winner = 0x1::option::some<address>(v1);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.prize_pool, arg0.total_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(&v2) * 3 / 100), arg3), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), v1);
        let v3 = GameEnded{
            game_id   : arg0.game_id,
            winner    : v1,
            prize     : 0x2::balance::value<0x2::sui::SUI>(&v2),
            timestamp : v0,
        };
        0x2::event::emit<GameEnded>(v3);
    }

    public fun get_current_game_id(arg0: &GameState) : u64 {
        arg0.current_game_id
    }

    public fun get_game_players(arg0: &Game) : u64 {
        0x1::vector::length<address>(&arg0.players)
    }

    public fun get_jackpot_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool)
    }

    public fun get_prize_pool(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            prize_pool        : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpot_pool      : 0x2::balance::zero<0x2::sui::SUI>(),
            current_game_id   : 0,
            total_games       : 0,
            last_jackpot_time : 0,
        };
        0x2::transfer::share_object<GameState>(v0);
    }

    public fun is_game_active(arg0: &Game) : bool {
        arg0.is_active
    }

    public fun join_game(arg0: &mut Game, arg1: &mut GameState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 50000000, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        0x1::vector::push_back<address>(&mut arg0.players, v1);
        0x2::table::add<address, u64>(&mut arg0.bets, v1, v0);
        arg0.total_pool = arg0.total_pool + v0;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.jackpot_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(&v2) * 10 / 100));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, v2);
        let v3 = PlayerJoined{
            game_id    : arg0.game_id,
            player     : v1,
            bet_amount : v0,
        };
        0x2::event::emit<PlayerJoined>(v3);
    }

    public fun trigger_jackpot(arg0: &mut GameState, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.jackpot_pool, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 * 3 / 100), arg3), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_jackpot_time = v2;
        let v3 = JackpotWon{
            winner    : arg1,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&v1),
            timestamp : v2,
        };
        0x2::event::emit<JackpotWon>(v3);
    }

    // decompiled from Move bytecode v6
}

