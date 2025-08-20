module 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router {
    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        fee_rate: u32,
        fee_recipient: address,
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

    struct SwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        pool_id: 0x2::object::ID,
        dex: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_in_remaining: u64,
        a2b: bool,
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
            balances          : v8,
        } = arg0;
        let v9 = v8;
        let v10 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9, v2);
        let v11 = if (v6 > 0 && v7 != @0x0) {
            let v12 = (((0x2::balance::value<T0>(&v10) as u128) * (v6 as u128) / (1000000 as u128)) as u64);
            transfer_balance<T0>(0x2::balance::split<T0>(&mut v10, v12), v7, arg1);
            v12
        } else {
            0
        };
        assert!(0x2::balance::value<T0>(&v10) >= v5, 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::errors::err_amount_out_slippage_check_failed());
        assert!(0x2::bag::is_empty(&v9), 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::errors::err_remains_balance());
        0x2::bag::destroy_empty(v9);
        let v13 = ConfirmSwapEvent{
            quote_id          : v0,
            from              : v1,
            target            : v2,
            amount_in         : v3,
            amount_out        : 0x2::balance::value<T0>(&v10),
            fee_amount        : v11,
            fee_rate          : v6,
            fee_recipient     : v7,
            expect_amount_out : v4,
            amount_out_limit  : v5,
        };
        0x2::event::emit<ConfirmSwapEvent>(v13);
        0x2::coin::from_balance<T0>(v10, arg1)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        let v0 = SwapEvent{
            quote_id            : arg0.quote_id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            from                : 0x1::type_name::get<T0>(),
            target              : 0x1::type_name::get<T1>(),
            amount_in           : arg3,
            amount_out          : arg4,
            amount_in_remaining : arg5,
            a2b                 : arg6,
        };
        0x2::event::emit<SwapEvent>(v0);
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

    public fun new_swap_context<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u32, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::errors::err_amount_in_is_zero());
        if (arg4 > 0) {
            assert!(arg5 != @0x0, 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::errors::err_invalid_fee_recipient());
        };
        assert!(arg4 <= 100000, 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::errors::err_too_large_fee_rate());
        let v0 = 0x2::bag::new(arg6);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg3));
        SwapContext{
            quote_id          : arg0,
            from              : v1,
            target            : 0x1::type_name::get<T1>(),
            amount_in         : 0x2::coin::value<T0>(&arg3),
            expect_amount_out : arg1,
            amount_out_limit  : arg2,
            fee_rate          : arg4,
            fee_recipient     : arg5,
            balances          : v0,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapContext, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1::type_name::get<T0>();
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

