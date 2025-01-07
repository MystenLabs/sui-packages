module 0xbdc0241b35ec6f43475c6e56880471ded3cfbfbdc1abe6d7c3756b0d5240b839::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun admin_deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(arg1));
    }

    public fun admin_withdraw(arg0: &mut AdminCap, arg1: u64, arg2: &mut Game, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&mut arg2.balance, arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&arg0.balance) >= 0x2::coin::value<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&arg3), 1);
        let v0 = 0x2::random::new_generator(arg1, arg4);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::value<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&arg3)), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0x1f85ccfd317c2269b82562acd752f6f339d490f50e09cdc4444d7f54ff4fd875::faucet_coin::FAUCET_COIN>(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

