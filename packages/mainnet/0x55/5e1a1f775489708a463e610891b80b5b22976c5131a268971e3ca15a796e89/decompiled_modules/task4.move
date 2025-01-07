module 0x555e1a1f775489708a463e610891b80b5b22976c5131a268971e3ca15a796e89::task4 {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(),
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_winner(arg0: u8, arg1: u8) : bool {
        if (arg0 == 0 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 0) {
            true
        } else {
            arg0 == 2 && arg1 == 1
        }
    }

    entry fun play(arg0: &mut Game, arg1: u8, arg2: 0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg2);
        assert!(0x2::balance::value<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.balance) >= v0 * 10, 1001);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u8(&mut v1) % 3;
        if (is_winner(arg1, v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(0x2::coin::from_balance<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(0x2::balance::split<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        } else if (is_winner(v2, arg1)) {
            deposit(arg0, arg2, arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(arg2, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>>(0x2::coin::from_balance<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(0x2::balance::split<0xf5f1f09b51d4a7b7e654cb044a63fd0270b89acbb94f72e013aeb10d6409aba8::suiceber_faucet_coin::SUICEBER_FAUCET_COIN>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

