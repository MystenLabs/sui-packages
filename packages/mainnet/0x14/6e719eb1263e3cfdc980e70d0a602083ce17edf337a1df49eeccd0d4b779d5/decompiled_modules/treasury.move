module 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::treasury {
    struct DepositEvent has copy, drop {
        depositor: address,
        amount: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    struct TreasuryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg0.version);
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg0.version);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3)));
        let v0 = DepositEvent{
            depositor : 0x2::tx_context::sender(arg3),
            amount    : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
        arg1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            version : 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version(),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = TreasuryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun migrate(arg0: &mut Treasury) {
        arg0.version = 0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::version();
    }

    public fun withdraw(arg0: &TreasuryAdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x146e719eb1263e3cfdc980e70d0a602083ce17edf337a1df49eeccd0d4b779d5::package::check_version(arg1.version);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

