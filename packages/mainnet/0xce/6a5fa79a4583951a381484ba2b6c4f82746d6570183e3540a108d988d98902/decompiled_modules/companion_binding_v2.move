module 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2 {
    struct MakerRuntimeCompanionRegistryIdsV2 has copy, drop, store {
        runtime_definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        seal_registry_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        physical_registry_id: 0x2::object::ID,
        market_registry_id: 0x2::object::ID,
    }

    struct MakerCompanionBindingFactsV2 has copy, drop {
        catalog_id: 0x2::object::ID,
        replacement_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_control_epoch: u64,
        root_content_commitment: vector<u8>,
        maker_admin_id: 0x2::object::ID,
        base_registry_id: 0x2::object::ID,
        base_definition_commitment: vector<u8>,
        maker_treasury_id: 0x2::object::ID,
        maker_signer: address,
    }

    struct MakerRuntimeCompanionBindingBuilderV2<phantom T0> {
        facts: MakerCompanionBindingFactsV2,
        ids: vector<0x2::object::ID>,
        next_role: u8,
    }

    public fun admission_authority_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.admission_authority_id
    }

    fun append_id<T0>(arg0: &mut MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: 0x2::object::ID) {
        let v0 = &arg0.facts;
        let v1 = if (arg1 != v0.root_id) {
            if (arg1 != v0.maker_admin_id) {
                if (arg1 != v0.base_registry_id) {
                    if (arg1 != v0.maker_treasury_id) {
                        if (arg1 != v0.catalog_id) {
                            if (arg1 != v0.replacement_id) {
                                arg1 != 0x2::object::id_from_address(@0x0)
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
        assert!(v1, 2);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.ids, &arg1), 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.ids, arg1);
    }

    public fun append_market_v2<T0, T1: drop>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: T1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_live(&arg0.facts, arg2, arg3, arg4, arg6);
        assert_stage<T0>(&arg0, 4);
        let v0 = b"market_v8";
        let v1 = b"MakerCompanionBindingWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 5), &v0, &v1);
        let v2 = &mut arg0;
        append_id<T0>(v2, arg5);
        arg0.next_role = 5;
        arg0
    }

    public fun append_output_v2<T0, T1: drop>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: T1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_live(&arg0.facts, arg2, arg3, arg4, arg7);
        assert_stage<T0>(&arg0, 2);
        let v0 = b"output_v8";
        let v1 = b"MakerCompanionBindingWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 3), &v0, &v1);
        let v2 = &mut arg0;
        append_id<T0>(v2, arg5);
        let v3 = &mut arg0;
        append_id<T0>(v3, arg6);
        arg0.next_role = 3;
        arg0
    }

    public fun append_physical_v2<T0, T1: drop>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: T1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_live(&arg0.facts, arg2, arg3, arg4, arg6);
        assert_stage<T0>(&arg0, 3);
        let v0 = b"physical_v8";
        let v1 = b"MakerCompanionBindingWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 4), &v0, &v1);
        let v2 = &mut arg0;
        append_id<T0>(v2, arg5);
        arg0.next_role = 4;
        arg0
    }

    public fun append_runtime_v2<T0, T1: drop>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: T1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_live(&arg0.facts, arg2, arg3, arg4, arg8);
        assert_stage<T0>(&arg0, 0);
        let v0 = b"runtime_v8";
        let v1 = b"MakerCompanionBindingWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 2), &v0, &v1);
        let v2 = &mut arg0;
        append_id<T0>(v2, arg5);
        let v3 = &mut arg0;
        append_id<T0>(v3, arg6);
        let v4 = &mut arg0;
        append_id<T0>(v4, arg7);
        arg0.next_role = 1;
        arg0
    }

    public fun append_seal_v2<T0, T1: drop>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: T1, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        assert_live(&arg0.facts, arg2, arg3, arg4, arg6);
        assert_stage<T0>(&arg0, 1);
        let v0 = b"seal_v8";
        let v1 = b"MakerCompanionBindingWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 1), &v0, &v1);
        let v2 = &mut arg0;
        append_id<T0>(v2, arg5);
        arg0.next_role = 2;
        arg0
    }

    public fun assert_facts_v2(arg0: &MakerCompanionBindingFactsV2, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &vector<u8>, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: &vector<u8>, arg8: 0x2::object::ID, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.root_id == arg1) {
            if (arg0.maker_version == arg2) {
                if (arg0.root_control_epoch == arg3) {
                    if (&arg0.root_content_commitment == arg4) {
                        if (arg0.maker_admin_id == arg5) {
                            if (arg0.base_registry_id == arg6) {
                                if (&arg0.base_definition_commitment == arg7) {
                                    if (arg0.maker_treasury_id == arg8) {
                                        arg0.maker_signer == 0x2::tx_context::sender(arg9)
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
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun assert_live(arg0: &MakerCompanionBindingFactsV2, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg3, arg2);
        let v0 = if (arg0.catalog_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg2)) {
            if (arg0.replacement_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2>(arg3)) {
                if (&arg0.package_tuple_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2))) {
                    arg0.maker_signer == 0x2::tx_context::sender(arg4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun assert_stage<T0>(arg0: &MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: u8) {
        assert!(arg0.next_role == arg1, 0);
        let v0 = if (arg1 == 0) {
            0
        } else if (arg1 == 1) {
            3
        } else if (arg1 == 2) {
            4
        } else if (arg1 == 3) {
            6
        } else if (arg1 == 4) {
            7
        } else {
            assert!(arg1 == 5, 0);
            8
        };
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.ids) == v0, 0);
    }

    public fun builder_facts_v2<T0>(arg0: &MakerRuntimeCompanionBindingBuilderV2<T0>) : &MakerCompanionBindingFactsV2 {
        &arg0.facts
    }

    fun finish<T0>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>) : (MakerCompanionBindingFactsV2, MakerRuntimeCompanionRegistryIdsV2) {
        assert_stage<T0>(&arg0, 5);
        let MakerRuntimeCompanionBindingBuilderV2 {
            facts     : v0,
            ids       : v1,
            next_role : _,
        } = arg0;
        let v3 = v1;
        let v4 = MakerRuntimeCompanionRegistryIdsV2{
            runtime_definition_registry_id : *0x1::vector::borrow<0x2::object::ID>(&v3, 0),
            pack_registry_id               : *0x1::vector::borrow<0x2::object::ID>(&v3, 1),
            admission_authority_id         : *0x1::vector::borrow<0x2::object::ID>(&v3, 2),
            seal_registry_id               : *0x1::vector::borrow<0x2::object::ID>(&v3, 3),
            output_registry_id             : *0x1::vector::borrow<0x2::object::ID>(&v3, 4),
            soul_registry_id               : *0x1::vector::borrow<0x2::object::ID>(&v3, 5),
            physical_registry_id           : *0x1::vector::borrow<0x2::object::ID>(&v3, 6),
            market_registry_id             : *0x1::vector::borrow<0x2::object::ID>(&v3, 7),
        };
        (v0, v4)
    }

    public(friend) fun finish_v2<T0>(arg0: MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &0x2::tx_context::TxContext) : (MakerCompanionBindingFactsV2, MakerRuntimeCompanionRegistryIdsV2) {
        assert_live(&arg0.facts, arg1, arg2, arg3, arg4);
        finish<T0>(arg0)
    }

    public fun ids_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (arg0.runtime_definition_registry_id, arg0.pack_registry_id, arg0.admission_authority_id, arg0.seal_registry_id, arg0.output_registry_id, arg0.soul_registry_id, arg0.physical_registry_id, arg0.market_registry_id)
    }

    public fun market_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.market_registry_id
    }

    public(friend) fun new_builder_v2<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: 0x2::object::ID, arg11: &0x2::tx_context::TxContext) : MakerRuntimeCompanionBindingBuilderV2<T0> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg2, arg1);
        assert!(0x1::vector::length<u8>(&arg6) == 32 && 0x1::vector::length<u8>(&arg9) == 32, 1);
        let v0 = MakerCompanionBindingFactsV2{
            catalog_id                 : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg1),
            replacement_id             : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2>(arg2),
            package_tuple_commitment   : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1)),
            root_id                    : arg3,
            maker_version              : arg4,
            root_control_epoch         : arg5,
            root_content_commitment    : arg6,
            maker_admin_id             : arg7,
            base_registry_id           : arg8,
            base_definition_commitment : arg9,
            maker_treasury_id          : arg10,
            maker_signer               : 0x2::tx_context::sender(arg11),
        };
        MakerRuntimeCompanionBindingBuilderV2<T0>{
            facts     : v0,
            ids       : 0x1::vector::empty<0x2::object::ID>(),
            next_role : 0,
        }
    }

    public fun output_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.output_registry_id
    }

    public fun pack_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.pack_registry_id
    }

    public fun physical_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.physical_registry_id
    }

    public fun runtime_definition_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.runtime_definition_registry_id
    }

    public fun seal_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.seal_registry_id
    }

    public fun soul_registry_id_v2(arg0: &MakerRuntimeCompanionRegistryIdsV2) : 0x2::object::ID {
        arg0.soul_registry_id
    }

    // decompiled from Move bytecode v7
}

