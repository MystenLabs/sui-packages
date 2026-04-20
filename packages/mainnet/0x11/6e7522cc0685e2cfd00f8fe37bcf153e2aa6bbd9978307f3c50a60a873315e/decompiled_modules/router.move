module 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        fee_rate: u32,
        fee_recipient: address,
        fee_amount: u64,
        balances: 0x2::bag::Bag,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        fee_rate: u32,
        fee_recipient: address,
        expect_amount_out: u64,
        amount_out_limit: u64,
    }

    public fun fee_recipient(arg0: &SwapContext) : address {
        arg0.fee_recipient
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            expect_amount_out : v4,
            amount_out_limit  : v5,
            fee_rate          : v6,
            fee_recipient     : v7,
            fee_amount        : v8,
            balances          : v9,
        } = arg0;
        let v10 = v9;
        let v11 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v10, v2);
        assert!(0x2::balance::value<T0>(&v11) >= v5, 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::errors::amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v10), 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::errors::remains_balance());
        0x2::bag::destroy_empty(v10);
        let v12 = ConfirmSwapEvent{
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            amount_out        : 0x2::balance::value<T0>(&v11),
            fee_amount        : v8,
            fee_rate          : v6,
            fee_recipient     : v7,
            expect_amount_out : v4,
            amount_out_limit  : v5,
        };
        0x2::event::emit<ConfirmSwapEvent>(v12);
        0x2::coin::from_balance<T0>(v11, arg1)
    }

    public fun max_amount_in() : u64 {
        18446744073709551615
    }

    public fun merge_balance<T0>(arg0: &mut SwapContext, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun new_swap_context<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::fee::FeeConfig, arg5: &mut 0x2::tx_context::TxContext) : SwapContext {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::fee::fee_rate(arg4);
        let v1 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::fee::fee_recipient(arg4);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0, 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::errors::amount_in_is_zero());
        if (v0 > 0) {
            assert!(v1 != @0x0, 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::errors::invalid_fee_recipient());
        };
        let v3 = 0x2::coin::into_balance<T0>(arg3);
        let v4 = if (v0 > 0) {
            let v5 = (((v2 as u128) * (v0 as u128) / 1000000) as u64);
            transfer_balance<T0>(0x2::balance::split<T0>(&mut v3, v5), v1, arg5);
            v5
        } else {
            0
        };
        let v6 = 0x2::bag::new(arg5);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v6, v7, v3);
        SwapContext{
            quote_id          : arg0,
            from              : v7,
            target            : 0x1::type_name::with_defining_ids<T1>(),
            amount_in         : v2,
            expect_amount_out : arg1,
            amount_out_limit  : arg2,
            fee_rate          : v0,
            fee_recipient     : v1,
            fee_amount        : v4,
            balances          : v6,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
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

    public fun transfer_remaining_balance<T0>(arg0: &SwapContext, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.fee_recipient != @0x0) {
            arg0.fee_recipient
        } else {
            0x2::tx_context::sender(arg2)
        };
        transfer_balance<T0>(arg1, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

