module 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::animacraft_v8_binding {
    struct MintBindingWitnessV8 has drop {
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        holder: address,
        ownership_epoch: u64,
        authorization_commitment: vector<u8>,
    }

    struct SoulOwnerWitnessV8 has drop {
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        holder: address,
        ownership_epoch: u64,
    }

    public fun certify_native_complete_read_v8<T0>(arg0: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState, arg1: &0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::NativeSoulBindingV8, arg2: &0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::CompleteOutputV8, arg3: &0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::CompleteReceiptV8, arg4: &0xe1e6857ccabcfb36c2e4cd1cf2a6d8babad7fb457106e4b4108f310528645b5f::maker_v8::MakerRootV8<T0>, arg5: &0xe1e6857ccabcfb36c2e4cd1cf2a6d8babad7fb457106e4b4108f310528645b5f::protocol_config_v8::ProtocolConfigV8, arg6: &0x2::tx_context::TxContext) : 0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::NativeCompleteDecryptProofV8 {
        let v0 = if (0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::animacraft_native_v8_binding_id(arg0) == 0x2::object::id<0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::NativeSoulBindingV8>(arg1)) {
            if (0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_soul_id_v8(arg1) == 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::soul_id(arg0)) {
                if (0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_state_id_v8(arg1) == 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState>(arg0)) {
                    if (0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_root_id_v8(arg1) == 0x2::object::id<0xe1e6857ccabcfb36c2e4cd1cf2a6d8babad7fb457106e4b4108f310528645b5f::maker_v8::MakerRootV8<T0>>(arg4)) {
                        if (0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_protocol_id_v8(arg1) == 0x2::object::id<0xe1e6857ccabcfb36c2e4cd1cf2a6d8babad7fb457106e4b4108f310528645b5f::protocol_config_v8::ProtocolConfigV8>(arg5)) {
                            if (0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_output_id_v8(arg1) == 0x2::object::id<0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::CompleteOutputV8>(arg2)) {
                                0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::native_soul_binding_receipt_id_v8(arg1) == 0x2::object::id<0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::CompleteReceiptV8>(arg3)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        0x4a10df716f3c2c451e1a8130c40dce8231778d230e4513eecd2f3a1feb5b80d7::output_v8::certify_native_complete_decrypt_v8<T0, SoulOwnerWitnessV8>(arg1, arg2, arg3, arg4, arg5, 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::current_owner(arg0), 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::ownership_epoch(arg0), read_owner_witness(arg0, arg6), arg6)
    }

    public(friend) fun mint_witness(arg0: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : MintBindingWitnessV8 {
        0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::ownership_epoch(arg0) == 0, 0);
        assert!(!0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::is_listed(arg0), 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        MintBindingWitnessV8{
            soul_id                  : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::soul_id(arg0),
            soul_state_id            : 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState>(arg0),
            holder                   : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::current_owner(arg0),
            ownership_epoch          : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::ownership_epoch(arg0),
            authorization_commitment : arg1,
        }
    }

    public(friend) fun owner_witness(arg0: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        assert!(!0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::is_listed(arg0), 1);
        read_owner_witness(arg0, arg1)
    }

    public(friend) fun read_owner_witness(arg0: &0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::assert_owner(arg0, 0x2::tx_context::sender(arg1));
        SoulOwnerWitnessV8{
            soul_id         : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::soul_id(arg0),
            soul_state_id   : 0x2::object::id<0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::SoulState>(arg0),
            holder          : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::current_owner(arg0),
            ownership_epoch : 0x5e3e75de3e1f661ffcad9bd0d53f3ea97e2e48f0765d2b2d9532256806409bb9::soul::ownership_epoch(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

