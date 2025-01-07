module 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::init_order {
    struct InitMctpLogged has copy, drop {
        coin_type: 0x1::ascii::String,
        coin_metadata: 0x2::object::ID,
        amount_in_initial: u64,
        custom_payload_raw: vector<u8>,
        custom_payload_hash: address,
    }

    struct OrderCreated has copy, drop {
        trader: address,
        token_in: address,
        amount_in: u64,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        cctp_nonce: u64,
        domain_dest: u32,
        hash: address,
    }

    struct InitOrderTicket<phantom T0> {
        payload_type: u8,
        trader: address,
        input_funds: 0x2::coin::Coin<T0>,
        addr_dest: address,
        chain_dest: u16,
        domain_dest: u32,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
    }

    struct CctpBurnRequestInitOrder {
        domain_dest: u32,
        mint_recipient: address,
        burn_token: address,
        amount_in: u64,
        caller: address,
        payload_type: u8,
        trader: address,
        chain_source: u16,
        token_in: address,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        cctp_domain: u32,
    }

    struct CircleAuth has drop {
        dummy_field: bool,
    }

    public fun initialize_order<T0: drop>(arg0: &0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::coin::CoinMetadata<T0>, arg3: InitOrderTicket<T0>, arg4: 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::MctpInitOrderParams) : (CctpBurnRequestInitOrder, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnWithCallerTicket<T0, CircleAuth>) {
        assert!(!0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::is_paused(arg0), 0);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::assert_valid_version(arg0);
        let InitOrderTicket {
            payload_type   : v0,
            trader         : v1,
            input_funds    : v2,
            addr_dest      : v3,
            chain_dest     : v4,
            domain_dest    : v5,
            token_out      : v6,
            amount_out_min : v7,
            gas_drop       : v8,
            fee_redeem     : v9,
            deadline       : v10,
            addr_ref       : v11,
            fee_rate_ref   : v12,
        } = arg3;
        let v13 = v2;
        assert!(v0 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::payload_type(&arg4), 2);
        assert!(v1 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::trader(&arg4), 2);
        assert!(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2) == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::coin_metadata_id(&arg4), 2);
        assert!(0x2::coin::value<T0>(&v13) == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::amount_in(&arg4), 2);
        assert!(v3 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::addr_dest(&arg4), 2);
        assert!(v4 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::chain_dest(&arg4), 2);
        assert!(v6 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::token_out(&arg4), 2);
        assert!(v7 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::amount_out_min(&arg4), 2);
        assert!(v8 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::gas_drop(&arg4), 2);
        assert!(v9 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::fee_redeem(&arg4), 2);
        assert!(v10 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::deadline(&arg4), 2);
        assert!(v11 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::addr_ref(&arg4), 2);
        assert!(v12 == 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::fee_rate_ref(&arg4), 2);
        let v14 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v15 = 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::calculate_mctp_fee::fee_rate_mayan(&arg4);
        assert!(v12 <= 100, 6);
        assert!(v15 <= 100, 5);
        assert!(0x2::coin::value<T0>(&v13) > v9, 1);
        if (v11 == @0x0) {
            assert!(v12 == 0, 6);
        };
        let v16 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v17 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::get_cctp_mayan_recipient(arg0, v5, 0x2::object::id_to_address(&v16));
        let v18 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::get_cctp_mayan_caller(arg0, v5);
        let v19 = CircleAuth{dummy_field: false};
        let v20 = CctpBurnRequestInitOrder{
            domain_dest    : v5,
            mint_recipient : v17,
            burn_token     : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>(),
            amount_in      : 0x2::coin::value<T0>(&v13),
            caller         : v18,
            payload_type   : v0,
            trader         : v1,
            chain_source   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(),
            token_in       : 0x2::object::id_to_address(&v14),
            addr_dest      : v3,
            chain_dest     : v4,
            token_out      : v6,
            amount_out_min : v7,
            gas_drop       : v8,
            fee_redeem     : v9,
            deadline       : v10,
            addr_ref       : v11,
            fee_rate_ref   : v12,
            fee_rate_mayan : v15,
            cctp_domain    : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1),
        };
        (v20, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, CircleAuth>(v19, v13, v5, v17, v18))
    }

    public fun log_initialize_mctp<T0>(arg0: u64, arg1: &0x2::coin::CoinMetadata<T0>, arg2: vector<u8>) {
        let v0 = if (0x1::vector::length<u8>(&arg2) > 0) {
            0x2::address::from_bytes(0x2::hash::keccak256(&arg2))
        } else {
            @0x0
        };
        let v1 = InitMctpLogged{
            coin_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_metadata       : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            amount_in_initial   : arg0,
            custom_payload_raw  : arg2,
            custom_payload_hash : v0,
        };
        0x2::event::emit<InitMctpLogged>(v1);
    }

    public fun prepare_initialize_order<T0>(arg0: u8, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u16, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: u8, arg12: u32, arg13: u64) : InitOrderTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg2) >= arg13, 4);
        InitOrderTicket<T0>{
            payload_type   : arg0,
            trader         : arg1,
            input_funds    : arg2,
            addr_dest      : arg3,
            chain_dest     : arg4,
            domain_dest    : arg12,
            token_out      : arg5,
            amount_out_min : arg6,
            gas_drop       : arg7,
            fee_redeem     : arg8,
            deadline       : arg9,
            addr_ref       : arg10,
            fee_rate_ref   : arg11,
        }
    }

    public fun publish_init_order(arg0: &mut 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::State, arg1: CctpBurnRequestInitOrder, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert!(!0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::is_paused(arg0), 0);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::assert_valid_version(arg0);
        let CctpBurnRequestInitOrder {
            domain_dest    : v0,
            mint_recipient : v1,
            burn_token     : v2,
            amount_in      : v3,
            caller         : v4,
            payload_type   : v5,
            trader         : v6,
            chain_source   : v7,
            token_in       : v8,
            addr_dest      : v9,
            chain_dest     : v10,
            token_out      : v11,
            amount_out_min : v12,
            gas_drop       : v13,
            fee_redeem     : v14,
            deadline       : v15,
            addr_ref       : v16,
            fee_rate_ref   : v17,
            fee_rate_mayan : v18,
            cctp_domain    : v19,
        } = arg1;
        let v20 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(arg2);
        let v21 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::from_bytes(&v20);
        assert!(v0 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(arg2), 2);
        assert!(v1 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::mint_recipient(&v21), 2);
        assert!(v2 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::burn_token(&v21), 2);
        assert!(v3 == (0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::amount(&v21) as u64), 2);
        assert!(v4 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(arg2), 2);
        let v22 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::swap_order::new(v5, v6, v7, v2, v3, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg2), v19);
        let v23 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::swap_order::to_hash(&v22);
        let v24 = OrderCreated{
            trader         : v6,
            token_in       : v8,
            amount_in      : v3,
            addr_dest      : v9,
            chain_dest     : v10,
            token_out      : v11,
            amount_out_min : v12,
            gas_drop       : v13,
            fee_redeem     : v14,
            deadline       : v15,
            addr_ref       : v16,
            fee_rate_ref   : v17,
            fee_rate_mayan : v18,
            cctp_nonce     : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg2),
            domain_dest    : v0,
            hash           : v23,
        };
        0x2::event::emit<OrderCreated>(v24);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::borrow_mut_emitter_cap(arg0), 0, 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::serialize(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::new(v23)))
    }

    // decompiled from Move bytecode v6
}

