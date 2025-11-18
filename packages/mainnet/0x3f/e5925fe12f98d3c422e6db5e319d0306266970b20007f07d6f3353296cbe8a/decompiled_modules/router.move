module 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::router {
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
        let v9 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v8, v2);
        let v10 = if (v5 > 0 && v6 != @0x0) {
            let v11 = (((0x2::balance::value<T0>(&v9) as u128) * (v5 as u128) / 1000000) as u64);
            transfer_balance<T0>(0x2::balance::split<T0>(&mut v9, v11), v6, arg1);
            v11
        } else {
            0
        };
        let v12 = 0x2::balance::value<T0>(&v9);
        assert!(v12 >= v4, 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v8), 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_remains_balance());
        0x2::bag::destroy_empty(v8);
        let v13 = FinishSwapEvent{
            quote_id         : v0,
            from             : v1,
            target           : v2,
            amount_in        : v3,
            amount_out       : v12,
            fee_amount       : v10,
            fee_rate         : v5,
            fee_recipient    : v6,
            amount_out_limit : v4,
        };
        0x2::event::emit<FinishSwapEvent>(v13);
        0x2::coin::from_balance<T0>(v9, arg1)
    }

    public fun handle_swap_output<T0, T1>(arg0: &mut SwapContext, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        if (arg1 == max_amount_in()) {
            let v1 = 0x2::tx_context::sender(arg4);
            transfer_balance<T0>(v0, v1, arg4);
        } else {
            merge_balance<T0>(arg0, v0);
        };
        merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
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

    public fun prepare_swap_input<T0>(arg0: &mut SwapContext, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64, u64) {
        let v0 = take_balance<T0>(arg0, arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return (0x1::vector::empty<0x2::coin::Coin<T0>>(), 0, 0)
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(v0, arg2));
        (v2, v1, 0)
    }

    public fun start_swap<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u32, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg2) <= max_amount_in(), 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_exceed_max_amount_in());
        assert!(0x2::coin::value<T0>(&arg2) > 0, 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_amount_in_is_zero());
        if (arg3 > 0) {
            assert!(arg4 != @0x0, 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_invalid_fee_recipient());
        };
        assert!(arg3 <= 100000, 0x3fe5925fe12f98d3c422e6db5e319d0306266970b20007f07d6f3353296cbe8a::errors::err_too_large_fee_rate());
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
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
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

