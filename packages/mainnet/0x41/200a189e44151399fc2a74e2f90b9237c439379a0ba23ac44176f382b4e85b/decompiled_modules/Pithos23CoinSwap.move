module 0x41200a189e44151399fc2a74e2f90b9237c439379a0ba23ac44176f382b4e85b::Pithos23CoinSwap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
    }

    public entry fun createPoool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank<T0, T1>{
            id     : 0x2::object::new(arg0),
            coin_x : 0x2::balance::zero<T0>(),
            coin_y : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Bank<T0, T1>>(v0);
    }

    public entry fun depositX<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_x, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun depositY<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_y, 0x2::coin::into_balance<T1>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swapX_to_Y<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::balance::value<T1>(&arg0.coin_y) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_y, v0), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.coin_x, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun swapY_to_X<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(0x2::balance::value<T0>(&arg0.coin_x) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_x, v0), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::join<T1>(&mut arg0.coin_y, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun withdrawX<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_x, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawY<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_y, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

