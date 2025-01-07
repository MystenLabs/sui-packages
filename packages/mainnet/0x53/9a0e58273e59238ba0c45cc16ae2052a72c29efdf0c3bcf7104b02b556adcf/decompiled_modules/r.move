module 0x539a0e58273e59238ba0c45cc16ae2052a72c29efdf0c3bcf7104b02b556adcf::r {
    struct TomTreasury has key {
        id: 0x2::object::UID,
        suiamount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun borrow(arg0: &mut TomTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.suiamount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
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

