module 0x6ff4219ee3d769b8f24fbc6d0324730d44d79c50cb1e9fc7c643daef2eb8755e::fantasyni_swap {
    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinPool has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_coin<T0>(arg0: &mut CoinPool, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinPool{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<CoinPool>(v0);
    }

    public entry fun swap_x_y<T0, T1>(arg0: &mut CoinPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit_coin<T0>(arg0, arg1);
        let v0 = withdraw_coin<T1>(arg0, 0x2::coin::value<T0>(&arg1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun withdraw_coin<T0>(arg0: &mut CoinPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

