module 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::create_order {
    struct OrderCreated has copy, drop {
        trader: address,
        payload_type: u8,
        dest_domain: u32,
        amount_in: u64,
        addr_dest: address,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        currency_id: address,
        coin_type: 0x1::ascii::String,
        circle_max_fee: u64,
        min_finality_threshold: u32,
        mint_recipient: address,
        destination_caller: address,
    }

    struct CreateOrderTicket<phantom T0> {
        input_funds: 0x2::coin::Coin<T0>,
        addr_dest: address,
        domain_dest: u32,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        circle_max_fee: u64,
        min_finality_threshold: u32,
    }

    public fun create_order<T0: drop>(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: &0x2::coin_registry::Currency<T0>, arg2: CreateOrderTicket<T0>, arg3: &0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T0, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::CircleAuth> {
        assert!(!0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::is_paused(arg0), 0);
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let CreateOrderTicket {
            input_funds            : v0,
            addr_dest              : v1,
            domain_dest            : v2,
            token_out              : v3,
            amount_out_min         : v4,
            gas_drop               : v5,
            fee_redeem             : v6,
            fee_refund             : v7,
            deadline               : v8,
            addr_ref               : v9,
            fee_rate_ref           : v10,
            circle_max_fee         : v11,
            min_finality_threshold : v12,
        } = arg2;
        let v13 = v0;
        let v14 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::order_payload::payload_type_order();
        let v15 = 0x2::coin::value<T0>(&v13);
        assert!(v6 + v11 < v15, 2);
        assert!(v7 + v11 < v15, 2);
        assert!(v10 <= 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::max_fee_rate(), 3);
        if (v9 == @0x0) {
            assert!(v10 == 0, 3);
        };
        if (v3 == @0x0) {
            assert!(v5 == 0, 4);
        };
        let v16 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1);
        let v17 = 0x2::object::id_to_address(&v16);
        let v18 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::get_cctp_mayan_recipient(arg0, v2, v17);
        let v19 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::get_cctp_mayan_caller(arg0, v2);
        let v20 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::order_payload::new(v14, v1, v3, v4, v5, v6, v7, v8, v9, v10);
        let v21 = OrderCreated{
            trader                 : 0x2::tx_context::sender(arg3),
            payload_type           : v14,
            dest_domain            : v2,
            amount_in              : v15,
            addr_dest              : v1,
            token_out              : v3,
            amount_out_min         : v4,
            gas_drop               : v5,
            fee_redeem             : v6,
            fee_refund             : v7,
            deadline               : v8,
            addr_ref               : v9,
            fee_rate_ref           : v10,
            currency_id            : v17,
            coin_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            circle_max_fee         : v11,
            min_finality_threshold : v12,
            mint_recipient         : v18,
            destination_caller     : v19,
        };
        0x2::event::emit<OrderCreated>(v21);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T0, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::CircleAuth>(v13, v2, v18, v19, (v11 as u256), v12, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::order_payload::serialize(&v20), 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::new())
    }

    public fun prepare_create_order<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: u32, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: u8, arg12: u64, arg13: u32) : CreateOrderTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        CreateOrderTicket<T0>{
            input_funds            : arg0,
            addr_dest              : arg2,
            domain_dest            : arg3,
            token_out              : arg4,
            amount_out_min         : arg5,
            gas_drop               : arg6,
            fee_redeem             : arg7,
            fee_refund             : arg8,
            deadline               : arg9,
            addr_ref               : arg10,
            fee_rate_ref           : arg11,
            circle_max_fee         : arg12,
            min_finality_threshold : arg13,
        }
    }

    // decompiled from Move bytecode v7
}

