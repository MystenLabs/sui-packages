module 0xecc15d0aea33e2059f82f8a50c91f05fb28f9b402e13ea43002fbcb8f6b81936::m {
    struct Tom has key {
        id: 0x2::object::UID,
    }

    struct TomTreasury has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &mut TomTreasury, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Tom{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Tom>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TomTreasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<TomTreasury>(v1);
    }

    public entry fun test(arg0: &TomTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun withdraw(arg0: &Tom, arg1: &mut TomTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

