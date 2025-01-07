module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::bridge_with_fee {
    struct PrepareBridgeTouched has copy, drop {
        coin_type: 0x1::ascii::String,
        coin_metadata: 0x2::object::ID,
        amount_in_initial: u64,
    }

    struct BridgeSubmittedWithFee has copy, drop {
        cctp_nonce: u64,
        dest_domain: u32,
        amount_bridged: u64,
        fee_redeem: u64,
        gas_drop: u64,
        addr_dest: address,
        coin_metadata_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        payload: vector<u8>,
    }

    public fun bridge_with_fee<T0: drop>(arg0: &mut 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: u64, arg8: u64, arg9: u64, arg10: u32, arg11: address, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert!(!0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::is_paused(arg0), 0);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= arg7, 3);
        assert!(v0 >= arg8, 1);
        assert!(arg10 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 2);
        let v1 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg6);
        let (v2, v3) = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn::deposit_for_burn_with_caller<T0>(arg5, arg10, 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::get_cctp_mayan_recipient(arg0, arg10, 0x2::object::id_to_address(&v1)), 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::get_cctp_mayan_caller(arg0, arg10), arg2, arg1, arg3, arg4, arg13);
        let v4 = v3;
        let v5 = v2;
        let v6 = BridgeSubmittedWithFee{
            cctp_nonce       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v4),
            dest_domain      : arg10,
            amount_bridged   : v0,
            fee_redeem       : arg8,
            gas_drop         : arg9,
            addr_dest        : arg11,
            coin_metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg6),
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            payload          : arg12,
        };
        0x2::event::emit<BridgeSubmittedWithFee>(v6);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::borrow_mut_emitter_cap(arg0), 0, 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::bwf_message::serialize(0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::bwf_message::new(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v4), 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), arg11, arg9, arg8, (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::amount(&v5) as u64), 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::burn_token(&v5), 0x1::option::some<vector<u8>>(arg12))))
    }

    public fun prepare_initialize_bridge<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &0x2::coin::CoinMetadata<T0>) {
        let v0 = PrepareBridgeTouched{
            coin_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_metadata     : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1),
            amount_in_initial : 0x2::coin::value<T0>(arg0),
        };
        0x2::event::emit<PrepareBridgeTouched>(v0);
    }

    // decompiled from Move bytecode v6
}

