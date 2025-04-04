module 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::fulfill_swap {
    struct SwapPreparedToFulfill has copy, drop {
        hash: address,
        vaa_init_sequence: u64,
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

    public fun complete_fulfill_swap<T0>(arg0: &0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::State, arg1: &0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::state::FeeManagerState, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: FulfillReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::assert_valid_version(arg0);
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
        assert!(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::normalize_amount(0x2::coin::value<T0>(&arg2), v8) >= v2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::denormalize_amount(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::bps(v2, (v5 as u16)), v8), arg5), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::denormalize_amount(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::bps(v2, (v6 as u16)), v8), arg5), 0xa78bf5adc9b7a2b6a71eea973ca3e9a1c2a185a732f740a7a0a67e4f5bf783c6::state::get_fee_collector(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v3);
        let v9 = SwapFulfilled{
            hash       : v0,
            token_out  : v1,
            amount_net : 0x2::coin::value<T0>(&arg2),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<SwapFulfilled>(v9);
    }

    public fun prepare_fulfill_swap<T0: drop>(arg0: &mut 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg9: u8, arg10: address, arg11: u16, arg12: address, arg13: u64, arg14: address, arg15: address, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: address, arg21: u8, arg22: u8, arg23: u64, arg24: u32, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, FulfillReceipt) {
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let (v3, v4, v5) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg5);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::verify_auction_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v4), v3);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg5));
        let v6 = 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::swap_order::new(arg9, arg10, arg11, arg12, arg13, arg14, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        assert!(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::vaa_message::unpack(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::vaa_message::deserialize(v2)) == 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::swap_order::to_hash(&v6), 2);
        let v7 = 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::vaa_message::unpack(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::vaa_message::deserialize(v5));
        let v8 = 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::auction_message::new(arg14, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, 0x2::tx_context::sender(arg26));
        assert!(v7 == 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::auction_message::to_hash(&v8), 2);
        assert!(arg19 > 0x2::clock::timestamp_ms(arg25) / 1000, 3);
        assert!(arg24 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 4);
        assert!(arg11 != 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 8);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg1, arg24, arg23), 0);
        assert!(!0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::is_mayan_used_nonce(arg0, arg24, arg23), 5);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::mark_mayan_nonce_used(arg0, arg24, arg23);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::verify_local_token_coin_type<T0>(arg2, arg24, arg12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::amount::denormalize_amount(arg17, 0x2::coin::get_decimals<0x2::sui::SUI>(arg7)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg14);
        let v9 = 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::receive_minted_funds<T0>(arg3, arg13, arg8);
        let v10 = SwapPreparedToFulfill{
            hash                 : v7,
            vaa_init_sequence    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            vaa_auction_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg5),
            cctp_nonce           : arg23,
            cctp_source_domain   : arg24,
            amount_net           : 0x2::coin::value<T0>(&v9),
        };
        0x2::event::emit<SwapPreparedToFulfill>(v10);
        let v11 = FulfillReceipt{
            hash            : v7,
            token_out       : arg15,
            amount_promised : arg16,
            addr_dest       : arg14,
            addr_ref        : arg20,
            fee_rate_ref    : arg21,
            fee_rate_mayan  : arg22,
        };
        (0x2::coin::split<T0>(&mut v9, arg18, arg26), v9, v11)
    }

    // decompiled from Move bytecode v6
}

