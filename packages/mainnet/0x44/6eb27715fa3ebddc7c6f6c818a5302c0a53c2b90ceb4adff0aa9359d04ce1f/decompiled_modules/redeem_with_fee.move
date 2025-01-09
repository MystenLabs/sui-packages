module 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::redeem_with_fee {
    struct BridgeRedeemedWithFee has copy, drop {
        vaa_sequence: u64,
        cctp_nonce: u64,
        cctp_source_domain: u32,
    }

    struct DestCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct DestCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct RedeemWithFeeReceipt<phantom T0> {
        payload_type: u8,
        addr_dest: address,
        relayer_funds: 0x2::coin::Coin<T0>,
        funds: 0x2::coin::Coin<T0>,
        gas_drop: 0x2::coin::Coin<0x2::sui::SUI>,
        custom_payload_hash: address,
    }

    public fun redeem_with_fee<T0: drop>(arg0: &mut 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: u8, arg8: u64, arg9: u64, arg10: address, arg11: u64, arg12: u32, arg13: u64, arg14: address, arg15: address, arg16: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg17: &mut 0x2::tx_context::TxContext) : RedeemWithFeeReceipt<T0> {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let v3 = 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::bwf_message::new(arg7, arg11, arg12, arg10, arg8, arg9, arg13, arg14, arg15);
        assert!(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::bwf_message::to_hash(&v3) == 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::vaa_message::unpack(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::vaa_message::deserialize(v2)), 6);
        assert!(arg12 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 3);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg1, arg12, arg11), 0);
        assert!(!0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::is_mayan_used_nonce(arg0, arg12, arg11), 2);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::verify_local_token_coin_type<T0>(arg2, arg12, arg14);
        let v4 = 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::receive_minted_funds<T0>(arg3, arg13, arg16);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::mark_mayan_nonce_used(arg0, arg12, arg11);
        let v5 = BridgeRedeemedWithFee{
            vaa_sequence       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            cctp_nonce         : arg11,
            cctp_source_domain : arg12,
        };
        0x2::event::emit<BridgeRedeemedWithFee>(v5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::denormalize_amount(arg8, 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 1);
        RedeemWithFeeReceipt<T0>{
            payload_type        : arg7,
            addr_dest           : arg10,
            relayer_funds       : 0x2::coin::split<T0>(&mut v4, arg9, arg17),
            funds               : v4,
            gas_drop            : arg5,
            custom_payload_hash : arg15,
        }
    }

    public fun complete_redeem_with_fee_simple<T0>(arg0: &0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: RedeemWithFeeReceipt<T0>) : 0x2::coin::Coin<T0> {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let RedeemWithFeeReceipt {
            payload_type        : v0,
            addr_dest           : v1,
            relayer_funds       : v2,
            funds               : v3,
            gas_drop            : v4,
            custom_payload_hash : _,
        } = arg1;
        assert!(v0 == 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::bwf_message::bwf_message_payload_type_default(), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1);
        v2
    }

    public fun complete_redeem_with_fee_with_payload<T0: drop>(arg0: RedeemWithFeeReceipt<T0>, arg1: &DestCap) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>, address) {
        let RedeemWithFeeReceipt {
            payload_type        : v0,
            addr_dest           : v1,
            relayer_funds       : v2,
            funds               : v3,
            gas_drop            : v4,
            custom_payload_hash : v5,
        } = arg0;
        assert!(v0 != 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::bwf_message::bwf_message_payload_type_custom(), 4);
        let v6 = 0x2::object::id<DestCap>(arg1);
        assert!(0x2::object::id_to_address(&v6) == v1, 5);
        (v2, v3, v4, v5)
    }

    public fun destroy_dest_cap(arg0: &0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: DestCap) {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let v0 = DestCapDestroyed{cap_id: 0x2::object::id<DestCap>(&arg1)};
        0x2::event::emit<DestCapDestroyed>(v0);
        let DestCap { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    public fun get_redeem_receipt_addr_dest<T0>(arg0: &RedeemWithFeeReceipt<T0>) : address {
        arg0.addr_dest
    }

    public fun get_redeem_receipt_custom_payload_hash<T0>(arg0: &RedeemWithFeeReceipt<T0>) : address {
        arg0.custom_payload_hash
    }

    public fun get_redeem_receipt_funds_value<T0>(arg0: &RedeemWithFeeReceipt<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.funds)
    }

    public fun get_redeem_receipt_gas_drop_value<T0>(arg0: &RedeemWithFeeReceipt<T0>) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.gas_drop)
    }

    public fun get_redeem_receipt_payload_type<T0>(arg0: &RedeemWithFeeReceipt<T0>) : u8 {
        arg0.payload_type
    }

    public fun get_redeem_receipt_relayer_funds_value<T0>(arg0: &RedeemWithFeeReceipt<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.relayer_funds)
    }

    public fun new_dest_cap(arg0: &0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: &mut 0x2::tx_context::TxContext) : DestCap {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let v0 = DestCap{id: 0x2::object::new(arg1)};
        let v1 = DestCapCreated{cap_id: 0x2::object::id<DestCap>(&v0)};
        0x2::event::emit<DestCapCreated>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

