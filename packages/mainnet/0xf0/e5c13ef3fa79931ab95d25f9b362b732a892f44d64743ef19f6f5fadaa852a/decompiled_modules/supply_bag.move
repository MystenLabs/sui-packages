module 0xf0e5c13ef3fa79931ab95d25f9b362b732a892f44d64743ef19f6f5fadaa852a::supply_bag {
    struct SupplyBag has store {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun destroy_empty(arg0: SupplyBag) {
        let SupplyBag {
            id  : v0,
            bag : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v1);
    }

    public fun bag(arg0: &SupplyBag) : &0x2::bag::Bag {
        &arg0.bag
    }

    public fun contains<T0>(arg0: &SupplyBag) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, 0x1::type_name::get<T0>())
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : SupplyBag {
        SupplyBag{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public fun decrease_supply<T0>(arg0: &mut SupplyBag, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun increase_supply<T0>(arg0: &mut SupplyBag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun supply_value<T0>(arg0: &SupplyBag) : u64 {
        0x2::balance::supply_value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&arg0.bag, 0x1::type_name::get<T0>()))
    }

    public fun init_supply<T0: drop>(arg0: T0, arg1: &mut SupplyBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Supply<T0>>(&mut arg1.bag, 0x1::type_name::get<T0>(), 0x2::balance::create_supply<T0>(arg0));
    }

    // decompiled from Move bytecode v6
}

