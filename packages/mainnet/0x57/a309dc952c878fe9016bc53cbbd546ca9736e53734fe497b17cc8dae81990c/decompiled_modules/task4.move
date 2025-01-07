module 0x57a309dc952c878fe9016bc53cbbd546ca9736e53734fe497b17cc8dae81990c::task4 {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun Withdraw(arg0: &mut Game, arg1: &AdaminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.val, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>, arg2: u64) {
        0x2::balance::join<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.val, 0x2::balance::split<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(arg1), arg2));
        assert!(0x2::coin::value<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: &mut 0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>, arg3: &0x2::random::Random, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg1) {
            0x2::coin::join<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(arg2, 0x2::coin::take<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>(&mut arg0.val, arg4, arg5));
        } else {
            public_deposit(arg0, arg2, arg4);
        };
    }

    public entry fun public_deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0xb3743a94cbc755521c27fb5d91e2c8b34ea5b0df899654c20d2f965d301bb7dd::faucet_coin::FAUCET_COIN>, arg2: u64) {
        deposit(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

