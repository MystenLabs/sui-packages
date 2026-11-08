module 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_equipment_adapter_v8 {
    public fun attach_pack_definitions_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackReleaseV8<T0>, arg6: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackPassV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg9);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::attach_pack_definitions_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun assert_equipment_read_v8(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x2::tx_context::TxContext) {
        let v0 = if (0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8>(arg1)) {
            if (0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_soul_id_v8(arg1) == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_state_id_v8(arg1) == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_read_v8<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::read_owner_witness(arg0, arg3), arg3);
    }

    public fun begin_update_v8(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8 {
        let v0 = if (0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8>(arg1)) {
            if (0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_soul_id_v8(arg1) == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_state_id_v8(arg1) == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::begin_soul_equipment_update_v8<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, arg3, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::owner_witness(arg0, arg4), arg4)
    }

    public fun clear_selection_v8(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg4);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::clear_non_external_selection_v8(arg1, arg3, arg2, arg4);
    }

    public fun close_empty_equipment_v8(arg0: &mut 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = if (0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::animacraft_native_equipment_id_v8(arg0) == 0x2::object::id<0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8>(&arg1)) {
            if (0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_soul_id_v8(&arg1) == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::soul_equipment_state_id_v8(&arg1) == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::unbind_animacraft_native_equipment_v8(arg0, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::close_soul_equipment_v8<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::SoulOwnerWitnessV8>(arg1, arg2, arg3, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::owner_witness(arg0, arg4), arg4));
    }

    public fun create_equipment_v8<T0>(arg0: &mut 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeSoulBindingV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = if (0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::animacraft_native_v8_binding_id(arg0) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeSoulBindingV8>(arg1)) {
            if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_soul_id_v8(arg1) == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_state_id_v8(arg1) == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)) {
                    if (0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_root_id_v8(arg1) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>>(arg2)) {
                        0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::native_soul_binding_protocol_id_v8(arg1) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8>(arg3)
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
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::assert_current_protocol_config_v8<T0>(arg2, arg3);
        let v1 = 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::create_soul_equipment_v8<T0, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::SoulOwnerWitnessV8>(arg2, arg3, arg4, arg5, arg6, 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0), 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0), 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0), 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::owner_witness(arg0, arg7), arg7);
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::bind_animacraft_native_equipment_v8(arg0, v1);
        v1
    }

    public fun equip_base_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedBaseItemV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x1::string::String>, arg12: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg12);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::equip_owned_base_style_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun equip_external_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedExternalItemV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::ExternalItemProductV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg10);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::equip_external_style_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun equip_protected_base_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedBaseItemV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x1::string::String>, arg12: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg13: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg14: vector<u8>, arg15: vector<u8>, arg16: vector<u8>, arg17: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg17);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::equip_protected_owned_base_style_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13, arg8, arg9, arg10, arg11, arg14, arg15, arg16, arg17);
    }

    public fun finish_update_v8(arg0: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg1: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg3: vector<0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackDefinitionProofV8>, arg4: 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::finish_soul_equipment_update_v8(arg0, arg1, arg2, arg3, arg4);
    }

    public fun select_base_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg13);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::select_base_style_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun select_pack_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg6: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackReleaseV8<T0>, arg7: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackPassV8, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::option::Option<0x1::string::String>, arg15: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg15);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::select_pack_style_v8<T0>(arg1, arg2, arg3, arg5, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun select_protected_base_v8<T0>(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::option::Option<0x1::string::String>, arg13: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg14: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg15: vector<u8>, arg16: vector<u8>, arg17: vector<u8>, arg18: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg18);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::select_protected_base_style_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg13, arg14, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
    }

    public fun unequip_base_v8(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedBaseItemV8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg4);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::unequip_owned_base_style_v8(arg1, arg2, arg3, arg4);
    }

    public fun unequip_external_v8(arg0: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::SoulEquipmentUpdateV8, arg1: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg2: &mut 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedExternalItemV8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::assert_soul_equipment_update_v8(arg1, arg0, arg4);
        0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::unequip_external_style_v8(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

