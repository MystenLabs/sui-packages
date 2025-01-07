module 0x2588fe5aa1518bde3904a7f80cb5194c605bcea92d11aa5489a2b638805944a1::howardlau2000_game {
    struct GameResult has copy, drop {
        your_roll: u8,
        npc_roll: u8,
        result: 0x1::string::String,
        is_winner: bool,
    }

    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>,
        ticket: u64,
        reward: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 2);
        let v1 = 0x2::coin::into_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg0.pool, 0x2::balance::split<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>>(0x2::coin::from_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg0.pool, v1);
        };
    }

    public fun game_pool(arg0: &Game) : u64 {
        0x2::balance::value<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&arg0.pool)
    }

    public fun game_reward(arg0: &Game) : u64 {
        arg0.reward
    }

    public fun game_ticket(arg0: &Game) : u64 {
        arg0.ticket
    }

    public entry fun get_faucet_coin(arg0: &mut 0x2::coin::TreasuryCap<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::mint(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun get_random_roll(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % 6 + 1) as u8)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id     : 0x2::object::new(arg0),
            pool   : 0x2::balance::zero<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(),
            ticket : 1000,
            reward : 2000,
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: u8, arg1: &mut Game, arg2: 0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 7, 0);
        assert!(0x2::balance::value<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&arg1.pool) >= arg1.reward - arg1.ticket, 1);
        let v0 = 0x2::coin::value<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&arg2);
        assert!(v0 >= arg1.ticket, 2);
        let v1 = 0x2::coin::into_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(arg2);
        if (v0 > arg1.ticket) {
            0x2::balance::join<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg1.pool, 0x2::balance::split<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut v1, arg1.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>>(0x2::coin::from_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(v1, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg1.pool, v1);
        };
        let v2 = get_random_roll(arg3);
        let (v3, v4) = if (arg0 > v2) {
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v2) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>>(0x2::coin::from_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(0x2::balance::split<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg1.pool, arg1.reward), arg4), 0x2::tx_context::sender(arg4));
        };
        let v5 = GameResult{
            your_roll : arg0,
            npc_roll  : v2,
            result    : v3,
            is_winner : v4,
        };
        0x2::event::emit<GameResult>(v5);
    }

    public entry fun set_reward(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.reward = arg2;
    }

    public entry fun set_ticket(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ticket = arg2;
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>>(0x2::coin::from_balance<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(0x2::balance::split<0xedfec1a78e883e790eae6e873d5643a6c309c40103fbbab8717285976d0767c5::howardlau2000_faucet_coin::HOWARDLAU2000_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

