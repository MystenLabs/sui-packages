module 0x6fb7567ecf6a6d52c1b0f382bdc5394336a4feec59cad32207f73ee78c0191aa::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    entry fun deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
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

    entry fun withdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg1.balance, arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

