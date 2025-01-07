module 0x698251b6db71d555f1e63e8db687045b7ecb3dac7311f72d60eb41cadcff38e::r {
    struct TomTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    public fun borrow_SUI<T0>(arg0: &mut TomTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_amount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
    }

    public fun borrow_USDC<T0>(arg0: &mut TomTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
    }

    public fun deposit_SUI<T0>(arg0: &mut TomTreasury<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg1))
    }

    public fun deposit_USDC<T0>(arg0: &mut TomTreasury<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    public fun test<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TomTreasury<T0>{
            id          : 0x2::object::new(arg0),
            sui_amount  : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TomTreasury<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

