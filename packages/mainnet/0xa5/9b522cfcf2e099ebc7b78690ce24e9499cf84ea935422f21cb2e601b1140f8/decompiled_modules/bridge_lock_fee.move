module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::bridge_lock_fee {
    struct BridgeSubmittedLockedFee has copy, drop {
        cctp_nonce: u64,
        dest_domain: u32,
        amount_bridged: u64,
        fee_redeem: u64,
        gas_drop: u64,
        coin_metadata_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        locked_fee_id: address,
        addr_dest: address,
    }

    public fun bridge_lock_fee<T0: drop>(arg0: &mut 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: u64, arg8: u64, arg9: u32, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::is_paused(arg0), 0);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= arg7, 1);
        assert!(arg9 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 2);
        assert!(arg9 != 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::solana_cctp_domain(), 3);
        let v1 = 0x2::coin::into_balance<T0>(arg5);
        let (_, v3) = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn::deposit_for_burn_with_caller<T0>(0x2::coin::take<T0>(&mut v1, v0 - arg7, arg11), arg9, arg10, 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::get_cctp_mayan_caller(arg0, arg9), arg2, arg1, arg3, arg4, arg11);
        let v4 = v3;
        let v5 = BridgeSubmittedLockedFee{
            cctp_nonce       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v4),
            dest_domain      : arg9,
            amount_bridged   : v0,
            fee_redeem       : arg7,
            gas_drop         : arg8,
            coin_metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg6),
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            locked_fee_id    : 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::lock_fee_redeem<T0>(arg0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v4), arg10, arg8, v1, arg11),
            addr_dest        : arg10,
        };
        0x2::event::emit<BridgeSubmittedLockedFee>(v5);
    }

    // decompiled from Move bytecode v6
}

