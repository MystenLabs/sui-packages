module 0xcfff4a60587d5475fb62365da7105806aa608b8585a7d4f2ba965a44f7875772::myswap {
    struct SWAPBANK<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a_balance: 0x2::balance::Balance<T0>,
        coin_b_balance: 0x2::balance::Balance<T1>,
        lp: 0x2::balance::Supply<LPCOUPON<T0, T1>>,
        scale: u64,
    }

    struct LPCOUPON<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    public entry fun add_bank<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LPCOUPON<T0, T1>{dummy_field: false};
        let v1 = SWAPBANK<T0, T1>{
            id             : 0x2::object::new(arg2),
            coin_a_balance : 0x2::coin::into_balance<T0>(arg0),
            coin_b_balance : 0x2::coin::into_balance<T1>(arg1),
            lp             : 0x2::balance::create_supply<LPCOUPON<T0, T1>>(v0),
            scale          : 10000000000,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCOUPON<T0, T1>>>(0x2::coin::from_balance<LPCOUPON<T0, T1>>(0x2::balance::increase_supply<LPCOUPON<T0, T1>>(&mut v1.lp, 0x1::u64::sqrt(0x2::coin::value<T0>(&arg0) * 0x2::coin::value<T1>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<SWAPBANK<T0, T1>>(v1);
    }

    public entry fun deposit<T0, T1>(arg0: &mut SWAPBANK<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) / 0x2::coin::value<T1>(&arg2) == 0x2::balance::value<T0>(&arg0.coin_a_balance) / 0x2::balance::value<T1>(&arg0.coin_b_balance), 2305);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCOUPON<T0, T1>>>(0x2::coin::from_balance<LPCOUPON<T0, T1>>(0x2::balance::increase_supply<LPCOUPON<T0, T1>>(&mut arg0.lp, 0x1::u64::sqrt(0x2::coin::value<T0>(&arg1) * 0x2::coin::value<T1>(&arg2))), arg3), 0x2::tx_context::sender(arg3));
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(arg2));
        0x2::balance::join<T0>(&mut arg0.coin_a_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun swapCoinA<T0, T1>(arg0: &mut SWAPBANK<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.coin_a_balance) >= 0x2::coin::value<T0>(&arg1), 2306);
        0x2::balance::join<T0>(&mut arg0.coin_a_balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_balance, 0x2::balance::value<T1>(&arg0.coin_b_balance) - 0x2::balance::value<T0>(&arg0.coin_a_balance) * 0x2::balance::value<T1>(&arg0.coin_b_balance) / (0x2::coin::value<T0>(&arg1) + 0x2::balance::value<T0>(&arg0.coin_a_balance))), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swapCoinB<T0, T1>(arg0: &mut SWAPBANK<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_balance, 0x2::balance::value<T0>(&arg0.coin_a_balance) - 0x2::balance::value<T0>(&arg0.coin_a_balance) * 0x2::balance::value<T1>(&arg0.coin_b_balance) / (0x2::coin::value<T1>(&arg1) + 0x2::balance::value<T1>(&arg0.coin_b_balance))), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw<T0, T1>(arg0: &mut SWAPBANK<T0, T1>, arg1: &0x2::coin::Coin<LPCOUPON<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::pow(0x2::coin::value<LPCOUPON<T0, T1>>(arg1), 2) / 0x2::balance::value<T0>(&arg0.coin_a_balance) * 0x2::balance::value<T1>(&arg0.coin_b_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_balance, 0x2::balance::value<T0>(&arg0.coin_a_balance) * v0), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_balance, 0x2::balance::value<T1>(&arg0.coin_b_balance) * v0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

