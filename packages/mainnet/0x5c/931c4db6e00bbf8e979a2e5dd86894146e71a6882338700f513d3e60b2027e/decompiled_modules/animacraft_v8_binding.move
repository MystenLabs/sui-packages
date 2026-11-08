module 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding {
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

    public fun certify_native_complete_read_v8<T0>(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeSoulBindingV8, arg2: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteOutputV8, arg3: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteReceiptV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg6: &0x2::tx_context::TxContext) : 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeCompleteDecryptProofV8 {
        let v0 = if (0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::animacraft_native_v8_binding_id(arg0) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeSoulBindingV8>(arg1)) {
            if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_soul_id_v8(arg1) == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_state_id_v8(arg1) == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)) {
                    if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_root_id_v8(arg1) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>>(arg4)) {
                        if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_protocol_id_v8(arg1) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8>(arg5)) {
                            if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_output_id_v8(arg1) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteOutputV8>(arg2)) {
                                0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_receipt_id_v8(arg1) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteReceiptV8>(arg3)
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
        0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::certify_native_complete_decrypt_v8<T0, SoulOwnerWitnessV8>(arg1, arg2, arg3, arg4, arg5, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::current_owner(arg0), 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0), read_owner_witness(arg0, arg6), arg6)
    }

    public(friend) fun mint_witness(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : MintBindingWitnessV8 {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0) == 0, 0);
        assert!(!0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::is_listed(arg0), 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        MintBindingWitnessV8{
            soul_id                  : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0),
            soul_state_id            : 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0),
            holder                   : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::current_owner(arg0),
            ownership_epoch          : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0),
            authorization_commitment : arg1,
        }
    }

    public(friend) fun owner_witness(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        assert!(!0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::is_listed(arg0), 1);
        read_owner_witness(arg0, arg1)
    }

    public(friend) fun read_owner_witness(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::assert_owner(arg0, 0x2::tx_context::sender(arg1));
        SoulOwnerWitnessV8{
            soul_id         : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0),
            soul_state_id   : 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0),
            holder          : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::current_owner(arg0),
            ownership_epoch : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

