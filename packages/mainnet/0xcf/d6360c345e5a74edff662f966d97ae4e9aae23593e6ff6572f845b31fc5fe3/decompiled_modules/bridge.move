module 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge {
    struct InitFastMctpLogged has copy, drop {
        coin_type: 0x1::ascii::String,
        currency_id: 0x2::object::ID,
        amount_in_initial: u64,
        custom_payload_raw: vector<u8>,
        custom_payload_hash: address,
    }

    struct BridgeSubmitted has copy, drop {
        trader: address,
        payload_type: u8,
        dest_domain: u32,
        amount_in: u64,
        fee_redeem: u64,
        gas_drop: u64,
        addr_dest: address,
        addr_ref: address,
        fee_rate_ref: u8,
        currency_id: address,
        coin_type: 0x1::ascii::String,
        custom_payload_hash: address,
        custom_payload: vector<u8>,
        circle_max_fee: u64,
        min_finality_threshold: u32,
        mint_recipient: address,
        destination_caller: address,
    }

    struct BridgeTicket<phantom T0> {
        payload_type: u8,
        input_funds: 0x2::coin::Coin<T0>,
        addr_dest: address,
        domain_dest: u32,
        gas_drop: u64,
        fee_redeem: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        circle_max_fee: u64,
        min_finality_threshold: u32,
        custom_payload: vector<u8>,
    }

    public fun bridge<T0: drop>(arg0: &0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::State, arg1: &0x2::coin_registry::Currency<T0>, arg2: BridgeTicket<T0>, arg3: &0x2::tx_context::TxContext) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T0, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::CircleAuth> {
        assert!(!0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::is_paused(arg0), 0);
        0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::assert_valid_version(arg0);
        let BridgeTicket {
            payload_type           : v0,
            input_funds            : v1,
            addr_dest              : v2,
            domain_dest            : v3,
            gas_drop               : v4,
            fee_redeem             : v5,
            addr_ref               : v6,
            fee_rate_ref           : v7,
            circle_max_fee         : v8,
            min_finality_threshold : v9,
            custom_payload         : v10,
        } = arg2;
        let v11 = v10;
        let v12 = v1;
        let v13 = 0x2::coin::value<T0>(&v12);
        assert!(v5 + v8 < v13, 2);
        assert!(v7 <= 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::amount::max_fee_rate(), 4);
        if (v6 == @0x0) {
            assert!(v7 == 0, 4);
        };
        let v14 = if (0x1::vector::length<u8>(&v11) > 0) {
            assert!(v0 == 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::payload_type_custom(), 3);
            0x2::address::from_bytes(0x2::hash::keccak256(&v11))
        } else {
            assert!(v0 == 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::payload_type_default(), 3);
            @0x0
        };
        let v15 = 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1);
        let v16 = 0x2::object::id_to_address(&v15);
        let v17 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::get_cctp_mayan_recipient(arg0, v3, v16);
        let v18 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::state::get_cctp_mayan_caller(arg0, v3);
        let v19 = 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::new(v0, v2, v4, v5, v6, v7, v14);
        let v20 = BridgeSubmitted{
            trader                 : 0x2::tx_context::sender(arg3),
            payload_type           : v0,
            dest_domain            : v3,
            amount_in              : v13,
            fee_redeem             : v5,
            gas_drop               : v4,
            addr_dest              : v2,
            addr_ref               : v6,
            fee_rate_ref           : v7,
            currency_id            : v16,
            coin_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            custom_payload_hash    : v14,
            custom_payload         : v11,
            circle_max_fee         : v8,
            min_finality_threshold : v9,
            mint_recipient         : v17,
            destination_caller     : v18,
        };
        0x2::event::emit<BridgeSubmitted>(v20);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::create_deposit_for_burn_with_package_auth_ticket<T0, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::CircleAuth>(v12, v3, v17, v18, (v8 as u256), v9, 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::bridge_payload::serialize(&v19), 0xcfd6360c345e5a74edff662f966d97ae4e9aae23593e6ff6572f845b31fc5fe3::circle_auth::new())
    }

    public fun log_initialize_fast_mctp<T0>(arg0: u64, arg1: &0x2::coin_registry::Currency<T0>, arg2: vector<u8>) {
        let v0 = if (0x1::vector::length<u8>(&arg2) > 0) {
            0x2::address::from_bytes(0x2::hash::keccak256(&arg2))
        } else {
            @0x0
        };
        let v1 = InitFastMctpLogged{
            coin_type           : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            currency_id         : 0x2::object::id<0x2::coin_registry::Currency<T0>>(arg1),
            amount_in_initial   : arg0,
            custom_payload_raw  : arg2,
            custom_payload_hash : v0,
        };
        0x2::event::emit<InitFastMctpLogged>(v1);
    }

    public fun prepare_bridge<T0>(arg0: u8, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u32, arg5: u64, arg6: u64, arg7: address, arg8: u8, arg9: u64, arg10: u32, arg11: vector<u8>) : BridgeTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        BridgeTicket<T0>{
            payload_type           : arg0,
            input_funds            : arg1,
            addr_dest              : arg3,
            domain_dest            : arg4,
            gas_drop               : arg5,
            fee_redeem             : arg6,
            addr_ref               : arg7,
            fee_rate_ref           : arg8,
            circle_max_fee         : arg9,
            min_finality_threshold : arg10,
            custom_payload         : arg11,
        }
    }

    // decompiled from Move bytecode v7
}

