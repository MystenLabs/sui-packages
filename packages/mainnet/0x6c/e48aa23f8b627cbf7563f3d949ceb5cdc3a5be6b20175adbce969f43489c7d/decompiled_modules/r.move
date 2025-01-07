module 0x6ce48aa23f8b627cbf7563f3d949ceb5cdc3a5be6b20175adbce969f43489c7d::r {
    struct TomTreasury has key {
        id: 0x2::object::UID,
        suiamount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun borrow(arg0: &mut TomTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.suiamount, arg1), arg2)
    }

    public fun deposit_pool(arg0: &mut TomTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.suiamount, 0x2::coin::into_balance<0x2::sui::SUI>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TomTreasury{
            id        : 0x2::object::new(arg0),
            suiamount : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<TomTreasury>(v0);
    }

    // decompiled from Move bytecode v6
}

