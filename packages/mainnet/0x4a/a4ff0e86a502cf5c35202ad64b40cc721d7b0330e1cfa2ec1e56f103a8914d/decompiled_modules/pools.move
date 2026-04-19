module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools {
    struct UserPool has store {
        inner: 0x2::bag::Bag,
    }

    struct FeePool has store {
        inner: 0x2::bag::Bag,
    }

    struct GasPool has store {
        inner: 0x2::balance::Balance<0x2::sui::SUI>,
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

    public fun gas_balance(arg0: &GasPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.inner)
    }

    public(friend) fun gas_drain(arg0: &mut GasPool) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.inner, 0x2::balance::value<0x2::sui::SUI>(&arg0.inner))
    }

    public(friend) fun gas_join(arg0: &mut GasPool, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.inner, arg1);
    }

    public(friend) fun gas_split(arg0: &mut GasPool, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.inner, arg1)
    }

    public(friend) fun new_fee_pool(arg0: &mut 0x2::tx_context::TxContext) : FeePool {
        FeePool{inner: 0x2::bag::new(arg0)}
    }

    public(friend) fun new_gas_pool() : GasPool {
        GasPool{inner: 0x2::balance::zero<0x2::sui::SUI>()}
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

