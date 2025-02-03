module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::coin_balance_bag {
    struct CoinBalanceBag has store, key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : CoinBalanceBag {
        CoinBalanceBag{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public fun credit_coin_balance<T0>(arg0: &mut CoinBalanceBag, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun debit_coin_balance<T0>(arg0: &mut CoinBalanceBag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun init_coin_balance<T0>(arg0: &mut CoinBalanceBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
    }

    // decompiled from Move bytecode v6
}

