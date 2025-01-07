module 0xd6ccdc86323e1acf88ac1cd48bf83a2a553b323167b04f116d27138debc96d30::game {
    struct GamePool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        balance: 0x2::balance::Balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut GamePool, arg1: 0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg1) >= arg2, 104);
        let v0 = 0x2::coin::into_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(arg1);
        0x2::balance::join<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut v0, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(x"6368696e617a6d6320e8b584e98791e6b1a0"),
            balance : 0x2::balance::zero<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<GamePool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut GamePool, arg1: u64, arg2: &mut 0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(arg2) >= arg3, 101);
        assert!(0x2::balance::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg0.balance) >= arg3, 102);
        assert!(arg1 == 1 || arg1 == 2, 103);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = 0x2::random::generate_bool(&mut v0);
        if (arg1 == 1 && v1 || arg1 == 2 && !v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.balance, arg3), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::join<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(0x2::coin::split<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(arg2, arg3, arg5)));
        };
    }

    public entry fun withdrow(arg0: &AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&arg1.balance) >= arg2, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>>(0x2::coin::take<0xad326729307cb3d4bd56c23d9620b6d60ef6c2d786c52206a5bd078e7d55ee88::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

