module 0x872179354fa62e76740dc9d29085223b7e2cb9713ec8ba39e2d959b0a5a4c69b::operaxxx {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a_balance: 0x2::balance::Balance<T0>,
        coin_b_balance: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin_A<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.coin_a_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun add_coin_B<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id             : 0x2::object::new(arg1),
            coin_a_balance : 0x2::balance::zero<T0>(),
            coin_b_balance : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::public_transfer<Pool<T0, T1>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_to_A<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(0x2::balance::value<T0>(&arg0.coin_a_balance) >= v0, 1);
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_to_B<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::balance::value<T1>(&arg0.coin_b_balance) >= v0, 1);
        0x2::balance::join<T0>(&mut arg0.coin_a_balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin_A<T0, T1>(arg0: &mut AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.coin_a_balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_a_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin_B<T0, T1>(arg0: &mut AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg1.coin_b_balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.coin_b_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

