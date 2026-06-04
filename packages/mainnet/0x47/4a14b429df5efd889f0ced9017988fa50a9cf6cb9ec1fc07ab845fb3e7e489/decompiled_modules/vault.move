module 0x474a14b429df5efd889f0ced9017988fa50a9cf6cb9ec1fc07ab845fb3e7e489::vault {
    struct LockedVault has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct RecoverableVault has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct LockedBalanceVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun locked_balance_value(arg0: &LockedBalanceVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun locked_value(arg0: &LockedVault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.coin)
    }

    public fun recoverable_value(arg0: &RecoverableVault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.coin)
    }

    entry fun unwrap_recoverable(arg0: RecoverableVault, arg1: address) {
        let RecoverableVault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg1);
    }

    entry fun wrap_balance_locked(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedBalanceVault{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<LockedBalanceVault>(v0, arg1);
    }

    entry fun wrap_locked(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedVault{
            id   : 0x2::object::new(arg2),
            coin : arg0,
        };
        0x2::transfer::transfer<LockedVault>(v0, arg1);
    }

    entry fun wrap_recoverable(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RecoverableVault{
            id   : 0x2::object::new(arg2),
            coin : arg0,
        };
        0x2::transfer::transfer<RecoverableVault>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

