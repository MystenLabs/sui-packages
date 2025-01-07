module 0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>,
    }

    struct GameResult has copy, drop {
        your_choice: 0x1::string::String,
        npc_choice: 0x1::string::String,
        result: 0x1::string::String,
        is_winner: bool,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut arg0.pool, 0x2::balance::split<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>>(0x2::coin::from_balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut arg0.pool, v1);
        };
    }

    fun get_choice_desc(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Mouse")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Elephant")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Cat")
        } else {
            0x1::string::utf8(b"Invalid")
        }
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::mint<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    public entry fun guess_fists(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 3, 0);
        let v0 = 0x2::coin::value<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&arg2);
        assert!(v0 > 1000, 2);
        let v1 = v0 * 2;
        assert!(v1 < 0x2::balance::value<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&arg1.pool), 1);
        0x2::balance::join<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut arg1.pool, 0x2::coin::into_balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(arg2));
        let v2 = get_random_choice(arg3);
        let (v3, v4) = if (arg0 == 0 && v2 == 1 || arg0 == 1 && v2 == 2 || arg0 == 2 && v2 == 0) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>>(0x2::coin::from_balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(0x2::balance::split<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut arg1.pool, v1), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_choice : get_choice_desc(arg0),
            npc_choice  : get_choice_desc(v2),
            result      : v3,
            is_winner   : v4,
        };
        0x2::event::emit<GameResult>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>>(0x2::coin::from_balance<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(0x2::balance::split<0x16da5f3b60b187eefe9bd10e739ed4654a1d5c7e9230cf2a7a61b49f01754477::sony9997_faucet::SONY9997_FAUCET>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

