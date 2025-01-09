module 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::fulfill_swap {
    struct SwapPreparedToFulfill has copy, drop {
        hash: address,
        vaa_auction_sequence: u64,
        cctp_nonce: u64,
        cctp_source_domain: u32,
        amount_net: u64,
    }

    struct SwapFulfilled has copy, drop {
        hash: address,
        token_out: address,
        amount_net: u64,
        coin_type: 0x1::ascii::String,
    }

    struct FulfillReceipt {
        hash: address,
        token_out: address,
        amount_promised: u64,
        addr_dest: address,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
    }

    public fun complete_fulfill_swap<T0>(arg0: &0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: &0x6e2508e57bad200438dc53ad01d2ae3b6a144f1b6971eb75bce2ad9de2b47e84::state::FeeManagerState, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: FulfillReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let FulfillReceipt {
            hash            : v0,
            token_out       : v1,
            amount_promised : v2,
            addr_dest       : v3,
            addr_ref        : v4,
            fee_rate_ref    : v5,
            fee_rate_mayan  : v6,
        } = arg4;
        let v7 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3);
        assert!(0x2::object::id_to_address(&v7) == v1, 6);
        let v8 = 0x2::coin::get_decimals<T0>(arg3);
        assert!(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::normalize_amount(0x2::coin::value<T0>(&arg2), v8) >= v2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::denormalize_amount(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::bps(v2, (v5 as u16)), v8), arg5), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::denormalize_amount(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::bps(v2, (v6 as u16)), v8), arg5), 0x6e2508e57bad200438dc53ad01d2ae3b6a144f1b6971eb75bce2ad9de2b47e84::state::get_fee_collector(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v3);
        let v9 = SwapFulfilled{
            hash       : v0,
            token_out  : v1,
            amount_net : 0x2::coin::value<T0>(&arg2),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<SwapFulfilled>(v9);
    }

    public fun prepare_fulfill_swap<T0: drop>(arg0: &mut 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg8: u16, arg9: address, arg10: u64, arg11: address, arg12: address, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: address, arg18: u8, arg19: u8, arg20: u64, arg21: u32, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, FulfillReceipt) {
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::verify_auction_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let v3 = 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::vaa_message::unpack(0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::vaa_message::deserialize(v2));
        let v4 = 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::auction_message::new(arg9, arg10, arg11, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, 0x2::tx_context::sender(arg23));
        assert!(v3 == 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::auction_message::to_hash(&v4), 2);
        assert!(arg16 > 0x2::clock::timestamp_ms(arg22) / 1000, 3);
        assert!(arg21 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 4);
        assert!(arg8 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 8);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg1, arg21, arg20), 0);
        assert!(!0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::is_mayan_used_nonce(arg0, arg21, arg20), 5);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::mark_mayan_nonce_used(arg0, arg21, arg20);
        0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::verify_local_token_coin_type<T0>(arg2, arg21, arg9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::amount::denormalize_amount(arg14, 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg11);
        let v5 = 0x446eb27715fa3ebddc7c6f6c818a5302c0a53c2b90ceb4adff0aa9359d04ce1f::state::receive_minted_funds<T0>(arg3, arg10, arg7);
        let v6 = SwapPreparedToFulfill{
            hash                 : v3,
            vaa_auction_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            cctp_nonce           : arg20,
            cctp_source_domain   : arg21,
            amount_net           : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<SwapPreparedToFulfill>(v6);
        let v7 = FulfillReceipt{
            hash            : v3,
            token_out       : arg12,
            amount_promised : arg13,
            addr_dest       : arg11,
            addr_ref        : arg17,
            fee_rate_ref    : arg18,
            fee_rate_mayan  : arg19,
        };
        (0x2::coin::split<T0>(&mut v5, arg15, arg23), v5, v7)
    }

    // decompiled from Move bytecode v6
}

