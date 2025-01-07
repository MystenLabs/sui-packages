module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::fulfill_swap {
    struct SwapPreparedToFulfill has copy, drop {
        hash: address,
        vaa_init_sequence: u64,
        vaa_auction_sequence: u64,
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

    public fun complete_fulfill_swap<T0>(arg0: &0xac779469c33eb0c129997fbaa17d872464d1329850dd974e91ffc78e4e205a35::state::FeeManagerState, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: FulfillReceipt, arg4: &mut 0x2::tx_context::TxContext) {
        let FulfillReceipt {
            hash            : v0,
            token_out       : v1,
            amount_promised : v2,
            addr_dest       : v3,
            addr_ref        : v4,
            fee_rate_ref    : v5,
            fee_rate_mayan  : v6,
        } = arg3;
        let v7 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        assert!(0x2::object::id_to_address(&v7) == v1, 8);
        let v8 = 0x2::coin::value<T0>(&arg1);
        let v9 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::bps(v8, (v5 as u16));
        let v10 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::bps(v8, (v6 as u16));
        let v11 = v8 - v9 - v10;
        assert!(v11 >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::denormalize_amount(v2, 0x2::coin::get_decimals<T0>(arg2)), 0);
        let v12 = 0x2::coin::into_balance<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v12, v9, arg4), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v12, v10, arg4), 0xac779469c33eb0c129997fbaa17d872464d1329850dd974e91ffc78e4e205a35::state::get_fee_collector(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg4), v3);
        let v13 = SwapFulfilled{
            hash       : v0,
            token_out  : v1,
            amount_net : v11,
            coin_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<SwapFulfilled>(v13);
    }

    public fun prepare_fulfill_swap<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::FundsReceiver, arg4: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg5: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg9: address, arg10: address, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, FulfillReceipt) {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg4);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_mctp_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg4));
        let (v3, v4, v5) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg5);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_auction_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v4), v3);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::consume_vaa(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::digest(&arg5));
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18) = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::auction_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::auction_message::deserialize(v5));
        assert!(v6 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 5);
        assert!(v8 == 0x2::tx_context::sender(arg14), 6);
        let v19 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::swap_order::new(arg9, v0, arg10, arg11, v7, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), v9, arg12, v11, v16, v15, v12, v13, v14, v18, v17);
        let v20 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::init_swap_message::unpack(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::init_swap_message::deserialize(v2));
        assert!(v20 == 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::swap_order::to_hash(&v19), 2);
        assert!(v15 > 0x2::clock::timestamp_ms(arg13) / 1000, 3);
        assert!(v17 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 4);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_nonce_used(arg1, v17, v18), 0);
        assert!(!0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_mayan_used_nonce(arg0, v17, v18), 7);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::mark_mayan_nonce_used(arg0, v17, v18);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::verify_local_token_coin_type<T0>(arg2, v17, arg10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::amount::denormalize_amount(v11, 0x2::coin::get_decimals<0x2::sui::SUI>(arg7)), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v7);
        let v21 = 0x2::coin::into_balance<T0>(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::receive_minted_funds<T0>(arg3, arg11, arg8));
        let v22 = SwapPreparedToFulfill{
            hash                 : v20,
            vaa_init_sequence    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg4),
            vaa_auction_sequence : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg5),
            amount_net           : 1000,
        };
        0x2::event::emit<SwapPreparedToFulfill>(v22);
        let v23 = FulfillReceipt{
            hash            : v20,
            token_out       : v9,
            amount_promised : v10,
            addr_dest       : v7,
            addr_ref        : v12,
            fee_rate_ref    : v13,
            fee_rate_mayan  : v14,
        };
        (0x2::coin::take<T0>(&mut v21, v16, arg14), 0x2::coin::from_balance<T0>(v21, arg14), v23)
    }

    // decompiled from Move bytecode v6
}

