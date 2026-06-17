module 0x7f3578ebe174b0343cd96391b2a1c75d5db4ad82c793650b3950bdb5634192e5::usage_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Deposited has copy, drop {
        payer: address,
        amount: u64,
        deposit_reference: vector<u8>,
        balance_after: u64,
    }

    struct Withdrawn has copy, drop {
        admin: address,
        recipient: address,
        amount: u64,
        balance_after: u64,
    }

    public fun balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Deposited{
            payer             : 0x2::tx_context::sender(arg3),
            amount            : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            deposit_reference : arg2,
            balance_after     : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg4), arg3);
        let v0 = Withdrawn{
            admin         : 0x2::tx_context::sender(arg4),
            recipient     : arg3,
            amount        : arg2,
            balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg1.balance),
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

