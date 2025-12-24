module 0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::aggregator {
    struct SwapSession {
        id: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        expect_amount_out: u64,
        min_amount_out: u64,
        fee_rate: u32,
        fee_recipient: address,
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

    public fun complete_swap<T0>(arg0: SwapSession, arg1: &mut 0x2::tx_context::TxContext, arg2: u32, arg3: 0x1::option::Option<address>) : 0x2::coin::Coin<T0> {
        let SwapSession {
            id                : v0,
            input_type        : v1,
            output_type       : v2,
            amount_in         : v3,
            expect_amount_out : v4,
            min_amount_out    : v5,
            fee_rate          : v6,
            fee_recipient     : v7,
            balances          : v8,
        } = arg0;
        let v9 = v8;
        let v10 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v9, v2);
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = if (v6 > 0) {
            let v13 = (((v11 as u128) * (v6 as u128) / (1000000 as u128)) as u64);
            0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v10, v13), v7, arg1);
            v13
        } else {
            0
        };
        let v14 = v12;
        let v15 = if (arg2 > 0 && 0x1::option::is_some<address>(&arg3)) {
            let v16 = (((v11 as u128) * (arg2 as u128) / (1000000 as u128)) as u64);
            0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v10, v16), 0x1::option::extract<address>(&mut arg3), arg1);
            v16
        } else {
            arg2 = 0;
            0
        };
        let v17 = 0x2::balance::value<T0>(&v10);
        assert!(v17 >= v5, 0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::errors::err_amount_out_slippage_check_failed());
        if (v17 >= v4) {
            let v18 = v17 - v4;
            v14 = v12 + v18;
            0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::utils::transfer_balance<T0>(0x2::balance::split<T0>(&mut v10, v18), v7, arg1);
        };
        assert!(0x2::bag::is_empty(&v9), 0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::errors::err_remains_balance());
        0x2::bag::destroy_empty(v9);
        let v19 = SwapCompletedEvent{
            swap_context_id          : v0,
            input_type               : v1,
            output_type              : v2,
            amount_in                : v3,
            amount_out               : 0x2::balance::value<T0>(&v10),
            expect_amount_out        : v4,
            min_amount_out           : v5,
            aggregator_fee_amount    : v14,
            aggregator_fee_rate      : v6,
            aggregator_fee_recipient : v7,
            partner_fee_amount       : v15,
            partner_fee_rate         : arg2,
            partner_fee_recipient    : arg3,
        };
        0x2::event::emit<SwapCompletedEvent>(v19);
        0x2::coin::from_balance<T0>(v10, arg1)
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

    public fun open_swap<T0, T1>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u32, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : SwapSession {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::errors::err_amount_in_is_zero());
        assert!(arg3 <= 100000, 0xbab3330b5126e7a5bcc61ec040c414967ab629f71f054f9fa7644008ca2d75e0::errors::err_too_large_fee_rate());
        let v1 = 0x2::bag::new(arg5);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1, v2, 0x2::coin::into_balance<T0>(arg2));
        let v3 = 0x2::object::new(arg5);
        0x2::object::delete(v3);
        SwapSession{
            id                : 0x2::object::uid_to_inner(&v3),
            input_type        : v2,
            output_type       : 0x1::type_name::with_defining_ids<T1>(),
            amount_in         : v0,
            expect_amount_out : arg0,
            min_amount_out    : arg1,
            fee_rate          : arg3,
            fee_recipient     : arg4,
            balances          : v1,
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

