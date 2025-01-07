module 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::balance_bag {
    struct BalanceBag has store, key {
        id: 0x2::object::UID,
        amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        inner: 0x2::bag::Bag,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : BalanceBag {
        BalanceBag{
            id      : 0x2::object::new(arg0),
            amounts : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            inner   : 0x2::bag::new(arg0),
        }
    }

    public fun destroy_empty(arg0: BalanceBag) {
        let BalanceBag {
            id      : v0,
            amounts : v1,
            inner   : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u64>(v1);
        0x2::bag::destroy_empty(v2);
    }

    public fun add<T0>(arg0: &mut BalanceBag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.amounts, &v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0), arg1);
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.amounts, &v0);
            *v1 = *v1 + 0x2::balance::value<T0>(&arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.amounts, v0, 0x2::balance::value<T0>(&arg1));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0, arg1);
        };
    }

    public fun amounts(arg0: &BalanceBag) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.amounts
    }

    public fun take_all<T0>(arg0: &mut BalanceBag) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.amounts, &v0)) {
            return 0x2::balance::zero<T0>()
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.amounts, &v0);
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0)
    }

    public fun take_amount<T0>(arg0: &mut BalanceBag, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.amounts, &v0);
        if (*v1 == arg1) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.amounts, &v0);
            return 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0)
        };
        *v1 = *v1 - arg1;
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.inner, v0), arg1)
    }

    // decompiled from Move bytecode v6
}

