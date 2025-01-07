module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload {
    struct RedeemerReceipt<phantom T0> {
        source_chain: u16,
        parsed: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::TransferWithPayload,
        bridged_out: 0x2::coin::Coin<T0>,
    }

    public fun authorize_transfer<T0>(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::TokenBridgeMessage, arg2: &mut 0x2::tx_context::TxContext) : RedeemerReceipt<T0> {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        handle_authorize_transfer<T0>(&v0, arg0, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::emit_transfer_redeemed(&arg1), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::take_payload(arg1), arg2)
    }

    fun handle_authorize_transfer<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: u16, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : RedeemerReceipt<T0> {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::deserialize(arg3);
        let (_, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer::verify_and_bridge_out<T0>(arg0, arg1, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::token_chain(&v0), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::token_address(&v0), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::redeemer_chain(&v0), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::amount(&v0));
        RedeemerReceipt<T0>{
            source_chain : arg2,
            parsed       : v0,
            bridged_out  : 0x2::coin::from_balance<T0>(v2, arg4),
        }
    }

    public fun redeem_coin<T0>(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: RedeemerReceipt<T0>) : (0x2::coin::Coin<T0>, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::TransferWithPayload, u16) {
        let RedeemerReceipt {
            source_chain : v0,
            parsed       : v1,
            bridged_out  : v2,
        } = arg1;
        let v3 = v1;
        assert!(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::redeemer_id(&v3) == 0x2::object::id<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(arg0), 0);
        (v2, v3, v0)
    }

    // decompiled from Move bytecode v6
}

