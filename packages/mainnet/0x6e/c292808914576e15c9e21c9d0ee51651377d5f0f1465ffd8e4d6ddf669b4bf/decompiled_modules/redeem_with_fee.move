module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::redeem_with_fee {
    struct BridgeRedeemedWithFee has copy, drop {
        vaa_sequence: u64,
        cctp_nonce: u64,
        cctp_domain: u32,
    }

    public fun redeem_with_fee<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4) = redeem_with_fee_shared<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v5 = v4;
        assert!(0x1::option::is_none<vector<u8>>(&v5), 4);
        let v6 = 0x2::coin::into_balance<T0>(v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::denormalize_amount(v2, 0x2::coin::get_decimals<0x2::sui::SUI>(arg6)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg8), v1);
        0x2::coin::take<T0>(&mut v6, v3, arg8)
    }

    fun redeem_with_fee_shared<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : (0x2::coin::Coin<T0>, address, u64, u64, 0x1::option::Option<vector<u8>>) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        let (v3, v4, v5, v6, v7, v8, v9, v10) = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::bwf_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::bwf_message::deserialize(v2));
        assert!(v4 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 3);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_nonce_used(arg1, v4, v3), 0);
        assert!(!0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_mayan_used_nonce(arg0, v4, v3), 2);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_local_token_coin_type<T0>(arg2, v4, v9);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::mark_mayan_nonce_used(arg0, v4, v3);
        let v11 = BridgeRedeemedWithFee{
            vaa_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            cctp_nonce   : v3,
            cctp_domain  : v4,
        };
        0x2::event::emit<BridgeRedeemedWithFee>(v11);
        (0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::receive_minted_funds<T0>(arg3, v8, arg5), v5, v6, v7, v10)
    }

    public fun redeem_with_fee_with_payload<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap) : (0x2::coin::Coin<T0>, vector<u8>) {
        let (v0, v1, _, _, v4) = redeem_with_fee_shared<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v5 = v4;
        assert!(0x1::option::is_some<vector<u8>>(&v5), 4);
        let v6 = 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(arg6);
        assert!(0x2::object::id_to_address(&v6) == v1, 5);
        (v0, 0x1::option::destroy_some<vector<u8>>(v5))
    }

    // decompiled from Move bytecode v6
}

