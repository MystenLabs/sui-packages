module 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::pools {
    struct UserPool has store {
        inner: 0x2::bag::Bag,
    }

    struct FeePool has store {
        inner: 0x2::bag::Bag,
    }

    public fun fee_balance<T0>(arg0: &FeePool) : u64 {
        let v0 = token_key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.inner, v0))
        } else {
            0
        }
    }

    public(friend) fun fee_drain<T0>(arg0: &mut FeePool) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, token_key<T0>());
        0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0))
    }

    public(friend) fun fee_join<T0>(arg0: &mut FeePool, arg1: 0x2::balance::Balance<T0>) {
        let v0 = token_key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0, arg1);
        };
    }

    public(friend) fun fee_split<T0>(arg0: &mut FeePool, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, token_key<T0>()), arg1)
    }

    public(friend) fun new_fee_pool(arg0: &mut 0x2::tx_context::TxContext) : FeePool {
        FeePool{inner: 0x2::bag::new(arg0)}
    }

    public(friend) fun new_user_pool(arg0: &mut 0x2::tx_context::TxContext) : UserPool {
        UserPool{inner: 0x2::bag::new(arg0)}
    }

    fun token_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    public fun user_balance<T0>(arg0: &UserPool) : u64 {
        let v0 = token_key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.inner, v0))
        } else {
            0
        }
    }

    public fun user_contains<T0>(arg0: &UserPool) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, token_key<T0>())
    }

    public(friend) fun user_join<T0>(arg0: &mut UserPool, arg1: 0x2::balance::Balance<T0>) {
        let v0 = token_key<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.inner, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0, arg1);
        };
    }

    public(friend) fun user_split<T0>(arg0: &mut UserPool, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, token_key<T0>()), arg1)
    }

    // decompiled from Move bytecode v7
}

