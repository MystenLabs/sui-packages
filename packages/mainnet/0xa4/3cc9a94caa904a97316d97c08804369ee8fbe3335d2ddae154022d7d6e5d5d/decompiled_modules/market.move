module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketConfig has key {
        id: 0x2::object::UID,
        version: u64,
        fee_recipient: address,
        platform_fee_bps: u16,
        paused: bool,
    }

    struct MarketConfigV2 has key {
        id: 0x2::object::UID,
        version: u64,
        legacy_config_id: 0x2::object::ID,
        fee_recipient: address,
        platform_fee_bps: u16,
        primary_enabled: bool,
        secondary_enabled: bool,
    }

    struct MarketAdminCapV2 has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct KioskRegistry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct SoulListing has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        price: u64,
        creator: address,
        creator_royalty_bps: u16,
        collection_id: 0x1::option::Option<0x2::object::ID>,
        purchase_cap: 0x1::option::Option<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>,
        is_active: bool,
    }

    struct CollectionListing has key {
        id: 0x2::object::UID,
        version: u64,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        price: u64,
        purchase_cap: 0x1::option::Option<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>,
        is_active: bool,
    }

    struct PersonalKioskOwnerKey has copy, drop, store {
        owner: address,
    }

    struct JoinedSourceKey has copy, drop, store {
        source_object_id: 0x2::object::ID,
    }

    struct PersonalKioskRegistration has copy, drop, store {
        version: u64,
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
    }

    struct SoulMarketProof has drop {
        dummy_field: bool,
    }

    struct CollectionMarketProof has drop {
        dummy_field: bool,
    }

    struct InitialContentEntry has store {
        kind: u32,
        name: 0x1::string::String,
        slot_read_mode_mask: u64,
        download_policy: u8,
        set_active: bool,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
    }

    struct StateConfigEntry has copy, drop, store {
        key: 0x1::string::String,
        value: vector<u8>,
    }

    struct MarketInitialized has copy, drop {
        config_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        soul_policy_id: 0x2::object::ID,
        collection_policy_id: 0x2::object::ID,
        admin: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        fee_recipient: address,
    }

    struct PlatformFeeBpsUpdated has copy, drop {
        fee_bps: u16,
    }

    struct MarketPauseUpdated has copy, drop {
        paused: bool,
    }

    struct LegacyMarketRetired has copy, drop {
        legacy_config_id: 0x2::object::ID,
        config_v2_id: 0x2::object::ID,
        admin_cap_v2_id: 0x2::object::ID,
        retired_by: address,
    }

    struct MarketPrimaryGateV2Updated has copy, drop {
        enabled: bool,
    }

    struct MarketSecondaryGateV2Updated has copy, drop {
        enabled: bool,
    }

    struct PersonalKioskInitialized has copy, drop {
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct PersonalKioskRegistrationUpdated has copy, drop {
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct PersonalKioskRebound has copy, drop {
        owner: address,
        old_kiosk_id: 0x2::object::ID,
        old_kiosk_cap_id: 0x2::object::ID,
        new_kiosk_id: 0x2::object::ID,
        new_kiosk_cap_id: 0x2::object::ID,
    }

    struct SoulMintedToKiosk has copy, drop {
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        provenance_kind: u8,
    }

    struct SoulListed has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        price: u64,
    }

    struct SoulListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
    }

    struct SoulPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
        creator_royalty: u64,
        collection_royalty: u64,
    }

    struct AnimacraftSoulPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        provenance_id: 0x2::object::ID,
        maker_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
        maker_royalty_bps: u16,
        maker_royalty: u64,
        collection_royalty: u64,
    }

    struct AnimacraftV5SoulPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        provenance_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        maker_source_recipient: address,
        price: u64,
        seller_payout: u64,
        protocol_fee: u64,
        soul_creator_royalty_bps: u16,
        soul_creator_royalty: u64,
        maker_source_royalty_bps: u16,
        maker_source_royalty: u64,
    }

    struct CollectionMintedToKiosk has copy, drop {
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        tradeable: bool,
    }

    struct CollectionListed has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        price: u64,
    }

    struct CollectionListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
    }

    struct CollectionPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
    }

    struct SoulPaidAccessPurchased has copy, drop {
        soul_id: 0x2::object::ID,
        paid_access_list_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        platform_fee: u64,
        payment_recipient: address,
    }

    struct SoulListingDeleted has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        deleted_by: address,
    }

    struct CollectionListingDeleted has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        deleted_by: address,
    }

    public fun admin_cap_v2_config_id(arg0: &MarketAdminCapV2) : 0x2::object::ID {
        arg0.config_id
    }

    fun apply_initial_content_entries(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg3: vector<InitialContentEntry>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x1::vector::reverse<InitialContentEntry>(&mut arg3);
        while (!0x1::vector::is_empty<InitialContentEntry>(&arg3)) {
            let InitialContentEntry {
                kind                : v0,
                name                : v1,
                slot_read_mode_mask : v2,
                download_policy     : v3,
                set_active          : v4,
                blob                : v5,
            } = 0x1::vector::pop_back<InitialContentEntry>(&mut arg3);
            if (v4) {
                assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::descriptor_has_active_binding(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::borrow_descriptor(arg2, v0)), 43);
            };
            let v6 = if (v0 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::kind_soul_doc() || v0 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::kind_memory()) {
                0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::append_initial_invariant_version(arg0, arg2, v0, v1, v2, v3, v5, arg4)
            } else {
                0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::append_initial_user_version(arg0, arg2, v0, v1, v2, v3, v5, arg4)
            };
            if (v4) {
                0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::set_active(arg0, arg1, arg2, v0, v1, v6, arg5);
            };
        };
        0x1::vector::destroy_empty<InitialContentEntry>(arg3);
    }

    fun apply_initial_state_config(arg0: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: vector<StateConfigEntry>, arg2: address) {
        while (!0x1::vector::is_empty<StateConfigEntry>(&arg1)) {
            let StateConfigEntry {
                key   : v0,
                value : v1,
            } = 0x1::vector::pop_back<StateConfigEntry>(&mut arg1);
            let v2 = v0;
            assert!(!0x1::string::is_empty(&v2), 45);
            0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::upsert_state_config(arg0, v2, v1);
            0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_state_config_upserted(arg0, arg2, v2);
        };
        0x1::vector::destroy_empty<StateConfigEntry>(arg1);
    }

    fun assert_animacraft_v5_royalty_schedule(arg0: u16, arg1: u16) {
        assert!(arg0 <= 500 && arg0 % 50 == 0, 65);
        assert!(arg1 <= 500 && arg1 % 50 == 0, 64);
        let v0 = (arg1 as u64) + (arg0 as u64);
        assert!(v0 <= (1000 as u64), 10);
        assert!((250 as u64) + v0 <= (1250 as u64), 10);
    }

    fun assert_initial_content_well_formed(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg1: &vector<InitialContentEntry>) {
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::soul_doc_name();
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::memory_name();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<InitialContentEntry>(arg1)) {
            let v5 = 0x1::vector::borrow<InitialContentEntry>(arg1, v4);
            let v6 = initial_entry_kind(v5);
            let v7 = initial_entry_name(v5);
            if (v6 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::kind_soul_doc()) {
                assert!(v7 == &v0, 47);
                v2 = v2 + 1;
            } else if (v6 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::kind_memory()) {
                assert!(v7 == &v1, 49);
                v3 = v3 + 1;
            } else {
                assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::descriptor_op_mask(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::borrow_descriptor(arg0, v6)) & 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::op_append() != 0, 50);
            };
            v4 = v4 + 1;
        };
        assert!(v2 == 1, 46);
        assert!(v3 >= 1, 48);
    }

    fun assert_registered_personal_kiosk(arg0: &KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = borrow_personal_kiosk_registration(arg0, arg1);
        assert!(v0.kiosk_id == arg2, 14);
        assert!(v0.kiosk_cap_id == arg3, 37);
    }

    fun borrow_personal_kiosk_registration(arg0: &KioskRegistry, arg1: address) : &PersonalKioskRegistration {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        assert!(0x2::dynamic_field::exists<PersonalKioskOwnerKey>(&arg0.id, v0), 13);
        0x2::dynamic_field::borrow<PersonalKioskOwnerKey, PersonalKioskRegistration>(&arg0.id, v0)
    }

    fun bps_amount(arg0: u64, arg1: u16) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 == 0) {
            return 0
        };
        (((v0 + 9999) / 10000) as u64)
    }

    public fun buy_animacraft_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg10: &mut SoulListing, arg11: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = arg10.seller;
        assert!(0x1::option::is_none<0x2::object::ID>(&arg10.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg9)), 15);
        buy_animacraft_soul_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v0, arg12);
    }

    public fun buy_animacraft_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg10: &mut SoulListing, arg11: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        let v0 = arg10.seller;
        assert!(0x1::option::is_none<0x2::object::ID>(&arg10.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg9)), 15);
        buy_animacraft_soul_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0, v0, arg12);
    }

    public fun buy_animacraft_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg10: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg11: &mut SoulListing, arg12: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg6);
        assert!(0x1::option::contains<0x2::object::ID>(&arg11.collection_id, &v0), 15);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg10), &v0), 15);
        buy_animacraft_soul_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg6), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg6), arg13);
    }

    public fun buy_animacraft_soul_fixed_price_with_collection_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg5: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg10: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg11: &mut SoulListing, arg12: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg6);
        assert!(0x1::option::contains<0x2::object::ID>(&arg11.collection_id, &v0), 15);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg10), &v0), 15);
        buy_animacraft_soul_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg12, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg6), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg6), arg13);
    }

    fun buy_animacraft_soul_impl(arg0: bool, arg1: address, arg2: u16, arg3: &KioskRegistry, arg4: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg5: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::OCMaker, arg7: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::MakerTreasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg11: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg12: &mut SoulListing, arg13: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: u16, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0, 11);
        assert!(arg12.is_active, 3);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg11), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v4_compatible(arg5), 62);
        assert!(arg12.state_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg11), 42);
        assert!(arg12.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg11), 42);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg8) == arg12.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg8) == arg12.seller, 41);
        assert!(arg12.creator_royalty_bps == 0, 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg11) == 0, 55);
        assert!(0x2::kiosk::has_access(arg9, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg10)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg9) == 0x2::tx_context::sender(arg16), 40);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg5, arg11);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_maker<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5, arg6, arg7);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg9);
        assert_registered_personal_kiosk(arg3, 0x2::tx_context::sender(arg16), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg10));
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg5);
        let (v2, v3, v4, v5, v6) = quote_animacraft_soul_purchase_with_fee_bps(arg2, arg12.price, v1, arg14);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg13) == v6, 6);
        let v7 = take_soul_purchase_cap(arg12);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg8, v7, 0x2::coin::zero<0x2::sui::SUI>(arg16));
        let v10 = v9;
        let v11 = v8;
        assert!(0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&v11) == arg12.soul_id, 5);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg13, v2, arg16), arg1);
        };
        if (v4 > 0) {
            0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::deposit_resale_royalty<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_policy(arg5), arg6, arg7, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg13, v4, arg16), v3, arg12.soul_id, arg16);
        };
        if (v5 > 0 && arg15 != arg12.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg13, v5, arg16), arg15);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg13, arg12.seller);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::grant::invalidate_all_for_owner_rotation(arg11, 0x2::tx_context::sender(arg16), 0x2::tx_context::sender(arg16));
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::rotate_owner(arg11, 0x2::tx_context::sender(arg16), v0);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg11, false);
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg9, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg10), arg4, v11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&mut v10, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg9, &mut v10);
        let v12 = SoulMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul, SoulMarketProof>(v12, arg4, &mut v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg4, v10);
        arg12.is_active = false;
        let v16 = SoulPurchased{
            listing_id         : 0x2::object::id<SoulListing>(arg12),
            soul_id            : arg12.soul_id,
            seller             : arg12.seller,
            buyer              : 0x2::tx_context::sender(arg16),
            price              : v3,
            platform_fee       : v2,
            creator_royalty    : v4,
            collection_royalty : v5,
        };
        0x2::event::emit<SoulPurchased>(v16);
        let v17 = AnimacraftSoulPurchased{
            listing_id         : 0x2::object::id<SoulListing>(arg12),
            soul_id            : arg12.soul_id,
            provenance_id      : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::provenance_id(arg5),
            maker_id           : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::maker_id(arg5),
            maker_treasury_id  : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::maker_treasury_id(arg5),
            seller             : arg12.seller,
            buyer              : 0x2::tx_context::sender(arg16),
            price              : v3,
            platform_fee       : v2,
            maker_royalty_bps  : v1,
            maker_royalty      : v4,
            collection_royalty : v5,
        };
        0x2::event::emit<AnimacraftSoulPurchased>(v17);
    }

    public fun buy_animacraft_v5_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg8: &mut SoulListing, arg9: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        assert!(arg0.platform_fee_bps == 250, 63);
        assert!(arg8.version == 5, 66);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg8.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg7)), 15);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg7), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v5_commerce_compatible(arg3), 62);
        assert!(arg8.is_active, 3);
        assert!(arg8.state_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg7), 42);
        assert!(arg8.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg7), 42);
        assert!(arg8.creator == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::state_creator(arg7), 42);
        assert!(arg8.creator_royalty_bps == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg7), 67);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == arg8.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg4) == arg8.seller, 41);
        assert!(0x2::kiosk::has_access(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg10), 40);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg3, arg7);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        assert_registered_personal_kiosk(arg1, 0x2::tx_context::sender(arg10), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg6));
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg3);
        let v2 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::maker_creator(arg3);
        let (v3, v4, v5, v6) = quote_animacraft_v5_soul_sale_for_state(arg7, arg8.price, v1);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg9) == arg8.price, 6);
        let v7 = take_soul_purchase_cap(arg8);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg4, v7, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let v10 = v9;
        let v11 = v8;
        assert!(0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&v11) == arg8.soul_id, 5);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg9, v4, arg10), arg0.fee_recipient);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg9, v5, arg10), arg8.creator);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg9, v6, arg10), v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg9, arg8.seller);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::grant::invalidate_all_for_owner_rotation(arg7, 0x2::tx_context::sender(arg10), 0x2::tx_context::sender(arg10));
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::rotate_owner(arg7, 0x2::tx_context::sender(arg10), v0);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg7, false);
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg2, v11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&mut v10, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg5, &mut v10);
        let v12 = SoulMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul, SoulMarketProof>(v12, arg2, &mut v10);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg2, v10);
        arg8.is_active = false;
        let v16 = AnimacraftV5SoulPurchased{
            listing_id               : 0x2::object::id<SoulListing>(arg8),
            soul_id                  : arg8.soul_id,
            provenance_id            : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::provenance_id(arg3),
            seller                   : arg8.seller,
            buyer                    : 0x2::tx_context::sender(arg10),
            maker_source_recipient   : v2,
            price                    : arg8.price,
            seller_payout            : v3,
            protocol_fee             : v4,
            soul_creator_royalty_bps : arg8.creator_royalty_bps,
            soul_creator_royalty     : v5,
            maker_source_royalty_bps : v1,
            maker_source_royalty     : v6,
        };
        0x2::event::emit<AnimacraftV5SoulPurchased>(v16);
    }

    public fun buy_collection_right_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg3: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut CollectionListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        buy_collection_right_fixed_price_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun buy_collection_right_fixed_price_impl(arg0: bool, arg1: address, arg2: u16, arg3: &KioskRegistry, arg4: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg6: &mut 0x2::kiosk::Kiosk, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: &mut CollectionListing, arg10: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0, 11);
        assert!(arg9.is_active, 3);
        assert!(arg9.collection_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg5), 15);
        assert!(arg9.right_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::right_id(arg5), 16);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg6) == arg9.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == arg9.seller, 41);
        assert!(0x2::kiosk::has_access(arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg8)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg7) == 0x2::tx_context::sender(arg11), 40);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::assert_tradeable(arg5);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg7);
        assert_registered_personal_kiosk(arg3, 0x2::tx_context::sender(arg11), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg8));
        let v1 = arg9.price;
        let v2 = bps_amount(v1, arg2);
        let v3 = (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 9);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg10) == (v3 as u64), 6);
        let v4 = take_collection_purchase_cap(arg9);
        let (v5, v6) = 0x2::kiosk::purchase_with_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg6, v4, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&v8) == arg9.right_id, 16);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg10, v2, arg11), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg10, arg9.seller);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::update_holder(arg5, 0x2::tx_context::sender(arg11), v0);
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg7, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg8), arg4, v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&mut v7, arg7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg7, &mut v7);
        let v9 = CollectionMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight, CollectionMarketProof>(v9, arg4, &mut v7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg4, v7);
        arg9.is_active = false;
        let v13 = CollectionPurchased{
            listing_id    : 0x2::object::id<CollectionListing>(arg9),
            collection_id : arg9.collection_id,
            right_id      : arg9.right_id,
            seller        : arg9.seller,
            buyer         : 0x2::tx_context::sender(arg11),
            price         : v1,
            platform_fee  : v2,
        };
        0x2::event::emit<CollectionPurchased>(v13);
    }

    public fun buy_collection_right_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg3: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut CollectionListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        buy_collection_right_fixed_price_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun buy_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: &mut SoulListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg7.seller;
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg6), 56);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg7.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg6)), 15);
        buy_soul_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, v0, arg9);
    }

    public fun buy_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: &mut SoulListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        let v0 = arg7.seller;
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg6), 56);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg7.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg6)), 15);
        buy_soul_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, v0, arg9);
    }

    public fun buy_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg8: &mut SoulListing, arg9: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg7), 56);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&arg8.collection_id, &v0), 15);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg7), &v0), 15);
        buy_soul_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg3), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg3), arg10);
    }

    public fun buy_soul_fixed_price_with_collection_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg8: &mut SoulListing, arg9: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.secondary_enabled, 61);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg7), 56);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&arg8.collection_id, &v0), 15);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg7), &v0), 15);
        buy_soul_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg3), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg3), arg10);
    }

    fun buy_soul_impl(arg0: bool, arg1: address, arg2: u16, arg3: &KioskRegistry, arg4: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg8: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg9: &mut SoulListing, arg10: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: u16, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0, 11);
        assert!(arg9.is_active, 3);
        assert!(arg9.state_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg8), 42);
        assert!(arg9.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg8), 42);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg5) == arg9.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == arg9.seller, 41);
        assert!(0x2::kiosk::has_access(arg6, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg7)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg6) == 0x2::tx_context::sender(arg13), 40);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg6);
        assert_registered_personal_kiosk(arg3, 0x2::tx_context::sender(arg13), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg7));
        let (v1, v2, v3, v4, v5) = quote_soul_purchase_with_fee_bps(arg2, arg9.price, arg9.creator_royalty_bps, arg11);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg10) == v5, 6);
        let v6 = take_soul_purchase_cap(arg9);
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg5, v6, 0x2::coin::zero<0x2::sui::SUI>(arg13));
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&v10) == arg9.soul_id, 5);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg10, v1, arg13), arg1);
        };
        if (v3 > 0 && arg9.creator != arg9.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg10, v3, arg13), arg9.creator);
        };
        if (v4 > 0 && arg12 != arg9.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg10, v4, arg13), arg12);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg10, arg9.seller);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::grant::invalidate_all_for_owner_rotation(arg8, 0x2::tx_context::sender(arg13), 0x2::tx_context::sender(arg13));
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::rotate_owner(arg8, 0x2::tx_context::sender(arg13), v0);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg8, false);
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg6, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg7), arg4, v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&mut v9, arg6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg6, &mut v9);
        let v11 = SoulMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul, SoulMarketProof>(v11, arg4, &mut v9);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg4, v9);
        arg9.is_active = false;
        let v15 = SoulPurchased{
            listing_id         : 0x2::object::id<SoulListing>(arg9),
            soul_id            : arg9.soul_id,
            seller             : arg9.seller,
            buyer              : 0x2::tx_context::sender(arg13),
            price              : v2,
            platform_fee       : v1,
            creator_royalty    : v3,
            collection_royalty : v4,
        };
        0x2::event::emit<SoulPurchased>(v15);
    }

    public fun cancel_collection_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut CollectionListing) {
        assert!(arg2.is_active, 3);
        assert!(0x2::kiosk::has_access(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1)), 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg2.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg0) == arg2.seller, 40);
        let v0 = take_collection_purchase_cap(arg2);
        0x2::kiosk::return_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg0, v0);
        arg2.is_active = false;
        let v1 = CollectionListingCancelled{
            listing_id    : 0x2::object::id<CollectionListing>(arg2),
            collection_id : arg2.collection_id,
            seller        : arg2.seller,
        };
        0x2::event::emit<CollectionListingCancelled>(v1);
    }

    public fun cancel_soul_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg3: &mut SoulListing) {
        assert!(arg3.is_active, 3);
        assert!(0x2::kiosk::has_access(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1)), 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg3.seller_kiosk_id, 4);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg0) == arg3.seller, 40);
        assert!(arg3.state_id == 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg2), 42);
        assert!(arg3.soul_id == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg2), 42);
        let v0 = take_soul_purchase_cap(arg3);
        0x2::kiosk::return_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg0, v0);
        arg3.is_active = false;
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg2, false);
        let v1 = SoulListingCancelled{
            listing_id : 0x2::object::id<SoulListing>(arg3),
            soul_id    : arg3.soul_id,
            seller     : arg3.seller,
        };
        0x2::event::emit<SoulListingCancelled>(v1);
    }

    public fun clear_active_content(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg3) == 0x2::tx_context::sender(arg5), 44);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::clear_active(arg2, arg3, arg1, arg4, arg5);
    }

    public fun clear_active_content_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg3) == 0x2::tx_context::sender(arg5), 44);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::clear_active(arg2, arg3, arg1, arg4, arg5);
    }

    public fun collection_listing_version(arg0: &CollectionListing) : u64 {
        arg0.version
    }

    public fun config_v2_fee_recipient(arg0: &MarketConfigV2) : address {
        arg0.fee_recipient
    }

    public fun config_v2_legacy_config_id(arg0: &MarketConfigV2) : 0x2::object::ID {
        arg0.legacy_config_id
    }

    public fun config_v2_platform_fee_bps(arg0: &MarketConfigV2) : u16 {
        arg0.platform_fee_bps
    }

    public fun config_v2_primary_enabled(arg0: &MarketConfigV2) : bool {
        arg0.primary_enabled
    }

    public fun config_v2_secondary_enabled(arg0: &MarketConfigV2) : bool {
        arg0.secondary_enabled
    }

    public fun config_v2_version(arg0: &MarketConfigV2) : u64 {
        arg0.version
    }

    public fun config_version(arg0: &MarketConfig) : u64 {
        arg0.version
    }

    public fun configure_paid_access_kind(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::configure_paid_access_kind(arg2, arg3, arg1, arg4, arg5, arg6, arg7, arg8);
    }

    public fun configure_paid_access_kind_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::configure_paid_access_kind(arg2, arg3, arg1, arg4, arg5, arg6, arg7, arg8);
    }

    public fun create_collection_in_personal_kiosk(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u16, arg9: bool, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection {
        create_collection_in_personal_kiosk_impl(arg0.paused, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun create_collection_in_personal_kiosk_impl(arg0: bool, arg1: u16, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u16, arg10: bool, arg11: 0x1::option::Option<u64>, arg12: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection {
        assert!(!arg0, 11);
        assert!((arg1 as u64) + (arg9 as u64) <= (10000 as u64), 10);
        assert!(0x2::kiosk::has_access(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5)), 8);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg4);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        assert_registered_personal_kiosk(arg2, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg5));
        let (v2, v3) = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::create(arg6, arg7, arg8, arg9, arg10, arg11, v0, v1, arg12);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5), arg3, v4);
        let v6 = CollectionMintedToKiosk{
            collection_id : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(&v5),
            right_id      : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&v4),
            owner         : v0,
            kiosk_id      : v1,
            tradeable     : arg10,
        };
        0x2::event::emit<CollectionMintedToKiosk>(v6);
        v5
    }

    public fun create_collection_in_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u16, arg9: bool, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection {
        assert!(arg0.primary_enabled, 60);
        create_collection_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    fun create_collection_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : CollectionListing {
        0x2::kiosk::borrow<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg3);
        CollectionListing{
            id              : 0x2::object::new(arg5),
            version         : 1,
            collection_id   : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg2),
            right_id        : arg3,
            seller          : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg0),
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            price           : arg4,
            purchase_cap    : 0x1::option::some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(0x2::kiosk::list_with_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg3, 0, arg5)),
            is_active       : true,
        }
    }

    fun create_soul_listing(arg0: &MarketConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg5 > 0, 1);
        0x2::kiosk::borrow<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg4);
        let (_, _, _, _, _) = quote_soul_purchase(arg0, arg5, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg3), arg7);
        SoulListing{
            id                  : 0x2::object::new(arg8),
            version             : 1,
            soul_id             : arg4,
            state_id            : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg3),
            seller              : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg1),
            seller_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price               : arg5,
            creator             : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::state_creator(arg3),
            creator_royalty_bps : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg3),
            collection_id       : arg6,
            purchase_cap        : 0x1::option::some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(0x2::kiosk::list_with_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg4, 0, arg8)),
            is_active           : true,
        }
    }

    public fun delete_collection_listing(arg0: CollectionListing, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 30);
        let CollectionListing {
            id              : v0,
            version         : _,
            collection_id   : v2,
            right_id        : _,
            seller          : v4,
            seller_kiosk_id : _,
            price           : _,
            purchase_cap    : v7,
            is_active       : _,
        } = arg0;
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(v7);
        0x2::object::delete(v0);
        let v9 = CollectionListingDeleted{
            listing_id    : 0x2::object::id<CollectionListing>(&arg0),
            collection_id : v2,
            seller        : v4,
            deleted_by    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CollectionListingDeleted>(v9);
    }

    public fun delete_paid_access_kind(arg0: &MarketConfig, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::delete_paid_access_kind(arg1, arg2, arg3, arg4);
    }

    public fun delete_paid_access_kind_v2(arg0: &MarketConfigV2, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::delete_paid_access_kind(arg1, arg2, arg3, arg4);
    }

    public fun delete_soul_listing(arg0: SoulListing, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 30);
        let SoulListing {
            id                  : v0,
            version             : _,
            soul_id             : v2,
            state_id            : _,
            seller              : v4,
            seller_kiosk_id     : _,
            price               : _,
            creator             : _,
            creator_royalty_bps : _,
            collection_id       : _,
            purchase_cap        : v10,
            is_active           : _,
        } = arg0;
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(v10);
        0x2::object::delete(v0);
        let v12 = SoulListingDeleted{
            listing_id : 0x2::object::id<SoulListing>(&arg0),
            soul_id    : v2,
            seller     : v4,
            deleted_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SoulListingDeleted>(v12);
    }

    public fun delete_state_config(arg0: &MarketConfig, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg1) == 0x2::tx_context::sender(arg3), 44);
        assert!(!0x1::string::is_empty(&arg2), 45);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::delete_state_config(arg1, arg2);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_state_config_deleted(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun delete_state_config_v2(arg0: &MarketConfigV2, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg1) == 0x2::tx_context::sender(arg3), 44);
        assert!(!0x1::string::is_empty(&arg2), 45);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::delete_state_config(arg1, arg2);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_state_config_deleted(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun ensure_personal_kiosk_registered(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        insert_or_assert_personal_kiosk_registration(arg1, 0x2::tx_context::sender(arg3), 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2)), 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg2));
    }

    public fun ensure_personal_kiosk_registered_v2(arg0: &MarketConfigV2, arg1: &mut KioskRegistry, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled || arg0.secondary_enabled, 60);
        insert_or_assert_personal_kiosk_registration(arg1, 0x2::tx_context::sender(arg3), 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2)), 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg2));
    }

    public fun fee_recipient(arg0: &MarketConfig) : address {
        arg0.fee_recipient
    }

    public fun finalize_collection(arg0: 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection) {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::share_collection(arg0);
    }

    public fun finalize_collection_listing(arg0: CollectionListing) {
        0x2::transfer::share_object<CollectionListing>(arg0);
    }

    public fun finalize_soul_content(arg0: 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent) {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::share_content(arg0);
    }

    public fun finalize_soul_listing(arg0: SoulListing) {
        0x2::transfer::share_object<SoulListing>(arg0);
    }

    public fun finalize_soul_state(arg0: 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState) {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::share_state(arg0);
    }

    fun floor_bps_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKET>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        init_impl(v0, v1, true, arg1);
    }

    fun init_impl(arg0: 0x2::package::Publisher, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2::transfer_policy::new<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&arg0, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = MarketConfig{
            id               : 0x2::object::new(arg3),
            version          : 1,
            fee_recipient    : arg1,
            platform_fee_bps : 250,
            paused           : arg2,
        };
        let v9 = KioskRegistry{
            id      : 0x2::object::new(arg3),
            version : 1,
        };
        let v10 = MarketAdminCap{id: 0x2::object::new(arg3)};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul, SoulMarketProof>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&mut v7, &v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>(&mut v7, &v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight, CollectionMarketProof>(&mut v7, &v6);
        0x2::transfer::share_object<MarketConfig>(v8);
        0x2::transfer::share_object<KioskRegistry>(v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(v7);
        0x2::transfer::transfer<MarketAdminCap>(v10, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(v2, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(v6, arg1);
        0x2::package::burn_publisher(arg0);
        let v11 = MarketInitialized{
            config_id            : 0x2::object::id<MarketConfig>(&v8),
            registry_id          : 0x2::object::id<KioskRegistry>(&v9),
            soul_policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(&v3),
            collection_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(&v7),
            admin                : arg1,
        };
        0x2::event::emit<MarketInitialized>(v11);
    }

    public fun init_personal_kiosk(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg2);
        let v5 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v4);
        let v6 = 0x2::tx_context::sender(arg2);
        register_personal_kiosk(arg1, v6, v3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v4, arg2);
        let v7 = PersonalKioskInitialized{
            kiosk_id     : v3,
            kiosk_cap_id : v5,
            owner        : v6,
        };
        0x2::event::emit<PersonalKioskInitialized>(v7);
        v3
    }

    public fun init_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &mut KioskRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.primary_enabled || arg0.secondary_enabled, 60);
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg2);
        let v5 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v4);
        let v6 = 0x2::tx_context::sender(arg2);
        register_personal_kiosk(arg1, v6, v3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v4, arg2);
        let v7 = PersonalKioskInitialized{
            kiosk_id     : v3,
            kiosk_cap_id : v5,
            owner        : v6,
        };
        0x2::event::emit<PersonalKioskInitialized>(v7);
        v3
    }

    fun initial_entry_kind(arg0: &InitialContentEntry) : u32 {
        arg0.kind
    }

    fun initial_entry_name(arg0: &InitialContentEntry) : &0x1::string::String {
        &arg0.name
    }

    fun insert_or_assert_personal_kiosk_registration(arg0: &mut KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        if (0x2::dynamic_field::exists<PersonalKioskOwnerKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<PersonalKioskOwnerKey, PersonalKioskRegistration>(&arg0.id, v0);
            assert!(v1.kiosk_id == arg2, 14);
            assert!(v1.kiosk_cap_id == arg3, 37);
        } else {
            let v2 = PersonalKioskRegistration{
                version      : 1,
                kiosk_id     : arg2,
                kiosk_cap_id : arg3,
            };
            0x2::dynamic_field::add<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg0.id, v0, v2);
            let v3 = PersonalKioskRegistrationUpdated{
                kiosk_id     : arg2,
                kiosk_cap_id : arg3,
                owner        : arg1,
            };
            0x2::event::emit<PersonalKioskRegistrationUpdated>(v3);
        };
    }

    public fun kiosk_registry_version(arg0: &KioskRegistry) : u64 {
        arg0.version
    }

    fun list_animacraft_soul_after_validation(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3)), 8);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4) == 0x2::tx_context::sender(arg8), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_kiosk_id(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 38);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3));
        let v3 = create_soul_listing(arg0, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg4, true);
        let v4 = SoulListed{
            listing_id : 0x2::object::id<SoulListing>(&v3),
            soul_id    : v0,
            seller     : v1,
            kiosk_id   : v2,
            price      : arg5,
        };
        0x2::event::emit<SoulListed>(v4);
        v3
    }

    public fun list_animacraft_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg5), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v4_compatible(arg2), 62);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg5) == 0, 55);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg5)), 15);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg5);
        let (_, _, _, _, _) = quote_animacraft_soul_purchase(arg0, arg6, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg2), 0);
        list_animacraft_soul_after_validation(arg0, arg1, arg3, arg4, arg5, arg6, 0x1::option::none<0x2::object::ID>(), 0, arg7)
    }

    public fun list_animacraft_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg5), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v4_compatible(arg2), 62);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg5) == 0, 55);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg5)), 15);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg5);
        let (_, _, _, _, _) = quote_animacraft_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg6, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg2), 0);
        list_soul_after_validation_v2(arg0, arg1, arg3, arg4, arg5, arg6, 0x1::option::none<0x2::object::ID>(), 0, arg7)
    }

    public fun list_animacraft_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg6), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v4_compatible(arg2), 62);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg6) == 0, 55);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg6), &v0), 15);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg6);
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg3);
        let (_, _, _, _, _) = quote_animacraft_soul_purchase(arg0, arg7, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg2), v1);
        list_animacraft_soul_after_validation(arg0, arg1, arg4, arg5, arg6, arg7, 0x1::option::some<0x2::object::ID>(v0), v1, arg8)
    }

    public fun list_animacraft_soul_fixed_price_with_collection_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg6), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v4_compatible(arg2), 62);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg6) == 0, 55);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg6), &v0), 15);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg6);
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg3);
        let (_, _, _, _, _) = quote_animacraft_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg7, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg2), v1);
        list_soul_after_validation_v2(arg0, arg1, arg4, arg5, arg6, arg7, 0x1::option::some<0x2::object::ID>(v0), v1, arg8)
    }

    public fun list_animacraft_v5_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SoulListing {
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg5);
        list_animacraft_v5_soul_fixed_price_with_creator_royalty_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7)
    }

    public fun list_animacraft_v5_soul_fixed_price_with_creator_royalty_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::AnimacraftProvenance, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(arg0.platform_fee_bps == 250, 63);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg5), 55);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::is_v5_commerce_compatible(arg2), 62);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg5)), 15);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::assert_matches_soul(arg2, arg5);
        assert!(arg7 == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg5), 67);
        let (_, _, _, _) = quote_animacraft_v5_soul_sale_for_state(arg5, arg6, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::royalty_bps(arg2));
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg5) == 0x2::tx_context::sender(arg8), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_kiosk_id(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 38);
        let v4 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg5);
        let v5 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg3);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v5, v6, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        0x2::kiosk::borrow<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), v4);
        let v7 = SoulListing{
            id                  : 0x2::object::new(arg8),
            version             : 5,
            soul_id             : v4,
            state_id            : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg5),
            seller              : v5,
            seller_kiosk_id     : v6,
            price               : arg6,
            creator             : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::state_creator(arg5),
            creator_royalty_bps : arg7,
            collection_id       : 0x1::option::none<0x2::object::ID>(),
            purchase_cap        : 0x1::option::some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(0x2::kiosk::list_with_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), v4, 0, arg8)),
            is_active           : true,
        };
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg5, true);
        let v8 = SoulListed{
            listing_id : 0x2::object::id<SoulListing>(&v7),
            soul_id    : v4,
            seller     : v5,
            kiosk_id   : v6,
            price      : arg6,
        };
        0x2::event::emit<SoulListed>(v8);
        v7
    }

    public fun list_collection_right_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CollectionListing {
        assert!(!arg0.paused, 11);
        assert!(arg5 > 0, 1);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::assert_tradeable(arg2);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg2) == 0x2::tx_context::sender(arg6), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder_kiosk_id(arg2) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 15);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::right_id(arg2);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg3);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v3 = create_collection_listing(arg3, arg4, arg2, v0, arg5, arg6);
        let v4 = CollectionListed{
            listing_id    : 0x2::object::id<CollectionListing>(&v3),
            collection_id : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg2),
            right_id      : v0,
            seller        : v1,
            kiosk_id      : v2,
            price         : arg5,
        };
        0x2::event::emit<CollectionListed>(v4);
        v3
    }

    public fun list_collection_right_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CollectionListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(arg5 > 0, 1);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::assert_tradeable(arg2);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder(arg2) == 0x2::tx_context::sender(arg6), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::current_holder_kiosk_id(arg2) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 15);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::right_id(arg2);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg3);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v3 = create_collection_listing(arg3, arg4, arg2, v0, arg5, arg6);
        let v4 = CollectionListed{
            listing_id    : 0x2::object::id<CollectionListing>(&v3),
            collection_id : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg2),
            right_id      : v0,
            seller        : v1,
            kiosk_id      : v2,
            price         : arg5,
        };
        0x2::event::emit<CollectionListed>(v4);
        v3
    }

    fun list_soul_after_validation_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3)), 8);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4) == 0x2::tx_context::sender(arg8), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_kiosk_id(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 38);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3));
        assert!(arg5 > 0, 1);
        0x2::kiosk::borrow<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), v0);
        let (_, _, _, _, _) = quote_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg5, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg4), arg7);
        let v8 = SoulListing{
            id                  : 0x2::object::new(arg8),
            version             : 2,
            soul_id             : v0,
            state_id            : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg4),
            seller              : v1,
            seller_kiosk_id     : v2,
            price               : arg5,
            creator             : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::state_creator(arg4),
            creator_royalty_bps : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg4),
            collection_id       : arg6,
            purchase_cap        : 0x1::option::some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(0x2::kiosk::list_with_purchase_cap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), v0, 0, arg8)),
            is_active           : true,
        };
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg4, true);
        let v9 = SoulListed{
            listing_id : 0x2::object::id<SoulListing>(&v8),
            soul_id    : v0,
            seller     : v1,
            kiosk_id   : v2,
            price      : arg5,
        };
        0x2::event::emit<SoulListed>(v9);
        v8
    }

    public fun list_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(!arg0.paused, 11);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg4), 58);
        assert!((arg0.platform_fee_bps as u64) + (0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg4) as u64) <= (10000 as u64), 10);
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3)), 8);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg4)), 15);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4) == 0x2::tx_context::sender(arg6), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_kiosk_id(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 38);
        let v0 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3));
        let v3 = create_soul_listing(arg0, arg2, arg3, arg4, v0, arg5, 0x1::option::none<0x2::object::ID>(), 0, arg6);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg4, true);
        let v4 = SoulListed{
            listing_id : 0x2::object::id<SoulListing>(&v3),
            soul_id    : v0,
            seller     : v1,
            kiosk_id   : v2,
            price      : arg5,
        };
        0x2::event::emit<SoulListed>(v4);
        v3
    }

    public fun list_soul_fixed_price_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg4), 58);
        assert!(0x1::option::is_none<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg4)), 15);
        list_soul_after_validation_v2(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x2::object::ID>(), 0, arg6)
    }

    public fun list_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(!arg0.paused, 11);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg5), 58);
        assert!((arg0.platform_fee_bps as u64) + (0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg5) as u64) + (0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg2) as u64) <= (10000 as u64), 10);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg5), &v0), 15);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg5) == 0x2::tx_context::sender(arg7), 39);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_kiosk_id(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 38);
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg5);
        let v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg3);
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v2, v3, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v4 = create_soul_listing(arg0, arg3, arg4, arg5, v1, arg6, 0x1::option::some<0x2::object::ID>(v0), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg2), arg7);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_listed(arg5, true);
        let v5 = SoulListed{
            listing_id : 0x2::object::id<SoulListing>(&v4),
            soul_id    : v1,
            seller     : v2,
            kiosk_id   : v3,
            price      : arg6,
        };
        0x2::event::emit<SoulListed>(v5);
        v4
    }

    public fun list_soul_fixed_price_with_collection_v2(arg0: &MarketConfigV2, arg1: &KioskRegistry, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg0.secondary_enabled, 61);
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::has_animacraft_provenance(arg5), 58);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollection>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::collection_id(arg5), &v0), 15);
        list_soul_after_validation_v2(arg0, arg1, arg3, arg4, arg5, arg6, 0x1::option::some<0x2::object::ID>(v0), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::extra_royalty_bps(arg2), arg7)
    }

    public fun mint_animacraft_in_personal_kiosk(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::CanonicalSoulMintAuthorization, arg7: 0x1::string::String, arg8: vector<InitialContentEntry>, arg9: vector<StateConfigEntry>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        mint_animacraft_in_personal_kiosk_impl(arg0.paused, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, 4, arg10, arg11)
    }

    fun mint_animacraft_in_personal_kiosk_impl(arg0: bool, arg1: u16, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg3: &KioskRegistry, arg4: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::CanonicalSoulMintAuthorization, arg8: 0x1::string::String, arg9: vector<InitialContentEntry>, arg10: vector<StateConfigEntry>, arg11: u16, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        let (v0, v1, v2, v3, v4) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::consume_canonical_soul_mint_authorization(arg7);
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::consume_soul_mint_authorization(v0);
        let v21 = v17;
        let v22 = v16;
        assert!(v5 == 4 || v5 == 5, 52);
        assert!(arg12 == 0 || v5 == arg12, 52);
        assert!(v9 == 0x2::tx_context::sender(arg14), 53);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == v9, 53);
        assert!(v6 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_maker_id(&v22), 55);
        assert!(v7 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_treasury_id(&v22), 55);
        if (v5 == 5) {
            assert_animacraft_v5_royalty_schedule(arg11, 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::royalty_policy_bps(&v22));
        } else {
            assert!(arg11 == 0, 55);
        };
        let v23 = payment_coin_type_name<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>();
        assert!(&v21 == &v23, 54);
        let v24 = mint_soul_in_personal_kiosk_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v10, arg8, v13, arg9, arg10, arg11, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_animacraft(), 0x1::option::some<0x1::string::String>(v11), arg13, arg14);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::bind_and_freeze(&mut v24, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_provenance::new(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(&v24), v5, v6, v7, v8, v9, v11, v12, v13, v14, v15, v22, v21, v18, v1, v2, v3, v4, v19, v20, arg14));
        v24
    }

    public fun mint_animacraft_in_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::CanonicalSoulMintAuthorization, arg7: 0x1::string::String, arg8: vector<InitialContentEntry>, arg9: vector<StateConfigEntry>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(arg0.primary_enabled, 60);
        mint_animacraft_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, 4, arg10, arg11)
    }

    public fun mint_animacraft_v5_in_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceV5SoulMintAuthorization, arg9: 0x1::string::String, arg10: vector<InitialContentEntry>, arg11: vector<StateConfigEntry>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(arg0.primary_enabled, 60);
        let (v0, v1, v2) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::consume_commerce_v5_soul_mint_authorization(arg8);
        let v3 = v2;
        let v4 = mint_animacraft_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg10, arg11, v1, 5, arg12, arg13);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::bind_complete_output_to_soul_v5<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_binding_v5::AnimacraftSoulBindingProofV5>(arg6, arg7, v3, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(&v4), 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_binding_v5::new());
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_output_provenance_v5::new_bind_and_freeze(&mut v4, arg6, *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::complete_output_soul_binding_seal_id_v5(&v3), arg13);
        v4
    }

    public fun mint_imported_in_personal_kiosk(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<InitialContentEntry>, arg10: vector<StateConfigEntry>, arg11: 0x1::string::String, arg12: u16, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        mint_soul_in_personal_kiosk_impl(arg0.paused, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_imported(), 0x1::option::some<0x1::string::String>(arg11), arg13, arg14)
    }

    public fun mint_imported_in_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<InitialContentEntry>, arg10: vector<StateConfigEntry>, arg11: 0x1::string::String, arg12: u16, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(arg0.primary_enabled, 60);
        mint_soul_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_imported(), 0x1::option::some<0x1::string::String>(arg11), arg13, arg14)
    }

    public fun mint_joined_in_personal_kiosk<T0: store + key>(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x2::object::ID, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<InitialContentEntry>, arg11: vector<StateConfigEntry>, arg12: 0x1::string::String, arg13: u16, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg4, arg6), 15);
        let v0 = JoinedSourceKey{source_object_id: arg6};
        assert!(!0x2::dynamic_field::exists<JoinedSourceKey>(&arg2.id, v0), 25);
        0x2::dynamic_field::add<JoinedSourceKey, bool>(&mut arg2.id, v0, true);
        mint_soul_in_personal_kiosk_impl(arg0.paused, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg13, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_personal_join(), 0x1::option::some<0x1::string::String>(arg12), arg14, arg15)
    }

    public fun mint_joined_in_personal_kiosk_v2<T0: store + key>(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x2::object::ID, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<InitialContentEntry>, arg11: vector<StateConfigEntry>, arg12: 0x1::string::String, arg13: u16, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(arg0.primary_enabled, 60);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg4, arg6), 15);
        let v0 = JoinedSourceKey{source_object_id: arg6};
        assert!(!0x2::dynamic_field::exists<JoinedSourceKey>(&arg2.id, v0), 25);
        0x2::dynamic_field::add<JoinedSourceKey, bool>(&mut arg2.id, v0, true);
        mint_soul_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11, arg13, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_personal_join(), 0x1::option::some<0x1::string::String>(arg12), arg14, arg15)
    }

    public fun mint_native_in_personal_kiosk(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<InitialContentEntry>, arg10: vector<StateConfigEntry>, arg11: u16, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        mint_soul_in_personal_kiosk_impl(arg0.paused, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_native(), 0x1::option::none<0x1::string::String>(), arg12, arg13)
    }

    public fun mint_native_in_personal_kiosk_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &KioskRegistry, arg3: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<InitialContentEntry>, arg10: vector<StateConfigEntry>, arg11: u16, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(arg0.primary_enabled, 60);
        mint_soul_in_personal_kiosk_impl(false, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::provenance_native(), 0x1::option::none<0x1::string::String>(), arg12, arg13)
    }

    fun mint_soul_in_personal_kiosk_impl(arg0: bool, arg1: u16, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg3: &KioskRegistry, arg4: &0x2::transfer_policy::TransferPolicy<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<InitialContentEntry>, arg11: vector<StateConfigEntry>, arg12: u16, arg13: u8, arg14: 0x1::option::Option<0x1::string::String>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState {
        assert!(!arg0, 11);
        assert!((arg1 as u64) + (arg12 as u64) <= (10000 as u64), 10);
        assert!(0x2::kiosk::has_access(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6)), 8);
        assert_initial_content_well_formed(arg2, &arg10);
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        assert_registered_personal_kiosk(arg3, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg6));
        let v2 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::mint(arg7, arg8, arg9, v0, arg12, arg13, arg14, arg16);
        let v3 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(&v2);
        let v4 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::create_state(v3, v0, arg12, v0, v1, arg16);
        let v5 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::create(v3, arg16);
        let v6 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent>(&v5);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_content_id(&mut v4, v6);
        let v7 = &mut v4;
        apply_initial_state_config(v7, arg11, v0);
        let v8 = &mut v5;
        apply_initial_content_entries(v8, &v4, arg2, arg10, arg15, arg16);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::assert_initial_content_complete(&v4, &v5);
        let v9 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::create(v3, v0, arg16);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::set_access_list_id(&mut v4, 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList>(&v9));
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::share_paid_access_list(v9);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::share_content(v5);
        0x2::kiosk::lock<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg4, v2);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_created_after_content_bound(&v4, arg13);
        let v10 = SoulMintedToKiosk{
            soul_id         : v3,
            state_id        : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(&v4),
            content_id      : v6,
            kiosk_id        : v1,
            owner           : v0,
            provenance_kind : arg13,
        };
        0x2::event::emit<SoulMintedToKiosk>(v10);
        v4
    }

    public fun new_initial_content_entry(arg0: u32, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: bool, arg5: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) : InitialContentEntry {
        InitialContentEntry{
            kind                : arg0,
            name                : arg1,
            slot_read_mode_mask : arg2,
            download_policy     : arg3,
            set_active          : arg4,
            blob                : arg5,
        }
    }

    public fun new_state_config_entry(arg0: 0x1::string::String, arg1: vector<u8>) : StateConfigEntry {
        StateConfigEntry{
            key   : arg0,
            value : arg1,
        }
    }

    public fun paused(arg0: &MarketConfig) : bool {
        arg0.paused
    }

    fun payment_coin_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun personal_kiosk_registration(arg0: &KioskRegistry, arg1: address) : &PersonalKioskRegistration {
        borrow_personal_kiosk_registration(arg0, arg1)
    }

    public fun personal_kiosk_registration_version(arg0: &PersonalKioskRegistration) : u64 {
        arg0.version
    }

    public fun platform_fee_bps(arg0: &MarketConfig) : u16 {
        arg0.platform_fee_bps
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun purchase_paid_access(arg0: &MarketConfig, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg3: u32, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        purchase_paid_access_impl(arg0.paused, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun purchase_paid_access_impl(arg0: bool, arg1: address, arg2: u16, arg3: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg4: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg5: u32, arg6: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::soul_id(arg3) == 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4), 19);
        let v0 = 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::access_list_id(arg4), &v0), 29);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::has_kind_config(arg3, arg5), 51);
        let v1 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::kind_config_price_atomic(arg3, arg5);
        assert!(v1 > 0, 28);
        assert!(0x2::tx_context::sender(arg8) != 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4), 35);
        let v2 = bps_amount(v1, arg2);
        let v3 = (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 9);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg6) == (v3 as u64), 6);
        let v4 = 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg4);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg6, v2, arg8), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg6, v4);
        let v5 = 0x2::tx_context::sender(arg8);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::record_purchase(arg3, arg4, v5, arg5, v1, arg7, arg8);
        let v6 = SoulPaidAccessPurchased{
            soul_id             : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg4),
            paid_access_list_id : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList>(arg3),
            buyer               : v5,
            price               : v1,
            platform_fee        : v2,
            payment_recipient   : v4,
        };
        0x2::event::emit<SoulPaidAccessPurchased>(v6);
    }

    public fun purchase_paid_access_v2(arg0: &MarketConfigV2, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg2: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg3: u32, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        purchase_paid_access_impl(false, arg0.fee_recipient, arg0.platform_fee_bps, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun quote_animacraft_soul_purchase(arg0: &MarketConfig, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        quote_animacraft_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg1, arg2, arg3)
    }

    public fun quote_animacraft_soul_purchase_v2(arg0: &MarketConfigV2, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        assert!(arg0.secondary_enabled, 61);
        quote_animacraft_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg1, arg2, arg3)
    }

    fun quote_animacraft_soul_purchase_with_fee_bps(arg0: u16, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        assert!(arg1 > 0, 1);
        assert!((arg0 as u64) + (arg2 as u64) + (arg3 as u64) <= (10000 as u64), 10);
        let v0 = bps_amount(arg1, arg0);
        let v1 = floor_bps_amount(arg1, arg2);
        assert!(arg2 == 0 || v1 > 0, 57);
        let v2 = bps_amount(arg1, arg3);
        let v3 = (arg1 as u128) + (v0 as u128) + (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 9);
        (v0, arg1, v1, v2, (v3 as u64))
    }

    public fun quote_animacraft_v5_soul_sale(arg0: u64, arg1: u16, arg2: u16) : (u64, u64, u64, u64) {
        assert!(arg0 > 0, 1);
        assert_animacraft_v5_royalty_schedule(arg1, arg2);
        let v0 = floor_bps_amount(arg0, 250);
        let v1 = floor_bps_amount(arg0, arg1);
        let v2 = floor_bps_amount(arg0, arg2);
        (arg0 - v0 - v1 - v2, v0, v1, v2)
    }

    public fun quote_animacraft_v5_soul_sale_for_state(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: u64, arg2: u16) : (u64, u64, u64, u64) {
        quote_animacraft_v5_soul_sale(arg1, 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::creator_royalty_bps(arg0), arg2)
    }

    public fun quote_collection_purchase(arg0: &MarketConfig, arg1: u64) : (u64, u64, u64) {
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_collection_purchase_v2(arg0: &MarketConfigV2, arg1: u64) : (u64, u64, u64) {
        assert!(arg0.secondary_enabled, 61);
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_paid_access_purchase(arg0: &MarketConfig, arg1: u64) : (u64, u64, u64) {
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_paid_access_purchase_v2(arg0: &MarketConfigV2, arg1: u64) : (u64, u64, u64) {
        assert!(arg0.primary_enabled, 60);
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_soul_purchase(arg0: &MarketConfig, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        quote_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg1, arg2, arg3)
    }

    public fun quote_soul_purchase_v2(arg0: &MarketConfigV2, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        assert!(arg0.secondary_enabled, 61);
        quote_soul_purchase_with_fee_bps(arg0.platform_fee_bps, arg1, arg2, arg3)
    }

    fun quote_soul_purchase_with_fee_bps(arg0: u16, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        assert!((arg0 as u64) + (arg2 as u64) + (arg3 as u64) <= (10000 as u64), 10);
        let v0 = bps_amount(arg1, arg0);
        let v1 = bps_amount(arg1, arg2);
        let v2 = bps_amount(arg1, arg3);
        let v3 = (arg1 as u128) + (v0 as u128) + (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 9);
        (v0, arg1, v1, v2, (v3 as u64))
    }

    public fun rebind_primary_kiosk(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        rebind_primary_kiosk_impl(arg1, arg2, arg3, arg4);
    }

    fun rebind_primary_kiosk_impl(arg0: &mut KioskRegistry, arg1: &0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2));
        let v3 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg2);
        assert!(v1 != v2, 33);
        assert!(0x2::kiosk::item_count(arg1) == 0, 31);
        let v4 = PersonalKioskOwnerKey{owner: v0};
        assert!(0x2::dynamic_field::exists<PersonalKioskOwnerKey>(&arg0.id, v4), 13);
        let v5 = 0x2::dynamic_field::borrow_mut<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg0.id, v4);
        assert!(v5.kiosk_id == v1, 32);
        v5.kiosk_id = v2;
        v5.kiosk_cap_id = v3;
        let v6 = PersonalKioskRebound{
            owner            : v0,
            old_kiosk_id     : v1,
            old_kiosk_cap_id : v5.kiosk_cap_id,
            new_kiosk_id     : v2,
            new_kiosk_cap_id : v3,
        };
        0x2::event::emit<PersonalKioskRebound>(v6);
    }

    public fun rebind_primary_kiosk_v2(arg0: &MarketConfigV2, arg1: &mut KioskRegistry, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled || arg0.secondary_enabled, 60);
        rebind_primary_kiosk_impl(arg1, arg2, arg3, arg4);
    }

    fun register_personal_kiosk(arg0: &mut KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        assert!(!0x2::dynamic_field::exists<PersonalKioskOwnerKey>(&arg0.id, v0), 12);
        let v1 = PersonalKioskRegistration{
            version      : 1,
            kiosk_id     : arg2,
            kiosk_cap_id : arg3,
        };
        0x2::dynamic_field::add<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg0.id, v0, v1);
    }

    public fun retire_legacy_market(arg0: &mut MarketConfig, arg1: MarketAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 59);
        let v0 = 0x2::object::id<MarketConfig>(arg0);
        let MarketAdminCap { id: v1 } = arg1;
        0x2::object::delete(v1);
        let v2 = MarketConfigV2{
            id                : 0x2::object::new(arg2),
            version           : 2,
            legacy_config_id  : v0,
            fee_recipient     : arg0.fee_recipient,
            platform_fee_bps  : arg0.platform_fee_bps,
            primary_enabled   : false,
            secondary_enabled : false,
        };
        let v3 = 0x2::object::id<MarketConfigV2>(&v2);
        let v4 = MarketAdminCapV2{
            id        : 0x2::object::new(arg2),
            config_id : v3,
        };
        0x2::transfer::share_object<MarketConfigV2>(v2);
        0x2::transfer::transfer<MarketAdminCapV2>(v4, 0x2::tx_context::sender(arg2));
        let v5 = LegacyMarketRetired{
            legacy_config_id : v0,
            config_v2_id     : v3,
            admin_cap_v2_id  : 0x2::object::id<MarketAdminCapV2>(&v4),
            retired_by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LegacyMarketRetired>(v5);
    }

    public fun reuse_personal_kiosk(arg0: &KioskRegistry, arg1: 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&arg1));
        assert_registered_personal_kiosk(arg0, 0x2::tx_context::sender(arg2), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&arg1));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(arg1, arg2);
        v0
    }

    public fun set_active_content(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg3) == 0x2::tx_context::sender(arg7), 44);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::set_active(arg2, arg3, arg1, arg4, arg5, arg6, arg7);
    }

    public fun set_active_content_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::SoulContent, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg3) == 0x2::tx_context::sender(arg7), 44);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::content::set_active(arg2, arg3, arg1, arg4, arg5, arg6, arg7);
    }

    public fun set_state_config(arg0: &MarketConfig, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg1) == 0x2::tx_context::sender(arg4), 44);
        assert!(!0x1::string::is_empty(&arg2), 45);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::upsert_state_config(arg1, arg2, arg3);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_state_config_upserted(arg1, 0x2::tx_context::sender(arg4), arg2);
    }

    public fun set_state_config_v2(arg0: &MarketConfigV2, arg1: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        assert!(0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::current_owner(arg1) == 0x2::tx_context::sender(arg4), 44);
        assert!(!0x1::string::is_empty(&arg2), 45);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::upsert_state_config(arg1, arg2, arg3);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::emit_state_config_upserted(arg1, 0x2::tx_context::sender(arg4), arg2);
    }

    public fun soul_listing_version(arg0: &SoulListing) : u64 {
        arg0.version
    }

    fun take_collection_purchase_cap(arg0: &mut CollectionListing) : 0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight> {
        assert!(0x1::option::is_some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(&arg0.purchase_cap), 7);
        0x1::option::extract<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::collection::SoulCollectionRight>>(&mut arg0.purchase_cap)
    }

    fun take_soul_purchase_cap(arg0: &mut SoulListing) : 0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul> {
        assert!(0x1::option::is_some<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(&arg0.purchase_cap), 7);
        0x1::option::extract<0x2::kiosk::PurchaseCap<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::Soul>>(&mut arg0.purchase_cap)
    }

    public fun update_config_v2_fee_recipient(arg0: &mut MarketConfigV2, arg1: &MarketAdminCapV2, arg2: address) {
        assert!(arg1.config_id == 0x2::object::id<MarketConfigV2>(arg0), 55);
        assert!(arg2 != @0x0, 0);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{fee_recipient: arg2};
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun update_config_v2_platform_fee_bps(arg0: &mut MarketConfigV2, arg1: &MarketAdminCapV2, arg2: u16) {
        assert!(arg1.config_id == 0x2::object::id<MarketConfigV2>(arg0), 55);
        assert!(arg2 <= 10000, 2);
        arg0.platform_fee_bps = arg2;
        let v0 = PlatformFeeBpsUpdated{fee_bps: arg2};
        0x2::event::emit<PlatformFeeBpsUpdated>(v0);
    }

    public fun update_config_v2_primary_enabled(arg0: &mut MarketConfigV2, arg1: &MarketAdminCapV2, arg2: bool) {
        assert!(arg1.config_id == 0x2::object::id<MarketConfigV2>(arg0), 55);
        arg0.primary_enabled = arg2;
        let v0 = MarketPrimaryGateV2Updated{enabled: arg2};
        0x2::event::emit<MarketPrimaryGateV2Updated>(v0);
    }

    public fun update_config_v2_secondary_enabled(arg0: &mut MarketConfigV2, arg1: &MarketAdminCapV2, arg2: bool) {
        assert!(arg1.config_id == 0x2::object::id<MarketConfigV2>(arg0), 55);
        arg0.secondary_enabled = arg2;
        let v0 = MarketSecondaryGateV2Updated{enabled: arg2};
        0x2::event::emit<MarketSecondaryGateV2Updated>(v0);
    }

    public fun update_fee_recipient(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 0);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{fee_recipient: arg2};
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun update_paid_access_kind(arg0: &MarketConfig, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::update_paid_access_kind(arg2, arg3, arg1, arg4, arg5, arg6, arg7, arg8);
    }

    public fun update_paid_access_kind_v2(arg0: &MarketConfigV2, arg1: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::kind_registry::KindRegistry, arg2: &mut 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::SoulPaidAccessList, arg3: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg4: u32, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.primary_enabled, 60);
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::paid_access::update_paid_access_kind(arg2, arg3, arg1, arg4, arg5, arg6, arg7, arg8);
    }

    public fun update_paused(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = MarketPauseUpdated{paused: arg2};
        0x2::event::emit<MarketPauseUpdated>(v0);
    }

    public fun update_platform_fee_bps(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: u16) {
        assert!(arg2 <= 10000, 2);
        arg0.platform_fee_bps = arg2;
        let v0 = PlatformFeeBpsUpdated{fee_bps: arg2};
        0x2::event::emit<PlatformFeeBpsUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

