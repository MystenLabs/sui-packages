module 0x7d2cc236bf30ea1e0403a2cd60e986ef7f60632e05702793a7703477f7eaf7f3::test_minimal {
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

