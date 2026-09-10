module 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding {
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

    public fun certify_native_complete_read_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeSoulBindingV8, arg2: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8, arg3: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0x2::tx_context::TxContext) : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeCompleteDecryptProofV8 {
        let v0 = if (0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::animacraft_native_v8_binding_id(arg0) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeSoulBindingV8>(arg1)) {
            if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_soul_id_v8(arg1) == 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0)) {
                if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_state_id_v8(arg1) == 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0)) {
                    if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_root_id_v8(arg1) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>>(arg4)) {
                        if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_protocol_id_v8(arg1) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8>(arg5)) {
                            if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_output_id_v8(arg1) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8>(arg2)) {
                                0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_receipt_id_v8(arg1) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8>(arg3)
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
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::certify_native_complete_decrypt_v8<T0, SoulOwnerWitnessV8>(arg1, arg2, arg3, arg4, arg5, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::current_owner(arg0), 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::ownership_epoch(arg0), read_owner_witness(arg0, arg6), arg6)
    }

    public(friend) fun mint_witness(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : MintBindingWitnessV8 {
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::ownership_epoch(arg0) == 0, 0);
        assert!(!0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::is_listed(arg0), 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        MintBindingWitnessV8{
            soul_id                  : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0),
            soul_state_id            : 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0),
            holder                   : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::current_owner(arg0),
            ownership_epoch          : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::ownership_epoch(arg0),
            authorization_commitment : arg1,
        }
    }

    public(friend) fun owner_witness(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        assert!(!0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::is_listed(arg0), 1);
        read_owner_witness(arg0, arg1)
    }

    public(friend) fun read_owner_witness(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &0x2::tx_context::TxContext) : SoulOwnerWitnessV8 {
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::assert_owner(arg0, 0x2::tx_context::sender(arg1));
        SoulOwnerWitnessV8{
            soul_id         : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0),
            soul_state_id   : 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0),
            holder          : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::current_owner(arg0),
            ownership_epoch : 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::ownership_epoch(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

