module 0x49b7e2f1587b5150f3ec99349f6f78c831521ccea0824d0c543a77aa909c8f03::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>,
        name: 0x1::string::String,
        reward_rate: u64,
    }

    struct GameCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_sui(arg0: &mut Game, arg1: 0x2::coin::Coin<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&mut arg0.balance, 0x2::coin::into_balance<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id          : 0x2::object::new(arg0),
            balance     : 0x2::balance::zero<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(),
            name        : 0x1::string::utf8(b"zerokk246's Game"),
            reward_rate : 1,
        };
        let v1 = GameCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<GameCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&arg2);
        assert!(v0 > 0 && 0x2::balance::value<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&arg0.balance) >= v0 * arg0.reward_rate, 100);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (0x2::random::generate_bool(&mut v1) == arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&mut arg0.balance, v0 * arg0.reward_rate), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&mut arg0.balance, 0x2::coin::into_balance<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(arg2));
        };
    }

    public entry fun withdraw(arg0: &GameCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xa03f42f57279ce7534ba0e07c4311c073751b6f40d25c2596c3a7ce41ddbc9da::faucetcoin::FAUCETCOIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

