module 0x40de0e713249894ffd47d14d55a32b65b9e38f3f6df94b5e4ef586cd9e20743a::CoinSwap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin1: 0x2::balance::Balance<T0>,
        coin2: 0x2::balance::Balance<T1>,
    }

    public entry fun createPoool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id    : 0x2::object::new(arg0),
            coin1 : 0x2::balance::zero<T0>(),
            coin2 : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    public entry fun depositA<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin1, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun depositB<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin2, 0x2::coin::into_balance<T1>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swapA_to_B<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin2, 0x2::coin::value<T0>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.coin1, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun swapB_to_A<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin1, 0x2::coin::value<T1>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<T1>(&mut arg0.coin2, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun withdrawA<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin1, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawB<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin2, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

