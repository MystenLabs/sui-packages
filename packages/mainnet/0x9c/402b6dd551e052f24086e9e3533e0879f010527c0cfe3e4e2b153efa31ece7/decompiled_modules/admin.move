module 0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct GameCap has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        publisher_address: address,
    }

    public fun borrow_balance_mut(arg0: &mut GameCap) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ADMIN>(arg0, arg1);
        let v0 = GameCap{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            publisher_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<GameCap>(v0);
    }

    entry fun withdraw(arg0: &0x2::package::Publisher, arg1: &mut GameCap, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_(arg1, arg2);
    }

    public(friend) fun withdraw_(arg0: &mut GameCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), arg0.publisher_address);
    }

    // decompiled from Move bytecode v6
}

