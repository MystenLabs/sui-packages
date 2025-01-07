module 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::bridge_with_fee {
    struct BridgeSubmittedWithFee has copy, drop {
        payload_type: u8,
        cctp_nonce: u64,
        dest_domain: u32,
        amount_bridged: u64,
        fee_redeem: u64,
        gas_drop: u64,
        addr_dest: address,
        coin_metadata_id: address,
        custom_payload_hash: address,
        payload: vector<u8>,
    }

    struct BridgeWithFeeTicket<phantom T0> {
        payload_type: u8,
        input_funds: 0x2::coin::Coin<T0>,
        addr_dest: address,
        domain_dest: u32,
        gas_drop: u64,
        fee_redeem: u64,
        payload: vector<u8>,
    }

    struct CctpBurnRequestBridgeWithFee {
        domain_dest: u32,
        mint_recipient: address,
        burn_token: address,
        amount_in: u64,
        caller: address,
        payload_type: u8,
        cctp_domain: u32,
        addr_dest: address,
        gas_drop: u64,
        fee_redeem: u64,
        token_in: address,
        payload: vector<u8>,
    }

    struct CircleAuth has drop {
        dummy_field: bool,
    }

    public fun bridge_with_fee<T0: drop>(arg0: &mut 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::State, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::coin::CoinMetadata<T0>, arg3: BridgeWithFeeTicket<T0>) : (CctpBurnRequestBridgeWithFee, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::DepositForBurnWithCallerTicket<T0, CircleAuth>) {
        assert!(!0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::is_paused(arg0), 0);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::assert_valid_version(arg0);
        let BridgeWithFeeTicket {
            payload_type : v0,
            input_funds  : v1,
            addr_dest    : v2,
            domain_dest  : v3,
            gas_drop     : v4,
            fee_redeem   : v5,
            payload      : v6,
        } = arg3;
        let v7 = v1;
        let v8 = 0x2::coin::value<T0>(&v7);
        assert!(v8 >= v5, 1);
        assert!(v3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 2);
        let v9 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v10 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::get_cctp_mayan_recipient(arg0, v3, 0x2::object::id_to_address(&v9));
        let v11 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::get_cctp_mayan_caller(arg0, v3);
        let v12 = CircleAuth{dummy_field: false};
        let v13 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        let v14 = CctpBurnRequestBridgeWithFee{
            domain_dest    : v3,
            mint_recipient : v10,
            burn_token     : 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::token_utils::calculate_token_id<T0>(),
            amount_in      : v8,
            caller         : v11,
            payload_type   : v0,
            cctp_domain    : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1),
            addr_dest      : v2,
            gas_drop       : v4,
            fee_redeem     : v5,
            token_in       : 0x2::object::id_to_address(&v13),
            payload        : v6,
        };
        (v14, 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, CircleAuth>(v12, v7, v3, v10, v11))
    }

    public fun prepare_bridge_with_fee<T0>(arg0: u8, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u32, arg5: u64, arg6: u64, arg7: vector<u8>) : BridgeWithFeeTicket<T0> {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 3);
        BridgeWithFeeTicket<T0>{
            payload_type : arg0,
            input_funds  : arg1,
            addr_dest    : arg3,
            domain_dest  : arg4,
            gas_drop     : arg5,
            fee_redeem   : arg6,
            payload      : arg7,
        }
    }

    public fun publish_bridge_with_fee(arg0: &mut 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::State, arg1: CctpBurnRequestBridgeWithFee, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::Message) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert!(!0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::is_paused(arg0), 0);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::assert_valid_version(arg0);
        let CctpBurnRequestBridgeWithFee {
            domain_dest    : v0,
            mint_recipient : v1,
            burn_token     : v2,
            amount_in      : v3,
            caller         : v4,
            payload_type   : v5,
            cctp_domain    : v6,
            addr_dest      : v7,
            gas_drop       : v8,
            fee_redeem     : v9,
            token_in       : v10,
            payload        : v11,
        } = arg1;
        let v12 = v11;
        let v13 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(arg2);
        let v14 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::from_bytes(&v13);
        assert!(v0 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(arg2), 4);
        assert!(v1 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::mint_recipient(&v14), 4);
        assert!(v2 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::burn_token(&v14), 4);
        assert!(v3 == (0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::burn_message::amount(&v14) as u64), 4);
        assert!(v4 == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(arg2), 4);
        let v15 = if (0x1::vector::length<u8>(&v12) > 0) {
            assert!(v5 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::bwf_message::bwf_message_payload_type_custom(), 5);
            0x2::address::from_bytes(0x2::hash::keccak256(&v12))
        } else {
            assert!(v5 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::bwf_message::bwf_message_payload_type_default(), 5);
            @0x0
        };
        let v16 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::bwf_message::new(v5, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg2), v6, v7, v8, v9, v3, v2, v15);
        let v17 = BridgeSubmittedWithFee{
            payload_type        : v5,
            cctp_nonce          : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(arg2),
            dest_domain         : v0,
            amount_bridged      : v3,
            fee_redeem          : v9,
            gas_drop            : v8,
            addr_dest           : v7,
            coin_metadata_id    : v10,
            custom_payload_hash : v15,
            payload             : v12,
        };
        0x2::event::emit<BridgeSubmittedWithFee>(v17);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::borrow_mut_emitter_cap(arg0), 0, 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::serialize(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::new(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::bwf_message::to_hash(&v16))))
    }

    // decompiled from Move bytecode v6
}

