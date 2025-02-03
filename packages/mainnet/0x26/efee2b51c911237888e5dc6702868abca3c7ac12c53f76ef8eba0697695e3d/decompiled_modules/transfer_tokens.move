module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens {
    struct TransferTicket<phantom T0> {
        asset_info: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>,
        bridged_in: 0x2::balance::Balance<T0>,
        norm_amount: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount,
        recipient_chain: u16,
        recipient: vector<u8>,
        relayer_fee: u64,
        nonce: u32,
    }

    public fun transfer_tokens<T0>(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: TransferTicket<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        let (v1, v2) = bridge_in_and_serialize_transfer<T0>(&v0, arg0, arg1);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::prepare_wormhole_message(&v0, arg0, v1, v2)
    }

    fun bridge_in_and_serialize_transfer<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: TransferTicket<T0>) : (u32, vector<u8>) {
        let TransferTicket {
            asset_info      : v0,
            bridged_in      : v1,
            norm_amount     : v2,
            recipient_chain : v3,
            recipient       : v4,
            relayer_fee     : v5,
            nonce           : v6,
        } = arg2;
        let v7 = v1;
        let v8 = v0;
        assert!(v5 <= 0x2::balance::value<T0>(&v7), 0);
        let (v9, v10) = burn_or_deposit_funds<T0>(arg0, arg1, &v8, v7);
        (v6, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer::serialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer::new(v2, v10, v9, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(v4)), v3, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::from_raw(v5, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&v8)))))
    }

    public(friend) fun burn_or_deposit_funds<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg3: 0x2::balance::Balance<T0>) : (u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        if (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::is_wrapped<T0>(arg2)) {
            0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::wrapped_asset::burn<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::borrow_mut_wrapped<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_token_registry(arg0, arg1)), arg3);
        } else {
            0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::native_asset::deposit<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::borrow_mut_native<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_token_registry(arg0, arg1)), arg3);
        };
        (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_chain<T0>(arg2), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_address<T0>(arg2))
    }

    public fun prepare_transfer<T0>(arg0: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u16, arg3: vector<u8>, arg4: u64, arg5: u32) : (TransferTicket<T0>, 0x2::coin::Coin<T0>) {
        let v0 = &mut arg1;
        let (v1, v2) = take_truncated_amount<T0>(&arg0, v0);
        let v3 = TransferTicket<T0>{
            asset_info      : arg0,
            bridged_in      : v1,
            norm_amount     : v2,
            recipient_chain : arg2,
            recipient       : arg3,
            relayer_fee     : arg4,
            nonce           : arg5,
        };
        (v3, arg1)
    }

    public(friend) fun take_truncated_amount<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg1: &mut 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount) {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(arg0);
        let v1 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::from_raw(0x2::coin::value<T0>(arg1), v0);
        (0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(v1, v0)), v1)
    }

    // decompiled from Move bytecode v6
}

