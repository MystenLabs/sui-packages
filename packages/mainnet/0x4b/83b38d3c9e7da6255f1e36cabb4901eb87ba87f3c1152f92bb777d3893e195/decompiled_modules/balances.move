module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::balances {
    struct Balances has store {
        inner: 0x2::object::UID,
        items: u64,
    }

    public fun borrow<T0>(arg0: &Balances) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.inner, 0x1::type_name::get<T0>())
    }

    public fun borrow_mut<T0>(arg0: &mut Balances) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&mut arg0.inner, v0)) {
            arg0.items = arg0.items + 1;
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0)
    }

    public fun destroy_empty(arg0: Balances) {
        let Balances {
            inner : v0,
            items : v1,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun withdraw_all<T0>(arg0: &mut Balances) : 0x2::balance::Balance<T0> {
        arg0.items = arg0.items - 1;
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, 0x1::type_name::get<T0>())
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Balances {
        Balances{
            inner : 0x2::object::new(arg0),
            items : 0,
        }
    }

    public fun join_with<T0>(arg0: &mut Balances, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(borrow_mut<T0>(arg0), arg1);
    }

    public fun take_from<T0>(arg0: &mut Balances, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        0x2::balance::join<T0>(borrow_mut<T0>(arg0), 0x2::balance::split<T0>(arg1, arg2));
    }

    public fun withdraw_all_from<T0>(arg0: &mut Balances, arg1: &mut 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(borrow_mut<T0>(arg0), 0x2::balance::withdraw_all<T0>(arg1));
    }

    public fun withdraw_amount<T0>(arg0: &mut Balances, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(borrow_mut<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

