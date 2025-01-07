module 0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373::simple_swap {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance0: 0x2::balance::Balance<T0>,
        balance1: 0x2::balance::Balance<T1>,
        owner: address,
    }

    public entry fun addLiq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        0x2::coin::put<T0>(&mut arg0.balance0, arg1);
        0x2::coin::put<T1>(&mut arg0.balance1, arg2);
    }

    public entry fun createPool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id       : 0x2::object::new(arg0),
            balance0 : 0x2::balance::zero<T0>(),
            balance1 : 0x2::balance::zero<T1>(),
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public entry fun delLiq<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance0, arg1), arg3), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance1, arg2), arg3), arg0.owner);
    }

    public entry fun x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.balance0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance1, 0x2::coin::value<T0>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T1>(&mut arg0.balance1, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance0, 0x2::coin::value<T1>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

