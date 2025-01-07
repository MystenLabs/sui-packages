module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::init_swap {
    struct SwapCreated has copy, drop {
        trader: address,
        token_in: address,
        amount_in: u64,
        amount_in_min: u64,
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
        coin_type: 0x1::ascii::String,
    }

    public fun init_swap<T0: drop>(arg0: &mut 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State, arg1: &0xac779469c33eb0c129997fbaa17d872464d1329850dd974e91ffc78e4e205a35::state::FeeManagerState, arg2: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg4: &0x2::deny_list::DenyList, arg5: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: u64, arg9: address, arg10: address, arg11: u16, arg12: u32, arg13: address, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: address, arg19: u8, arg20: &mut 0x2::tx_context::TxContext) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        assert!(!0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::is_paused(arg0), 0);
        assert!(0x2::coin::value<T0>(&arg6) >= arg8, 3);
        assert!(arg12 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2), 2);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg7);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0xac779469c33eb0c129997fbaa17d872464d1329850dd974e91ffc78e4e205a35::calculate_fee_rate::calculate_fee(arg1, 20, arg13, arg11, v1, arg14, 0x2::coin::value<T0>(&arg6), arg18, arg19);
        assert!(arg19 <= 50, 5);
        assert!(v2 <= 50, 4);
        if (arg18 == @0x0) {
            assert!(arg19 == 0, 5);
        };
        let v3 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg7);
        let (v4, v5) = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn::deposit_for_burn_with_caller<T0>(arg6, arg12, 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::get_cctp_mayan_recipient(arg0, arg12, 0x2::object::id_to_address(&v3)), 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::get_cctp_mayan_caller(arg0, arg12), arg3, arg2, arg4, arg5, arg20);
        let v6 = v5;
        let v7 = v4;
        let v8 = (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::amount(&v7) as u64);
        assert!(v8 > arg16, 1);
        let v9 = 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::swap_order::new(arg9, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), v1, v8, arg10, arg11, arg13, arg14, arg15, arg16, arg17, arg18, arg19, v2, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v6), 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2));
        let v10 = 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::swap_order::to_hash(&v9);
        let v11 = SwapCreated{
            trader         : arg9,
            token_in       : v1,
            amount_in      : v8,
            amount_in_min  : arg8,
            addr_dest      : arg10,
            chain_dest     : arg11,
            token_out      : arg13,
            amount_out_min : arg14,
            gas_drop       : arg15,
            fee_redeem     : arg16,
            deadline       : arg17,
            addr_ref       : arg18,
            fee_rate_ref   : arg19,
            fee_rate_mayan : v2,
            cctp_nonce     : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v6),
            domain_dest    : arg12,
            hash           : v10,
            coin_type      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<SwapCreated>(v11);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::borrow_mut_emitter_cap(arg0), 0, 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::init_swap_message::serialize(0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::init_swap_message::new(v10)))
    }

    // decompiled from Move bytecode v6
}

