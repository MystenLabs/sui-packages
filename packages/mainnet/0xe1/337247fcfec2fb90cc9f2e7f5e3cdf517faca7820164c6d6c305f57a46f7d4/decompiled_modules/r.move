module 0xe1337247fcfec2fb90cc9f2e7f5e3cdf517faca7820164c6d6c305f57a46f7d4::r {
    struct TomTreasurySUI has key {
        id: 0x2::object::UID,
        sui_amount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TomTreasuryUSDC<phantom T0> has key {
        id: 0x2::object::UID,
        usdc_amount: 0x2::balance::Balance<T0>,
    }

    public fun borrow_SUI(arg0: &mut TomTreasurySUI, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_amount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
    }

    public fun borrow_USDC<T0>(arg0: &mut TomTreasuryUSDC<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.usdc_amount, arg1), arg2), @0x1c5c3b9c11083fad29aa2269d725d55da41701bf7fc96a05994a2b0e376c5fd5);
    }

    public fun deposit_SUI(arg0: &mut TomTreasurySUI, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg1))
    }

    public fun deposit_USDC<T0>(arg0: &mut TomTreasuryUSDC<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        0x2::balance::join<T0>(&mut arg0.usdc_amount, 0x2::coin::into_balance<T0>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TomTreasurySUI{
            id         : 0x2::object::new(arg0),
            sui_amount : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<TomTreasurySUI>(v0);
    }

    public fun test<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TomTreasuryUSDC<T0>{
            id          : 0x2::object::new(arg0),
            usdc_amount : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<TomTreasuryUSDC<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

