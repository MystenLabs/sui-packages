module 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::fee_pool {
    struct FeePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    public fun deposit_fee(arg0: &mut FeePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance(arg0: &FeePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeePool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner   : @0xd715effc3a6fa9371d4ad556b4514185935d37616d852215f813670d4889c936,
        };
        0x2::transfer::share_object<FeePool>(v0);
    }

    public fun withdraw(arg0: &mut FeePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

