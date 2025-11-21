module 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out_limit: u64,
        fee_rate: u32,
        fee_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct FinishSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u32,
        fee_recipient: address,
        amount_out_limit: u64,
    }

    public fun finalize_hop<T0, T1>(arg0: &mut SwapContext, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun finish_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            amount_out_limit : v4,
            fee_rate         : v5,
            fee_recipient    : v6,
            balances         : v7,
        } = arg0;
        let v8 = v7;
        let v9 = 0x1::type_name::get<T0>();
        assert!(v9 == v2, 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_target_mismatch());
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v8, v9), 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_target_not_found());
        let v10 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v8, v9);
        let v11 = if (v5 > 0 && v6 != @0x0) {
            let v12 = (((0x2::balance::value<T0>(&v10) as u128) * (v5 as u128) / 1000000) as u64);
            transfer_balance<T0>(0x2::balance::split<T0>(&mut v10, v12), v6, arg1);
            v12
        } else {
            0
        };
        let v13 = 0x2::balance::value<T0>(&v10);
        assert!(v13 >= v4, 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v8), 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_remains_balance());
        0x2::bag::destroy_empty(v8);
        let v14 = FinishSwapEvent{
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            amount_out       : v13,
            fee_amount       : v11,
            fee_rate         : v5,
            fee_recipient    : v6,
            amount_out_limit : v4,
        };
        0x2::event::emit<FinishSwapEvent>(v14);
        0x2::coin::from_balance<T0>(v10, arg1)
    }

    public fun max_amount_in() : u64 {
        18446744073709551615
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun prepare_hop<T0>(arg0: &mut SwapContext, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = take_balance<T0>(arg0, arg1);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::balance::value<T0>(&v0))
    }

    public fun return_remaining_balance<T0>(arg0: &mut SwapContext, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            let v1 = 0x2::tx_context::sender(arg1);
            transfer_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), v1, arg1);
        };
    }

    public fun start_swap<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u32, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg2) <= max_amount_in(), 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_exceed_max_amount_in());
        assert!(0x2::coin::value<T0>(&arg2) > 0, 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_amount_in_is_zero());
        if (arg3 > 0) {
            assert!(arg4 != @0x0, 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_invalid_fee_recipient());
        };
        assert!(arg3 <= 100000, 0x1b4e8a27fd9651ac017213318db6739b3bd253ff42c09c289f3e9509fd8f7ff3::errors::err_too_large_fee_rate());
        let v0 = 0x2::bag::new(arg5);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg2));
        SwapContext{
            quote_id         : arg0,
            from             : v1,
            target           : 0x1::type_name::get<T1>(),
            amount_in        : 0x2::coin::value<T0>(&arg2),
            amount_out_limit : arg1,
            fee_rate         : arg3,
            fee_recipient    : arg4,
            balances         : v0,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        if (0x2::balance::value<T0>(v1) <= arg1) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        }
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

