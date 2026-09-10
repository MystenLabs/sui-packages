module 0x3f4148b6c75e2db1daebbbadeb37666ec32bb8b38ebc0f93a2cbde07f9acae7e::market_v8 {
    struct MakerCompanionBindingWitnessV2 has drop {
        dummy_field: bool,
    }

    struct MarketOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct MarketCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct MarketSetupInstallWitnessV2 has drop {
        dummy_field: bool,
    }

    struct MarketRuntimeCallerCapInstallWitnessV2 has drop {
        dummy_field: bool,
    }

    struct MarketPackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        installation_commitment: vector<u8>,
        runtime_caller_cap: 0x1::option::Option<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>,
    }

    struct MarketTreasuryV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        escrow: 0x2::balance::Balance<T0>,
        gross_escrowed_atomic: u128,
        gross_released_atomic: u128,
    }

    struct MarketRegistryV8<phantom T0> has key {
        id: 0x2::object::UID,
        catalog_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        rights_commitment: vector<u8>,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
        treasury_id: 0x2::object::ID,
        sealed: bool,
        revision: u64,
        listing_count: u64,
        escrow_count: u64,
        completed_sale_count: u64,
        canceled_sale_count: u64,
        recovered_sale_count: u64,
        gross_volume_atomic: u128,
        protocol_paid_atomic: u128,
        creator_paid_atomic: u128,
        source_paid_atomic: u128,
        seller_paid_atomic: u128,
        zero_state_commitment: vector<u8>,
    }

    struct MarketZeroStateCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        catalog_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        rights_commitment: vector<u8>,
        maker_market_fee_bps: u16,
        soul_market_fee_bps: u16,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
        maker_resale_royalty_bps: u16,
        treasury_id: 0x2::object::ID,
    }

    struct MarketReadinessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        registry_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        zero_state_commitment: vector<u8>,
        sealed: bool,
        revision: u64,
        listing_count: u64,
        escrow_count: u64,
        completed_sale_count: u64,
        canceled_sale_count: u64,
        recovered_sale_count: u64,
        gross_volume_atomic: u128,
        protocol_paid_atomic: u128,
        creator_paid_atomic: u128,
        source_paid_atomic: u128,
        seller_paid_atomic: u128,
        treasury_balance_atomic: u64,
        treasury_gross_escrowed_atomic: u128,
        treasury_gross_released_atomic: u128,
    }

    struct MarketQuoteCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        quote_kind: u8,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        rights_commitment: vector<u8>,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        source_atomic: u64,
        seller_atomic: u64,
    }

    struct MarketRegistrySealedV8 has copy, drop {
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        zero_state_commitment: vector<u8>,
    }

    struct MarketQuoteV8 has copy, drop {
        quote_kind: u8,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        rights_commitment: vector<u8>,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        source_atomic: u64,
        seller_atomic: u64,
        commitment: vector<u8>,
    }

    struct MakerListingV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        admin_cap_id: 0x2::object::ID,
        seller: address,
        expected_control_epoch: u64,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        seller_atomic: u64,
        quote_commitment: vector<u8>,
        status: u8,
        revision: u64,
        terminal_recipient: address,
    }

    struct SoulListingV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        custody: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulMarketCustodyBindingV8,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        source_atomic: u64,
        seller_atomic: u64,
        quote_commitment: vector<u8>,
        status: u8,
        revision: u64,
        terminal_recipient: address,
    }

    struct PhysicalListingV8<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        custody: 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalMarketCustodyBindingV8,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        source_atomic: u64,
        seller_atomic: u64,
        quote_commitment: vector<u8>,
        status: u8,
        revision: u64,
        terminal_recipient: address,
    }

    struct MarketListingOpenedV8 has copy, drop {
        listing_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        lane: u8,
        root_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        seller: address,
        ownership_epoch: u64,
        gross_atomic: u64,
        quote_commitment: vector<u8>,
    }

    struct MarketListingSettledV8 has copy, drop {
        listing_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        lane: u8,
        asset_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        gross_atomic: u64,
        protocol_atomic: u64,
        creator_atomic: u64,
        source_atomic: u64,
        seller_atomic: u64,
    }

    struct MarketListingClosedV8 has copy, drop {
        listing_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        lane: u8,
        asset_id: 0x2::object::ID,
        seller: address,
        recovered: bool,
    }

    fun assert_active_market<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 3);
        assert_live_market<T0>(arg0, arg1, arg2);
    }

    fun assert_asset_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &vector<u8>, arg6: u8, arg7: &MarketQuoteV8) {
        let v0 = if (arg7.quote_kind == arg6) {
            if (arg7.gross_atomic == arg0) {
                if (arg7.protocol_atomic == arg1) {
                    if (arg7.creator_atomic == arg2) {
                        if (arg7.source_atomic == arg3) {
                            if (arg7.seller_atomic == arg4) {
                                &arg7.commitment == arg5
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
        assert!(v0, 2);
    }

    fun assert_bound_market<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &MarketPackageConfigV8) {
        assert_market_identity<T0>(arg0, arg1, arg2, arg3);
        assert!(arg0.sealed, 3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::market_registry_id_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg2)) == 0x2::object::id<MarketRegistryV8<T0>>(arg0), 1);
        assert!(arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg1), 1);
    }

    fun assert_config<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &MarketPackageConfigV8) {
        assert_config_installation(arg1, arg2, arg3, arg4);
        assert_return_config<T0>(arg0, arg2, arg3, arg4);
    }

    fun assert_config_installation(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &MarketPackageConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        assert_structural_config_installation(arg1, arg2, arg3);
    }

    fun assert_live_market<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg2, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg2, arg1.root_id, arg1.maker_version, &arg1.root_content_commitment);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::market_registry_id_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg2)) == 0x2::object::id<MarketRegistryV8<T0>>(arg0), 1);
        assert!(arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg1), 1);
        assert!(arg0.sealed, 3);
    }

    fun assert_maker_listing<T0>(arg0: &MakerListingV8<T0>, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &MarketPackageConfigV8) {
        assert!(arg0.version == 8 && arg0.status == 0, 6);
        let v0 = if (arg0.registry_id == 0x2::object::id<MarketRegistryV8<T0>>(arg1)) {
            if (arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg2)) {
                arg0.package_config_id == 0x2::object::id<MarketPackageConfigV8>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg3, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.seller != @0x0 && arg0.gross_atomic > 0, 6);
    }

    fun assert_maker_quote<T0>(arg0: &MakerListingV8<T0>, arg1: &MarketQuoteV8) {
        let v0 = if (arg1.quote_kind == 0) {
            if (arg1.gross_atomic == arg0.gross_atomic) {
                if (arg1.protocol_atomic == arg0.protocol_atomic) {
                    if (arg1.creator_atomic == arg0.creator_atomic) {
                        if (arg1.source_atomic == 0) {
                            if (arg1.seller_atomic == arg0.seller_atomic) {
                                arg1.commitment == arg0.quote_commitment
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
        assert!(v0, 2);
    }

    fun assert_market_identity<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &MarketPackageConfigV8) {
        assert!(arg1.version == 8, 1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg2, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg2, arg1.root_id, arg1.maker_version, &arg1.root_content_commitment);
        assert!(arg0.catalog_id == arg3.catalog_id && arg1.catalog_id == arg3.catalog_id, 1);
        assert!(arg0.package_config_id == 0x2::object::id<MarketPackageConfigV8>(arg3) && arg1.package_config_id == 0x2::object::id<MarketPackageConfigV8>(arg3), 1);
        assert!(arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg1), 1);
        assert!(arg0.product_binding_commitment == arg3.product_binding_commitment, 1);
        assert!(arg0.call_cap_set_commitment == arg3.call_cap_set_commitment, 1);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg2);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_rights_v2<T0>(arg2);
        assert!(arg0.protocol_config_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_id_v2(&v0), 1);
        assert!(arg0.protocol_config_revision == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_revision_v2(&v0), 1);
        assert!(&arg0.protocol_config_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_commitment_v2(&v0), 1);
        assert!(&arg0.economics_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_commitment_v2(&v0), 1);
        assert!(&arg0.rights_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_commitment_v2(&v1), 1);
        assert!(arg0.maker_market_fee_bps == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_maker_market_fee_bps_v2(&v0), 1);
        assert!(arg0.soul_market_fee_bps == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_soul_market_fee_bps_v2(&v0), 1);
        assert!(arg0.soul_creator_royalty_bps == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_soul_creator_royalty_bps_v2(&v1), 1);
        assert!(arg0.maker_source_royalty_bps == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_source_royalty_bps_v2(&v1), 1);
        assert!(arg0.maker_resale_royalty_bps == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_resale_royalty_bps_v2(&v1), 1);
        assert!(arg0.zero_state_commitment == derive_zero_state_commitment<T0>(arg2, arg3, 0x2::object::id<MarketTreasuryV8<T0>>(arg1), &v0, &v1), 2);
    }

    fun assert_physical_listing<T0>(arg0: &PhysicalListingV8<T0>, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &MarketPackageConfigV8) {
        assert!(arg0.version == 8 && arg0.status == 0, 6);
        let v0 = if (arg0.registry_id == 0x2::object::id<MarketRegistryV8<T0>>(arg1)) {
            if (arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg2)) {
                arg0.package_config_id == 0x2::object::id<MarketPackageConfigV8>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_listing_id_v8(&arg0.custody) == 0x2::object::id<PhysicalListingV8<T0>>(arg0), 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg3, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_root_id_v8(&arg0.custody), 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_maker_version_v8(&arg0.custody), 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_root_content_commitment_v8(&arg0.custody));
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody) != @0x0 && arg0.gross_atomic > 0, 6);
    }

    fun assert_physical_open_binding<T0>(arg0: &0x2::object::UID, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x2::tx_context::TxContext, arg5: u8, arg6: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalMarketCustodyBindingV8) {
        let v0 = if (0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_listing_id_v8(arg6) == 0x2::object::uid_to_inner(arg0)) {
            if (0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_market_registry_id_v8(arg6) == 0x2::object::id<MarketRegistryV8<T0>>(arg1)) {
                0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_market_treasury_id_v8(arg6) == 0x2::object::id<MarketTreasuryV8<T0>>(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg3, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_root_id_v8(arg6), 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_maker_version_v8(arg6), 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_root_content_commitment_v8(arg6));
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_kind_v8(arg6) == arg5, 6);
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(arg6) == 0x2::tx_context::sender(arg4) && 0x2::tx_context::sender(arg4) != @0x0, 8);
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_transferable_v8(arg6), 6);
    }

    fun assert_physical_purchase_boundary<T0>(arg0: &PhysicalListingV8<T0>, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg7: &MarketPackageConfigV8, arg8: u8) {
        assert_config<T0>(arg3, arg4, arg5, arg6, arg7);
        assert_bound_market<T0>(arg1, arg2, arg3, arg7);
        assert_active_market<T0>(arg1, arg2, arg3);
        assert_physical_listing<T0>(arg0, arg1, arg2, arg3, arg7);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg4);
        assert!(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_kind_v8(&arg0.custody) == arg8, 6);
    }

    fun assert_physical_quote<T0>(arg0: &PhysicalListingV8<T0>, arg1: &MarketQuoteV8) {
        assert_asset_quote(arg0.gross_atomic, arg0.protocol_atomic, arg0.creator_atomic, arg0.source_atomic, arg0.seller_atomic, &arg0.quote_commitment, 2, arg1);
    }

    fun assert_protocol_object<T0>(arg0: &MarketRegistryV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) {
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg1) == arg0.protocol_config_id, 1);
    }

    fun assert_return_config<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &MarketPackageConfigV8) {
        assert_structural_config_installation(arg1, arg2, arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_runtime_caller_cap_v1(runtime_caller_cap(arg3), 1, arg2, arg1);
    }

    fun assert_soul_listing<T0>(arg0: &SoulListingV8<T0>, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &MarketPackageConfigV8) {
        assert!(arg0.version == 8 && arg0.status == 0, 6);
        let v0 = if (arg0.registry_id == 0x2::object::id<MarketRegistryV8<T0>>(arg1)) {
            if (arg0.treasury_id == 0x2::object::id<MarketTreasuryV8<T0>>(arg2)) {
                arg0.package_config_id == 0x2::object::id<MarketPackageConfigV8>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_listing_id_v8(&arg0.custody) == 0x2::object::id<SoulListingV8<T0>>(arg0), 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg3, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_root_id_v8(&arg0.custody), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_maker_version_v8(&arg0.custody), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_root_content_commitment_v8(&arg0.custody));
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody) != @0x0 && arg0.gross_atomic > 0, 6);
    }

    fun assert_soul_open_binding<T0>(arg0: &0x2::object::UID, arg1: &MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x2::tx_context::TxContext, arg5: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulMarketCustodyBindingV8) {
        let v0 = if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_listing_id_v8(arg5) == 0x2::object::uid_to_inner(arg0)) {
            if (0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_market_registry_id_v8(arg5) == 0x2::object::id<MarketRegistryV8<T0>>(arg1)) {
                0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_market_treasury_id_v8(arg5) == 0x2::object::id<MarketTreasuryV8<T0>>(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg3, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_root_id_v8(arg5), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_maker_version_v8(arg5), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_root_content_commitment_v8(arg5));
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(arg5) == 0x2::tx_context::sender(arg4) && 0x2::tx_context::sender(arg4) != @0x0, 8);
    }

    fun assert_structural_config_installation(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg2: &MarketPackageConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg1, arg0);
        assert!(arg2.version == 8 && arg2.catalog_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg0), 0);
        let (_, _, _, v3, v4, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        assert!(&arg2.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v3) && &arg2.call_cap_set_commitment == v4, 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_role_config_installation_v2(arg0, 5, 0x2::object::id<MarketPackageConfigV8>(arg2), &arg2.installation_commitment);
    }

    fun assert_zero_state<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>) {
        assert!(arg0.revision == 0, 3);
        assert!(arg0.listing_count == 0 && arg0.escrow_count == 0, 3);
        let v0 = if (arg0.completed_sale_count == 0) {
            if (arg0.canceled_sale_count == 0) {
                arg0.recovered_sale_count == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = if (arg0.gross_volume_atomic == 0) {
            if (arg0.protocol_paid_atomic == 0) {
                if (arg0.creator_paid_atomic == 0) {
                    if (arg0.source_paid_atomic == 0) {
                        arg0.seller_paid_atomic == 0
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
        assert!(v1, 3);
        let v2 = if (0x2::balance::value<T0>(&arg1.escrow) == 0) {
            if (arg1.gross_escrowed_atomic == 0) {
                arg1.gross_released_atomic == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
    }

    fun asset_recoverable<T0>(arg0: &MarketRegistryV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : bool {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg1);
        if (v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8()) {
            true
        } else if (v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_archived_v8()) {
            true
        } else {
            protocol_degraded<T0>(arg0, arg2)
        }
    }

    public fun bind_maker_market_companion_v2<T0>(arg0: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &MarketPackageConfigV8, arg7: &MarketRegistryV8<T0>, arg8: &MarketTreasuryV8<T0>, arg9: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_companion_builder_root_v2<T0>(&arg0, arg1, arg2, arg9);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg5, arg4);
        assert_config<T0>(arg1, arg3, arg4, arg5, arg6);
        assert_market_identity<T0>(arg7, arg8, arg1, arg6);
        assert!(arg7.sealed, 3);
        assert_zero_state<T0>(arg7, arg8);
        let v0 = MakerCompanionBindingWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::append_market_v2<T0, MakerCompanionBindingWitnessV2>(arg0, v0, arg3, arg4, arg5, 0x2::object::id<MarketRegistryV8<T0>>(arg7), arg9)
    }

    public fun cancel_maker_control_listing_v8<T0>(arg0: &mut MakerListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg7: &MarketPackageConfigV8, arg8: 0x2::transfer::Receiving<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_return_config<T0>(arg3, arg5, arg6, arg7);
        assert_bound_market<T0>(arg1, arg2, arg3, arg7);
        assert_maker_listing<T0>(arg0, arg1, arg2, arg3, arg7);
        assert!(0x2::tx_context::sender(arg9) == arg0.seller, 8);
        assert!(0x2::transfer::receiving_object_id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>(&arg8) == arg0.admin_cap_id, 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::resolve_maker_admin_from_market_v8<T0>(arg3, arg4, arg5, arg6, runtime_caller_cap(arg7), &mut arg0.id, arg8, arg0.seller, arg9);
        close_listing<T0>(arg1, arg0, false);
    }

    public fun cancel_physical_listing_v8<T0>(arg0: &mut PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &MarketPackageConfigV8, arg9: 0x2::transfer::Receiving<0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8>, arg10: &0x2::tx_context::TxContext) {
        assert_return_config<T0>(arg4, arg6, arg7, arg8);
        assert_bound_market<T0>(arg1, arg2, arg4, arg8);
        assert_physical_listing<T0>(arg0, arg1, arg2, arg4, arg8);
        assert!(0x2::tx_context::sender(arg10) == 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody), 8);
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::return_physical_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg3, arg4, arg5, arg6, arg7, runtime_caller_cap(arg8), arg1, arg2, &mut arg0.id, arg9, &arg0.custody);
        close_physical_listing<T0>(arg1, arg0, false);
    }

    public fun cancel_soul_listing_v8<T0>(arg0: &mut SoulListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg4: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulRegistryV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg9: &MarketPackageConfigV8, arg10: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8>, arg11: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8>, arg12: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CanonicalSoulV8>, arg13: &mut 0x2::tx_context::TxContext) {
        assert_return_config<T0>(arg5, arg7, arg8, arg9);
        assert_bound_market<T0>(arg1, arg2, arg5, arg9);
        assert_soul_listing<T0>(arg0, arg1, arg2, arg5, arg9);
        assert!(0x2::tx_context::sender(arg13) == 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody), 8);
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::return_soul_bundle_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg10, arg11, arg12, &mut arg0.id, &arg0.custody, arg3, arg4, arg5, arg6, arg7, arg8, arg1, arg2, runtime_caller_cap(arg9));
        close_soul_listing<T0>(arg1, arg0, false);
    }

    fun close_listing<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &mut MakerListingV8<T0>, arg2: bool) {
        assert!(arg0.escrow_count > 0, 3);
        arg0.revision = arg0.revision + 1;
        arg0.escrow_count = arg0.escrow_count - 1;
        if (arg2) {
            arg0.recovered_sale_count = arg0.recovered_sale_count + 1;
            arg1.status = 3;
        } else {
            arg0.canceled_sale_count = arg0.canceled_sale_count + 1;
            arg1.status = 2;
        };
        arg1.revision = arg1.revision + 1;
        arg1.terminal_recipient = arg1.seller;
        let v0 = MarketListingClosedV8{
            listing_id  : 0x2::object::id<MakerListingV8<T0>>(arg1),
            registry_id : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            lane        : 0,
            asset_id    : arg1.admin_cap_id,
            seller      : arg1.seller,
            recovered   : arg2,
        };
        0x2::event::emit<MarketListingClosedV8>(v0);
    }

    fun close_physical_listing<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &mut PhysicalListingV8<T0>, arg2: bool) {
        assert!(arg0.escrow_count > 0, 3);
        arg0.revision = arg0.revision + 1;
        arg0.escrow_count = arg0.escrow_count - 1;
        if (arg2) {
            arg0.recovered_sale_count = arg0.recovered_sale_count + 1;
            arg1.status = 3;
        } else {
            arg0.canceled_sale_count = arg0.canceled_sale_count + 1;
            arg1.status = 2;
        };
        arg1.revision = arg1.revision + 1;
        arg1.terminal_recipient = 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg1.custody);
        let v0 = 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_kind_v8(&arg1.custody);
        let v1 = if (v0 == 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_base_style_v8()) {
            2
        } else {
            assert!(v0 == 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_pack_style_v8(), 6);
            3
        };
        let v2 = MarketListingClosedV8{
            listing_id  : 0x2::object::id<PhysicalListingV8<T0>>(arg1),
            registry_id : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            lane        : v1,
            asset_id    : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_asset_id_v8(&arg1.custody),
            seller      : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg1.custody),
            recovered   : arg2,
        };
        0x2::event::emit<MarketListingClosedV8>(v2);
    }

    fun close_soul_listing<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &mut SoulListingV8<T0>, arg2: bool) {
        assert!(arg0.escrow_count > 0, 3);
        arg0.revision = arg0.revision + 1;
        arg0.escrow_count = arg0.escrow_count - 1;
        if (arg2) {
            arg0.recovered_sale_count = arg0.recovered_sale_count + 1;
            arg1.status = 3;
        } else {
            arg0.canceled_sale_count = arg0.canceled_sale_count + 1;
            arg1.status = 2;
        };
        arg1.revision = arg1.revision + 1;
        arg1.terminal_recipient = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg1.custody);
        let v0 = MarketListingClosedV8{
            listing_id  : 0x2::object::id<SoulListingV8<T0>>(arg1),
            registry_id : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            lane        : 1,
            asset_id    : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_soul_id_v8(&arg1.custody),
            seller      : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg1.custody),
            recovered   : arg2,
        };
        0x2::event::emit<MarketListingClosedV8>(v0);
    }

    public fun config_id_v8(arg0: &MarketPackageConfigV8) : 0x2::object::ID {
        0x2::object::id<MarketPackageConfigV8>(arg0)
    }

    fun derive_quote<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: u8, arg2: u64) : MarketQuoteV8 {
        assert!(arg2 > 0, 4);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_rights_v2<T0>(arg0);
        let (v2, v3, v4) = if (arg1 == 0) {
            (0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_maker_market_fee_bps_v2(&v0), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_resale_royalty_bps_v2(&v1), 0)
        } else {
            assert!(arg1 == 1 || arg1 == 2, 3);
            (0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_soul_market_fee_bps_v2(&v0), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_soul_creator_royalty_bps_v2(&v1), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_source_royalty_bps_v2(&v1))
        };
        let v5 = share(arg2, v2);
        let v6 = share(arg2, v3);
        let v7 = share(arg2, v4);
        assert!((v5 as u128) + (v6 as u128) + (v7 as u128) < (arg2 as u128), 4);
        let v8 = arg2 - v5 - v6 - v7;
        assert!(v8 > 0, 4);
        let v9 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0);
        let v10 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0);
        let v11 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v12 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_commitment_v2(&v0);
        let v13 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_commitment_v2(&v1);
        let v14 = MarketQuoteCommitmentInputV8{
            domain                  : b"animacraft-v8/market/quote",
            version                 : 8,
            quote_kind              : arg1,
            root_id                 : v9,
            maker_version           : v10,
            root_content_commitment : v11,
            economics_commitment    : v12,
            rights_commitment       : v13,
            gross_atomic            : arg2,
            protocol_atomic         : v5,
            creator_atomic          : v6,
            source_atomic           : v7,
            seller_atomic           : v8,
        };
        MarketQuoteV8{
            quote_kind              : arg1,
            root_id                 : v9,
            maker_version           : v10,
            root_content_commitment : v11,
            economics_commitment    : v12,
            rights_commitment       : v13,
            gross_atomic            : arg2,
            protocol_atomic         : v5,
            creator_atomic          : v6,
            source_atomic           : v7,
            seller_atomic           : v8,
            commitment              : 0x1::hash::sha2_256(0x1::bcs::to_bytes<MarketQuoteCommitmentInputV8>(&v14)),
        }
    }

    fun derive_zero_state_commitment<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &MarketPackageConfigV8, arg2: 0x2::object::ID, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::EconomicsSnapshotV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::RightsSnapshotV8) : vector<u8> {
        let v0 = MarketZeroStateCommitmentInputV8{
            domain                     : b"animacraft-v8/market/zero-state",
            version                    : 8,
            catalog_id                 : arg1.catalog_id,
            package_config_id          : 0x2::object::id<MarketPackageConfigV8>(arg1),
            product_binding_commitment : arg1.product_binding_commitment,
            call_cap_set_commitment    : arg1.call_cap_set_commitment,
            root_id                    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            protocol_config_id         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_id_v2(arg3),
            protocol_config_revision   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_revision_v2(arg3),
            protocol_config_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_commitment_v2(arg3),
            economics_commitment       : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_commitment_v2(arg3),
            rights_commitment          : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_commitment_v2(arg4),
            maker_market_fee_bps       : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_maker_market_fee_bps_v2(arg3),
            soul_market_fee_bps        : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_soul_market_fee_bps_v2(arg3),
            soul_creator_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_soul_creator_royalty_bps_v2(arg4),
            maker_source_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_source_royalty_bps_v2(arg4),
            maker_resale_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_resale_royalty_bps_v2(arg4),
            treasury_id                : arg2,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<MarketZeroStateCommitmentInputV8>(&v0))
    }

    fun escrow_payment<T0>(arg0: &mut MarketTreasuryV8<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) == arg2, 7);
        0x2::coin::put<T0>(&mut arg0.escrow, arg1);
        arg0.gross_escrowed_atomic = arg0.gross_escrowed_atomic + (arg2 as u128);
    }

    public fun install_market_runtime_caller_cap_v2(arg0: &mut MarketPackageConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleBootstrapAdminV2, arg5: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1) {
        assert_config_installation(arg1, arg2, arg3, arg0);
        assert!(0x1::option::is_none<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>(&arg0.runtime_caller_cap), 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_runtime_caller_cap_v1(&arg5, 1, arg3, arg2);
        0x1::option::fill<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>(&mut arg0.runtime_caller_cap, arg5);
        let v0 = MarketRuntimeCallerCapInstallWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::mark_fresh_tuple_install_v2<MarketRuntimeCallerCapInstallWitnessV2>(arg1, arg4, arg3, arg2, v0, 8, 0x2::object::id<MarketPackageConfigV8>(arg0), 0x1::option::none<0x2::object::ID>(), *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::runtime_caller_cap_commitment_v2(&arg5));
    }

    public fun list_base_physical_v8<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalPackageConfigV8, arg9: &MarketPackageConfigV8, arg10: 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_config<T0>(arg3, arg5, arg6, arg7, arg9);
        assert_bound_market<T0>(arg0, arg1, arg3, arg9);
        assert_active_market<T0>(arg0, arg1, arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg5);
        let v0 = derive_quote<T0>(arg3, 2, arg11);
        let v1 = 0x2::object::new(arg12);
        let v2 = 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::consume_physical_market_custody_ticket_v8(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::custody_base_physical_for_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg2, arg3, arg5, arg6, arg7, arg8, runtime_caller_cap(arg9), arg0, arg1, &mut v1, arg4, arg10, arg12));
        assert_physical_open_binding<T0>(&v1, arg0, arg1, arg3, arg12, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_base_style_v8(), &v2);
        let v3 = PhysicalListingV8<T0>{
            id                 : v1,
            version            : 8,
            registry_id        : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id        : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            package_config_id  : 0x2::object::id<MarketPackageConfigV8>(arg9),
            custody            : v2,
            gross_atomic       : v0.gross_atomic,
            protocol_atomic    : v0.protocol_atomic,
            creator_atomic     : v0.creator_atomic,
            source_atomic      : v0.source_atomic,
            seller_atomic      : v0.seller_atomic,
            quote_commitment   : v0.commitment,
            status             : 0,
            revision           : 0,
            terminal_recipient : @0x0,
        };
        share_physical_listing<T0>(v3, arg0, arg3, 2)
    }

    public fun list_maker_control_v8<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &MarketPackageConfigV8, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_config<T0>(arg2, arg5, arg6, arg7, arg8);
        assert_bound_market<T0>(arg0, arg1, arg2, arg8);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8(), 3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg2, arg5);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg2, arg4);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::maker_treasury_balance_v2<T0>(arg4) == 0, 3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_admin_v8<T0>(arg2, &arg3);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg2);
        assert!(v0 == 0x2::tx_context::sender(arg10), 8);
        let v1 = 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>(&arg3);
        let v2 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_control_epoch_v2<T0>(arg2);
        let v3 = derive_quote<T0>(arg2, 0, arg9);
        let v4 = MakerListingV8<T0>{
            id                      : 0x2::object::new(arg10),
            version                 : 8,
            registry_id             : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id             : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            package_config_id       : 0x2::object::id<MarketPackageConfigV8>(arg8),
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg2),
            admin_cap_id            : v1,
            seller                  : v0,
            expected_control_epoch  : v2,
            gross_atomic            : arg9,
            protocol_atomic         : v3.protocol_atomic,
            creator_atomic          : v3.creator_atomic,
            seller_atomic           : v3.seller_atomic,
            quote_commitment        : v3.commitment,
            status                  : 0,
            revision                : 0,
            terminal_recipient      : @0x0,
        };
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::custody_maker_admin_for_market_v8<T0>(arg2, arg3, arg5, arg6, arg7, runtime_caller_cap(arg8), &mut v4.id);
        open_listing<T0>(arg0);
        let v5 = 0x2::object::id<MakerListingV8<T0>>(&v4);
        let v6 = MarketListingOpenedV8{
            listing_id       : v5,
            registry_id      : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            lane             : 0,
            root_id          : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            asset_id         : v1,
            seller           : v0,
            ownership_epoch  : v2,
            gross_atomic     : arg9,
            quote_commitment : v3.commitment,
        };
        0x2::event::emit<MarketListingOpenedV8>(v6);
        0x2::transfer::share_object<MakerListingV8<T0>>(v4);
        v5
    }

    public fun list_pack_physical_v8<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalPackageConfigV8, arg9: &MarketPackageConfigV8, arg10: 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_config<T0>(arg3, arg5, arg6, arg7, arg9);
        assert_bound_market<T0>(arg0, arg1, arg3, arg9);
        assert_active_market<T0>(arg0, arg1, arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg5);
        let v0 = derive_quote<T0>(arg3, 2, arg11);
        let v1 = 0x2::object::new(arg12);
        let v2 = 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::consume_physical_market_custody_ticket_v8(0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::custody_pack_physical_for_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg2, arg3, arg5, arg6, arg7, arg8, runtime_caller_cap(arg9), arg0, arg1, &mut v1, arg4, arg10, arg12));
        assert_physical_open_binding<T0>(&v1, arg0, arg1, arg3, arg12, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_pack_style_v8(), &v2);
        let v3 = PhysicalListingV8<T0>{
            id                 : v1,
            version            : 8,
            registry_id        : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id        : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            package_config_id  : 0x2::object::id<MarketPackageConfigV8>(arg9),
            custody            : v2,
            gross_atomic       : v0.gross_atomic,
            protocol_atomic    : v0.protocol_atomic,
            creator_atomic     : v0.creator_atomic,
            source_atomic      : v0.source_atomic,
            seller_atomic      : v0.seller_atomic,
            quote_commitment   : v0.commitment,
            status             : 0,
            revision           : 0,
            terminal_recipient : @0x0,
        };
        share_physical_listing<T0>(v3, arg0, arg3, 3)
    }

    public fun list_soul_bundle_v8<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg3: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &MarketPackageConfigV8, arg9: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8, arg10: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8, arg11: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CanonicalSoulV8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_config<T0>(arg4, arg5, arg6, arg7, arg8);
        assert_bound_market<T0>(arg0, arg1, arg4, arg8);
        assert_active_market<T0>(arg0, arg1, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg4, arg5);
        let v0 = derive_quote<T0>(arg4, 1, arg12);
        let v1 = 0x2::object::new(arg13);
        let v2 = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::consume_soul_market_custody_ticket_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::custody_soul_bundle_for_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg9, arg10, arg11, &mut v1, arg2, arg3, arg4, arg5, arg6, arg7, arg0, arg1, runtime_caller_cap(arg8), arg13), &v1, arg2, arg3, arg4, arg5, arg6, arg7, arg0, arg1, runtime_caller_cap(arg8));
        assert_soul_open_binding<T0>(&v1, arg0, arg1, arg4, arg13, &v2);
        let v3 = SoulListingV8<T0>{
            id                 : v1,
            version            : 8,
            registry_id        : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id        : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            package_config_id  : 0x2::object::id<MarketPackageConfigV8>(arg8),
            custody            : v2,
            gross_atomic       : arg12,
            protocol_atomic    : v0.protocol_atomic,
            creator_atomic     : v0.creator_atomic,
            source_atomic      : v0.source_atomic,
            seller_atomic      : v0.seller_atomic,
            quote_commitment   : v0.commitment,
            status             : 0,
            revision           : 0,
            terminal_recipient : @0x0,
        };
        open_listing<T0>(arg0);
        let v4 = 0x2::object::id<SoulListingV8<T0>>(&v3);
        let v5 = MarketListingOpenedV8{
            listing_id       : v4,
            registry_id      : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            lane             : 1,
            root_id          : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg4),
            asset_id         : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_soul_id_v8(&v2),
            seller           : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&v2),
            ownership_epoch  : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_expected_epoch_v8(&v2),
            gross_atomic     : arg12,
            quote_commitment : v0.commitment,
        };
        0x2::event::emit<MarketListingOpenedV8>(v5);
        0x2::transfer::share_object<SoulListingV8<T0>>(v3);
        v4
    }

    public fun listing_canceled_v8() : u8 {
        2
    }

    public fun listing_open_v8() : u8 {
        0
    }

    public fun listing_recovered_v8() : u8 {
        3
    }

    public fun listing_settled_v8() : u8 {
        1
    }

    public fun maker_listing_admin_cap_id_v8<T0>(arg0: &MakerListingV8<T0>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun maker_listing_control_epoch_v8<T0>(arg0: &MakerListingV8<T0>) : u64 {
        arg0.expected_control_epoch
    }

    public fun maker_listing_gross_atomic_v8<T0>(arg0: &MakerListingV8<T0>) : u64 {
        arg0.gross_atomic
    }

    public fun maker_listing_id_v8<T0>(arg0: &MakerListingV8<T0>) : 0x2::object::ID {
        0x2::object::id<MakerListingV8<T0>>(arg0)
    }

    public fun maker_listing_quote_commitment_v8<T0>(arg0: &MakerListingV8<T0>) : &vector<u8> {
        &arg0.quote_commitment
    }

    public fun maker_listing_registry_id_v8<T0>(arg0: &MakerListingV8<T0>) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun maker_listing_root_id_v8<T0>(arg0: &MakerListingV8<T0>) : 0x2::object::ID {
        arg0.root_id
    }

    public fun maker_listing_seller_v8<T0>(arg0: &MakerListingV8<T0>) : address {
        arg0.seller
    }

    public fun maker_listing_status_v8<T0>(arg0: &MakerListingV8<T0>) : u8 {
        arg0.status
    }

    public fun maker_listing_terminal_recipient_v8<T0>(arg0: &MakerListingV8<T0>) : address {
        arg0.terminal_recipient
    }

    public fun maker_listing_treasury_id_v8<T0>(arg0: &MakerListingV8<T0>) : 0x2::object::ID {
        arg0.treasury_id
    }

    fun new_market_objects<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &MarketPackageConfigV8, arg2: &mut 0x2::tx_context::TxContext) : (MarketRegistryV8<T0>, MarketTreasuryV8<T0>) {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_rights_v2<T0>(arg0);
        let v2 = MarketTreasuryV8<T0>{
            id                      : 0x2::object::new(arg2),
            version                 : 8,
            catalog_id              : arg1.catalog_id,
            package_config_id       : 0x2::object::id<MarketPackageConfigV8>(arg1),
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            escrow                  : 0x2::balance::zero<T0>(),
            gross_escrowed_atomic   : 0,
            gross_released_atomic   : 0,
        };
        let v3 = 0x2::object::id<MarketTreasuryV8<T0>>(&v2);
        let v4 = MarketRegistryV8<T0>{
            id                         : 0x2::object::new(arg2),
            catalog_id                 : arg1.catalog_id,
            package_config_id          : 0x2::object::id<MarketPackageConfigV8>(arg1),
            product_binding_commitment : arg1.product_binding_commitment,
            call_cap_set_commitment    : arg1.call_cap_set_commitment,
            root_id                    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            protocol_config_id         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_id_v2(&v0),
            protocol_config_revision   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_revision_v2(&v0),
            protocol_config_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_commitment_v2(&v0),
            economics_commitment       : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_commitment_v2(&v0),
            rights_commitment          : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_commitment_v2(&v1),
            maker_market_fee_bps       : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_maker_market_fee_bps_v2(&v0),
            soul_market_fee_bps        : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_soul_market_fee_bps_v2(&v0),
            soul_creator_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_soul_creator_royalty_bps_v2(&v1),
            maker_source_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_source_royalty_bps_v2(&v1),
            maker_resale_royalty_bps   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::rights_maker_resale_royalty_bps_v2(&v1),
            treasury_id                : v3,
            sealed                     : false,
            revision                   : 0,
            listing_count              : 0,
            escrow_count               : 0,
            completed_sale_count       : 0,
            canceled_sale_count        : 0,
            recovered_sale_count       : 0,
            gross_volume_atomic        : 0,
            protocol_paid_atomic       : 0,
            creator_paid_atomic        : 0,
            source_paid_atomic         : 0,
            seller_paid_atomic         : 0,
            zero_state_commitment      : derive_zero_state_commitment<T0>(arg0, arg1, v3, &v0, &v1),
        };
        (v4, v2)
    }

    public fun new_market_objects_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &MarketPackageConfigV8, arg6: &mut 0x2::tx_context::TxContext) : (MarketRegistryV8<T0>, MarketTreasuryV8<T0>) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_config<T0>(arg0, arg2, arg3, arg4, arg5);
        new_market_objects<T0>(arg0, arg5, arg6)
    }

    public fun new_market_package_config_v8(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PackageCallCapV8<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::MarketRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : MarketPackageConfigV8 {
        let v0 = 0x2::object::new(arg2);
        let v1 = MarketSetupInstallWitnessV2{dummy_field: false};
        let (_, _, _, v5, v6, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        MarketPackageConfigV8{
            id                         : v0,
            version                    : 8,
            catalog_id                 : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg0),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v5),
            call_cap_set_commitment    : *v6,
            installation_commitment    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::consume_market_call_cap_v8<MarketSetupInstallWitnessV2>(arg0, arg1, v1, 0x2::object::uid_to_inner(&v0)),
            runtime_caller_cap         : 0x1::option::none<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>(),
        }
    }

    fun open_listing<T0>(arg0: &mut MarketRegistryV8<T0>) {
        arg0.revision = arg0.revision + 1;
        arg0.listing_count = arg0.listing_count + 1;
        arg0.escrow_count = arg0.escrow_count + 1;
    }

    public fun physical_listing_asset_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_asset_id_v8(&arg0.custody)
    }

    public fun physical_listing_gross_atomic_v8<T0>(arg0: &PhysicalListingV8<T0>) : u64 {
        arg0.gross_atomic
    }

    public fun physical_listing_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        0x2::object::id<PhysicalListingV8<T0>>(arg0)
    }

    public fun physical_listing_ownership_epoch_v8<T0>(arg0: &PhysicalListingV8<T0>) : u64 {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_ownership_epoch_v8(&arg0.custody)
    }

    public fun physical_listing_quote_commitment_v8<T0>(arg0: &PhysicalListingV8<T0>) : &vector<u8> {
        &arg0.quote_commitment
    }

    public fun physical_listing_registry_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun physical_listing_seller_v8<T0>(arg0: &PhysicalListingV8<T0>) : address {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody)
    }

    public fun physical_listing_source_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_id_v8(&arg0.custody)
    }

    public fun physical_listing_source_kind_v8<T0>(arg0: &PhysicalListingV8<T0>) : u8 {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_kind_v8(&arg0.custody)
    }

    public fun physical_listing_source_treasury_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_source_treasury_id_v8(&arg0.custody)
    }

    public fun physical_listing_status_v8<T0>(arg0: &PhysicalListingV8<T0>) : u8 {
        arg0.status
    }

    public fun physical_listing_terminal_recipient_v8<T0>(arg0: &PhysicalListingV8<T0>) : address {
        arg0.terminal_recipient
    }

    public fun physical_listing_treasury_id_v8<T0>(arg0: &PhysicalListingV8<T0>) : 0x2::object::ID {
        arg0.treasury_id
    }

    fun protocol_degraded<T0>(arg0: &MarketRegistryV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : bool {
        if (!0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_enabled_v2(arg1)) {
            true
        } else if (0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_revision_v8(arg1) != arg0.protocol_config_revision) {
            true
        } else {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_commitment_v8(arg1) != &arg0.protocol_config_commitment
        }
    }

    public fun purchase_base_physical_v8<T0>(arg0: &mut PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &mut MarketTreasuryV8<T0>, arg3: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg7: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg10: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalPackageConfigV8, arg11: &MarketPackageConfigV8, arg12: 0x2::transfer::Receiving<0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8>, arg13: 0x2::coin::Coin<T0>, arg14: &mut 0x2::tx_context::TxContext) {
        assert_physical_purchase_boundary<T0>(arg0, arg1, arg2, arg4, arg6, arg8, arg9, arg11, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_base_style_v8());
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg4, arg5);
        let v0 = derive_quote<T0>(arg4, 2, arg0.gross_atomic);
        assert_physical_quote<T0>(arg0, &v0);
        escrow_payment<T0>(arg2, arg13, arg0.gross_atomic);
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::purchase_base_physical_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg3, arg4, arg6, arg8, arg9, arg10, runtime_caller_cap(arg11), arg1, arg2, &mut arg0.id, arg5, arg12, &arg0.custody, arg14);
        let v1 = 0x2::tx_context::sender(arg14);
        release_maker_source_payment<T0>(arg2, arg4, arg5, arg6, arg7, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody), &v0, arg14);
        settle_physical_sale<T0>(arg0, arg1, &v0, v1, 2);
    }

    public fun purchase_maker_control_v8<T0>(arg0: &mut MakerListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &mut MarketTreasuryV8<T0>, arg3: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &MarketPackageConfigV8, arg9: 0x2::transfer::Receiving<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>, arg10: 0x2::coin::Coin<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg3, arg4, arg6, arg7, arg8);
        assert_bound_market<T0>(arg1, arg2, arg3, arg8);
        assert_maker_listing<T0>(arg0, arg1, arg2, arg3, arg8);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg3) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8(), 3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg3, arg4);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg3) == arg0.seller, 6);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_control_epoch_v2<T0>(arg3) == arg0.expected_control_epoch, 6);
        assert!(0x2::transfer::receiving_object_id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>(&arg9) == arg0.admin_cap_id, 6);
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(v0 != arg0.seller, 8);
        let v1 = derive_quote<T0>(arg3, 0, arg0.gross_atomic);
        assert_maker_quote<T0>(arg0, &v1);
        escrow_payment<T0>(arg2, arg10, arg0.gross_atomic);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::resolve_maker_admin_from_market_v8<T0>(arg3, arg4, arg6, arg7, runtime_caller_cap(arg8), &mut arg0.id, arg9, v0, arg11);
        release_maker_payment<T0>(arg2, arg4, arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_creator_v2<T0>(arg3), arg0.seller, &v1, arg11);
        settle_listing<T0>(arg1, arg0.gross_atomic, &v1);
        arg0.status = 1;
        arg0.revision = arg0.revision + 1;
        arg0.terminal_recipient = v0;
        let v2 = MarketListingSettledV8{
            listing_id      : 0x2::object::id<MakerListingV8<T0>>(arg0),
            registry_id     : 0x2::object::id<MarketRegistryV8<T0>>(arg1),
            lane            : 0,
            asset_id        : arg0.admin_cap_id,
            seller          : arg0.seller,
            buyer           : v0,
            gross_atomic    : v1.gross_atomic,
            protocol_atomic : v1.protocol_atomic,
            creator_atomic  : v1.creator_atomic,
            source_atomic   : 0,
            seller_atomic   : v1.seller_atomic,
        };
        0x2::event::emit<MarketListingSettledV8>(v2);
    }

    public fun purchase_pack_physical_v8<T0>(arg0: &mut PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &mut MarketTreasuryV8<T0>, arg3: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg6: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg8: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg11: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalPackageConfigV8, arg12: &MarketPackageConfigV8, arg13: 0x2::transfer::Receiving<0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8>, arg14: 0x2::coin::Coin<T0>, arg15: &mut 0x2::tx_context::TxContext) {
        assert_physical_purchase_boundary<T0>(arg0, arg1, arg2, arg4, arg7, arg9, arg10, arg12, 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::source_pack_style_v8());
        let v0 = derive_quote<T0>(arg4, 2, arg0.gross_atomic);
        assert_physical_quote<T0>(arg0, &v0);
        escrow_payment<T0>(arg2, arg14, arg0.gross_atomic);
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::purchase_pack_physical_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg3, arg4, arg7, arg9, arg10, arg11, runtime_caller_cap(arg12), arg1, arg2, &mut arg0.id, arg6, arg13, &arg0.custody, arg15);
        let v1 = 0x2::tx_context::sender(arg15);
        release_pack_source_payment<T0>(arg2, arg5, arg6, arg7, arg8, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_creator_v2<T0>(arg4), 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody), &v0, arg15);
        settle_physical_sale<T0>(arg0, arg1, &v0, v1, 3);
    }

    public fun purchase_soul_bundle_v8<T0>(arg0: &mut SoulListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &mut MarketTreasuryV8<T0>, arg3: &mut 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg4: &mut 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulRegistryV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg8: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg11: &MarketPackageConfigV8, arg12: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8>, arg13: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8>, arg14: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CanonicalSoulV8>, arg15: 0x2::coin::Coin<T0>, arg16: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg5, arg7, arg9, arg10, arg11);
        assert_bound_market<T0>(arg1, arg2, arg5, arg11);
        assert_active_market<T0>(arg1, arg2, arg5);
        assert_soul_listing<T0>(arg0, arg1, arg2, arg5, arg11);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg5, arg7);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(v0 != 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody), 8);
        let v1 = derive_quote<T0>(arg5, 1, arg0.gross_atomic);
        assert_asset_quote(arg0.gross_atomic, arg0.protocol_atomic, arg0.creator_atomic, arg0.source_atomic, arg0.seller_atomic, &arg0.quote_commitment, 1, &v1);
        escrow_payment<T0>(arg2, arg15, arg0.gross_atomic);
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::purchase_soul_bundle_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg12, arg13, arg14, &mut arg0.id, &arg0.custody, arg3, arg4, arg5, arg7, arg9, arg10, arg1, arg2, runtime_caller_cap(arg11), v0);
        release_maker_source_payment<T0>(arg2, arg5, arg6, arg7, arg8, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody), &v1, arg16);
        settle_listing<T0>(arg1, arg0.gross_atomic, &v1);
        arg0.status = 1;
        arg0.revision = arg0.revision + 1;
        arg0.terminal_recipient = v0;
        let v2 = MarketListingSettledV8{
            listing_id      : 0x2::object::id<SoulListingV8<T0>>(arg0),
            registry_id     : 0x2::object::id<MarketRegistryV8<T0>>(arg1),
            lane            : 1,
            asset_id        : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_soul_id_v8(&arg0.custody),
            seller          : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody),
            buyer           : v0,
            gross_atomic    : v1.gross_atomic,
            protocol_atomic : v1.protocol_atomic,
            creator_atomic  : v1.creator_atomic,
            source_atomic   : v1.source_atomic,
            seller_atomic   : v1.seller_atomic,
        };
        0x2::event::emit<MarketListingSettledV8>(v2);
    }

    public fun quote_commitment_v8(arg0: &MarketQuoteV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun quote_creator_atomic_v8(arg0: &MarketQuoteV8) : u64 {
        arg0.creator_atomic
    }

    public fun quote_gross_atomic_v8(arg0: &MarketQuoteV8) : u64 {
        arg0.gross_atomic
    }

    public fun quote_kind_v8(arg0: &MarketQuoteV8) : u8 {
        arg0.quote_kind
    }

    public fun quote_maker_resale_kind_v8() : u8 {
        0
    }

    public fun quote_maker_resale_v8<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: u64) : MarketQuoteV8 {
        assert_live_market<T0>(arg0, arg1, arg2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2);
        assert!(v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8() || v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8(), 3);
        derive_quote<T0>(arg2, 0, arg3)
    }

    public fun quote_physical_resale_kind_v8() : u8 {
        2
    }

    public fun quote_physical_resale_v8<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: u64) : MarketQuoteV8 {
        assert_active_market<T0>(arg0, arg1, arg2);
        derive_quote<T0>(arg2, 2, arg3)
    }

    public fun quote_protocol_atomic_v8(arg0: &MarketQuoteV8) : u64 {
        arg0.protocol_atomic
    }

    public fun quote_seller_atomic_v8(arg0: &MarketQuoteV8) : u64 {
        arg0.seller_atomic
    }

    public fun quote_soul_resale_kind_v8() : u8 {
        1
    }

    public fun quote_soul_resale_v8<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: u64) : MarketQuoteV8 {
        assert_active_market<T0>(arg0, arg1, arg2);
        derive_quote<T0>(arg2, 1, arg3)
    }

    public fun quote_source_atomic_v8(arg0: &MarketQuoteV8) : u64 {
        arg0.source_atomic
    }

    fun readiness_commitment<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>) : vector<u8> {
        let v0 = MarketReadinessCommitmentInputV8{
            domain                         : b"animacraft-v8/market/readiness",
            version                        : 8,
            registry_id                    : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id                    : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            zero_state_commitment          : arg0.zero_state_commitment,
            sealed                         : arg0.sealed,
            revision                       : arg0.revision,
            listing_count                  : arg0.listing_count,
            escrow_count                   : arg0.escrow_count,
            completed_sale_count           : arg0.completed_sale_count,
            canceled_sale_count            : arg0.canceled_sale_count,
            recovered_sale_count           : arg0.recovered_sale_count,
            gross_volume_atomic            : arg0.gross_volume_atomic,
            protocol_paid_atomic           : arg0.protocol_paid_atomic,
            creator_paid_atomic            : arg0.creator_paid_atomic,
            source_paid_atomic             : arg0.source_paid_atomic,
            seller_paid_atomic             : arg0.seller_paid_atomic,
            treasury_balance_atomic        : 0x2::balance::value<T0>(&arg1.escrow),
            treasury_gross_escrowed_atomic : arg1.gross_escrowed_atomic,
            treasury_gross_released_atomic : arg1.gross_released_atomic,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<MarketReadinessCommitmentInputV8>(&v0))
    }

    public fun recover_maker_control_listing_v8<T0>(arg0: &mut MakerListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg7: &MarketPackageConfigV8, arg8: 0x2::transfer::Receiving<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_return_config<T0>(arg3, arg5, arg6, arg7);
        assert_bound_market<T0>(arg1, arg2, arg3, arg7);
        assert_maker_listing<T0>(arg0, arg1, arg2, arg3, arg7);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg4) == arg1.protocol_config_id, 1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg3) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_archived_v8() || protocol_degraded<T0>(arg1, arg4), 9);
        assert!(0x2::transfer::receiving_object_id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>(&arg8) == arg0.admin_cap_id, 6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::resolve_maker_admin_from_market_v8<T0>(arg3, arg4, arg5, arg6, runtime_caller_cap(arg7), &mut arg0.id, arg8, arg0.seller, arg9);
        close_listing<T0>(arg1, arg0, true);
    }

    public fun recover_physical_listing_v8<T0>(arg0: &mut PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg8: &MarketPackageConfigV8, arg9: 0x2::transfer::Receiving<0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalAssetV8>) {
        assert_return_config<T0>(arg4, arg6, arg7, arg8);
        assert_bound_market<T0>(arg1, arg2, arg4, arg8);
        assert_physical_listing<T0>(arg0, arg1, arg2, arg4, arg8);
        assert_protocol_object<T0>(arg1, arg5);
        assert!(asset_recoverable<T0>(arg1, arg4, arg5), 9);
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::return_physical_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg3, arg4, arg5, arg6, arg7, runtime_caller_cap(arg8), arg1, arg2, &mut arg0.id, arg9, &arg0.custody);
        close_physical_listing<T0>(arg1, arg0, true);
    }

    public fun recover_soul_listing_v8<T0>(arg0: &mut SoulListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketTreasuryV8<T0>, arg3: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg4: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulRegistryV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg9: &MarketPackageConfigV8, arg10: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8>, arg11: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8>, arg12: 0x2::transfer::Receiving<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CanonicalSoulV8>) {
        assert_return_config<T0>(arg5, arg7, arg8, arg9);
        assert_bound_market<T0>(arg1, arg2, arg5, arg9);
        assert_soul_listing<T0>(arg0, arg1, arg2, arg5, arg9);
        assert_protocol_object<T0>(arg1, arg6);
        assert!(asset_recoverable<T0>(arg1, arg5, arg6), 9);
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::return_soul_bundle_from_market_v8<T0, MarketRegistryV8<T0>, MarketTreasuryV8<T0>>(arg10, arg11, arg12, &mut arg0.id, &arg0.custody, arg3, arg4, arg5, arg6, arg7, arg8, arg1, arg2, runtime_caller_cap(arg9));
        close_soul_listing<T0>(arg1, arg0, true);
    }

    public fun registry_canceled_sale_count_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.canceled_sale_count
    }

    public fun registry_catalog_id_v8<T0>(arg0: &MarketRegistryV8<T0>) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun registry_completed_sale_count_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.completed_sale_count
    }

    public fun registry_creator_paid_atomic_v8<T0>(arg0: &MarketRegistryV8<T0>) : u128 {
        arg0.creator_paid_atomic
    }

    public fun registry_escrow_count_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.escrow_count
    }

    public fun registry_gross_volume_atomic_v8<T0>(arg0: &MarketRegistryV8<T0>) : u128 {
        arg0.gross_volume_atomic
    }

    public fun registry_id_v8<T0>(arg0: &MarketRegistryV8<T0>) : 0x2::object::ID {
        0x2::object::id<MarketRegistryV8<T0>>(arg0)
    }

    public fun registry_listing_count_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.listing_count
    }

    public fun registry_maker_market_fee_bps_v8<T0>(arg0: &MarketRegistryV8<T0>) : u16 {
        arg0.maker_market_fee_bps
    }

    public fun registry_maker_resale_royalty_bps_v8<T0>(arg0: &MarketRegistryV8<T0>) : u16 {
        arg0.maker_resale_royalty_bps
    }

    public fun registry_maker_source_royalty_bps_v8<T0>(arg0: &MarketRegistryV8<T0>) : u16 {
        arg0.maker_source_royalty_bps
    }

    public fun registry_maker_version_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.maker_version
    }

    public fun registry_package_config_id_v8<T0>(arg0: &MarketRegistryV8<T0>) : 0x2::object::ID {
        arg0.package_config_id
    }

    public fun registry_protocol_paid_atomic_v8<T0>(arg0: &MarketRegistryV8<T0>) : u128 {
        arg0.protocol_paid_atomic
    }

    public fun registry_recovered_sale_count_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.recovered_sale_count
    }

    public fun registry_revision_v8<T0>(arg0: &MarketRegistryV8<T0>) : u64 {
        arg0.revision
    }

    public fun registry_root_content_commitment_v8<T0>(arg0: &MarketRegistryV8<T0>) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun registry_root_id_v8<T0>(arg0: &MarketRegistryV8<T0>) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_sealed_v8<T0>(arg0: &MarketRegistryV8<T0>) : bool {
        arg0.sealed
    }

    public fun registry_seller_paid_atomic_v8<T0>(arg0: &MarketRegistryV8<T0>) : u128 {
        arg0.seller_paid_atomic
    }

    public fun registry_soul_creator_royalty_bps_v8<T0>(arg0: &MarketRegistryV8<T0>) : u16 {
        arg0.soul_creator_royalty_bps
    }

    public fun registry_soul_market_fee_bps_v8<T0>(arg0: &MarketRegistryV8<T0>) : u16 {
        arg0.soul_market_fee_bps
    }

    public fun registry_source_paid_atomic_v8<T0>(arg0: &MarketRegistryV8<T0>) : u128 {
        arg0.source_paid_atomic
    }

    public fun registry_treasury_id_v8<T0>(arg0: &MarketRegistryV8<T0>) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun registry_zero_state_commitment_v8<T0>(arg0: &MarketRegistryV8<T0>) : &vector<u8> {
        &arg0.zero_state_commitment
    }

    fun release_maker_payment<T0>(arg0: &mut MarketTreasuryV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg3: address, arg4: address, arg5: &MarketQuoteV8, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg5.protocol_atomic > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg1, arg2, 0x2::coin::take<T0>(&mut arg0.escrow, arg5.protocol_atomic, arg6));
        };
        if (arg5.creator_atomic > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg5.creator_atomic, arg6), arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg5.seller_atomic, arg6), arg4);
        arg0.gross_released_atomic = arg0.gross_released_atomic + (arg5.gross_atomic as u128);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == 0, 3);
    }

    fun release_maker_source_payment<T0>(arg0: &mut MarketTreasuryV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg5: address, arg6: &MarketQuoteV8, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6.protocol_atomic > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg3, arg4, 0x2::coin::take<T0>(&mut arg0.escrow, arg6.protocol_atomic, arg7));
        };
        if (arg6.creator_atomic > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg6.creator_atomic, arg7), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_creator_v2<T0>(arg1));
        };
        if (arg6.source_atomic > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::deposit_maker_revenue_v8<T0>(arg1, arg2, arg3, 0x2::coin::take<T0>(&mut arg0.escrow, arg6.source_atomic, arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg6.seller_atomic, arg7), arg5);
        arg0.gross_released_atomic = arg0.gross_released_atomic + (arg6.gross_atomic as u128);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == 0, 3);
    }

    fun release_pack_source_payment<T0>(arg0: &mut MarketTreasuryV8<T0>, arg1: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg2: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg5: address, arg6: address, arg7: &MarketQuoteV8, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7.protocol_atomic > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg3, arg4, 0x2::coin::take<T0>(&mut arg0.escrow, arg7.protocol_atomic, arg8));
        };
        if (arg7.creator_atomic > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg7.creator_atomic, arg8), arg5);
        };
        if (arg7.source_atomic > 0) {
            0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::deposit_pack_revenue_v8<T0>(arg1, arg2, 0x2::coin::take<T0>(&mut arg0.escrow, arg7.source_atomic, arg8));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, arg7.seller_atomic, arg8), arg6);
        arg0.gross_released_atomic = arg0.gross_released_atomic + (arg7.gross_atomic as u128);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == 0, 3);
    }

    fun runtime_caller_cap(arg0: &MarketPackageConfigV8) : &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1 {
        assert!(0x1::option::is_some<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>(&arg0.runtime_caller_cap), 0);
        0x1::option::borrow<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1>(&arg0.runtime_caller_cap)
    }

    public fun seal_market_registry_v8<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg7: &MarketPackageConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg2, arg3);
        assert_config<T0>(arg2, arg4, arg5, arg6, arg7);
        assert_market_identity<T0>(arg0, arg1, arg2, arg7);
        assert_zero_state<T0>(arg0, arg1);
        assert!(!arg0.sealed, 3);
        arg0.sealed = true;
        let v0 = MarketRegistrySealedV8{
            root_id               : arg0.root_id,
            registry_id           : 0x2::object::id<MarketRegistryV8<T0>>(arg0),
            treasury_id           : 0x2::object::id<MarketTreasuryV8<T0>>(arg1),
            zero_state_commitment : arg0.zero_state_commitment,
        };
        0x2::event::emit<MarketRegistrySealedV8>(v0);
    }

    fun settle_listing<T0>(arg0: &mut MarketRegistryV8<T0>, arg1: u64, arg2: &MarketQuoteV8) {
        assert!(arg0.escrow_count > 0, 3);
        arg0.revision = arg0.revision + 1;
        arg0.escrow_count = arg0.escrow_count - 1;
        arg0.completed_sale_count = arg0.completed_sale_count + 1;
        arg0.gross_volume_atomic = arg0.gross_volume_atomic + (arg1 as u128);
        arg0.protocol_paid_atomic = arg0.protocol_paid_atomic + (arg2.protocol_atomic as u128);
        arg0.creator_paid_atomic = arg0.creator_paid_atomic + (arg2.creator_atomic as u128);
        arg0.source_paid_atomic = arg0.source_paid_atomic + (arg2.source_atomic as u128);
        arg0.seller_paid_atomic = arg0.seller_paid_atomic + (arg2.seller_atomic as u128);
    }

    fun settle_physical_sale<T0>(arg0: &mut PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &MarketQuoteV8, arg3: address, arg4: u8) {
        settle_listing<T0>(arg1, arg0.gross_atomic, arg2);
        arg0.status = 1;
        arg0.revision = arg0.revision + 1;
        arg0.terminal_recipient = arg3;
        let v0 = MarketListingSettledV8{
            listing_id      : 0x2::object::id<PhysicalListingV8<T0>>(arg0),
            registry_id     : 0x2::object::id<MarketRegistryV8<T0>>(arg1),
            lane            : arg4,
            asset_id        : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_asset_id_v8(&arg0.custody),
            seller          : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody),
            buyer           : arg3,
            gross_atomic    : arg2.gross_atomic,
            protocol_atomic : arg2.protocol_atomic,
            creator_atomic  : arg2.creator_atomic,
            source_atomic   : arg2.source_atomic,
            seller_atomic   : arg2.seller_atomic,
        };
        0x2::event::emit<MarketListingSettledV8>(v0);
    }

    fun share(arg0: u64, arg1: u16) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        assert!(arg1 == 0 || v0 > 0, 5);
        (v0 as u64)
    }

    public fun share_market_package_config_v8(arg0: MarketPackageConfigV8) {
        0x2::transfer::share_object<MarketPackageConfigV8>(arg0);
    }

    public fun share_market_registry_v8<T0>(arg0: MarketRegistryV8<T0>) {
        0x2::transfer::share_object<MarketRegistryV8<T0>>(arg0);
    }

    public fun share_market_treasury_v8<T0>(arg0: MarketTreasuryV8<T0>) {
        0x2::transfer::share_object<MarketTreasuryV8<T0>>(arg0);
    }

    fun share_physical_listing<T0>(arg0: PhysicalListingV8<T0>, arg1: &mut MarketRegistryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: u8) : 0x2::object::ID {
        open_listing<T0>(arg1);
        let v0 = 0x2::object::id<PhysicalListingV8<T0>>(&arg0);
        let v1 = MarketListingOpenedV8{
            listing_id       : v0,
            registry_id      : 0x2::object::id<MarketRegistryV8<T0>>(arg1),
            lane             : arg3,
            root_id          : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            asset_id         : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_asset_id_v8(&arg0.custody),
            seller           : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_holder_v8(&arg0.custody),
            ownership_epoch  : 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::physical_market_custody_ownership_epoch_v8(&arg0.custody),
            gross_atomic     : arg0.gross_atomic,
            quote_commitment : arg0.quote_commitment,
        };
        0x2::event::emit<MarketListingOpenedV8>(v1);
        0x2::transfer::share_object<PhysicalListingV8<T0>>(arg0);
        v0
    }

    public fun soul_listing_gross_atomic_v8<T0>(arg0: &SoulListingV8<T0>) : u64 {
        arg0.gross_atomic
    }

    public fun soul_listing_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        0x2::object::id<SoulListingV8<T0>>(arg0)
    }

    public fun soul_listing_output_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_output_id_v8(&arg0.custody)
    }

    public fun soul_listing_ownership_epoch_v8<T0>(arg0: &SoulListingV8<T0>) : u64 {
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_expected_epoch_v8(&arg0.custody)
    }

    public fun soul_listing_quote_commitment_v8<T0>(arg0: &SoulListingV8<T0>) : &vector<u8> {
        &arg0.quote_commitment
    }

    public fun soul_listing_receipt_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_receipt_id_v8(&arg0.custody)
    }

    public fun soul_listing_registry_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun soul_listing_seller_v8<T0>(arg0: &SoulListingV8<T0>) : address {
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_seller_v8(&arg0.custody)
    }

    public fun soul_listing_soul_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::soul_market_soul_id_v8(&arg0.custody)
    }

    public fun soul_listing_status_v8<T0>(arg0: &SoulListingV8<T0>) : u8 {
        arg0.status
    }

    public fun soul_listing_terminal_recipient_v8<T0>(arg0: &SoulListingV8<T0>) : address {
        arg0.terminal_recipient
    }

    public fun soul_listing_treasury_id_v8<T0>(arg0: &SoulListingV8<T0>) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun treasury_balance_v8<T0>(arg0: &MarketTreasuryV8<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun treasury_gross_escrowed_atomic_v8<T0>(arg0: &MarketTreasuryV8<T0>) : u128 {
        arg0.gross_escrowed_atomic
    }

    public fun treasury_gross_released_atomic_v8<T0>(arg0: &MarketTreasuryV8<T0>) : u128 {
        arg0.gross_released_atomic
    }

    public fun treasury_id_v8<T0>(arg0: &MarketTreasuryV8<T0>) : 0x2::object::ID {
        0x2::object::id<MarketTreasuryV8<T0>>(arg0)
    }

    public fun treasury_maker_version_v8<T0>(arg0: &MarketTreasuryV8<T0>) : u64 {
        arg0.maker_version
    }

    public fun treasury_root_content_commitment_v8<T0>(arg0: &MarketTreasuryV8<T0>) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun treasury_root_id_v8<T0>(arg0: &MarketTreasuryV8<T0>) : 0x2::object::ID {
        arg0.root_id
    }

    public fun validate_market_activation_readiness_v2<T0>(arg0: &MarketRegistryV8<T0>, arg1: &MarketTreasuryV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &MarketPackageConfigV8) : vector<u8> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_v8<T0>(arg2);
        assert_config<T0>(arg2, arg3, arg4, arg5, arg6);
        assert_market_identity<T0>(arg0, arg1, arg2, arg6);
        assert!(arg0.sealed, 3);
        assert_zero_state<T0>(arg0, arg1);
        readiness_commitment<T0>(arg0, arg1)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

