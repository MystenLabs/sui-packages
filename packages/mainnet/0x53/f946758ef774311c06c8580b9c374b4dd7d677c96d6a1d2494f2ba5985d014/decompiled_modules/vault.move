module 0x53f946758ef774311c06c8580b9c374b4dd7d677c96d6a1d2494f2ba5985d014::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault>(v1);
    }

    // decompiled from Move bytecode v6
}

