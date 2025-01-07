module 0xd3dda4bd6e34cd105d811186a8787017a550e86ae71d8b31cfa3b73c820fc7c1::swaper {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapBank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coinA_balance: 0x2::balance::Balance<T0>,
        coinB_balance: 0x2::balance::Balance<T1>,
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapBank<T0, T1>{
            id            : 0x2::object::new(arg0),
            coinA_balance : 0x2::balance::zero<T0>(),
            coinB_balance : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<SwapBank<T0, T1>>(v0);
    }

    public entry fun deposite_coinA<T0, T1>(arg0: &mut SwapBank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coinA_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposite_coinB<T0, T1>(arg0: &mut SwapBank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coinB_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_coinA_for_coinB<T0, T1>(arg0: &mut SwapBank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coinA_balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coinB_balance, 0x2::coin::value<T0>(&arg1) * 1818180000000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_coinB_for_coinA<T0, T1>(arg0: &mut SwapBank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coinB_balance, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coinA_balance, 0x2::coin::value<T1>(&arg1) * 55 * 100000 / 1000000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_CoinA<T0, T1>(arg0: &AdminCap, arg1: &mut SwapBank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coinA_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_CoinB<T0, T1>(arg0: &AdminCap, arg1: &mut SwapBank<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coinB_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

