module 0x5b2f2f2051218313201340e756d8eab3edc5667a01a75d9af22df1323b953336::flash_pool {
    struct FlashPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun borrow(arg0: &mut FlashPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashPool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FlashPool>(v0);
    }

    public entry fun deposit(arg0: &mut FlashPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun repay(arg0: &mut FlashPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    // decompiled from Move bytecode v6
}

