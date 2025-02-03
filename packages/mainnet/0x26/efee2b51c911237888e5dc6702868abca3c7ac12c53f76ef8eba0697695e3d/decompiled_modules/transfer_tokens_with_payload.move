module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload {
    struct TransferTicket<phantom T0> {
        asset_info: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>,
        bridged_in: 0x2::balance::Balance<T0>,
        norm_amount: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount,
        sender: 0x2::object::ID,
        redeemer_chain: u16,
        redeemer: vector<u8>,
        payload: vector<u8>,
        nonce: u32,
    }

    public fun transfer_tokens_with_payload<T0>(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: TransferTicket<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        let (v1, v2) = bridge_in_and_serialize_transfer<T0>(&v0, arg0, arg1);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::prepare_wormhole_message(&v0, arg0, v1, v2)
    }

    fun bridge_in_and_serialize_transfer<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: TransferTicket<T0>) : (u32, vector<u8>) {
        let TransferTicket {
            asset_info     : v0,
            bridged_in     : v1,
            norm_amount    : v2,
            sender         : v3,
            redeemer_chain : v4,
            redeemer       : v5,
            payload        : v6,
            nonce          : v7,
        } = arg2;
        let v8 = v0;
        let (v9, v10) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::burn_or_deposit_funds<T0>(arg0, arg1, &v8, v1);
        (v7, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::serialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::new(v3, v2, v10, v9, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(v5)), v4, v6)))
    }

    public fun prepare_transfer<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: u32) : (TransferTicket<T0>, 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens::take_truncated_amount<T0>(&arg1, &mut arg2);
        let v2 = TransferTicket<T0>{
            asset_info     : arg1,
            bridged_in     : v0,
            norm_amount    : v1,
            sender         : 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(arg0),
            redeemer_chain : arg3,
            redeemer       : arg4,
            payload        : arg5,
            nonce          : arg6,
        };
        (v2, arg2)
    }

    // decompiled from Move bytecode v6
}

