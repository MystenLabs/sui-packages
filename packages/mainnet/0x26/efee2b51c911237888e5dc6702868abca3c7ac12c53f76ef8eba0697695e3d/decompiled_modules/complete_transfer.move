module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::complete_transfer {
    struct TransferRedeemed has copy, drop {
        emitter_chain: u16,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        sequence: u64,
    }

    struct RelayerReceipt<phantom T0> {
        payout: 0x2::coin::Coin<T0>,
    }

    public fun authorize_transfer<T0>(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::TokenBridgeMessage, arg2: &mut 0x2::tx_context::TxContext) : RelayerReceipt<T0> {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        emit_transfer_redeemed(&arg1);
        handle_complete_transfer<T0>(&v0, arg0, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::take_payload(arg1), arg2)
    }

    public(friend) fun emit_transfer_redeemed(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::TokenBridgeMessage) : u16 {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::emitter_chain(arg0);
        let v1 = TransferRedeemed{
            emitter_chain   : v0,
            emitter_address : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::emitter_address(arg0),
            sequence        : 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa::sequence(arg0),
        };
        0x2::event::emit<TransferRedeemed>(v1);
        v0
    }

    fun handle_complete_transfer<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : RelayerReceipt<T0> {
        let (v0, v1, v2, v3, v4, v5) = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer::unpack(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::transfer::deserialize(arg2));
        let v6 = v5;
        let (v7, v8) = verify_and_bridge_out<T0>(arg0, arg1, v2, v1, v4, v0);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v3);
        let v12 = if (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::value(&v6) == 0 || v11 == 0x2::tx_context::sender(arg3)) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut v9, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(v6, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&v10)))
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg3), v11);
        RelayerReceipt<T0>{payout: 0x2::coin::from_balance<T0>(v12, arg3)}
    }

    public fun redeem_relayer_payout<T0>(arg0: RelayerReceipt<T0>) : 0x2::coin::Coin<T0> {
        let RelayerReceipt { payout: v0 } = arg0;
        v0
    }

    public(friend) fun verify_and_bridge_out<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::LatestOnly, arg1: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: u16, arg5: 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::NormalizedAmount) : (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::VerifiedAsset<T0>, 0x2::balance::Balance<T0>) {
        assert!(arg4 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg1);
        assert!(arg2 == 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_chain<T0>(&v0) && arg3 == 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::token_address<T0>(&v0), 1);
        let v1 = if (0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::is_wrapped<T0>(&v0)) {
            0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::wrapped_asset::mint<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::borrow_mut_wrapped<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_token_registry(arg0, arg1)), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(arg5, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&v0)))
        } else {
            0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::native_asset::withdraw<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::borrow_mut_native<T0>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_token_registry(arg0, arg1)), 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::normalized_amount::to_raw(arg5, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::token_registry::coin_decimals<T0>(&v0)))
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

