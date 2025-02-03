module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::coin_supply_bag {
    struct CoinSupplyBag has store, key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : CoinSupplyBag {
        CoinSupplyBag{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public fun add_coin_supply<T0>(arg0: &mut CoinSupplyBag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun init_coin_supply<T0: drop>(arg0: T0, arg1: &mut CoinSupplyBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg1.bag, 0x1::type_name::get<T0>(), 0x2::balance::create_supply<T0>(arg0));
    }

    public fun sub_coin_supply<T0>(arg0: &mut CoinSupplyBag, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    // decompiled from Move bytecode v6
}

