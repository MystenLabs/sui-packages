module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::refund {
    struct OrderRefunded has copy, drop {
        hash: address,
        vaa_sequence: u64,
    }

    public fun refund_swap<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg8: address, arg9: address, arg10: u64, arg11: address, arg12: address, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: address, arg18: u8, arg19: u8, arg20: u64, arg21: u32, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let v3 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::swap_order::new(arg8, v0, arg9, arg10, arg11, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21);
        let v4 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::swap_order::to_hash(&v3);
        assert!(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::init_swap_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::init_swap_message::deserialize(v2)) == v4, 2);
        assert!(arg16 <= 0x2::clock::timestamp_ms(arg22) / 1000, 3);
        assert!(arg21 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 5);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_nonce_used(arg1, arg21, arg20), 0);
        assert!(!0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_mayan_used_nonce(arg0, arg21, arg20), 4);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_local_token_coin_type<T0>(arg2, arg21, arg9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::denormalize_amount(arg14, 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg11);
        let v5 = 0x2::coin::into_balance<T0>(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::receive_minted_funds<T0>(arg3, arg10, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg23), arg11);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::mark_mayan_nonce_used(arg0, arg21, arg20);
        let v6 = OrderRefunded{
            hash         : v4,
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
        };
        0x2::event::emit<OrderRefunded>(v6);
        0x2::coin::take<T0>(&mut v5, arg15, arg23)
    }

    // decompiled from Move bytecode v6
}

