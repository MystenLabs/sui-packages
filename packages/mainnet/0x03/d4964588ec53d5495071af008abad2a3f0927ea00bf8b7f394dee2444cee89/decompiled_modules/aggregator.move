module 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator {
    struct SwapSession {
        id: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        min_amount_out: u64,
        aggregator_fee_rate: u32,
        aggregator_fee_recipient: address,
        partner_fee_rate: u32,
        partner_fee_recipient: 0x1::option::Option<address>,
        balances: 0x2::bag::Bag,
    }

    struct SwapCompletedEvent has copy, drop {
        swap_context_id: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        expect_amount_out: u64,
        min_amount_out: u64,
        aggregator_fee_amount: u64,
        aggregator_fee_rate: u32,
        aggregator_fee_recipient: address,
        partner_fee_amount: u64,
        partner_fee_rate: u32,
        partner_fee_recipient: 0x1::option::Option<address>,
    }

    struct SwapEvent has copy, drop {
        swap_context_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dex: 0x1::string::String,
        input_type: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_in_remaining: u64,
    }

    public fun complete_swap<T0>(arg0: SwapSession, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapSession {
            id                       : v0,
            input_type               : v1,
            output_type              : v2,
            amount_in                : v3,
            expect_amount_out        : v4,
            min_amount_out           : v5,
            aggregator_fee_rate      : v6,
            aggregator_fee_recipient : v7,
            partner_fee_rate         : v8,
            partner_fee_recipient    : v9,
            balances                 : v10,
        } = arg0;
        let v11 = v9;
        let v12 = v8;
        let v13 = v10;
        let v14 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v13, v2);
        let v15 = 0x2::balance::value<T0>(&v14);
        let v16 = if (v6 > 0) {
            let v17 = (((v15 as u128) * (v6 as u128) / (1000000 as u128)) as u64);
            0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v14, v17), v7, arg1);
            v17
        } else {
            0
        };
        let v18 = v16;
        let v19 = if (v8 > 0 && 0x1::option::is_some<address>(&v11)) {
            let v20 = (((v15 as u128) * (v8 as u128) / (1000000 as u128)) as u64);
            let v21 = 0x1::option::extract<address>(&mut v11);
            0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v14, v20), v21, arg1);
            0x1::option::fill<address>(&mut v11, v21);
            v20
        } else {
            v12 = 0;
            0
        };
        let v22 = 0x2::balance::value<T0>(&v14);
        assert!(v22 >= v5, 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::errors::err_amount_out_slippage_check_failed());
        if (v22 >= v4) {
            let v23 = v22 - v4;
            v18 = v16 + v23;
            0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v14, v23), v7, arg1);
        };
        assert!(0x2::bag::is_empty(&v13), 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::errors::err_remains_balance());
        0x2::bag::destroy_empty(v13);
        let v24 = SwapCompletedEvent{
            swap_context_id          : v0,
            input_type               : v1,
            output_type              : v2,
            amount_in                : v3,
            amount_out               : 0x2::balance::value<T0>(&v14),
            expect_amount_out        : v4,
            min_amount_out           : v5,
            aggregator_fee_amount    : v18,
            aggregator_fee_rate      : v6,
            aggregator_fee_recipient : v7,
            partner_fee_amount       : v19,
            partner_fee_rate         : v12,
            partner_fee_recipient    : v11,
        };
        0x2::event::emit<SwapCompletedEvent>(v24);
        0x2::coin::from_balance<T0>(v14, arg1)
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapSession, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            swap_context_id     : arg0.id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            input_type          : 0x1::type_name::with_defining_ids<T0>(),
            target              : 0x1::type_name::with_defining_ids<T1>(),
            amount_in           : arg3,
            amount_out          : arg4,
            amount_in_remaining : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun max_amount_in() : u64 {
        18446744073709551615
    }

    public fun merge_balance<T0>(arg0: &mut SwapSession, arg1: 0x2::balance::Balance<T0>) {
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

    public fun open_swap<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u32, arg4: address, arg5: u32, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : SwapSession {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::errors::err_amount_in_is_zero());
        assert!(arg3 <= 100000, 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::errors::err_too_large_fee_rate());
        assert!(arg5 <= 100000, 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::errors::err_too_large_fee_rate());
        let v1 = 0x2::bag::new(arg7);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1, v2, 0x2::coin::into_balance<T0>(arg2));
        let v3 = 0x2::object::new(arg7);
        0x2::object::delete(v3);
        SwapSession{
            id                       : 0x2::object::uid_to_inner(&v3),
            input_type               : v2,
            output_type              : 0x1::type_name::with_defining_ids<T1>(),
            amount_in                : v0,
            expect_amount_out        : arg0,
            min_amount_out           : arg1,
            aggregator_fee_rate      : arg3,
            aggregator_fee_recipient : arg4,
            partner_fee_rate         : arg5,
            partner_fee_recipient    : arg6,
            balances                 : v1,
        }
    }

    public fun take_balance<T0>(arg0: &mut SwapSession, arg1: u64) : 0x2::balance::Balance<T0> {
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

    // decompiled from Move bytecode v6
}

