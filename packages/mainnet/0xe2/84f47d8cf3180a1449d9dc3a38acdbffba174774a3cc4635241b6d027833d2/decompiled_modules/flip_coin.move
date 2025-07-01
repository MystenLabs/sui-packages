module 0xe284f47d8cf3180a1449d9dc3a38acdbffba174774a3cc4635241b6d027833d2::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&mut arg0.balance, 0x2::coin::into_balance<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(),
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Game>(v0);
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&arg2);
        assert!(0x2::balance::value<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&arg0.balance) >= v0 * 10, 1001);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>>(0x2::coin::from_balance<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(0x2::balance::split<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            deposit(arg0, arg2, arg4);
        };
    }

    public entry fun withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>>(0x2::coin::from_balance<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(0x2::balance::split<0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason::FAUCET_MASON>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

