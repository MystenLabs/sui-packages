module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::treasury {
    struct LaunchpadTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun balance(arg0: &LaunchpadTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LaunchpadTreasury {
        LaunchpadTreasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun deposit(arg0: &mut LaunchpadTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun share(arg0: LaunchpadTreasury) {
        0x2::transfer::share_object<LaunchpadTreasury>(arg0);
    }

    public fun withdraw(arg0: &mut LaunchpadTreasury, arg1: &0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_treasury_zero_withdraw());
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_treasury_insufficient());
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3)
    }

    public fun withdraw_all(arg0: &mut LaunchpadTreasury, arg1: &0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_treasury_zero_withdraw());
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

