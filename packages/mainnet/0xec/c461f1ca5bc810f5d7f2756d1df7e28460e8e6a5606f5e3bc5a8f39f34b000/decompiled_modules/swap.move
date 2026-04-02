module 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::swap {
    struct SwapContext {
        balances: 0x2::bag::Bag,
    }

    struct EmptyTokenTicket {
        dummy_field: bool,
    }

    public fun check_min_output<T0>(arg0: &SwapContext, arg1: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            assert!(arg1 == 0, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::slippage_exceeded());
        } else {
            assert!(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) >= arg1, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::slippage_exceeded());
        };
    }

    public fun empty_token_as_coin<T0>(arg0: &mut SwapContext, arg1: &EmptyTokenTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::coin::zero<T0>(arg2)
        };
        0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2)
    }

    public fun end_swap(arg0: SwapContext, arg1: EmptyTokenTicket) {
        let SwapContext { balances: v0 } = arg0;
        assert!(0x2::bag::is_empty(&v0), 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::balances_not_empty());
        0x2::bag::destroy_empty(v0);
        let EmptyTokenTicket {  } = arg1;
    }

    public fun new_swap_context(arg0: &mut 0x2::tx_context::TxContext) : (SwapContext, EmptyTokenTicket) {
        let v0 = SwapContext{balances: 0x2::bag::new(arg0)};
        let v1 = EmptyTokenTicket{dummy_field: false};
        (v0, v1)
    }

    public fun put_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        put_balance_internal<T0>(arg0, arg1);
    }

    fun put_balance_internal<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T0>(), arg1);
        };
    }

    public fun take_balance<T0: drop, T1>(arg0: &mut SwapContext, arg1: &0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router::Router, arg2: T0, arg3: u64) : 0x2::balance::Balance<T1> {
        assert!(0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::router::is_package_whitelisted<T0>(arg1), 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::package_not_whitelisted());
        take_balance_internal<T1>(arg0, arg3)
    }

    fun take_balance_internal<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::invalid_coin_type());
        let v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0));
        let v2 = if (arg1 >= v1) {
            v1
        } else {
            arg1
        };
        assert!(v1 >= v2, 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error::insufficient_balance());
        if (v2 == v1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), v2)
        }
    }

    // decompiled from Move bytecode v6
}

