module 0x5d2feddda7008e7a110608e8019a5f4749dbfd34004aae4d6f599596ea898332::x {
    struct V has key {
        id: 0x2::object::UID,
        a: address,
        m: 0x2::vec_set::VecSet<address>,
    }

    public entry fun am(arg0: &mut V, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        ia(0x2::tx_context::sender(arg2), arg0);
        0x2::vec_set::insert<address>(&mut arg0.m, arg1);
    }

    public entry fun cv(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = V{
            id : 0x2::object::new(arg0),
            a  : v0,
            m  : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v1.m, v0);
        0x2::transfer::share_object<V>(v1);
    }

    public entry fun d<T0>(arg0: &mut V, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            let v1 = 0x2::balance::zero<T0>();
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(arg1));
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, v1);
        };
    }

    fun ia(arg0: address, arg1: &V) {
        assert!(arg0 == arg1.a, 0);
    }

    fun im(arg0: address, arg1: &V) {
        assert!(0x2::vec_set::contains<address>(&arg1.m, &arg0), 0);
    }

    public fun w<T0>(arg0: &mut V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        im(0x2::tx_context::sender(arg2), arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    public fun wp<T0>(arg0: &mut V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(w<T0>(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

