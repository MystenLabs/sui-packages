module 0xab2524c7d199a0d2bc6da7ecc3f7ae6f24bfcf4f04648b617fb8a66258d74993::balance_bag {
    struct BalanceBag has store {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun destroy_empty(arg0: BalanceBag) {
        let BalanceBag {
            id  : v0,
            bag : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v1);
    }

    public fun bag(arg0: &BalanceBag) : &0x2::bag::Bag {
        &arg0.bag
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : BalanceBag {
        BalanceBag{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        }
    }

    public fun join<T0>(arg0: &mut BalanceBag, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1);
    }

    public fun split<T0>(arg0: &mut BalanceBag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>()), arg1)
    }

    public fun value<T0>(arg0: &BalanceBag) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, 0x1::type_name::get<T0>()))
    }

    public fun contains<T0>(arg0: &BalanceBag) : bool {
        0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, 0x1::type_name::get<T0>())
    }

    public fun init_balance<T0>(arg0: &mut BalanceBag) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
    }

    // decompiled from Move bytecode v6
}

