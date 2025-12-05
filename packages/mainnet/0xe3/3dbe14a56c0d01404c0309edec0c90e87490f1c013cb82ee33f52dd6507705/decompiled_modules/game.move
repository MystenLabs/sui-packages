module 0xe33dbe14a56c0d01404c0309edec0c90e87490f1c013cb82ee33f52dd6507705::game {
    struct Game has key {
        id: 0x2::object::UID,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        jackpot_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        players: 0x2::table::Table<address, PlayerBet>,
        player_count: u64,
        game_number: u64,
        is_active: bool,
        drawn_numbers: vector<u8>,
    }

    struct PlayerBet has copy, drop, store {
        selected_numbers: vector<u8>,
        bet_amount: u64,
        wallet: address,
    }

    struct PlayerStats has key {
        id: 0x2::object::UID,
        wallet: address,
        total_plays: u64,
        total_wins: u64,
        total_losses: u64,
        total_wagered: u64,
        total_won: u64,
    }

    struct GameStarted has copy, drop {
        game_number: u64,
        timestamp: u64,
    }

    struct BetPlaced has copy, drop {
        player: address,
        amount: u64,
        game_number: u64,
    }

    struct GameEnded has copy, drop {
        game_number: u64,
        winners: vector<address>,
        prize_amount: u64,
    }

    struct JackpotWon has copy, drop {
        winner: address,
        amount: u64,
    }

    struct NoWinnersRollover has copy, drop {
        game_number: u64,
        jackpot_amount: u64,
        dev_amount: u64,
    }

    fun distribute_prizes(arg0: &mut Game, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) * 300 / 10000), arg2), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) / 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v0), arg2), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = GameEnded{
            game_number  : arg0.game_number,
            winners      : arg1,
            prize_amount : v0,
        };
        0x2::event::emit<GameEnded>(v2);
    }

    public fun draw_game(arg0: &mut Game, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 15) {
            let v3 = 0x2::random::generate_u8(&mut v0) % 25 + 1;
            if (!0x1::vector::contains<u8>(&v1, &v3)) {
                0x1::vector::push_back<u8>(&mut v1, v3);
                v2 = v2 + 1;
            };
        };
        arg0.drawn_numbers = v1;
        let v4 = find_winners(arg0);
        if (0x1::vector::length<address>(&v4) > 0) {
            distribute_prizes(arg0, v4, arg2);
        } else {
            handle_no_winners(arg0, arg2);
        };
        reset_game(arg0, arg2);
    }

    public fun draw_jackpot(arg0: &mut Game, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool);
        if (v0 > 0 && arg0.player_count > 0) {
            let _ = 0x2::random::new_generator(arg1, arg2);
            let v2 = JackpotWon{
                winner : @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b,
                amount : v0,
            };
            0x2::event::emit<JackpotWon>(v2);
        };
    }

    fun find_winners(arg0: &Game) : vector<address> {
        let v0 = 0;
        while (v0 < arg0.player_count) {
            v0 = v0 + 1;
        };
        0x1::vector::empty<address>()
    }

    public fun get_current_prize_pool(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_jackpot_amount(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.jackpot_pool)
    }

    public fun get_player_count(arg0: &Game) : u64 {
        arg0.player_count
    }

    fun handle_no_winners(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) * 9000 / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.jackpot_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v0));
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v1), arg1), @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        let v2 = NoWinnersRollover{
            game_number    : arg0.game_number,
            jackpot_amount : v0,
            dev_amount     : v1,
        };
        0x2::event::emit<NoWinnersRollover>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id            : 0x2::object::new(arg0),
            prize_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            jackpot_pool  : 0x2::balance::zero<0x2::sui::SUI>(),
            players       : 0x2::table::new<address, PlayerBet>(arg0),
            player_count  : 0,
            game_number   : 1,
            is_active     : true,
            drawn_numbers : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    public fun place_bet(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 2);
        assert!(arg0.player_count < 100, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 50000000, 1);
        assert!(0x1::vector::length<u8>(&arg2) == 10, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = PlayerBet{
            selected_numbers : arg2,
            bet_amount       : v0,
            wallet           : v1,
        };
        0x2::table::add<address, PlayerBet>(&mut arg0.players, v1, v2);
        arg0.player_count = arg0.player_count + 1;
        update_player_stats(v1, v0, arg3);
        let v3 = BetPlaced{
            player      : v1,
            amount      : v0,
            game_number : arg0.game_number,
        };
        0x2::event::emit<BetPlaced>(v3);
    }

    fun reset_game(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.player_count = 0;
        arg0.game_number = arg0.game_number + 1;
        arg0.is_active = true;
        arg0.drawn_numbers = 0x1::vector::empty<u8>();
        let v0 = GameStarted{
            game_number : arg0.game_number,
            timestamp   : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<GameStarted>(v0);
    }

    fun update_player_stats(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

