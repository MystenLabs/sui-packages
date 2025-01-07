module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::bridge_lock_fee {
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

    public fun bridge_lock_fee<T0: drop>(arg0: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg1: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg2: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg3: &0x2::deny_list::DenyList, arg4: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: u64, arg8: u64, arg9: u32, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::is_paused(arg0), 0);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 >= arg7, 1);
        assert!(arg9 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg1), 2);
        let v1 = 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::get_cctp_mayan_recipient(arg0, arg9);
        let v2 = 0x2::coin::into_balance<T0>(arg5);
        let (_, v4) = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn::deposit_for_burn_with_caller<T0>(0x2::coin::take<T0>(&mut v2, v0 - arg7, arg11), arg9, v1, v1, arg2, arg1, arg3, arg4, arg11);
        let v5 = v4;
        let v6 = BridgeSubmittedLockedFee{
            cctp_nonce       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v5),
            dest_domain      : arg9,
            amount_bridged   : v0,
            fee_redeem       : arg7,
            gas_drop         : arg8,
            coin_metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg6),
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            locked_fee_id    : 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::lock_fee_redeem<T0>(arg0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v5), arg10, arg8, v2, arg11),
            addr_dest        : arg10,
        };
        0x2::event::emit<BridgeSubmittedLockedFee>(v6);
    }

    // decompiled from Move bytecode v6
}

