module 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_equipment_adapter_v8 {
    public fun assert_equipment_read_v8(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0x2::tx_context::TxContext) {
        let v0 = if (0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8>(arg1)) {
            if (0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_soul_id_v8(arg1) == 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0)) {
                0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_state_id_v8(arg1) == 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::assert_soul_equipment_read_v8<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::read_owner_witness(arg0, arg3), arg3);
    }

    fun begin_update(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::SoulEquipmentUpdateV8 {
        let v0 = if (0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8>(arg1)) {
            if (0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_soul_id_v8(arg1) == 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0)) {
                0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_state_id_v8(arg1) == 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::begin_soul_equipment_update_v8<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, arg3, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::owner_witness(arg0, arg4), arg4)
    }

    public fun clear_selection_v8(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg2, arg3, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::clear_non_external_selection_v8(arg1, arg4, arg3, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun close_empty_equipment_v8(arg0: &mut 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = if (0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8>(&arg1)) {
            if (0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_soul_id_v8(&arg1) == 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0)) {
                0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::soul_equipment_state_id_v8(&arg1) == 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::unbind_animacraft_native_equipment_v8(arg0, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::close_soul_equipment_v8<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, arg3, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::owner_witness(arg0, arg4), arg4));
    }

    public fun create_equipment_v8<T0>(arg0: &mut 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeSoulBindingV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = if (0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::animacraft_native_v8_binding_id(arg0) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeSoulBindingV8>(arg1)) {
            if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_soul_id_v8(arg1) == 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0)) {
                if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_state_id_v8(arg1) == 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0)) {
                    if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_root_id_v8(arg1) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>>(arg2)) {
                        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::native_soul_binding_protocol_id_v8(arg1) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8>(arg3)
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
        assert!(v0, 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg2, arg3);
        let v1 = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::create_soul_equipment_v8<T0, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::SoulOwnerWitnessV8>(arg2, arg3, arg4, arg5, arg6, 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::soul_id(arg0), 0x2::object::id<0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState>(arg0), 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::ownership_epoch(arg0), 0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::owner_witness(arg0, arg7), arg7);
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::bind_animacraft_native_equipment_v8(arg0, v1);
        v1
    }

    public fun equip_base_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedBaseItemV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg3, arg9, arg13);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::equip_owned_base_style_v8<T0>(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun equip_external_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedExternalItemV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::ExternalItemProductV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg3, arg9, arg11);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::equip_external_style_v8<T0>(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun equip_protected_base_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedBaseItemV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg14: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg15: vector<u8>, arg16: vector<u8>, arg17: vector<u8>, arg18: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg3, arg9, arg18);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::equip_protected_owned_base_style_v8<T0>(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg13, arg14, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun select_base_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::option::Option<0x1::string::String>, arg14: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg2, arg8, arg14);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::select_base_style_v8<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun select_pack_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg10: u64, arg11: 0x1::option::Option<u64>, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::option::Option<0x1::string::String>, arg16: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg2, arg10, arg16);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::select_pack_style_v8<T0>(arg1, arg3, arg4, arg6, arg5, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun select_protected_base_v8<T0>(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::option::Option<0x1::string::String>, arg14: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg15: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg2, arg8, arg19);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::select_protected_base_style_v8<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg14, arg15, arg8, arg9, arg10, arg11, arg12, arg13, arg16, arg17, arg18, arg19);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun unequip_base_v8(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedBaseItemV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg3, arg4, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::unequip_owned_base_style_v8(arg1, arg2, arg4, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    public fun unequip_external_v8(arg0: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg1: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedExternalItemV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = begin_update(arg0, arg1, arg3, arg4, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::unequip_external_style_v8(arg1, arg2, arg4, arg5);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::finish_soul_equipment_update_v8(arg1, v0);
    }

    // decompiled from Move bytecode v7
}

