module 0x5d58418b93cc4a96e295b980cc91a5288e017c060c6504a70fdf0de45a249b26::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        unlock_epoch: u64,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        owner: address,
        epoch: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        owner: address,
        epoch: u64,
    }

    public entry fun create_vault(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Vault{
            id           : 0x2::object::new(arg1),
            owner        : v0,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            unlock_epoch : arg0,
        };
        0x2::transfer::public_transfer<Vault>(v1, v0);
    }

    public entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = Deposited{
            vault_id : 0x2::object::id<Vault>(arg0),
            amount   : v1,
            owner    : v0,
            epoch    : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<Deposited>(v2);
    }

    public fun get_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun withdraw(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x2::tx_context::epoch(arg1);
        assert!(v1 >= arg0.unlock_epoch, 2);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg1), arg0.owner);
        let v3 = Withdrawn{
            vault_id : 0x2::object::id<Vault>(arg0),
            amount   : v2,
            owner    : v0,
            epoch    : v1,
        };
        0x2::event::emit<Withdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

