module 0x41fa1afb9f46d2f76944799331348465fbb84d75a37841687105fc6693183ff6::test_minimal {
    struct GameTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &mut GameTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance(arg0: &GameTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameTreasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GameTreasury>(v0);
    }

    // decompiled from Move bytecode v6
}

