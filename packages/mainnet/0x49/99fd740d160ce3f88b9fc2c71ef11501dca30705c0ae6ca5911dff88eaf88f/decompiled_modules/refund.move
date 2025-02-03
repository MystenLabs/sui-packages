module 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::refund {
    struct OrderRefunded has copy, drop {
        hash: address,
        vaa_sequence: u64,
        cctp_nonce: u64,
        cctp_source_domain: u32,
    }

    public fun refund_swap<T0: drop>(arg0: &mut 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::State, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg3: &mut 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg8: u8, arg9: address, arg10: address, arg11: u64, arg12: address, arg13: address, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: address, arg19: u8, arg20: u8, arg21: u64, arg22: u32, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::assert_valid_version(arg0);
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let v3 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::unpack(0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::vaa_message::deserialize(v2));
        let v4 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::swap_order::new(arg8, arg9, v0, arg10, arg11, arg12, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        assert!(v3 == 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::swap_order::to_hash(&v4), 2);
        assert!(arg17 <= 0x2::clock::timestamp_ms(arg23) / 1000, 3);
        assert!(arg22 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg1), 5);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg1, arg22, arg21), 0);
        assert!(!0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::is_mayan_used_nonce(arg0, arg22, arg21), 4);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::verify_local_token_coin_type<T0>(arg2, arg22, arg10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::amount::denormalize_amount(arg15, 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg12);
        let v5 = 0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::receive_minted_funds<T0>(arg3, arg11, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg12);
        0x4999fd740d160ce3f88b9fc2c71ef11501dca30705c0ae6ca5911dff88eaf88f::state::mark_mayan_nonce_used(arg0, arg22, arg21);
        let v6 = OrderRefunded{
            hash               : v3,
            vaa_sequence       : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            cctp_nonce         : arg21,
            cctp_source_domain : arg22,
        };
        0x2::event::emit<OrderRefunded>(v6);
        0x2::coin::split<T0>(&mut v5, arg16, arg24)
    }

    // decompiled from Move bytecode v6
}

