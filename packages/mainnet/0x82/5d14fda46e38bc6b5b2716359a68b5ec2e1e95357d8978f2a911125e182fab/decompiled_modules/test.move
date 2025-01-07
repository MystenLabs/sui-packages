module 0x825d14fda46e38bc6b5b2716359a68b5ec2e1e95357d8978f2a911125e182fab::test {
    struct TomTreasurySUI<phantom T0> has key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<T0>,
    }

    public fun test<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TomTreasurySUI<T0>{
            id         : 0x2::object::new(arg0),
            sui_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TomTreasurySUI<T0>>(v0);
    }

    public fun borrow_SUI<T0>(arg0: &mut TomTreasurySUI<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sui_amount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
    }

    public fun deposit_SUI<T0>(arg0: &mut TomTreasurySUI<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.sui_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    // decompiled from Move bytecode v6
}

