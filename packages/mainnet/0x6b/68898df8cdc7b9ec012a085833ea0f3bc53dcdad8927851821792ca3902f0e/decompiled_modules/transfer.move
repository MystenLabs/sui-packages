module 0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::transfer {
    public fun redeem_transfer_with_payload<T0>(arg0: &0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::State, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::RedeemerReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer_with_payload::redeem_coin<T0>(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::emitter_cap(arg0), arg1);
        let v3 = v1;
        let v4 = v0;
        assert!(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::foreign_contract_address(arg0, v2) == 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::sender(&v3), 1);
        let v5 = 0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::message::deserialize(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_with_payload::payload(&v3));
        let v6 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::message::recipient(&v5));
        let v7 = 0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::get_relayer_fee(arg0, 0x2::coin::value<T0>(&v4));
        if (v7 > 0 && v6 != 0x2::tx_context::sender(arg2)) {
            0x2::pay::split<T0>(&mut v4, v7, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v6);
    }

    public fun send_tokens_with_payload<T0>(arg0: &0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::State, arg1: 0x2::coin::Coin<T0>, arg2: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, arg3: u16, arg4: address, arg5: u32, arg6: &0x2::tx_context::TxContext) : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::TransferTicket<T0> {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::from_address(arg4);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::is_nonzero(&v0), 0);
        assert!(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::contract_registered(arg0, arg3), 1);
        let v1 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&arg2);
        assert!(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::from_raw(0x2::coin::value<T0>(&arg1), v1), v1) > 0, 2);
        let (v2, v3) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer_tokens_with_payload::prepare_transfer<T0>(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::emitter_cap(arg0), arg2, arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::state::foreign_contract_address(arg0, arg3)), 0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::message::serialize(0x6b68898df8cdc7b9ec012a085833ea0f3bc53dcdad8927851821792ca3902f0e::message::new(v0)), arg5);
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils::return_nonzero<T0>(v3, arg6);
        v2
    }

    // decompiled from Move bytecode v6
}

