module 0x1568f13b3c8f5b2246d8ba421ff83510417fc0d492eef1e1ce12e76c5304ed71::physical_composition_v7 {
    struct PhysicalProtocolConfigV7 has key {
        id: 0x2::object::UID,
        version: u64,
        v6_config_id: 0x2::object::ID,
        v5_config_id: 0x2::object::ID,
        v6_admin_cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        soul_owner_proof_type: 0x1::string::String,
        listing_proof_type: 0x1::option::Option<0x1::string::String>,
        enabled: bool,
    }

    struct PhysicalAdminCapV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
    }

    struct PhysicalRegistryV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profiles: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        family_seed_products: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        style_products: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        wardrobes: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        free_style_claims: 0x2::table::Table<FreeStyleClaimKeyV7, bool>,
        family_count: u64,
        product_count: u64,
        wardrobe_count: u64,
    }

    struct FreeStyleClaimKeyV7 has copy, drop, store {
        style_product_id: 0x2::object::ID,
        wallet: address,
    }

    struct PartPolicyKeyV7 has copy, drop, store {
        slot_key: 0x1::string::String,
    }

    struct PartPolicyV7 has copy, drop, store {
        slot_key: 0x1::string::String,
        behavior: u8,
        required: bool,
        max_source_kind: u8,
    }

    struct MakerPhysicalProfileV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        v6_profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        slot_schema_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        part_policies: 0x2::table::Table<PartPolicyKeyV7, PartPolicyV7>,
        required_slot_keys: vector<0x1::string::String>,
        part_policy_count: u64,
        sealed: bool,
    }

    struct ItemFamilyV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        seed_v6_product_id: 0x2::object::ID,
        creator: address,
        slot_key: 0x1::string::String,
        family_key: 0x1::string::String,
        label: 0x1::string::String,
        family_commitment: vector<u8>,
        rights_origin: u8,
    }

    struct StyleProductV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        v6_profile_id: 0x2::object::ID,
        family_id: 0x2::object::ID,
        v6_product_id: 0x2::object::ID,
        original_creator: address,
        slot_key: 0x1::string::String,
        style_key: 0x1::string::String,
        recipe_item_key: 0x1::string::String,
        label: 0x1::string::String,
        source_kind: u8,
        entitlement_kind: u8,
        pack_key: 0x1::option::Option<0x1::string::String>,
        supply_kind: u8,
        max_supply: u64,
        minted_supply: u64,
        price_atomic: u64,
        protocol_fee_bps: u16,
        maker_ecosystem_fee_bps: u16,
        transferable: bool,
        definition_commitment: vector<u8>,
        asset_commitment: vector<u8>,
        definition_blob_id: 0x1::string::String,
        definition_identifier: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_identifier: 0x1::string::String,
        renderer_commitment: vector<u8>,
        required_v6_product_ids: vector<0x2::object::ID>,
        excluded_v6_product_ids: vector<0x2::object::ID>,
        active: bool,
    }

    struct StyleAssetV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        family_id: 0x2::object::ID,
        style_product_id: 0x2::object::ID,
        v6_product_id: 0x2::object::ID,
        original_creator: address,
        slot_key: 0x1::string::String,
        source_kind: u8,
        asset_kind: u8,
        serial: u64,
        transferable: bool,
        holder: address,
        bound_soul_id: 0x1::option::Option<0x2::object::ID>,
        ownership_epoch: u64,
        required_v6_product_ids: vector<0x2::object::ID>,
        excluded_v6_product_ids: vector<0x2::object::ID>,
    }

    struct CustodyRecordV7 has copy, drop, store {
        style_product_id: 0x2::object::ID,
        family_id: 0x2::object::ID,
        v6_product_id: 0x2::object::ID,
        slot_key: 0x1::string::String,
        source_kind: u8,
        asset_kind: u8,
        bound_soul_id: 0x1::option::Option<0x2::object::ID>,
        equipped: bool,
        required_v6_product_ids: vector<0x2::object::ID>,
        excluded_v6_product_ids: vector<0x2::object::ID>,
    }

    struct InitialPhysicalLoadoutAuthorizationV7 {
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        v6_profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        recipe_hash: vector<u8>,
        recipe: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>,
        style_selections: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>,
        visual_recipe_indices: vector<u64>,
        style_product_ids: vector<0x2::object::ID>,
        authorization_commitment: vector<u8>,
        sealed: bool,
    }

    struct InitialPhysicalAuthorizationHashInputV7 has copy, drop, store {
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        v6_profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        recipe_hash: vector<u8>,
        visual_recipe_indices: vector<u64>,
        style_product_ids: vector<0x2::object::ID>,
    }

    struct SoulWardrobeV7 has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        slot_schema_commitment: vector<u8>,
        revision: u64,
        initialized: bool,
        listed: bool,
        inventory: 0x2::table::Table<0x2::object::ID, CustodyRecordV7>,
        claimed_included_products: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        equipped_by_slot: 0x2::table::Table<PartPolicyKeyV7, 0x2::object::ID>,
        equipped_asset_ids: vector<0x2::object::ID>,
        initial_product_by_slot: 0x2::table::Table<PartPolicyKeyV7, 0x2::object::ID>,
        authorized_initial_style_product_ids: vector<0x2::object::ID>,
        initial_recipe_hash: vector<u8>,
        initial_authorization_commitment: vector<u8>,
        initial_style_product_ids: vector<0x2::object::ID>,
        initial_asset_ids: vector<0x2::object::ID>,
        external_asset_count: u64,
        soul_local_asset_count: u64,
        equipped_count: u64,
    }

    struct PhysicalProtocolInitializedV7 has copy, drop {
        config_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        owner_proof_type: 0x1::string::String,
    }

    struct PartPolicyRegisteredV7 has copy, drop {
        profile_id: 0x2::object::ID,
        slot_key: 0x1::string::String,
        behavior: u8,
        required: bool,
        max_source_kind: u8,
    }

    struct ItemFamilyPublishedV7 has copy, drop {
        family_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        seed_v6_product_id: 0x2::object::ID,
        creator: address,
        slot_key: 0x1::string::String,
    }

    struct StyleProductPublishedV7 has copy, drop {
        style_product_id: 0x2::object::ID,
        family_id: 0x2::object::ID,
        v6_product_id: 0x2::object::ID,
        original_creator: address,
        recipe_item_key: 0x1::string::String,
        supply_kind: u8,
        max_supply: u64,
        definition_blob_id: 0x1::string::String,
        definition_identifier: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_identifier: 0x1::string::String,
        definition_commitment: vector<u8>,
        asset_commitment: vector<u8>,
    }

    struct SoulWardrobeCreatedV7 has copy, drop {
        wardrobe_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        initial_recipe_hash: vector<u8>,
        initial_authorization_commitment: vector<u8>,
    }

    struct SoulWardrobeFinalizedV7 has copy, drop {
        wardrobe_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        revision: u64,
        initial_style_count: u64,
    }

    struct StyleAssetMaterializedV7 has copy, drop {
        asset_id: 0x2::object::ID,
        style_product_id: 0x2::object::ID,
        asset_kind: u8,
        serial: u64,
        soul_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct WardrobeMutationV7 has copy, drop {
        wardrobe_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        slot_key: 0x1::string::String,
        operation: u8,
        revision: u64,
    }

    fun add_to_wardrobe(arg0: &mut SoulWardrobeV7, arg1: &StyleAssetV7) {
        let v0 = 0x2::object::id<StyleAssetV7>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0), 33);
        0x2::table::add<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0, custody_record(arg1, false));
        if (arg1.asset_kind == 1) {
            arg0.external_asset_count = arg0.external_asset_count + 1;
        } else {
            arg0.soul_local_asset_count = arg0.soul_local_asset_count + 1;
        };
    }

    public fun append_initial_logical_style_to_authorization_v7(arg0: &mut InitialPhysicalLoadoutAuthorizationV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: 0x1::string::String) {
        assert!(!arg0.sealed, 56);
        assert!(arg0.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg1), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg1), 10);
        let v0 = 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(&arg0.style_selections);
        assert!(v0 < 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg0.recipe), 55);
        let v1 = 0x1::vector::borrow<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg0.recipe, v0);
        let v2 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_part_key(v1);
        let v3 = *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_item_key(v1);
        let v4 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_row_kind_v5(arg1, v2, v3, arg2);
        assert!(v4 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_row_logical_none_v5() || v4 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_row_logical_color_v5(), 59);
        0x1::vector::push_back<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(&mut arg0.style_selections, 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::new_style_selection_v5(v2, v3, arg2));
    }

    public fun append_initial_style_to_authorization_v7(arg0: &mut InitialPhysicalLoadoutAuthorizationV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg2: &ItemFamilyV7, arg3: &StyleProductV7) {
        assert!(!arg0.sealed, 56);
        assert!(arg0.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg1), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg1), 10);
        assert!(arg2.config_id == arg0.config_id, 2);
        assert!(arg2.profile_id == arg0.profile_id, 2);
        assert!(arg3.config_id == arg0.config_id, 2);
        assert!(arg3.profile_id == arg0.profile_id, 2);
        assert!(arg3.v6_profile_id == arg0.v6_profile_id, 2);
        assert!(arg3.family_id == 0x2::object::id<ItemFamilyV7>(arg2), 19);
        assert_included_entitlement_kind(arg3);
        assert!(arg3.supply_kind == 0, 22);
        assert!(arg3.active, 24);
        let v0 = 0x2::object::id<StyleProductV7>(arg3);
        assert!(!vector_contains_id(&arg0.style_product_ids, v0), 57);
        let v1 = 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(&arg0.style_selections);
        assert!(v1 < 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg0.recipe), 55);
        let v2 = 0x1::vector::borrow<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg0.recipe, v1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_part_key(v2) == &arg3.slot_key, 55);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::recipe_slot_item_key(v2) == &arg3.recipe_item_key, 55);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_row_kind_v5(arg1, arg3.slot_key, arg3.recipe_item_key, arg3.style_key) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_row_visual_v5(), 59);
        let v3 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_pack_key_v5(arg1, arg3.slot_key, arg3.recipe_item_key, arg3.style_key);
        assert!(&v3 == &arg3.pack_key, 47);
        0x1::vector::push_back<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(&mut arg0.style_selections, 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::new_style_selection_v5(arg3.slot_key, arg3.recipe_item_key, arg3.style_key));
        0x1::vector::push_back<u64>(&mut arg0.visual_recipe_indices, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.style_product_ids, v0);
    }

    fun assert_admin(arg0: &PhysicalProtocolConfigV7, arg1: &PhysicalAdminCapV7) {
        assert!(arg1.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg0), 0);
    }

    fun assert_asset_product(arg0: &SoulWardrobeV7, arg1: &StyleProductV7, arg2: &StyleAssetV7) {
        assert!(arg1.config_id == arg0.config_id, 2);
        assert!(arg1.profile_id == arg0.profile_id, 2);
        assert!(arg2.config_id == arg0.config_id, 31);
        assert!(arg2.profile_id == arg0.profile_id, 31);
        assert!(arg2.style_product_id == 0x2::object::id<StyleProductV7>(arg1), 31);
        assert!(arg2.family_id == arg1.family_id, 31);
        assert!(&arg2.slot_key == &arg1.slot_key, 38);
    }

    fun assert_config_links(arg0: &PhysicalProtocolConfigV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert!(arg0.v6_config_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6>(arg1), 2);
        assert!(arg0.v5_config_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5>(arg2), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_v5_config_id_v6(arg1) == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5>(arg2), 2);
    }

    fun assert_config_profile(arg0: &PhysicalProtocolConfigV7, arg1: &MakerPhysicalProfileV7) {
        assert!(arg1.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg0), 2);
    }

    fun assert_equipped_rules(arg0: &SoulWardrobeV7) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.equipped_asset_ids)) {
            let v1 = 0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, *0x1::vector::borrow<0x2::object::ID>(&arg0.equipped_asset_ids, v0));
            assert!(v1.equipped, 42);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x2::object::ID>(&v1.required_v6_product_ids)) {
                assert!(equipped_contains_v6_product(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1.required_v6_product_ids, v2)), 42);
                v2 = v2 + 1;
            };
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(&v1.excluded_v6_product_ids)) {
                assert!(!equipped_contains_v6_product(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1.excluded_v6_product_ids, v3)), 42);
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_external_publication_authority(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg1);
        assert!(v0 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::origin_certified_v6() || v0 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::origin_open_v6(), 40);
        assert_v6_admission_source(arg0, arg1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_original_creator_v6(arg1) == 0x2::tx_context::sender(arg2) && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_publisher_v6(arg1) == 0x2::tx_context::sender(arg2), 25);
    }

    fun assert_family_seed_unregistered(arg0: &PhysicalRegistryV7, arg1: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.family_seed_products, arg1), 16);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 20);
    }

    fun assert_included_entitlement_kind(arg0: &StyleProductV7) {
        assert!(arg0.entitlement_kind == 0 || arg0.entitlement_kind == 3, 47);
        if (arg0.entitlement_kind == 3) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg0.pack_key), 47);
        } else {
            assert!(0x1::option::is_none<0x1::string::String>(&arg0.pack_key), 47);
        };
    }

    fun assert_initial_part_accepts_asset(arg0: &MakerPhysicalProfileV7, arg1: &StyleAssetV7) {
        let v0 = part_policy(arg0, arg1.slot_key);
        assert!(arg1.source_kind <= v0.max_source_kind, 40);
        assert!(arg1.asset_kind == 0, 31);
        assert!(arg1.source_kind == 0, 40);
        let v1 = if (v0.behavior == 0) {
            true
        } else if (v0.behavior == 1) {
            true
        } else {
            v0.behavior == 3
        };
        assert!(v1, 40);
    }

    fun assert_listing_proof<T0: drop>(arg0: &PhysicalProtocolConfigV7) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.listing_proof_type), 3);
        let v0 = defining_type_name<T0>();
        assert!(&v0 == 0x1::option::borrow<0x1::string::String>(&arg0.listing_proof_type), 5);
    }

    fun assert_locator_identifier(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) <= 512, 21);
    }

    fun assert_non_empty(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 21);
    }

    fun assert_operational(arg0: &PhysicalProtocolConfigV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &MakerPhysicalProfileV7, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert_publication_gate(arg0, arg1, arg5);
        assert_config_profile(arg0, arg2);
        assert!(arg2.sealed, 10);
        assert!(arg2.v6_profile_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg3), 2);
        assert_v6_profile_link(arg0, arg3, arg4);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_operational_v5(arg4, arg5);
    }

    fun assert_owner_action<T0: drop>(arg0: &SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::object::ID, arg8: T0) {
        assert_owner_proof<T0>(arg1);
        assert_operational(arg1, arg2, arg3, arg4, arg5, arg6);
        assert_wardrobe_config(arg0, arg1);
        assert!(arg0.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg3), 2);
        assert!(arg0.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg5), 2);
        assert!(arg0.soul_id == arg7, 27);
    }

    fun assert_owner_proof<T0: drop>(arg0: &PhysicalProtocolConfigV7) {
        let v0 = defining_type_name<T0>();
        assert!(&v0 == &arg0.soul_owner_proof_type, 4);
    }

    fun assert_part_accepts_asset(arg0: &MakerPhysicalProfileV7, arg1: &StyleAssetV7) {
        let v0 = part_policy(arg0, arg1.slot_key);
        assert!(v0.behavior != 0, 39);
        assert!(arg1.source_kind <= v0.max_source_kind, 40);
        if (arg1.asset_kind == 0) {
            assert!(v0.behavior == 1 || v0.behavior == 3, 40);
        } else {
            assert!(v0.behavior == 2 || v0.behavior == 3, 40);
        };
    }

    fun assert_part_can_unequip(arg0: &PartPolicyV7) {
        assert!(arg0.behavior != 0, 39);
        assert!(!arg0.required, 41);
    }

    fun assert_part_policy(arg0: u8, arg1: bool, arg2: u8, arg3: &0x1::string::String) {
        assert_non_empty(arg3);
        assert!(arg0 <= 3, 12);
        assert!(arg2 <= 2, 12);
        if (arg0 == 0 || arg0 == 1) {
            assert!(arg2 == 0, 12);
        };
        let v0 = arg1 && arg0 == 2;
        assert!(!v0, 12);
    }

    public fun assert_physical_profile_binding_v7(arg0: &MakerPhysicalProfileV7, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &vector<u8>) {
        assert!(arg0.sealed, 10);
        assert!(arg0.root_id == arg1, 2);
        assert!(arg0.v6_profile_id == arg2, 2);
        assert!(&arg0.slot_schema_commitment == arg3, 2);
        assert!(&arg0.renderer_commitment == arg4, 2);
    }

    fun assert_postmint_included_entitlement(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg1: &StyleProductV7, arg2: address) {
        assert_included_entitlement_kind(arg1);
        assert!(arg1.entitlement_kind == 3 && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_pack_entitlement_v5(arg0, *0x1::option::borrow<0x1::string::String>(&arg1.pack_key), arg2) || 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::has_base_entitlement_v5(arg0, arg2), 58);
    }

    fun assert_product_admitted(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: &StyleProductV7) {
        assert!(arg1.v6_profile_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg0), 2);
        assert_v6_admission_active(arg0, arg1.v6_product_id);
    }

    fun assert_product_part_compatible(arg0: &MakerPhysicalProfileV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg2: u8) {
        assert_supply_part_policy_compatible(part_policy(arg0, *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg1)), 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg1), arg2);
    }

    fun assert_publication_gate(arg0: &PhysicalProtocolConfigV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5) {
        assert!(arg0.enabled, 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_enabled_v6(arg1), 1);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_protocol_enabled_v5(arg2);
        assert_config_links(arg0, arg1, arg2);
    }

    fun assert_registry(arg0: &PhysicalProtocolConfigV7, arg1: &PhysicalRegistryV7) {
        assert!(arg1.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg0), 2);
        assert!(0x2::object::id<PhysicalRegistryV7>(arg1) == arg0.registry_id, 2);
    }

    fun assert_style_product_unregistered(arg0: &PhysicalRegistryV7, arg1: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.style_products, arg1), 17);
    }

    fun assert_style_sale_link(arg0: &PhysicalProtocolConfigV7, arg1: &StyleProductV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6) {
        assert!(arg0.enabled, 1);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_enabled_v6(arg2), 1);
        assert!(arg1.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg0), 2);
        assert!(arg1.v6_profile_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg3), 2);
        assert!(arg1.v6_product_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6>(arg4), 48);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_config_id_v6(arg4) == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6>(arg2), 2);
        assert_product_admitted(arg3, arg1);
        assert!(arg1.active, 24);
    }

    fun assert_supply(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg1: u8, arg2: u64) {
        assert!(arg1 <= 2, 22);
        if (arg1 == 0) {
            assert!(arg2 == 0, 22);
            let v0 = if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_embedded_v6()) {
                if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_binding_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::binding_embedded_v6()) {
                    !0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_transferable_v6(arg0)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 26);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::origin_official_v6(), 40);
        } else {
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_binding_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::binding_owned_v6(), 26);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_free_v6() || 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_paid_v6(), 47);
            if (arg1 == 1) {
                assert!(arg2 == 0, 22);
            } else {
                assert!(arg2 > 0, 22);
            };
        };
    }

    fun assert_supply_available(arg0: &StyleProductV7) {
        assert!(arg0.active, 24);
        if (arg0.supply_kind == 2) {
            assert!(arg0.minted_supply < arg0.max_supply, 23);
        };
    }

    fun assert_supply_part_policy_compatible(arg0: &PartPolicyV7, arg1: u8, arg2: u8) {
        assert!(arg1 <= arg0.max_source_kind, 40);
        if (arg2 == 0) {
            assert!(arg1 == 0, 40);
            let v0 = if (arg0.behavior == 0) {
                true
            } else if (arg0.behavior == 1) {
                true
            } else {
                arg0.behavior == 3
            };
            assert!(v0, 40);
        } else {
            assert!(arg0.behavior == 2 || arg0.behavior == 3, 40);
        };
    }

    fun assert_v6_admission_active(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: 0x2::object::ID) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::item_is_admitted_v6(arg0, arg1), 18);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::admission_active_v6(arg0, arg1), 18);
    }

    fun assert_v6_admission_source(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6) {
        let v0 = 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6>(arg1);
        assert_v6_admission_active(arg0, v0);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::admission_source_kind_v6(arg0, v0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg1), 40);
    }

    fun assert_v6_product_link(arg0: &PhysicalProtocolConfigV7, arg1: &MakerPhysicalProfileV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6) {
        assert!(arg1.v6_profile_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg2), 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_config_id_v6(arg3) == arg0.v6_config_id, 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_schema_commitment_v6(arg3) == &arg1.slot_schema_commitment, 2);
        let v0 = PartPolicyKeyV7{slot_key: *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg3)};
        assert!(0x2::table::contains<PartPolicyKeyV7, PartPolicyV7>(&arg1.part_policies, v0), 14);
    }

    fun assert_v6_profile_link(arg0: &PhysicalProtocolConfigV7, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_config_id_v6(arg1) == arg0.v6_config_id, 2);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_root_id_v6(arg1) == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg2), 2);
    }

    fun assert_wardrobe_complete_internal(arg0: &SoulWardrobeV7, arg1: &MakerPhysicalProfileV7) {
        assert!(arg0.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg1), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1.required_slot_keys)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1.required_slot_keys, v0);
            assert!(part_policy(arg1, v1).required, 12);
            let v2 = PartPolicyKeyV7{slot_key: v1};
            assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2), 50);
            v0 = v0 + 1;
        };
        assert_equipped_rules(arg0);
    }

    public fun assert_wardrobe_complete_v7(arg0: &SoulWardrobeV7, arg1: &MakerPhysicalProfileV7) {
        assert!(arg0.initialized, 52);
        assert_wardrobe_complete_internal(arg0, arg1);
    }

    fun assert_wardrobe_config(arg0: &SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7) {
        assert!(arg0.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg1), 2);
    }

    fun assert_wardrobe_mutable(arg0: &SoulWardrobeV7, arg1: u64) {
        assert!(arg0.initialized, 52);
        assert!(!arg0.listed, 29);
        assert!(arg0.revision == arg1, 30);
    }

    public fun assert_wardrobe_transferable_v7(arg0: &SoulWardrobeV7, arg1: &MakerPhysicalProfileV7) {
        assert!(arg0.initialized, 52);
        assert!(!arg0.listed, 29);
        assert!(arg0.external_asset_count == 0, 44);
        assert_wardrobe_complete_internal(arg0, arg1);
    }

    fun assert_withdrawable_asset(arg0: &StyleAssetV7, arg1: &CustodyRecordV7) {
        assert!(arg0.asset_kind == 1, 43);
        assert!(arg1.asset_kind == 1, 31);
    }

    public fun asset_owned_v7() : u8 {
        1
    }

    public fun asset_soul_local_v7() : u8 {
        0
    }

    public fun begin_initial_physical_loadout_authorization_v7(arg0: &PhysicalProtocolConfigV7, arg1: &MakerPhysicalProfileV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: vector<u8>, arg4: vector<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>) : InitialPhysicalLoadoutAuthorizationV7 {
        assert_config_profile(arg0, arg1);
        assert!(arg1.sealed, 10);
        assert!(arg1.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg2), 2);
        assert_hash(&arg3);
        assert!(0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg4) > 0, 53);
        InitialPhysicalLoadoutAuthorizationV7{
            version                  : 7,
            config_id                : 0x2::object::id<PhysicalProtocolConfigV7>(arg0),
            profile_id               : 0x2::object::id<MakerPhysicalProfileV7>(arg1),
            v6_profile_id            : arg1.v6_profile_id,
            root_id                  : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg2),
            recipe_hash              : arg3,
            recipe                   : arg4,
            style_selections         : 0x1::vector::empty<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(),
            visual_recipe_indices    : vector[],
            style_product_ids        : 0x1::vector::empty<0x2::object::ID>(),
            authorization_commitment : b"",
            sealed                   : false,
        }
    }

    public fun bind_listing_proof_type_v7<T0: drop>(arg0: &mut PhysicalProtocolConfigV7, arg1: &PhysicalAdminCapV7) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.listing_proof_type), 7);
        arg0.listing_proof_type = 0x1::option::some<0x1::string::String>(defining_type_name<T0>());
    }

    fun claim_and_equip_included_internal(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &mut StyleProductV7, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_wardrobe_mutable(arg0, arg5);
        assert!(arg3.supply_kind == 0, 22);
        assert_included_entitlement_kind(arg3);
        let v0 = 0x2::object::id<StyleProductV7>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.claimed_included_products, v0), 46);
        let v1 = create_style_asset(arg1, arg3, 0, @0x0, 0x1::option::some<0x2::object::ID>(arg4), 0, arg6);
        assert_part_accepts_asset(arg2, &v1);
        let v2 = PartPolicyKeyV7{slot_key: v1.slot_key};
        assert!(!0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2), 37);
        let v3 = 0x2::object::id<StyleAssetV7>(&v1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.claimed_included_products, v0, v3);
        add_to_wardrobe(arg0, &v1);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v3).equipped = true;
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v2, v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equipped_asset_ids, v3);
        arg0.equipped_count = arg0.equipped_count + 1;
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v3, v1.slot_key, 10);
    }

    public fun claim_and_equip_included_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &mut StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        assert_postmint_included_entitlement(arg6, arg5, 0x2::tx_context::sender(arg11));
        claim_and_equip_included_internal(arg0, arg1, arg3, arg5, arg8, arg10, arg11);
    }

    fun claim_and_swap_included_internal(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &mut StyleProductV7, arg4: 0x2::object::ID, arg5: 0x2::transfer::Receiving<StyleAssetV7>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_wardrobe_mutable(arg0, arg6);
        assert!(arg3.supply_kind == 0, 22);
        assert_included_entitlement_kind(arg3);
        let v0 = 0x2::object::id<StyleProductV7>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.claimed_included_products, v0), 46);
        let v1 = create_style_asset(arg1, arg3, 0, @0x0, 0x1::option::some<0x2::object::ID>(arg4), 0, arg7);
        assert_part_accepts_asset(arg2, &v1);
        let v2 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg5);
        assert!(0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v2), 34);
        let v3 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg5);
        assert!(&v1.slot_key == &v3.slot_key, 38);
        let v4 = PartPolicyKeyV7{slot_key: v1.slot_key};
        assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v4), 36);
        assert!(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v4) == v2, 36);
        assert!(0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v2).equipped, 36);
        let v5 = 0x2::object::id<StyleAssetV7>(&v1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.claimed_included_products, v0, v5);
        add_to_wardrobe(arg0, &v1);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v2).equipped = false;
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v5).equipped = true;
        0x2::table::remove<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v4);
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v4, v5);
        let v6 = &mut arg0.equipped_asset_ids;
        replace_equipped_id(v6, v2, v5);
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v3, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v5, v1.slot_key, 11);
    }

    public fun claim_and_swap_included_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &mut StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: 0x2::transfer::Receiving<StyleAssetV7>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        assert_postmint_included_entitlement(arg6, arg5, 0x2::tx_context::sender(arg12));
        claim_and_swap_included_internal(arg0, arg1, arg3, arg5, arg8, arg10, arg11, arg12);
    }

    public fun claim_free_owned_style_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &mut StyleProductV7, arg3: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1, arg0);
        assert_style_sale_link(arg1, arg2, arg4, arg5, arg6);
        assert!(arg2.supply_kind != 0, 22);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg6) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_free_v6(), 47);
        assert_supply_available(arg2);
        let v0 = reserve_free_style_claim(arg0, 0x2::object::id<StyleProductV7>(arg2), 0x2::tx_context::sender(arg10));
        let v1 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::claim_free_owned_item_for_physical_v7(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let (v2, v3, v4) = consume_v6_owned_receipt(arg3, arg4, arg5, arg2, v1, arg10);
        assert!(v3 == arg2.transferable, 31);
        0x2::table::add<FreeStyleClaimKeyV7, bool>(&mut arg0.free_style_claims, v0, true);
        0x2::transfer::transfer<StyleAssetV7>(create_style_asset(arg1, arg2, 1, v2, 0x1::option::none<0x2::object::ID>(), v4, arg10), v2);
    }

    fun claim_included_internal(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &mut StyleProductV7, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_wardrobe_mutable(arg0, arg5);
        assert!(arg3.supply_kind == 0, 22);
        assert_included_entitlement_kind(arg3);
        let v0 = 0x2::object::id<StyleProductV7>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.claimed_included_products, v0), 46);
        let v1 = create_style_asset(arg1, arg3, 0, @0x0, 0x1::option::some<0x2::object::ID>(arg4), 0, arg6);
        assert_part_accepts_asset(arg2, &v1);
        let v2 = 0x2::object::id<StyleAssetV7>(&v1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.claimed_included_products, v0, v2);
        add_to_wardrobe(arg0, &v1);
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v2, v1.slot_key, 7);
    }

    public fun claim_included_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &mut StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        assert_postmint_included_entitlement(arg6, arg5, 0x2::tx_context::sender(arg11));
        claim_included_internal(arg0, arg1, arg3, arg5, arg8, arg10, arg11);
    }

    public fun claim_initial_included_style_v7(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &mut StyleProductV7, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.initialized, 52);
        assert_wardrobe_config(arg0, arg1);
        assert!(arg0.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg2), 2);
        assert!(arg0.soul_id == arg5, 27);
        assert!(!arg0.listed, 29);
        assert!(arg0.revision == arg6, 30);
        assert!(arg4.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg1), 2);
        assert!(arg4.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg2), 2);
        assert_product_admitted(arg3, arg4);
        assert!(arg4.supply_kind == 0, 22);
        assert_included_entitlement_kind(arg4);
        let v0 = 0x2::object::id<StyleProductV7>(arg4);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.claimed_included_products, v0), 46);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg0.initial_style_product_ids);
        assert!(v1 < 0x1::vector::length<0x2::object::ID>(&arg0.authorized_initial_style_product_ids), 55);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.authorized_initial_style_product_ids, v1) == v0, 55);
        let v2 = create_style_asset(arg1, arg4, 0, @0x0, 0x1::option::some<0x2::object::ID>(arg5), 0, arg7);
        assert_initial_part_accepts_asset(arg2, &v2);
        let v3 = PartPolicyKeyV7{slot_key: v2.slot_key};
        assert!(!0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v3), 37);
        let v4 = 0x2::object::id<StyleAssetV7>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.claimed_included_products, v0, v4);
        add_to_wardrobe(arg0, &v2);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v4).equipped = true;
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v3, v4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equipped_asset_ids, v4);
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.initial_product_by_slot, v3, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.initial_style_product_ids, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.initial_asset_ids, v4);
        arg0.equipped_count = arg0.equipped_count + 1;
        0x2::transfer::transfer<StyleAssetV7>(v2, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v4, v2.slot_key, 8);
    }

    fun consume_initial_physical_authorization(arg0: InitialPhysicalLoadoutAuthorizationV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg4: &vector<u8>) : (vector<0x2::object::ID>, vector<u8>, vector<u8>) {
        let InitialPhysicalLoadoutAuthorizationV7 {
            version                  : v0,
            config_id                : v1,
            profile_id               : v2,
            v6_profile_id            : v3,
            root_id                  : v4,
            recipe_hash              : v5,
            recipe                   : _,
            style_selections         : _,
            visual_recipe_indices    : v8,
            style_product_ids        : v9,
            authorization_commitment : v10,
            sealed                   : v11,
        } = arg0;
        let v12 = v9;
        let v13 = v8;
        let v14 = v5;
        assert!(v0 == 7 && v11, 56);
        assert!(v1 == 0x2::object::id<PhysicalProtocolConfigV7>(arg1), 2);
        assert!(v2 == 0x2::object::id<MakerPhysicalProfileV7>(arg2), 2);
        assert!(v3 == arg2.v6_profile_id, 2);
        assert!(v4 == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg3), 2);
        assert!(&v14 == arg4, 55);
        assert!(0x1::vector::length<0x2::object::ID>(&v12) > 0, 53);
        assert!(v10 == initial_physical_authorization_commitment(v0, v1, v2, v3, v4, &v14, &v13, &v12), 55);
        (v12, v14, v10)
    }

    fun consume_v6_owned_receipt(arg0: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg3: &StyleProductV7, arg4: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::OwnedItemV6, arg5: &0x2::tx_context::TxContext) : (address, bool, u64) {
        let (v0, v1, v2, v3) = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::consume_owned_item_for_physical_v7(arg0, arg1, arg2, arg4, arg5);
        assert!(v0 == arg3.v6_product_id, 48);
        (v1, v2, v3)
    }

    public fun create_maker_physical_profile_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MakerPhysicalProfileV7>(new_physical_profile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    fun create_migrated_style_asset(arg0: &PhysicalProtocolConfigV7, arg1: &mut StyleProductV7, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StyleAssetV7 {
        arg1.minted_supply = arg1.minted_supply + 1;
        materialize_style_asset(arg0, arg1, 1, arg2, 0x1::option::none<0x2::object::ID>(), arg3, arg1.minted_supply, arg4)
    }

    public fun create_soul_wardrobe_v7<T0: drop>(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::object::ID, arg8: InitialPhysicalLoadoutAuthorizationV7, arg9: &vector<u8>, arg10: T0, arg11: &mut 0x2::tx_context::TxContext) : SoulWardrobeV7 {
        assert_operational(arg1, arg2, arg3, arg4, arg5, arg6);
        let (v0, v1, v2) = consume_initial_physical_authorization(arg8, arg1, arg3, arg5, arg9);
        new_wardrobe<T0>(arg0, arg1, arg3, arg7, v0, v1, v2, arg10, arg11)
    }

    fun create_style_asset(arg0: &PhysicalProtocolConfigV7, arg1: &mut StyleProductV7, arg2: u8, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : StyleAssetV7 {
        let v0 = next_serial(arg1);
        materialize_style_asset(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6)
    }

    public fun custody_asset_kind_v7(arg0: &CustodyRecordV7) : u8 {
        arg0.asset_kind
    }

    public fun custody_bound_soul_id_v7(arg0: &CustodyRecordV7) : 0x1::option::Option<0x2::object::ID> {
        arg0.bound_soul_id
    }

    public fun custody_equipped_v7(arg0: &CustodyRecordV7) : bool {
        arg0.equipped
    }

    public fun custody_excluded_v6_ids_v7(arg0: &CustodyRecordV7) : &vector<0x2::object::ID> {
        &arg0.excluded_v6_product_ids
    }

    public fun custody_family_id_v7(arg0: &CustodyRecordV7) : 0x2::object::ID {
        arg0.family_id
    }

    fun custody_record(arg0: &StyleAssetV7, arg1: bool) : CustodyRecordV7 {
        CustodyRecordV7{
            style_product_id        : arg0.style_product_id,
            family_id               : arg0.family_id,
            v6_product_id           : arg0.v6_product_id,
            slot_key                : arg0.slot_key,
            source_kind             : arg0.source_kind,
            asset_kind              : arg0.asset_kind,
            bound_soul_id           : arg0.bound_soul_id,
            equipped                : arg1,
            required_v6_product_ids : arg0.required_v6_product_ids,
            excluded_v6_product_ids : arg0.excluded_v6_product_ids,
        }
    }

    public fun custody_required_v6_ids_v7(arg0: &CustodyRecordV7) : &vector<0x2::object::ID> {
        &arg0.required_v6_product_ids
    }

    public fun custody_slot_key_v7(arg0: &CustodyRecordV7) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun custody_source_kind_v7(arg0: &CustodyRecordV7) : u8 {
        arg0.source_kind
    }

    public fun custody_style_product_id_v7(arg0: &CustodyRecordV7) : 0x2::object::ID {
        arg0.style_product_id
    }

    public fun custody_v6_product_id_v7(arg0: &CustodyRecordV7) : 0x2::object::ID {
        arg0.v6_product_id
    }

    fun defining_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    fun deposit_and_equip_internal(arg0: &mut SoulWardrobeV7, arg1: &MakerPhysicalProfileV7, arg2: &StyleProductV7, arg3: StyleAssetV7, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_wardrobe_mutable(arg0, arg4);
        assert_asset_product(arg0, arg2, &arg3);
        assert!(arg3.asset_kind == 1, 31);
        assert!(arg3.holder == 0x2::tx_context::sender(arg5), 32);
        assert_part_accepts_asset(arg1, &arg3);
        let v0 = PartPolicyKeyV7{slot_key: arg3.slot_key};
        assert!(!0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v0), 37);
        arg3.holder = @0x0;
        arg3.bound_soul_id = 0x1::option::some<0x2::object::ID>(arg0.soul_id);
        let v1 = 0x2::object::id<StyleAssetV7>(&arg3);
        add_to_wardrobe(arg0, &arg3);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v1).equipped = true;
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v0, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equipped_asset_ids, v1);
        arg0.equipped_count = arg0.equipped_count + 1;
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(arg3, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v1, arg3.slot_key, 5);
    }

    public fun deposit_and_equip_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: StyleAssetV7, arg11: u64, arg12: &0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        deposit_and_equip_internal(arg0, arg3, arg5, arg10, arg11, arg12);
    }

    public fun deposit_and_swap_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: StyleAssetV7, arg11: 0x2::transfer::Receiving<StyleAssetV7>, arg12: u64, arg13: &0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        assert_wardrobe_mutable(arg0, arg12);
        assert_asset_product(arg0, arg5, &arg10);
        assert!(arg10.asset_kind == 1, 31);
        assert!(arg10.holder == 0x2::tx_context::sender(arg13), 32);
        assert_part_accepts_asset(arg3, &arg10);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg11);
        let v1 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg11);
        assert!(&arg10.slot_key == &v1.slot_key, 38);
        let v2 = PartPolicyKeyV7{slot_key: arg10.slot_key};
        assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2), 36);
        assert!(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2) == v0, 36);
        arg10.holder = @0x0;
        arg10.bound_soul_id = 0x1::option::some<0x2::object::ID>(arg0.soul_id);
        let v3 = 0x2::object::id<StyleAssetV7>(&arg10);
        add_to_wardrobe(arg0, &arg10);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0).equipped = false;
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v3).equipped = true;
        0x2::table::remove<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v2);
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v2, v3);
        let v4 = &mut arg0.equipped_asset_ids;
        replace_equipped_id(v4, v0, v3);
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        0x2::transfer::transfer<StyleAssetV7>(arg10, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v3, arg10.slot_key, 6);
    }

    fun deposit_owned_internal(arg0: &mut SoulWardrobeV7, arg1: &MakerPhysicalProfileV7, arg2: &StyleProductV7, arg3: StyleAssetV7, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_wardrobe_mutable(arg0, arg4);
        assert_asset_product(arg0, arg2, &arg3);
        assert!(arg3.asset_kind == 1, 31);
        assert!(arg3.holder == 0x2::tx_context::sender(arg5), 32);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg3.bound_soul_id), 33);
        assert_part_accepts_asset(arg1, &arg3);
        arg3.holder = @0x0;
        arg3.bound_soul_id = 0x1::option::some<0x2::object::ID>(arg0.soul_id);
        add_to_wardrobe(arg0, &arg3);
        0x2::transfer::transfer<StyleAssetV7>(arg3, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, 0x2::object::id<StyleAssetV7>(&arg3), arg2.slot_key, 0);
    }

    public fun deposit_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: StyleAssetV7, arg11: u64, arg12: &0x2::tx_context::TxContext) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        deposit_owned_internal(arg0, arg3, arg5, arg10, arg11, arg12);
    }

    fun emergency_unequip_and_withdraw_internal(arg0: &mut SoulWardrobeV7, arg1: 0x2::transfer::Receiving<StyleAssetV7>, arg2: u64, arg3: address) {
        assert_wardrobe_mutable(arg0, arg2);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0), 34);
        let v1 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg1);
        assert!(0x2::object::id<StyleAssetV7>(&v1) == v0, 49);
        let v2 = 0x2::table::remove<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0);
        assert!(v2.equipped, 36);
        assert_withdrawable_asset(&v1, &v2);
        let v3 = PartPolicyKeyV7{slot_key: v1.slot_key};
        assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v3), 36);
        assert!(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v3) == v0, 36);
        0x2::table::remove<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v3);
        let v4 = &mut arg0.equipped_asset_ids;
        remove_equipped_id(v4, v0);
        arg0.equipped_count = arg0.equipped_count - 1;
        arg0.external_asset_count = arg0.external_asset_count - 1;
        v1.holder = arg3;
        v1.bound_soul_id = 0x1::option::none<0x2::object::ID>();
        v1.ownership_epoch = v1.ownership_epoch + 1;
        0x2::transfer::transfer<StyleAssetV7>(v1, arg3);
        increment_revision(arg0);
        emit_wardrobe(arg0, v0, v1.slot_key, 9);
    }

    public fun emergency_unequip_and_withdraw_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: 0x2::object::ID, arg3: T0, arg4: 0x2::transfer::Receiving<StyleAssetV7>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_owner_proof<T0>(arg1);
        assert_wardrobe_config(arg0, arg1);
        assert!(arg0.soul_id == arg2, 27);
        emergency_unequip_and_withdraw_internal(arg0, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    fun emit_wardrobe(arg0: &SoulWardrobeV7, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u8) {
        let v0 = WardrobeMutationV7{
            wardrobe_id : 0x2::object::id<SoulWardrobeV7>(arg0),
            soul_id     : arg0.soul_id,
            asset_id    : arg1,
            slot_key    : arg2,
            operation   : arg3,
            revision    : arg0.revision,
        };
        0x2::event::emit<WardrobeMutationV7>(v0);
    }

    public fun entitlement_base_included_v7() : u8 {
        0
    }

    fun entitlement_kind_for_v6_product(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg1: u8, arg2: &0x1::option::Option<0x1::string::String>) : u8 {
        if (arg1 == 0) {
            if (0x1::option::is_some<0x1::string::String>(arg2)) {
                3
            } else {
                0
            }
        } else if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_free_v6()) {
            1
        } else {
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_paid_v6(), 47);
            2
        }
    }

    public fun entitlement_pack_included_v7() : u8 {
        3
    }

    public fun entitlement_wallet_free_v7() : u8 {
        1
    }

    public fun entitlement_wallet_paid_v7() : u8 {
        2
    }

    fun equip_received_internal(arg0: &mut SoulWardrobeV7, arg1: &MakerPhysicalProfileV7, arg2: &StyleProductV7, arg3: 0x2::transfer::Receiving<StyleAssetV7>, arg4: u64) {
        assert_wardrobe_mutable(arg0, arg4);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg3);
        assert!(0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0), 34);
        let v1 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg3);
        assert!(0x2::object::id<StyleAssetV7>(&v1) == v0, 49);
        assert_asset_product(arg0, arg2, &v1);
        assert_part_accepts_asset(arg1, &v1);
        let v2 = PartPolicyKeyV7{slot_key: v1.slot_key};
        assert!(!0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2), 37);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0);
        assert!(!v3.equipped, 35);
        v3.equipped = true;
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v2, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equipped_asset_ids, v0);
        arg0.equipped_count = arg0.equipped_count + 1;
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v0, v1.slot_key, 1);
    }

    public fun equip_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: 0x2::transfer::Receiving<StyleAssetV7>, arg11: u64) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        equip_received_internal(arg0, arg3, arg5, arg10, arg11);
    }

    fun equipped_contains_v6_product(arg0: &SoulWardrobeV7, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.equipped_asset_ids)) {
            if (0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, *0x1::vector::borrow<0x2::object::ID>(&arg0.equipped_asset_ids, v0)).v6_product_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun family_commitment_v7(arg0: &ItemFamilyV7) : &vector<u8> {
        &arg0.family_commitment
    }

    public fun family_creator_v7(arg0: &ItemFamilyV7) : address {
        arg0.creator
    }

    public fun family_id_v7(arg0: &ItemFamilyV7) : 0x2::object::ID {
        0x2::object::id<ItemFamilyV7>(arg0)
    }

    public fun family_key_v7(arg0: &ItemFamilyV7) : &0x1::string::String {
        &arg0.family_key
    }

    public fun family_label_v7(arg0: &ItemFamilyV7) : &0x1::string::String {
        &arg0.label
    }

    public fun family_profile_id_v7(arg0: &ItemFamilyV7) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun family_rights_origin_v7(arg0: &ItemFamilyV7) : u8 {
        arg0.rights_origin
    }

    public fun family_seed_v6_product_id_v7(arg0: &ItemFamilyV7) : 0x2::object::ID {
        arg0.seed_v6_product_id
    }

    public fun family_slot_key_v7(arg0: &ItemFamilyV7) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun finalize_soul_wardrobe_v7<T0: drop>(arg0: SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: 0x2::object::ID, arg4: T0, arg5: u64) {
        assert_owner_proof<T0>(arg1);
        assert_wardrobe_config(&arg0, arg1);
        assert!(arg0.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg2), 2);
        assert!(arg0.soul_id == arg3, 27);
        assert!(!arg0.initialized, 52);
        assert!(arg0.revision == arg5, 30);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.initial_style_product_ids) > 0, 53);
        assert!(arg0.initial_style_product_ids == arg0.authorized_initial_style_product_ids, 55);
        assert_wardrobe_complete_internal(&arg0, arg2);
        arg0.initialized = true;
        let v0 = &mut arg0;
        increment_revision(v0);
        let v1 = SoulWardrobeFinalizedV7{
            wardrobe_id         : 0x2::object::id<SoulWardrobeV7>(&arg0),
            soul_id             : arg3,
            revision            : arg0.revision,
            initial_style_count : 0x1::vector::length<0x2::object::ID>(&arg0.initial_style_product_ids),
        };
        0x2::event::emit<SoulWardrobeFinalizedV7>(v1);
        0x2::transfer::share_object<SoulWardrobeV7>(arg0);
    }

    public fun free_style_claimed_v7(arg0: &PhysicalRegistryV7, arg1: 0x2::object::ID, arg2: address) : bool {
        let v0 = FreeStyleClaimKeyV7{
            style_product_id : arg1,
            wallet           : arg2,
        };
        0x2::table::contains<FreeStyleClaimKeyV7, bool>(&arg0.free_style_claims, v0)
    }

    fun increment_revision(arg0: &mut SoulWardrobeV7) {
        arg0.revision = arg0.revision + 1;
    }

    public fun initial_authorization_commitment_v7(arg0: &InitialPhysicalLoadoutAuthorizationV7) : &vector<u8> {
        &arg0.authorization_commitment
    }

    public fun initial_authorization_recipe_hash_v7(arg0: &InitialPhysicalLoadoutAuthorizationV7) : &vector<u8> {
        &arg0.recipe_hash
    }

    public fun initial_authorization_root_id_v7(arg0: &InitialPhysicalLoadoutAuthorizationV7) : 0x2::object::ID {
        arg0.root_id
    }

    public fun initial_authorization_style_product_ids_v7(arg0: &InitialPhysicalLoadoutAuthorizationV7) : &vector<0x2::object::ID> {
        &arg0.style_product_ids
    }

    public fun initial_authorization_visual_recipe_indices_v7(arg0: &InitialPhysicalLoadoutAuthorizationV7) : &vector<u64> {
        &arg0.visual_recipe_indices
    }

    fun initial_physical_authorization_commitment(arg0: u64, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &vector<u8>, arg6: &vector<u64>, arg7: &vector<0x2::object::ID>) : vector<u8> {
        let v0 = InitialPhysicalAuthorizationHashInputV7{
            version               : arg0,
            config_id             : arg1,
            profile_id            : arg2,
            v6_profile_id         : arg3,
            root_id               : arg4,
            recipe_hash           : *arg5,
            visual_recipe_indices : *arg6,
            style_product_ids     : *arg7,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<InitialPhysicalAuthorizationHashInputV7>(&v0))
    }

    public fun initialize_physical_protocol_v7<T0: drop>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg1: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionAdminCapV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: &mut 0x2::tx_context::TxContext) {
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::claim_physical_v7_initializer(arg0, arg1);
        let (v0, v1, v2) = new_protocol_objects<T0>(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = v0;
        let v5 = PhysicalProtocolInitializedV7{
            config_id        : 0x2::object::id<PhysicalProtocolConfigV7>(&v4),
            registry_id      : 0x2::object::id<PhysicalRegistryV7>(&v3),
            owner_proof_type : v4.soul_owner_proof_type,
        };
        0x2::event::emit<PhysicalProtocolInitializedV7>(v5);
        0x2::transfer::share_object<PhysicalProtocolConfigV7>(v4);
        0x2::transfer::share_object<PhysicalRegistryV7>(v3);
        0x2::transfer::transfer<PhysicalAdminCapV7>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun materialize_legacy_owned_style_v7(arg0: &PhysicalProtocolConfigV7, arg1: &mut StyleProductV7, arg2: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::OwnedItemV6, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg0), 2);
        assert!(arg1.v6_profile_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg4), 2);
        assert!(arg1.supply_kind != 0, 22);
        let (v0, v1, v2) = consume_v6_owned_receipt(arg2, arg3, arg4, arg1, arg5, arg6);
        assert!(v1 == arg1.transferable, 31);
        0x2::transfer::transfer<StyleAssetV7>(create_migrated_style_asset(arg0, arg1, v0, v2, arg6), v0);
    }

    fun materialize_style_asset(arg0: &PhysicalProtocolConfigV7, arg1: &StyleProductV7, arg2: u8, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : StyleAssetV7 {
        let v0 = StyleAssetV7{
            id                      : 0x2::object::new(arg7),
            version                 : 7,
            config_id               : 0x2::object::id<PhysicalProtocolConfigV7>(arg0),
            profile_id              : arg1.profile_id,
            family_id               : arg1.family_id,
            style_product_id        : 0x2::object::id<StyleProductV7>(arg1),
            v6_product_id           : arg1.v6_product_id,
            original_creator        : arg1.original_creator,
            slot_key                : arg1.slot_key,
            source_kind             : arg1.source_kind,
            asset_kind              : arg2,
            serial                  : arg6,
            transferable            : arg1.transferable,
            holder                  : arg3,
            bound_soul_id           : arg4,
            ownership_epoch         : arg5,
            required_v6_product_ids : arg1.required_v6_product_ids,
            excluded_v6_product_ids : arg1.excluded_v6_product_ids,
        };
        let v1 = StyleAssetMaterializedV7{
            asset_id         : 0x2::object::id<StyleAssetV7>(&v0),
            style_product_id : 0x2::object::id<StyleProductV7>(arg1),
            asset_kind       : arg2,
            serial           : arg6,
            soul_id          : arg4,
        };
        0x2::event::emit<StyleAssetMaterializedV7>(v1);
        v0
    }

    fun new_external_item_family(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : ItemFamilyV7 {
        assert_operational(arg1, arg2, arg3, arg4, arg6, arg7);
        assert_external_publication_authority(arg4, arg5, arg11);
        new_item_family_definition(arg0, arg1, arg3, arg4, arg5, arg8, arg9, arg10, arg11)
    }

    fun new_external_style_product(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &ItemFamilyV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: u64, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: vector<u8>, arg19: &mut 0x2::tx_context::TxContext) : StyleProductV7 {
        assert_operational(arg1, arg2, arg3, arg4, arg7, arg8);
        assert_external_publication_authority(arg4, arg6, arg19);
        assert!(arg12 != 0, 22);
        new_style_product_definition(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    }

    fun new_item_family_definition(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : ItemFamilyV7 {
        assert_registry(arg1, arg0);
        assert_config_profile(arg1, arg2);
        assert_v6_product_link(arg1, arg2, arg3, arg4);
        let v0 = 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6>(arg4);
        assert_v6_admission_active(arg3, v0);
        assert_family_seed_unregistered(arg0, v0);
        assert_non_empty(&arg5);
        assert_non_empty(&arg6);
        assert_hash(&arg7);
        assert!(&arg7 == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_family_commitment_v6(arg4), 19);
        let v1 = ItemFamilyV7{
            id                 : 0x2::object::new(arg8),
            version            : 7,
            config_id          : 0x2::object::id<PhysicalProtocolConfigV7>(arg1),
            profile_id         : 0x2::object::id<MakerPhysicalProfileV7>(arg2),
            seed_v6_product_id : v0,
            creator            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_original_creator_v6(arg4),
            slot_key           : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg4),
            family_key         : arg5,
            label              : arg6,
            family_commitment  : arg7,
            rights_origin      : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_rights_origin_v6(arg4),
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.family_seed_products, v0, 0x2::object::id<ItemFamilyV7>(&v1));
        arg0.family_count = arg0.family_count + 1;
        let v2 = ItemFamilyPublishedV7{
            family_id          : 0x2::object::id<ItemFamilyV7>(&v1),
            profile_id         : 0x2::object::id<MakerPhysicalProfileV7>(arg2),
            seed_v6_product_id : v0,
            creator            : v1.creator,
            slot_key           : v1.slot_key,
        };
        0x2::event::emit<ItemFamilyPublishedV7>(v2);
        v1
    }

    fun new_official_item_family(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : ItemFamilyV7 {
        assert_operational(arg1, arg2, arg3, arg4, arg6, arg8);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg6, arg7, arg12);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg5) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::origin_official_v6(), 40);
        assert_v6_admission_source(arg4, arg5);
        new_item_family_definition(arg0, arg1, arg3, arg4, arg5, arg9, arg10, arg11, arg12)
    }

    fun new_official_style_product(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &ItemFamilyV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg9: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u8, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: vector<u8>, arg20: &mut 0x2::tx_context::TxContext) : StyleProductV7 {
        assert_operational(arg1, arg2, arg3, arg4, arg7, arg9);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg7, arg8, arg20);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg6) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::origin_official_v6(), 40);
        assert_v6_admission_source(arg4, arg6);
        new_style_product_definition(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20)
    }

    fun new_physical_profile(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: &mut 0x2::tx_context::TxContext) : MakerPhysicalProfileV7 {
        assert_publication_gate(arg1, arg2, arg6);
        assert_registry(arg1, arg0);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg4, arg5, arg7);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_lifecycle_v5(arg4) != 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::lifecycle_archived() && 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_lifecycle_v5(arg4) != 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::lifecycle_sale_pending(), 2);
        assert_v6_profile_link(arg1, arg3, arg4);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_sealed_v6(arg3), 10);
        let v0 = if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_mode_v6(arg3) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_mode_composable_v6()) {
            if (0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_loadout_mutable_v6(arg3)) {
                0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_item_assetization_v6(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        let v1 = 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6>(arg3);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.profiles, v1), 8);
        let v2 = MakerPhysicalProfileV7{
            id                     : 0x2::object::new(arg7),
            version                : 7,
            config_id              : 0x2::object::id<PhysicalProtocolConfigV7>(arg1),
            v6_profile_id          : v1,
            root_id                : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::root_id_v5(arg4),
            slot_schema_commitment : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_slot_schema_commitment_v6(arg3),
            renderer_commitment    : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::profile_renderer_commitment_v6(arg3),
            part_policies          : 0x2::table::new<PartPolicyKeyV7, PartPolicyV7>(arg7),
            required_slot_keys     : 0x1::vector::empty<0x1::string::String>(),
            part_policy_count      : 0,
            sealed                 : false,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.profiles, v1, 0x2::object::id<MakerPhysicalProfileV7>(&v2));
        v2
    }

    fun new_protocol_objects<T0: drop>(arg0: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg1: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionAdminCapV6, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg3: &mut 0x2::tx_context::TxContext) : (PhysicalProtocolConfigV7, PhysicalRegistryV7, PhysicalAdminCapV7) {
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::composition_admin_cap_config_id_v6(arg1) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_config_id_v6(arg0), 0);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_v5_config_id_v6(arg0) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::protocol_config_id_v5(arg2), 2);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::protocol_soul_owner_proof_type_v6(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 3);
        let v1 = defining_type_name<T0>();
        assert!(&v1 == 0x1::option::borrow<0x1::string::String>(&v0), 4);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = PhysicalRegistryV7{
            id                   : 0x2::object::new(arg3),
            version              : 7,
            config_id            : v3,
            profiles             : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg3),
            family_seed_products : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg3),
            style_products       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg3),
            wardrobes            : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg3),
            free_style_claims    : 0x2::table::new<FreeStyleClaimKeyV7, bool>(arg3),
            family_count         : 0,
            product_count        : 0,
            wardrobe_count       : 0,
        };
        let v5 = PhysicalProtocolConfigV7{
            id                    : v2,
            version               : 7,
            v6_config_id          : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6>(arg0),
            v5_config_id          : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5>(arg2),
            v6_admin_cap_id       : 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionAdminCapV6>(arg1),
            registry_id           : 0x2::object::id<PhysicalRegistryV7>(&v4),
            soul_owner_proof_type : v1,
            listing_proof_type    : 0x1::option::none<0x1::string::String>(),
            enabled               : false,
        };
        let v6 = PhysicalAdminCapV7{
            id        : 0x2::object::new(arg3),
            version   : 7,
            config_id : v3,
        };
        (v5, v4, v6)
    }

    fun new_style_product_definition(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg4: &ItemFamilyV7, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u8, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: &mut 0x2::tx_context::TxContext) : StyleProductV7 {
        assert_registry(arg1, arg0);
        assert_v6_product_link(arg1, arg2, arg3, arg5);
        let v0 = 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6>(arg5);
        assert_v6_admission_active(arg3, v0);
        assert!(arg4.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg1), 19);
        assert!(arg4.profile_id == 0x2::object::id<MakerPhysicalProfileV7>(arg2), 19);
        assert!(&arg4.slot_key == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg5), 19);
        assert!(arg4.creator == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_original_creator_v6(arg5), 19);
        assert!(&arg4.family_commitment == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_family_commitment_v6(arg5), 19);
        assert!(arg4.rights_origin == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_rights_origin_v6(arg5), 19);
        assert_style_product_unregistered(arg0, v0);
        assert_non_empty(&arg7);
        assert_non_empty(&arg9);
        assert_non_empty(&arg12);
        assert_non_empty(&arg14);
        assert_locator_identifier(&arg13);
        assert_locator_identifier(&arg15);
        assert_hash(&arg16);
        assert!(&arg16 == &arg2.renderer_commitment, 20);
        assert_supply(arg5, arg10, arg11);
        assert_product_part_compatible(arg2, arg5, arg10);
        let v1 = if (arg10 == 0) {
            assert_non_empty(&arg8);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_registry_sealed_v5(arg6), 10);
            assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_row_kind_v5(arg6, *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg5), arg8, arg7) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_row_visual_v5(), 59);
            0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::style_product_pack_key_v5(arg6, *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg5), arg8, arg7)
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v2 = v1;
        let v3 = StyleProductV7{
            id                      : 0x2::object::new(arg17),
            version                 : 7,
            config_id               : 0x2::object::id<PhysicalProtocolConfigV7>(arg1),
            profile_id              : 0x2::object::id<MakerPhysicalProfileV7>(arg2),
            v6_profile_id           : arg2.v6_profile_id,
            family_id               : 0x2::object::id<ItemFamilyV7>(arg4),
            v6_product_id           : v0,
            original_creator        : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_original_creator_v6(arg5),
            slot_key                : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_slot_key_v6(arg5),
            style_key               : arg7,
            recipe_item_key         : arg8,
            label                   : arg9,
            source_kind             : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_origin_kind_v6(arg5),
            entitlement_kind        : entitlement_kind_for_v6_product(arg5, arg10, &v2),
            pack_key                : v2,
            supply_kind             : arg10,
            max_supply              : arg11,
            minted_supply           : 0,
            price_atomic            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_price_atomic_v6(arg5),
            protocol_fee_bps        : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_primary_protocol_fee_bps_v6(arg5),
            maker_ecosystem_fee_bps : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_maker_ecosystem_fee_bps_v6(arg5),
            transferable            : 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_transferable_v6(arg5),
            definition_commitment   : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_definition_commitment_v6(arg5),
            asset_commitment        : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_asset_commitment_v6(arg5),
            definition_blob_id      : arg12,
            definition_identifier   : arg13,
            asset_blob_id           : arg14,
            asset_identifier        : arg15,
            renderer_commitment     : arg16,
            required_v6_product_ids : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_required_product_ids_v6(arg5),
            excluded_v6_product_ids : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_excluded_product_ids_v6(arg5),
            active                  : true,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.style_products, v0, 0x2::object::id<StyleProductV7>(&v3));
        arg0.product_count = arg0.product_count + 1;
        let v4 = StyleProductPublishedV7{
            style_product_id      : 0x2::object::id<StyleProductV7>(&v3),
            family_id             : 0x2::object::id<ItemFamilyV7>(arg4),
            v6_product_id         : v0,
            original_creator      : v3.original_creator,
            recipe_item_key       : arg8,
            supply_kind           : arg10,
            max_supply            : arg11,
            definition_blob_id    : arg12,
            definition_identifier : arg13,
            asset_blob_id         : arg14,
            asset_identifier      : arg15,
            definition_commitment : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_definition_commitment_v6(arg5),
            asset_commitment      : *0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_asset_commitment_v6(arg5),
        };
        0x2::event::emit<StyleProductPublishedV7>(v4);
        v3
    }

    fun new_wardrobe<T0: drop>(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>, arg5: vector<u8>, arg6: vector<u8>, arg7: T0, arg8: &mut 0x2::tx_context::TxContext) : SoulWardrobeV7 {
        assert_registry(arg1, arg0);
        assert_owner_proof<T0>(arg1);
        assert!(arg2.config_id == 0x2::object::id<PhysicalProtocolConfigV7>(arg1), 2);
        assert!(arg2.sealed, 10);
        assert!(0x2::object::id_to_address(&arg3) != @0x0, 27);
        assert!(0x1::vector::length<0x2::object::ID>(&arg4) > 0, 53);
        assert_hash(&arg5);
        assert_hash(&arg6);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.wardrobes, arg3), 28);
        let v0 = SoulWardrobeV7{
            id                                   : 0x2::object::new(arg8),
            version                              : 7,
            config_id                            : 0x2::object::id<PhysicalProtocolConfigV7>(arg1),
            profile_id                           : 0x2::object::id<MakerPhysicalProfileV7>(arg2),
            root_id                              : arg2.root_id,
            soul_id                              : arg3,
            slot_schema_commitment               : arg2.slot_schema_commitment,
            revision                             : 0,
            initialized                          : false,
            listed                               : false,
            inventory                            : 0x2::table::new<0x2::object::ID, CustodyRecordV7>(arg8),
            claimed_included_products            : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg8),
            equipped_by_slot                     : 0x2::table::new<PartPolicyKeyV7, 0x2::object::ID>(arg8),
            equipped_asset_ids                   : 0x1::vector::empty<0x2::object::ID>(),
            initial_product_by_slot              : 0x2::table::new<PartPolicyKeyV7, 0x2::object::ID>(arg8),
            authorized_initial_style_product_ids : arg4,
            initial_recipe_hash                  : arg5,
            initial_authorization_commitment     : arg6,
            initial_style_product_ids            : 0x1::vector::empty<0x2::object::ID>(),
            initial_asset_ids                    : 0x1::vector::empty<0x2::object::ID>(),
            external_asset_count                 : 0,
            soul_local_asset_count               : 0,
            equipped_count                       : 0,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.wardrobes, arg3, 0x2::object::id<SoulWardrobeV7>(&v0));
        arg0.wardrobe_count = arg0.wardrobe_count + 1;
        let v1 = SoulWardrobeCreatedV7{
            wardrobe_id                      : 0x2::object::id<SoulWardrobeV7>(&v0),
            soul_id                          : arg3,
            profile_id                       : 0x2::object::id<MakerPhysicalProfileV7>(arg2),
            initial_recipe_hash              : arg5,
            initial_authorization_commitment : arg6,
        };
        0x2::event::emit<SoulWardrobeCreatedV7>(v1);
        v0
    }

    fun next_serial(arg0: &mut StyleProductV7) : u64 {
        assert!(arg0.active, 24);
        if (arg0.supply_kind == 2) {
            assert!(arg0.minted_supply < arg0.max_supply, 23);
        };
        arg0.minted_supply = arg0.minted_supply + 1;
        arg0.minted_supply
    }

    public fun part_fixed_v7() : u8 {
        0
    }

    public fun part_hybrid_v7() : u8 {
        3
    }

    public fun part_open_v7() : u8 {
        2
    }

    fun part_policy(arg0: &MakerPhysicalProfileV7, arg1: 0x1::string::String) : &PartPolicyV7 {
        let v0 = PartPolicyKeyV7{slot_key: arg1};
        assert!(0x2::table::contains<PartPolicyKeyV7, PartPolicyV7>(&arg0.part_policies, v0), 14);
        0x2::table::borrow<PartPolicyKeyV7, PartPolicyV7>(&arg0.part_policies, v0)
    }

    public fun part_policy_behavior_v7(arg0: &PartPolicyV7) : u8 {
        arg0.behavior
    }

    public fun part_policy_max_source_kind_v7(arg0: &PartPolicyV7) : u8 {
        arg0.max_source_kind
    }

    public fun part_policy_required_v7(arg0: &PartPolicyV7) : bool {
        arg0.required
    }

    public fun part_policy_slot_key_v7(arg0: &PartPolicyV7) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun part_policy_v7(arg0: &MakerPhysicalProfileV7, arg1: 0x1::string::String) : &PartPolicyV7 {
        let v0 = PartPolicyKeyV7{slot_key: arg1};
        0x2::table::borrow<PartPolicyKeyV7, PartPolicyV7>(&arg0.part_policies, v0)
    }

    public fun part_soul_local_v7() : u8 {
        1
    }

    public fun physical_config_id_v7(arg0: &PhysicalProtocolConfigV7) : 0x2::object::ID {
        0x2::object::id<PhysicalProtocolConfigV7>(arg0)
    }

    public fun physical_listing_proof_type_v7(arg0: &PhysicalProtocolConfigV7) : &0x1::option::Option<0x1::string::String> {
        &arg0.listing_proof_type
    }

    public fun physical_profile_id_v7(arg0: &MakerPhysicalProfileV7) : 0x2::object::ID {
        0x2::object::id<MakerPhysicalProfileV7>(arg0)
    }

    public fun physical_profile_part_policy_count_v7(arg0: &MakerPhysicalProfileV7) : u64 {
        arg0.part_policy_count
    }

    public fun physical_profile_renderer_commitment_v7(arg0: &MakerPhysicalProfileV7) : &vector<u8> {
        &arg0.renderer_commitment
    }

    public fun physical_profile_required_slot_keys_v7(arg0: &MakerPhysicalProfileV7) : &vector<0x1::string::String> {
        &arg0.required_slot_keys
    }

    public fun physical_profile_root_id_v7(arg0: &MakerPhysicalProfileV7) : 0x2::object::ID {
        arg0.root_id
    }

    public fun physical_profile_sealed_v7(arg0: &MakerPhysicalProfileV7) : bool {
        arg0.sealed
    }

    public fun physical_profile_slot_schema_commitment_v7(arg0: &MakerPhysicalProfileV7) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun physical_profile_v6_id_v7(arg0: &MakerPhysicalProfileV7) : 0x2::object::ID {
        arg0.v6_profile_id
    }

    public fun physical_protocol_enabled_v7(arg0: &PhysicalProtocolConfigV7) : bool {
        arg0.enabled
    }

    public fun physical_protocol_version_v7() : u64 {
        7
    }

    public fun physical_registry_family_count_v7(arg0: &PhysicalRegistryV7) : u64 {
        arg0.family_count
    }

    public fun physical_registry_id_v7(arg0: &PhysicalProtocolConfigV7) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun physical_registry_product_count_v7(arg0: &PhysicalRegistryV7) : u64 {
        arg0.product_count
    }

    public fun physical_registry_profile_count_v7(arg0: &PhysicalRegistryV7) : u64 {
        0x2::table::length<0x2::object::ID, 0x2::object::ID>(&arg0.profiles)
    }

    public fun physical_registry_wardrobe_count_v7(arg0: &PhysicalRegistryV7) : u64 {
        arg0.wardrobe_count
    }

    public fun physical_soul_owner_proof_type_v7(arg0: &PhysicalProtocolConfigV7) : &0x1::string::String {
        &arg0.soul_owner_proof_type
    }

    public fun physical_v5_config_id_v7(arg0: &PhysicalProtocolConfigV7) : 0x2::object::ID {
        arg0.v5_config_id
    }

    public fun physical_v6_config_id_v7(arg0: &PhysicalProtocolConfigV7) : 0x2::object::ID {
        arg0.v6_config_id
    }

    public fun publish_external_item_family_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::freeze_object<ItemFamilyV7>(new_external_item_family(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun publish_external_style_product_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &ItemFamilyV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: u64, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: vector<u8>, arg19: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StyleProductV7>(new_external_style_product(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19));
    }

    public fun publish_item_family_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1, arg0);
        0x2::transfer::freeze_object<ItemFamilyV7>(new_official_item_family(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    public fun publish_style_product_v7(arg0: &mut PhysicalRegistryV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &ItemFamilyV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg9: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u8, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: vector<u8>, arg20: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StyleProductV7>(new_official_style_product(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20));
    }

    public fun purchase_owned_style_v7<T0>(arg0: &PhysicalProtocolConfigV7, arg1: &mut StyleProductV7, arg2: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionRegistryV6, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg4: &mut 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolTreasuryV6<T0>, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::ItemProductV6, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg8: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg9: 0x2::coin::Coin<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_style_sale_link(arg0, arg1, arg3, arg5, arg6);
        assert!(arg1.supply_kind != 0, 22);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::product_access_kind_v6(arg6) == 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::access_paid_v6(), 47);
        assert_supply_available(arg1);
        let v0 = 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::purchase_owned_item_for_physical_v7<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v1, v2, v3) = consume_v6_owned_receipt(arg2, arg3, arg5, arg1, v0, arg11);
        assert!(v2 == arg1.transferable, 31);
        0x2::transfer::transfer<StyleAssetV7>(create_style_asset(arg0, arg1, 1, v1, 0x1::option::none<0x2::object::ID>(), v3, arg11), v1);
    }

    public fun register_part_policy_v7(arg0: &mut MakerPhysicalProfileV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg4: 0x1::string::String, arg5: u8, arg6: bool, arg7: u8, arg8: &0x2::tx_context::TxContext) {
        assert_config_profile(arg1, arg0);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg2, arg3, arg8);
        assert!(arg0.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg2), 2);
        assert!(!arg0.sealed, 11);
        assert_part_policy(arg5, arg6, arg7, &arg4);
        let v0 = PartPolicyKeyV7{slot_key: arg4};
        assert!(!0x2::table::contains<PartPolicyKeyV7, PartPolicyV7>(&arg0.part_policies, v0), 13);
        let v1 = PartPolicyV7{
            slot_key        : arg4,
            behavior        : arg5,
            required        : arg6,
            max_source_kind : arg7,
        };
        0x2::table::add<PartPolicyKeyV7, PartPolicyV7>(&mut arg0.part_policies, v0, v1);
        if (arg6) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.required_slot_keys, arg4);
        };
        arg0.part_policy_count = arg0.part_policy_count + 1;
        let v2 = PartPolicyRegisteredV7{
            profile_id      : 0x2::object::id<MakerPhysicalProfileV7>(arg0),
            slot_key        : arg4,
            behavior        : arg5,
            required        : arg6,
            max_source_kind : arg7,
        };
        0x2::event::emit<PartPolicyRegisteredV7>(v2);
    }

    fun remove_equipped_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 36
    }

    fun replace_equipped_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                *0x1::vector::borrow_mut<0x2::object::ID>(arg0, v0) = arg2;
                return
            };
            v0 = v0 + 1;
        };
        abort 36
    }

    fun reserve_free_style_claim(arg0: &PhysicalRegistryV7, arg1: 0x2::object::ID, arg2: address) : FreeStyleClaimKeyV7 {
        let v0 = FreeStyleClaimKeyV7{
            style_product_id : arg1,
            wallet           : arg2,
        };
        assert!(!0x2::table::contains<FreeStyleClaimKeyV7, bool>(&arg0.free_style_claims, v0), 51);
        v0
    }

    public fun seal_initial_physical_loadout_authorization_v7(arg0: &mut InitialPhysicalLoadoutAuthorizationV7) {
        assert!(!arg0.sealed, 56);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.style_product_ids) > 0, 53);
        assert!(0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::StyleSelectionV5>(&arg0.style_selections) == 0x1::vector::length<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft::RecipeSlot>(&arg0.recipe), 55);
        assert!(0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::hash_complete_selection_v5(&arg0.recipe, &arg0.style_selections) == arg0.recipe_hash, 55);
        arg0.authorization_commitment = initial_physical_authorization_commitment(arg0.version, arg0.config_id, arg0.profile_id, arg0.v6_profile_id, arg0.root_id, &arg0.recipe_hash, &arg0.visual_recipe_indices, &arg0.style_product_ids);
        arg0.sealed = true;
    }

    public fun seal_maker_physical_profile_v7(arg0: &mut MakerPhysicalProfileV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg3: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerControlCapV5, arg4: &0x2::tx_context::TxContext) {
        assert_config_profile(arg1, arg0);
        0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::assert_extension_control_v5(arg2, arg3, arg4);
        assert!(arg0.root_id == 0x2::object::id<0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5>(arg2), 2);
        assert!(!arg0.sealed, 11);
        assert!(arg0.part_policy_count > 0, 15);
        arg0.sealed = true;
    }

    public fun set_style_product_active_v7(arg0: &mut StyleProductV7, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.original_creator, 25);
        arg0.active = arg1;
    }

    public fun set_wardrobe_listed_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &MakerPhysicalProfileV7, arg3: 0x2::object::ID, arg4: bool, arg5: T0, arg6: u64) {
        assert_listing_proof<T0>(arg1);
        assert_wardrobe_config(arg0, arg1);
        assert!(arg0.soul_id == arg3, 27);
        assert!(arg0.initialized, 52);
        assert!(arg0.revision == arg6, 30);
        if (arg4) {
            assert!(!arg0.listed, 29);
            assert!(arg0.external_asset_count == 0, 44);
            assert_wardrobe_complete_internal(arg0, arg2);
        } else {
            assert!(arg0.listed, 29);
        };
        arg0.listed = arg4;
        increment_revision(arg0);
    }

    public fun source_certified_v7() : u8 {
        1
    }

    public fun source_official_v7() : u8 {
        0
    }

    public fun source_open_v7() : u8 {
        2
    }

    public fun style_asset_bound_soul_id_v7(arg0: &StyleAssetV7) : 0x1::option::Option<0x2::object::ID> {
        arg0.bound_soul_id
    }

    public fun style_asset_excluded_v6_ids_v7(arg0: &StyleAssetV7) : &vector<0x2::object::ID> {
        &arg0.excluded_v6_product_ids
    }

    public fun style_asset_family_id_v7(arg0: &StyleAssetV7) : 0x2::object::ID {
        arg0.family_id
    }

    public fun style_asset_holder_v7(arg0: &StyleAssetV7) : address {
        arg0.holder
    }

    public fun style_asset_id_v7(arg0: &StyleAssetV7) : 0x2::object::ID {
        0x2::object::id<StyleAssetV7>(arg0)
    }

    public fun style_asset_kind_v7(arg0: &StyleAssetV7) : u8 {
        arg0.asset_kind
    }

    public fun style_asset_original_creator_v7(arg0: &StyleAssetV7) : address {
        arg0.original_creator
    }

    public fun style_asset_ownership_epoch_v7(arg0: &StyleAssetV7) : u64 {
        arg0.ownership_epoch
    }

    public fun style_asset_product_id_v7(arg0: &StyleAssetV7) : 0x2::object::ID {
        arg0.style_product_id
    }

    public fun style_asset_required_v6_ids_v7(arg0: &StyleAssetV7) : &vector<0x2::object::ID> {
        &arg0.required_v6_product_ids
    }

    public fun style_asset_serial_v7(arg0: &StyleAssetV7) : u64 {
        arg0.serial
    }

    public fun style_asset_slot_key_v7(arg0: &StyleAssetV7) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun style_asset_source_kind_v7(arg0: &StyleAssetV7) : u8 {
        arg0.source_kind
    }

    public fun style_asset_transferable_v7(arg0: &StyleAssetV7) : bool {
        arg0.transferable
    }

    public fun style_asset_v6_product_id_v7(arg0: &StyleAssetV7) : 0x2::object::ID {
        arg0.v6_product_id
    }

    public fun style_product_active_v7(arg0: &StyleProductV7) : bool {
        arg0.active
    }

    public fun style_product_asset_blob_id_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.asset_blob_id
    }

    public fun style_product_asset_commitment_v7(arg0: &StyleProductV7) : &vector<u8> {
        &arg0.asset_commitment
    }

    public fun style_product_asset_identifier_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.asset_identifier
    }

    public fun style_product_available_v7(arg0: &StyleProductV7) : bool {
        arg0.active && (arg0.supply_kind != 2 || arg0.minted_supply < arg0.max_supply)
    }

    public fun style_product_creator_v7(arg0: &StyleProductV7) : address {
        arg0.original_creator
    }

    public fun style_product_definition_blob_id_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.definition_blob_id
    }

    public fun style_product_definition_commitment_v7(arg0: &StyleProductV7) : &vector<u8> {
        &arg0.definition_commitment
    }

    public fun style_product_definition_identifier_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.definition_identifier
    }

    public fun style_product_entitlement_kind_v7(arg0: &StyleProductV7) : u8 {
        arg0.entitlement_kind
    }

    public fun style_product_excluded_v6_ids_v7(arg0: &StyleProductV7) : &vector<0x2::object::ID> {
        &arg0.excluded_v6_product_ids
    }

    public fun style_product_family_id_v7(arg0: &StyleProductV7) : 0x2::object::ID {
        arg0.family_id
    }

    public fun style_product_id_v7(arg0: &StyleProductV7) : 0x2::object::ID {
        0x2::object::id<StyleProductV7>(arg0)
    }

    public fun style_product_label_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.label
    }

    public fun style_product_maker_fee_bps_v7(arg0: &StyleProductV7) : u16 {
        arg0.maker_ecosystem_fee_bps
    }

    public fun style_product_max_supply_v7(arg0: &StyleProductV7) : u64 {
        arg0.max_supply
    }

    public fun style_product_minted_supply_v7(arg0: &StyleProductV7) : u64 {
        arg0.minted_supply
    }

    public fun style_product_pack_key_v7(arg0: &StyleProductV7) : &0x1::option::Option<0x1::string::String> {
        &arg0.pack_key
    }

    public fun style_product_price_atomic_v7(arg0: &StyleProductV7) : u64 {
        arg0.price_atomic
    }

    public fun style_product_profile_id_v7(arg0: &StyleProductV7) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun style_product_protocol_fee_bps_v7(arg0: &StyleProductV7) : u16 {
        arg0.protocol_fee_bps
    }

    public fun style_product_recipe_item_key_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.recipe_item_key
    }

    public fun style_product_renderer_commitment_v7(arg0: &StyleProductV7) : &vector<u8> {
        &arg0.renderer_commitment
    }

    public fun style_product_required_v6_ids_v7(arg0: &StyleProductV7) : &vector<0x2::object::ID> {
        &arg0.required_v6_product_ids
    }

    public fun style_product_slot_key_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.slot_key
    }

    public fun style_product_source_kind_v7(arg0: &StyleProductV7) : u8 {
        arg0.source_kind
    }

    public fun style_product_style_key_v7(arg0: &StyleProductV7) : &0x1::string::String {
        &arg0.style_key
    }

    public fun style_product_supply_kind_v7(arg0: &StyleProductV7) : u8 {
        arg0.supply_kind
    }

    public fun style_product_transferable_v7(arg0: &StyleProductV7) : bool {
        arg0.transferable
    }

    public fun style_product_v6_id_v7(arg0: &StyleProductV7) : 0x2::object::ID {
        arg0.v6_product_id
    }

    public fun style_product_v6_profile_id_v7(arg0: &StyleProductV7) : 0x2::object::ID {
        arg0.v6_profile_id
    }

    public fun supply_limited_edition_v7() : u8 {
        2
    }

    public fun supply_open_edition_v7() : u8 {
        1
    }

    public fun supply_soul_local_included_v7() : u8 {
        0
    }

    fun swap_internal(arg0: &mut SoulWardrobeV7, arg1: &MakerPhysicalProfileV7, arg2: &StyleProductV7, arg3: 0x2::transfer::Receiving<StyleAssetV7>, arg4: 0x2::transfer::Receiving<StyleAssetV7>, arg5: u64) {
        assert_wardrobe_mutable(arg0, arg5);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg3);
        let v1 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg4);
        assert!(v0 != v1, 31);
        let v2 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg3);
        let v3 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg4);
        assert_asset_product(arg0, arg2, &v2);
        assert_part_accepts_asset(arg1, &v2);
        assert!(&v2.slot_key == &v3.slot_key, 38);
        let v4 = PartPolicyKeyV7{slot_key: v2.slot_key};
        assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v4), 36);
        assert!(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v4) == v1, 36);
        assert!(0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v1).equipped, 36);
        assert!(!0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0).equipped, 35);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v1).equipped = false;
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0).equipped = true;
        0x2::table::remove<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v4);
        0x2::table::add<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v4, v0);
        let v5 = &mut arg0.equipped_asset_ids;
        replace_equipped_id(v5, v1, v0);
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v3, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        0x2::transfer::transfer<StyleAssetV7>(v2, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v0, v2.slot_key, 2);
    }

    public fun swap_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &StyleProductV7, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg7: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg8: 0x2::object::ID, arg9: T0, arg10: 0x2::transfer::Receiving<StyleAssetV7>, arg11: 0x2::transfer::Receiving<StyleAssetV7>, arg12: u64) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9);
        assert_product_admitted(arg4, arg5);
        swap_internal(arg0, arg3, arg5, arg10, arg11, arg12);
    }

    public fun transfer_owned_style_v7(arg0: StyleAssetV7, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.asset_kind == 1, 31);
        assert!(arg0.holder == 0x2::tx_context::sender(arg2), 32);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.bound_soul_id), 33);
        assert!(arg0.transferable, 54);
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 45);
        arg0.holder = arg1;
        arg0.ownership_epoch = arg0.ownership_epoch + 1;
        0x2::transfer::transfer<StyleAssetV7>(arg0, arg1);
    }

    public fun transfer_physical_admin_cap_v7(arg0: PhysicalAdminCapV7, arg1: address) {
        assert!(arg1 != @0x0, 45);
        0x2::transfer::transfer<PhysicalAdminCapV7>(arg0, arg1);
    }

    fun unequip_received_internal(arg0: &mut SoulWardrobeV7, arg1: &MakerPhysicalProfileV7, arg2: 0x2::transfer::Receiving<StyleAssetV7>, arg3: u64) {
        assert_wardrobe_mutable(arg0, arg3);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg2);
        let v1 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg2);
        assert_part_can_unequip(part_policy(arg1, v1.slot_key));
        let v2 = PartPolicyKeyV7{slot_key: v1.slot_key};
        assert!(0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2), 36);
        assert!(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v2) == v0, 36);
        0x2::table::borrow_mut<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0).equipped = false;
        0x2::table::remove<PartPolicyKeyV7, 0x2::object::ID>(&mut arg0.equipped_by_slot, v2);
        let v3 = &mut arg0.equipped_asset_ids;
        remove_equipped_id(v3, v0);
        arg0.equipped_count = arg0.equipped_count - 1;
        assert_equipped_rules(arg0);
        0x2::transfer::transfer<StyleAssetV7>(v1, 0x2::object::id_address<SoulWardrobeV7>(arg0));
        increment_revision(arg0);
        emit_wardrobe(arg0, v0, v1.slot_key, 3);
    }

    public fun unequip_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::CompositionProtocolConfigV6, arg3: &MakerPhysicalProfileV7, arg4: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::composition_v6::MakerProfileV6, arg5: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::MakerRootV5, arg6: &0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::commerce_v5::CommerceProtocolConfigV5, arg7: 0x2::object::ID, arg8: T0, arg9: 0x2::transfer::Receiving<StyleAssetV7>, arg10: u64) {
        assert_owner_action<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        unequip_received_internal(arg0, arg3, arg9, arg10);
    }

    public fun update_physical_protocol_enabled_v7(arg0: &mut PhysicalProtocolConfigV7, arg1: &PhysicalAdminCapV7, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.enabled = arg2;
    }

    fun vector_contains_id(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun wardrobe_authorized_initial_style_products_v7(arg0: &SoulWardrobeV7) : &vector<0x2::object::ID> {
        &arg0.authorized_initial_style_product_ids
    }

    public fun wardrobe_custody_record_v7(arg0: &SoulWardrobeV7, arg1: 0x2::object::ID) : &CustodyRecordV7 {
        0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, arg1)
    }

    public fun wardrobe_equipped_asset_v7(arg0: &SoulWardrobeV7, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PartPolicyKeyV7{slot_key: arg1};
        if (0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.equipped_by_slot, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun wardrobe_equipped_count_v7(arg0: &SoulWardrobeV7) : u64 {
        arg0.equipped_count
    }

    public fun wardrobe_external_asset_count_v7(arg0: &SoulWardrobeV7) : u64 {
        arg0.external_asset_count
    }

    public fun wardrobe_has_asset_v7(arg0: &SoulWardrobeV7, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, arg1)
    }

    public fun wardrobe_id_v7(arg0: &SoulWardrobeV7) : 0x2::object::ID {
        0x2::object::id<SoulWardrobeV7>(arg0)
    }

    public fun wardrobe_initial_asset_ids_v7(arg0: &SoulWardrobeV7) : &vector<0x2::object::ID> {
        &arg0.initial_asset_ids
    }

    public fun wardrobe_initial_authorization_commitment_v7(arg0: &SoulWardrobeV7) : &vector<u8> {
        &arg0.initial_authorization_commitment
    }

    public fun wardrobe_initial_recipe_hash_v7(arg0: &SoulWardrobeV7) : &vector<u8> {
        &arg0.initial_recipe_hash
    }

    public fun wardrobe_initial_style_for_slot_v7(arg0: &SoulWardrobeV7, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PartPolicyKeyV7{slot_key: arg1};
        if (0x2::table::contains<PartPolicyKeyV7, 0x2::object::ID>(&arg0.initial_product_by_slot, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PartPolicyKeyV7, 0x2::object::ID>(&arg0.initial_product_by_slot, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun wardrobe_initial_style_products_v7(arg0: &SoulWardrobeV7) : &vector<0x2::object::ID> {
        &arg0.initial_style_product_ids
    }

    public fun wardrobe_initialized_v7(arg0: &SoulWardrobeV7) : bool {
        arg0.initialized
    }

    public fun wardrobe_listed_v7(arg0: &SoulWardrobeV7) : bool {
        arg0.listed
    }

    public fun wardrobe_profile_id_v7(arg0: &SoulWardrobeV7) : 0x2::object::ID {
        arg0.profile_id
    }

    public fun wardrobe_revision_v7(arg0: &SoulWardrobeV7) : u64 {
        arg0.revision
    }

    public fun wardrobe_root_id_v7(arg0: &SoulWardrobeV7) : 0x2::object::ID {
        arg0.root_id
    }

    public fun wardrobe_slot_schema_commitment_v7(arg0: &SoulWardrobeV7) : &vector<u8> {
        &arg0.slot_schema_commitment
    }

    public fun wardrobe_soul_id_v7(arg0: &SoulWardrobeV7) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun wardrobe_soul_local_asset_count_v7(arg0: &SoulWardrobeV7) : u64 {
        arg0.soul_local_asset_count
    }

    fun withdraw_received_internal(arg0: &mut SoulWardrobeV7, arg1: 0x2::transfer::Receiving<StyleAssetV7>, arg2: u64, arg3: address) {
        assert_wardrobe_mutable(arg0, arg2);
        let v0 = 0x2::transfer::receiving_object_id<StyleAssetV7>(&arg1);
        assert!(0x2::table::contains<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0), 34);
        assert!(!0x2::table::borrow<0x2::object::ID, CustodyRecordV7>(&arg0.inventory, v0).equipped, 35);
        let v1 = 0x2::transfer::receive<StyleAssetV7>(&mut arg0.id, arg1);
        let v2 = 0x2::table::remove<0x2::object::ID, CustodyRecordV7>(&mut arg0.inventory, v0);
        assert_withdrawable_asset(&v1, &v2);
        arg0.external_asset_count = arg0.external_asset_count - 1;
        v1.holder = arg3;
        v1.bound_soul_id = 0x1::option::none<0x2::object::ID>();
        v1.ownership_epoch = v1.ownership_epoch + 1;
        0x2::transfer::transfer<StyleAssetV7>(v1, arg3);
        increment_revision(arg0);
        emit_wardrobe(arg0, v0, v1.slot_key, 4);
    }

    public fun withdraw_style_v7<T0: drop>(arg0: &mut SoulWardrobeV7, arg1: &PhysicalProtocolConfigV7, arg2: 0x2::object::ID, arg3: T0, arg4: 0x2::transfer::Receiving<StyleAssetV7>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_owner_proof<T0>(arg1);
        assert_wardrobe_config(arg0, arg1);
        assert!(arg0.soul_id == arg2, 27);
        withdraw_received_internal(arg0, arg4, arg5, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

