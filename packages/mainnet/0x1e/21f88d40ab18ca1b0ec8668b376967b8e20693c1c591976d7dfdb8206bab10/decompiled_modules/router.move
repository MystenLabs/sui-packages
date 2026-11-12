module 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::router {
    struct DebugCaptureCap has key {
        id: 0x2::object::UID,
        vault_id: address,
        operator: address,
    }

    struct SwapPlanV1 has drop {
        vault_id: address,
        signer_version: u64,
        policy_version: u64,
        sender: address,
        from: vector<u8>,
        target: vector<u8>,
        quote_amount_in: u64,
        quote_amount_out: u64,
        quote_id: vector<u8>,
        expiry_ms: u64,
    }

    struct SwapContext {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        quote_amount_in: u64,
        quote_amount_out: u64,
        min_amount_out: u64,
        vault_id: address,
        plan_policy_version: u64,
        signer_version: u64,
        balances: 0x2::bag::Bag,
    }

    struct ConfirmSwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        sender: address,
        vault_id: 0x2::object::ID,
        quote_amount_in: u64,
        quote_amount_out: u64,
        amount_in: u64,
        gross_amount_out: u64,
        amount_out: u64,
        expect_amount_out: u64,
        amount_out_limit: u64,
        protocol_fee_amount: u64,
        integrator_fee_amount: u64,
        surplus_amount: u64,
        captured_amount: u64,
        fee_rate: u32,
        fee_recipient: address,
        capture_rate: u64,
        volume_cap_rate: u64,
        vault_policy_version: u64,
        plan_policy_version: u64,
        signer_version: u64,
        capture_armed: bool,
        capture_paused: bool,
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
    }

    fun build_swap_context<T0>(arg0: 0x1::string::String, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: u32, arg10: address, arg11: &mut 0x2::tx_context::TxContext) : SwapContext {
        assert!(arg5 > 0, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_amount_in_is_zero());
        assert!(0x2::coin::value<T0>(&arg8) == arg5, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_amount_in_mismatch());
        assert!(arg6 > 0, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_amount_out_is_zero());
        assert!(arg7 > 0, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_amount_out_limit_is_zero());
        assert!(arg9 == 0 && arg10 == @0x0, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_overlay_fee_unsupported());
        let v0 = 0x2::bag::new(arg11);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0, v1, 0x2::coin::into_balance<T0>(arg8));
        SwapContext{
            quote_id            : arg0,
            from                : v1,
            target              : arg1,
            amount_in           : 0x2::coin::value<T0>(&arg8),
            quote_amount_in     : arg5,
            quote_amount_out    : arg6,
            min_amount_out      : arg7,
            vault_id            : arg2,
            plan_policy_version : arg3,
            signer_version      : arg4,
            balances            : v0,
        }
    }

    public fun confirm_swap<T0>(arg0: SwapContext, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        settle_swap<T0>(arg0, arg2, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::capture_rate(arg2), arg3)
    }

    public fun confirm_swap_debug<T0>(arg0: SwapContext, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg3: &DebugCaptureCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(arg3.vault_id == 0x2::object::id_address<0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault>(arg2) && arg3.operator == 0x2::tx_context::sender(arg5), 1);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 2500) {
            true
        } else if (arg4 == 5000) {
            true
        } else {
            arg4 == 10000
        };
        assert!(v0, 1);
        settle_swap<T0>(arg0, arg2, arg4 * 100, arg5)
    }

    fun decode_swap_plan(arg0: vector<u8>) : SwapPlanV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_invalid_plan());
        SwapPlanV1{
            vault_id         : 0x2::bcs::peel_address(&mut v0),
            signer_version   : 0x2::bcs::peel_u64(&mut v0),
            policy_version   : 0x2::bcs::peel_u64(&mut v0),
            sender           : 0x2::bcs::peel_address(&mut v0),
            from             : 0x2::bcs::peel_vec_u8(&mut v0),
            target           : 0x2::bcs::peel_vec_u8(&mut v0),
            quote_amount_in  : 0x2::bcs::peel_u64(&mut v0),
            quote_amount_out : 0x2::bcs::peel_u64(&mut v0),
            quote_id         : 0x2::bcs::peel_vec_u8(&mut v0),
            expiry_ms        : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun destroy_debug_capture(arg0: DebugCaptureCap) {
        let DebugCaptureCap {
            id       : v0,
            vault_id : _,
            operator : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emit_swap_event<T0, T1>(arg0: &SwapContext, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            quote_id            : arg0.quote_id,
            pool_id             : arg2,
            dex                 : 0x1::string::utf8(arg1),
            from                : 0x1::type_name::with_defining_ids<T0>(),
            target              : 0x1::type_name::with_defining_ids<T1>(),
            amount_in           : arg3,
            amount_out          : arg4,
            amount_in_remaining : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun grant_debug_capture(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        let v0 = DebugCaptureCap{
            id       : 0x2::object::new(arg4),
            vault_id : 0x2::object::id_address<0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault>(arg2),
            operator : arg3,
        };
        0x2::transfer::transfer<DebugCaptureCap>(v0, arg3);
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

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_expect_amount_out_overflow());
        (v0 as u64)
    }

    public fun new_swap_context<T0, T1>(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u32, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SwapContext {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg0);
        new_swap_context_with_plan<T0, T1>(arg1, 0x2::object::id_address<0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault>(arg1), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), arg2, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9)
    }

    fun new_swap_context_with_plan<T0, T1>(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: u32, arg9: address, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : SwapContext {
        let SwapPlanV1 {
            vault_id         : v0,
            signer_version   : v1,
            policy_version   : v2,
            sender           : _,
            from             : _,
            target           : _,
            quote_amount_in  : v6,
            quote_amount_out : v7,
            quote_id         : v8,
            expiry_ms        : v9,
        } = verify_plan(arg0, arg1, 0x2::tx_context::sender(arg11), arg2, arg3, arg4, arg5);
        assert!(arg10 < v9, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_expired());
        build_swap_context<T0>(0x1::string::utf8(v8), 0x1::type_name::with_defining_ids<T1>(), v0, v2, v1, v6, v7, arg6, arg7, arg8, arg9, arg11)
    }

    fun settle_swap<T0>(arg0: SwapContext, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SwapContext {
            quote_id            : v0,
            from                : v1,
            target              : v2,
            amount_in           : v3,
            quote_amount_in     : v4,
            quote_amount_out    : v5,
            min_amount_out      : v6,
            vault_id            : v7,
            plan_policy_version : v8,
            signer_version      : v9,
            balances            : v10,
        } = arg0;
        let v11 = v10;
        assert!(v7 == 0x2::object::id_address<0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault>(arg1), 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_vault_mismatch());
        let v12 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v11, v2);
        let v13 = 0x2::balance::value<T0>(&v12);
        let v14 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::rate_denominator();
        assert!(0x2::bag::is_empty(&v11), 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_remains_balance());
        0x2::bag::destroy_empty(v11);
        let v15 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::volume_cap_rate(arg1);
        let v16 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::policy_version(arg1);
        let v17 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::capture_paused(arg1);
        let v18 = if (!v17) {
            if (v8 == v16) {
                if (arg2 > 0) {
                    v15 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v19 = 0;
        let v20 = 0;
        if (0x2::balance::value<T0>(&v12) > v5) {
            let v21 = 0x2::balance::value<T0>(&v12) - v5;
            v19 = v21;
            if (v18) {
                let v22 = mul_div(v21, arg2, v14);
                v20 = v22;
                let v23 = mul_div(v13, v15, v14);
                if (v22 > v23) {
                    v20 = v23;
                };
                0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::deposit<T0>(arg1, 0x2::balance::split<T0>(&mut v12, v20));
            };
        };
        assert!(0x2::balance::value<T0>(&v12) >= v6, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_amount_out_slippage_check_failed());
        let v24 = ConfirmSwapEvent{
            quote_id              : v0,
            from                  : v1,
            target                : v2,
            sender                : 0x2::tx_context::sender(arg3),
            vault_id              : 0x2::object::id<0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault>(arg1),
            quote_amount_in       : v4,
            quote_amount_out      : v5,
            amount_in             : v3,
            gross_amount_out      : v13,
            amount_out            : 0x2::balance::value<T0>(&v12),
            expect_amount_out     : v5,
            amount_out_limit      : v6,
            protocol_fee_amount   : 0,
            integrator_fee_amount : 0,
            surplus_amount        : v19,
            captured_amount       : v20,
            fee_rate              : 0,
            fee_recipient         : @0x0,
            capture_rate          : arg2,
            volume_cap_rate       : v15,
            vault_policy_version  : v16,
            plan_policy_version   : v8,
            signer_version        : v9,
            capture_armed         : v18,
            capture_paused        : v17,
        };
        0x2::event::emit<ConfirmSwapEvent>(v24);
        0x2::coin::from_balance<T0>(v12, arg3)
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

    fun verify_plan(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::ProtocolFeeVault, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : SwapPlanV1 {
        assert!(0x1::vector::length<u8>(&arg6) == 96, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_invalid_plan());
        let v0 = b"";
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg6, v2));
            v2 = v2 + 1;
        };
        while (v2 < 96) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg6, v2));
            v2 = v2 + 1;
        };
        let v3 = x"43657475732d4167672d5375692d53776170506c616e2d763100000000000000";
        0x1::vector::append<u8>(&mut v3, arg5);
        assert!(0x2::ed25519::ed25519_verify(&v1, &v0, &v3), 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_bad_plan_signature());
        let v4 = decode_swap_plan(arg5);
        let v5 = 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee::signer_pubkey(arg0, v4.signer_version);
        assert!(0x1::option::is_some<vector<u8>>(&v5) && *0x1::option::borrow<vector<u8>>(&v5) == v0, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_unknown_plan_signer());
        assert!(v4.vault_id == arg1, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_vault_mismatch());
        assert!(v4.sender == @0x0 || v4.sender == arg2, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_sender_mismatch());
        assert!(v4.from == arg3 && v4.target == arg4, 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::errors::err_plan_coin_mismatch());
        v4
    }

    // decompiled from Move bytecode v7
}

