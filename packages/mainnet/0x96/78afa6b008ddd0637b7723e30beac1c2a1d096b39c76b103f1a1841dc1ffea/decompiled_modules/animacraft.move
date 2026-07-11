module 0x9678afa6b008ddd0637b7723e30beac1c2a1d096b39c76b103f1a1841dc1ffea::animacraft {
    struct ANIMACRAFT has drop {
        dummy_field: bool,
    }

    struct CreatorProfile has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        display_name: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_url: 0x1::string::String,
        payout_address: address,
        maker_count: u64,
        maker_ids: vector<0x2::object::ID>,
    }

    struct LicensePolicy has copy, drop, store {
        license_kind: u8,
        royalty_bps: u16,
        commercial_allowed: bool,
        remix_allowed: bool,
        attribution_required: bool,
    }

    struct RoyaltyPolicySnapshot has copy, drop, store {
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        royalty_bps: u16,
    }

    struct PartKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct PartRecord has copy, drop, store {
        key: 0x1::string::String,
        label: 0x1::string::String,
        part_kind: u8,
        render_order: u64,
        item_count: u64,
        menu_visible: bool,
        required: bool,
        colors: vector<0x1::string::String>,
    }

    struct ItemRecord has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        label: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        icon_blob_id: 0x1::string::String,
        gate_kind: u8,
    }

    struct MakerAdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
    }

    struct MakerTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        maker_id: 0x2::object::ID,
        revenue: 0x2::balance::Balance<T0>,
        total_collected: u64,
        total_royalty_collected: u64,
        total_withdrawn: u64,
    }

    struct OCMaker has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        creator_profile_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        cover_url: 0x1::string::String,
        manifest_blob_id: 0x1::string::String,
        policy: LicensePolicy,
        admin_cap_id: 0x1::option::Option<0x2::object::ID>,
        treasury_id: 0x1::option::Option<0x2::object::ID>,
        payment_coin_type: 0x1::string::String,
        minting_enabled: bool,
        mint_fee_enabled: bool,
        mint_price_atomic: u64,
        parts: 0x2::table::Table<PartKey, PartRecord>,
        items_by_part: 0x2::table::Table<PartKey, vector<ItemRecord>>,
        part_keys: vector<0x1::string::String>,
        selection_rules: vector<SelectionRule>,
        palette_links: vector<PaletteLink>,
        part_count: u64,
        item_count: u64,
        rule_count: u64,
        palette_link_count: u64,
        published: bool,
        archived: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct RecipeSlot has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        color_hex: 0x1::string::String,
        render_order: u64,
    }

    struct SelectionRule has copy, drop, store {
        left_part_key: 0x1::string::String,
        left_item_key: 0x1::string::String,
        right_part_key: 0x1::string::String,
        right_item_key: 0x1::string::String,
    }

    struct PaletteLink has copy, drop, store {
        left_part_key: 0x1::string::String,
        right_part_key: 0x1::string::String,
    }

    struct SoulMintAuthorization {
        version: u64,
        maker_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        maker_creator: address,
        payer: address,
        name: 0x1::string::String,
        profile_json_blob_id: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
        recipe_hash: vector<u8>,
        license_snapshot: LicensePolicy,
        mint_payment_coin_type: 0x1::string::String,
        mint_price_atomic: u64,
        recipe: vector<RecipeSlot>,
        authorized_at_ms: u64,
    }

    struct CreatorProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        payout_address: address,
    }

    struct OCMakerCreated has copy, drop {
        maker_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        creator: address,
        creator_profile_id: 0x2::object::ID,
        payment_coin_type: 0x1::string::String,
        license_kind: u8,
        royalty_bps: u16,
        minting_enabled: bool,
        mint_fee_enabled: bool,
        mint_price_atomic: u64,
    }

    struct MakerEconomicsUpdated has copy, drop {
        maker_id: 0x2::object::ID,
        updater: address,
        minting_enabled: bool,
        mint_fee_enabled: bool,
        mint_price_atomic: u64,
        royalty_bps: u16,
    }

    struct MakerRevenueCollected has copy, drop {
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        payer: address,
        amount: u64,
    }

    struct MakerRevenueWithdrawn has copy, drop {
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        operator: address,
        recipient: address,
        amount: u64,
    }

    struct MakerRoyaltyCollected has copy, drop {
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        payer: address,
        gross_sale_amount: u64,
        royalty_amount: u64,
        royalty_bps: u16,
        soul_id: 0x2::object::ID,
    }

    struct OCMakerMetadataUpdated has copy, drop {
        maker_id: 0x2::object::ID,
        updater: address,
    }

    struct OCMakerPartAdded has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        part_key: 0x1::string::String,
        part_kind: u8,
        render_order: u64,
    }

    struct OCMakerItemAdded has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        gate_kind: u8,
    }

    struct OCMakerPublished has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        manifest_blob_id: 0x1::string::String,
        part_count: u64,
        item_count: u64,
    }

    struct OCMakerArchiveChanged has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        archived: bool,
    }

    struct OCMakerRuleAdded has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        left_part_key: 0x1::string::String,
        right_part_key: 0x1::string::String,
    }

    struct OCMakerColorAdded has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        part_key: 0x1::string::String,
        color_hex: 0x1::string::String,
    }

    struct OCMakerPaletteLinked has copy, drop {
        maker_id: 0x2::object::ID,
        creator: address,
        left_part_key: 0x1::string::String,
        right_part_key: 0x1::string::String,
    }

    struct SoulMintAuthorized has copy, drop {
        maker_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        maker_creator: address,
        payer: address,
        recipe_hash: vector<u8>,
        license_kind: u8,
        royalty_bps: u16,
        mint_price_atomic: u64,
    }

    fun add_color(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert_max_bytes(&arg1, 128);
        assert_color_hex(&arg2);
        assert_part_exists(arg0, &arg1);
        let v0 = PartKey{name: arg1};
        let v1 = 0x2::table::borrow_mut<PartKey, PartRecord>(&mut arg0.parts, v0);
        assert!(0x1::vector::length<0x1::string::String>(&v1.colors) < 32, 30);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1.colors)) {
            assert!(0x1::vector::borrow<0x1::string::String>(&v1.colors, v2) != &arg2, 29);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<0x1::string::String>(&mut v1.colors, arg2);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v3 = OCMakerColorAdded{
            maker_id  : 0x2::object::id<OCMaker>(arg0),
            creator   : 0x2::tx_context::sender(arg4),
            part_key  : arg1,
            color_hex : arg2,
        };
        0x2::event::emit<OCMakerColorAdded>(v3);
    }

    fun add_item(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert_non_empty(&arg1);
        assert_non_empty(&arg2);
        assert_non_empty(&arg3);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 128);
        assert_max_bytes(&arg3, 128);
        assert_blob_id(&arg4);
        assert_max_bytes(&arg5, 512);
        assert_valid_item_gate(arg6);
        assert!(arg0.item_count < 5000, 20);
        let v0 = PartKey{name: arg1};
        assert!(0x2::table::contains<PartKey, PartRecord>(&arg0.parts, v0), 5);
        assert!(!item_exists(arg0, &arg1, &arg2), 18);
        let v1 = 0x2::table::borrow_mut<PartKey, PartRecord>(&mut arg0.parts, v0);
        v1.item_count = v1.item_count + 1;
        let v2 = ItemRecord{
            part_key       : arg1,
            item_key       : arg2,
            label          : arg3,
            walrus_blob_id : arg4,
            icon_blob_id   : arg5,
            gate_kind      : arg6,
        };
        0x1::vector::push_back<ItemRecord>(0x2::table::borrow_mut<PartKey, vector<ItemRecord>>(&mut arg0.items_by_part, v0), v2);
        arg0.item_count = arg0.item_count + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
        let v3 = OCMakerItemAdded{
            maker_id  : 0x2::object::id<OCMaker>(arg0),
            creator   : 0x2::tx_context::sender(arg8),
            part_key  : arg1,
            item_key  : arg2,
            gate_kind : arg6,
        };
        0x2::event::emit<OCMakerItemAdded>(v3);
    }

    fun add_palette_link(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert!(arg0.palette_link_count < 1000, 21);
        assert!(arg1 != arg2, 23);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 128);
        assert_part_exists(arg0, &arg1);
        assert_part_exists(arg0, &arg2);
        let v0 = PartKey{name: arg1};
        let v1 = PartKey{name: arg2};
        assert!(part_colors_equal(0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v0), 0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v1)), 33);
        let v2 = 0;
        while (v2 < 0x1::vector::length<PaletteLink>(&arg0.palette_links)) {
            let v3 = 0x1::vector::borrow<PaletteLink>(&arg0.palette_links, v2);
            let v4 = &v3.left_part_key == &arg1 && &v3.right_part_key == &arg2;
            let v5 = &v3.left_part_key == &arg2 && &v3.right_part_key == &arg1;
            let v6 = v4 || v5;
            assert!(!v6, 23);
            v2 = v2 + 1;
        };
        let v7 = PaletteLink{
            left_part_key  : arg1,
            right_part_key : arg2,
        };
        0x1::vector::push_back<PaletteLink>(&mut arg0.palette_links, v7);
        arg0.palette_link_count = arg0.palette_link_count + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v8 = OCMakerPaletteLinked{
            maker_id       : 0x2::object::id<OCMaker>(arg0),
            creator        : 0x2::tx_context::sender(arg4),
            left_part_key  : arg1,
            right_part_key : arg2,
        };
        0x2::event::emit<OCMakerPaletteLinked>(v8);
    }

    fun add_part(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert_non_empty(&arg1);
        assert_non_empty(&arg2);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 128);
        assert_valid_part_kind(arg3);
        assert!(arg0.part_count < 750, 19);
        assert!(arg3 != 2 || arg6, 10);
        let v0 = PartKey{name: arg1};
        assert!(!0x2::table::contains<PartKey, PartRecord>(&arg0.parts, v0), 4);
        let v1 = PartRecord{
            key          : arg1,
            label        : arg2,
            part_kind    : arg3,
            render_order : arg4,
            item_count   : 0,
            menu_visible : arg5,
            required     : arg6,
            colors       : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::table::add<PartKey, PartRecord>(&mut arg0.parts, v0, v1);
        0x2::table::add<PartKey, vector<ItemRecord>>(&mut arg0.items_by_part, v0, 0x1::vector::empty<ItemRecord>());
        0x1::vector::push_back<0x1::string::String>(&mut arg0.part_keys, arg1);
        arg0.part_count = arg0.part_count + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
        let v2 = OCMakerPartAdded{
            maker_id     : 0x2::object::id<OCMaker>(arg0),
            creator      : 0x2::tx_context::sender(arg8),
            part_key     : arg1,
            part_kind    : arg3,
            render_order : arg4,
        };
        0x2::event::emit<OCMakerPartAdded>(v2);
    }

    fun add_selection_rule(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert!(arg0.rule_count < 1000, 21);
        assert!(arg1 != arg3, 23);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 128);
        assert_max_bytes(&arg3, 128);
        assert_max_bytes(&arg4, 128);
        assert_part_exists(arg0, &arg1);
        assert_part_exists(arg0, &arg3);
        assert_rule_part(arg0, &arg1);
        assert_rule_part(arg0, &arg3);
        if (0x1::vector::length<u8>(0x1::string::as_bytes(&arg2)) > 0) {
            assert!(item_exists(arg0, &arg1, &arg2), 5);
        };
        if (0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) > 0) {
            assert!(item_exists(arg0, &arg3, &arg4), 5);
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<SelectionRule>(&arg0.selection_rules)) {
            let v1 = 0x1::vector::borrow<SelectionRule>(&arg0.selection_rules, v0);
            let v2 = if (&v1.left_part_key == &arg1) {
                if (&v1.left_item_key == &arg2) {
                    if (&v1.right_part_key == &arg3) {
                        &v1.right_item_key == &arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            let v3 = if (&v1.left_part_key == &arg3) {
                if (&v1.left_item_key == &arg4) {
                    if (&v1.right_part_key == &arg1) {
                        &v1.right_item_key == &arg2
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            let v4 = v2 || v3;
            assert!(!v4, 23);
            v0 = v0 + 1;
        };
        let v5 = SelectionRule{
            left_part_key  : arg1,
            left_item_key  : arg2,
            right_part_key : arg3,
            right_item_key : arg4,
        };
        0x1::vector::push_back<SelectionRule>(&mut arg0.selection_rules, v5);
        arg0.rule_count = arg0.rule_count + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v6 = OCMakerRuleAdded{
            maker_id       : 0x2::object::id<OCMaker>(arg0),
            creator        : 0x2::tx_context::sender(arg6),
            left_part_key  : arg1,
            right_part_key : arg3,
        };
        0x2::event::emit<OCMakerRuleAdded>(v6);
    }

    public fun admin_add_color(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        add_color(arg1, arg2, arg3, arg4, arg5);
    }

    public fun admin_add_item(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        add_item(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun admin_add_palette_link(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        add_palette_link(arg1, arg2, arg3, arg4, arg5);
    }

    public fun admin_add_part(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        add_part(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun admin_add_selection_rule(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        add_selection_rule(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_cap_maker_id(arg0: &MakerAdminCap) : 0x2::object::ID {
        arg0.maker_id
    }

    public fun admin_cap_treasury_id(arg0: &MakerAdminCap) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun admin_publish_maker(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        publish_maker(arg1, arg2, arg3, arg4);
    }

    public fun admin_set_maker_archived(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        set_maker_archived(arg1, arg2, arg3, arg4);
    }

    public fun admin_update_maker_metadata(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        update_maker_metadata(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_update_maker_policy(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: u8, arg3: u16, arg4: bool, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        update_maker_policy(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun assert_blob_id(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 13);
        assert_max_bytes(arg0, 512);
    }

    fun assert_color_hex(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 7 && *0x1::vector::borrow<u8>(v0, 0) == 35, 14);
        let v1 = 1;
        while (v1 < 7) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = v2 >= 48 && v2 <= 57;
            let v4 = v2 >= 65 && v2 <= 70;
            let v5 = v2 >= 97 && v2 <= 102;
            let v6 = if (v3) {
                true
            } else if (v4) {
                true
            } else {
                v5
            };
            assert!(v6, 14);
            v1 = v1 + 1;
        };
    }

    fun assert_editable(arg0: &OCMaker) {
        assert!(!arg0.published, 2);
    }

    fun assert_maker_admin(arg0: &OCMaker, arg1: &MakerAdminCap) {
        assert!(arg1.maker_id == 0x2::object::id<OCMaker>(arg0), 34);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.admin_cap_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.admin_cap_id) == 0x2::object::id<MakerAdminCap>(arg1), 34);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.treasury_id) == arg1.treasury_id, 34);
    }

    fun assert_max_bytes(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) <= arg1, 22);
    }

    fun assert_non_empty(arg0: &0x1::string::String) {
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(arg0)) > 0, 8);
    }

    fun assert_owner(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg1), 0);
    }

    fun assert_part_exists(arg0: &OCMaker, arg1: &0x1::string::String) {
        let v0 = PartKey{name: *arg1};
        assert!(0x2::table::contains<PartKey, PartRecord>(&arg0.parts, v0), 5);
    }

    fun assert_publishable_structure(arg0: &OCMaker) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.part_keys)) {
            let v2 = PartKey{name: *0x1::vector::borrow<0x1::string::String>(&arg0.part_keys, v0)};
            let v3 = 0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v2);
            assert!(v3.item_count > 0, 25);
            assert!(0x1::vector::length<0x1::string::String>(&v3.colors) > 0, 31);
            if (v3.menu_visible) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        assert!(v1, 24);
    }

    fun assert_rule_part(arg0: &OCMaker, arg1: &0x1::string::String) {
        let v0 = PartKey{name: *arg1};
        assert!(0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v0).part_kind != 2, 27);
    }

    fun assert_treasury_matches<T0>(arg0: &OCMaker, arg1: &MakerTreasury<T0>) {
        assert!(arg1.maker_id == 0x2::object::id<OCMaker>(arg0), 38);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.treasury_id) == 0x2::object::id<MakerTreasury<T0>>(arg1), 38);
        assert!(arg0.payment_coin_type == payment_coin_type_name<T0>(), 38);
    }

    fun assert_valid_fee_config(arg0: bool, arg1: bool, arg2: u64) {
        assert!(arg0 || !arg1, 40);
        assert!(arg1 && arg2 > 0 || !arg1 && arg2 == 0, 40);
    }

    fun assert_valid_item_gate(arg0: u8) {
        assert!(arg0 <= 2, 11);
    }

    fun assert_valid_license_kind(arg0: u8) {
        assert!(arg0 <= 3, 9);
    }

    fun assert_valid_part_kind(arg0: u8) {
        assert!(arg0 <= 2, 10);
    }

    fun assert_valid_recipe(arg0: &OCMaker, arg1: &vector<RecipeSlot>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RecipeSlot>(arg1)) {
            let v1 = 0x1::vector::borrow<RecipeSlot>(arg1, v0);
            assert_max_bytes(&v1.part_key, 128);
            assert_max_bytes(&v1.item_key, 128);
            assert_color_hex(&v1.color_hex);
            assert_part_exists(arg0, &v1.part_key);
            assert!(item_exists(arg0, &v1.part_key, &v1.item_key), 14);
            let v2 = PartKey{name: v1.part_key};
            let v3 = 0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v2);
            assert!(part_has_color(v3, &v1.color_hex), 14);
            assert!(v3.render_order == v1.render_order, 32);
            let v4 = v0 + 1;
            while (v4 < 0x1::vector::length<RecipeSlot>(arg1)) {
                assert!(&0x1::vector::borrow<RecipeSlot>(arg1, v4).part_key != &v1.part_key, 15);
                v4 = v4 + 1;
            };
            v0 = v0 + 1;
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&arg0.part_keys)) {
            let v6 = 0x1::vector::borrow<0x1::string::String>(&arg0.part_keys, v5);
            let v7 = PartKey{name: *v6};
            if (0x2::table::borrow<PartKey, PartRecord>(&arg0.parts, v7).required) {
                let v8 = 0x1::string::utf8(b"");
                assert!(recipe_contains(arg1, v6, &v8), 14);
            };
            v5 = v5 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<SelectionRule>(&arg0.selection_rules)) {
            let v10 = 0x1::vector::borrow<SelectionRule>(&arg0.selection_rules, v9);
            let v11 = recipe_contains(arg1, &v10.left_part_key, &v10.left_item_key) && recipe_contains(arg1, &v10.right_part_key, &v10.right_item_key);
            assert!(!v11, 16);
            v9 = v9 + 1;
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<PaletteLink>(&arg0.palette_links)) {
            let v13 = 0x1::vector::borrow<PaletteLink>(&arg0.palette_links, v12);
            assert!(linked_recipe_colors_match(arg1, &v13.left_part_key, &v13.right_part_key), 33);
            v12 = v12 + 1;
        };
    }

    fun assert_valid_royalty(arg0: u16) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 >= 100) {
            if (arg0 <= 500) {
                arg0 % 100 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 37);
    }

    public fun authorize_soul_mint(arg0: &OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<RecipeSlot>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : SoulMintAuthorization {
        assert!(arg0.minting_enabled, 35);
        assert!(!arg0.mint_fee_enabled && arg0.mint_price_atomic == 0, 36);
        new_soul_mint_authorization(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun authorize_soul_mint_paid<T0>(arg0: &OCMaker, arg1: &mut MakerTreasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<RecipeSlot>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : SoulMintAuthorization {
        assert!(arg0.minting_enabled, 35);
        assert!(arg0.mint_fee_enabled && arg0.mint_price_atomic > 0, 36);
        collect_mint_payment<T0>(arg0, arg1, arg2, arg10);
        new_soul_mint_authorization(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun collect_mint_payment<T0>(arg0: &OCMaker, arg1: &mut MakerTreasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_treasury_matches<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 == arg0.mint_price_atomic, 36);
        0x2::coin::put<T0>(&mut arg1.revenue, arg2);
        arg1.total_collected = arg1.total_collected + v0;
        let v1 = MakerRevenueCollected{
            maker_id    : 0x2::object::id<OCMaker>(arg0),
            treasury_id : 0x2::object::id<MakerTreasury<T0>>(arg1),
            payer       : 0x2::tx_context::sender(arg3),
            amount      : v0,
        };
        0x2::event::emit<MakerRevenueCollected>(v1);
    }

    public fun configure_maker_economics(arg0: &MakerAdminCap, arg1: &mut OCMaker, arg2: bool, arg3: bool, arg4: u64, arg5: u16, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        assert_valid_fee_config(arg2, arg3, arg4);
        assert_valid_royalty(arg5);
        arg1.minting_enabled = arg2;
        arg1.mint_fee_enabled = arg3;
        arg1.mint_price_atomic = arg4;
        arg1.policy.royalty_bps = arg5;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg6);
        let v0 = MakerEconomicsUpdated{
            maker_id          : 0x2::object::id<OCMaker>(arg1),
            updater           : 0x2::tx_context::sender(arg7),
            minting_enabled   : arg2,
            mint_fee_enabled  : arg3,
            mint_price_atomic : arg4,
            royalty_bps       : arg5,
        };
        0x2::event::emit<MakerEconomicsUpdated>(v0);
    }

    public fun consume_soul_mint_authorization(arg0: SoulMintAuthorization) : (u64, 0x2::object::ID, 0x2::object::ID, address, address, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, vector<u8>, LicensePolicy, RoyaltyPolicySnapshot, 0x1::string::String, u64, vector<RecipeSlot>, u64) {
        let SoulMintAuthorization {
            version                : v0,
            maker_id               : v1,
            maker_treasury_id      : v2,
            maker_creator          : v3,
            payer                  : v4,
            name                   : v5,
            profile_json_blob_id   : v6,
            image_blob_id          : v7,
            image_url              : v8,
            recipe_hash            : v9,
            license_snapshot       : v10,
            mint_payment_coin_type : v11,
            mint_price_atomic      : v12,
            recipe                 : v13,
            authorized_at_ms       : v14,
        } = arg0;
        let v15 = v10;
        let v16 = RoyaltyPolicySnapshot{
            maker_id    : v1,
            treasury_id : v2,
            royalty_bps : v15.royalty_bps,
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v15, v16, v11, v12, v13, v14)
    }

    entry fun create_creator_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::transfer<CreatorProfile>(new_creator_profile(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun creator_maker_ids(arg0: &CreatorProfile) : &vector<0x2::object::ID> {
        &arg0.maker_ids
    }

    public fun deposit_resale_royalty<T0>(arg0: &RoyaltyPolicySnapshot, arg1: &OCMaker, arg2: &mut MakerTreasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x2::object::ID, arg6: &0x2::tx_context::TxContext) {
        assert_treasury_matches<T0>(arg1, arg2);
        assert!(arg0.maker_id == 0x2::object::id<OCMaker>(arg1) && arg0.treasury_id == 0x2::object::id<MakerTreasury<T0>>(arg2), 38);
        let v0 = arg0.royalty_bps;
        assert!(v0 > 0, 37);
        let v1 = 0x1::u64::mul_div(arg4, (v0 as u64), 10000);
        assert!(v1 > 0 && 0x2::coin::value<T0>(&arg3) == v1, 36);
        0x2::coin::put<T0>(&mut arg2.revenue, arg3);
        arg2.total_collected = arg2.total_collected + v1;
        arg2.total_royalty_collected = arg2.total_royalty_collected + v1;
        let v2 = MakerRoyaltyCollected{
            maker_id          : 0x2::object::id<OCMaker>(arg1),
            treasury_id       : 0x2::object::id<MakerTreasury<T0>>(arg2),
            payer             : 0x2::tx_context::sender(arg6),
            gross_sale_amount : arg4,
            royalty_amount    : v1,
            royalty_bps       : v0,
            soul_id           : arg5,
        };
        0x2::event::emit<MakerRoyaltyCollected>(v2);
    }

    fun init(arg0: ANIMACRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ANIMACRAFT>(arg0, arg1);
        let v1 = 0x2::display::new<OCMaker>(&v0, arg1);
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{cover_url}"));
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"payment_coin_type"), 0x1::string::utf8(b"{payment_coin_type}"));
        0x2::display::add<OCMaker>(&mut v1, 0x1::string::utf8(b"mint_price_atomic"), 0x1::string::utf8(b"{mint_price_atomic}"));
        0x2::display::update_version<OCMaker>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OCMaker>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun item_creator_only() : u8 {
        2
    }

    fun item_exists(arg0: &OCMaker, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        let v0 = PartKey{name: *arg1};
        if (!0x2::table::contains<PartKey, vector<ItemRecord>>(&arg0.items_by_part, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<PartKey, vector<ItemRecord>>(&arg0.items_by_part, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<ItemRecord>(v1)) {
            if (&0x1::vector::borrow<ItemRecord>(v1, v2).item_key == arg2) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun item_included() : u8 {
        0
    }

    public fun item_paid_addon() : u8 {
        1
    }

    public fun keep_creator_profile(arg0: CreatorProfile, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0.owner, arg1);
        0x2::transfer::transfer<CreatorProfile>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun license_exclusive() : u8 {
        3
    }

    public fun license_free_remix() : u8 {
        1
    }

    public fun license_paid_commercial() : u8 {
        2
    }

    public fun license_personal() : u8 {
        0
    }

    fun linked_recipe_colors_match(arg0: &vector<RecipeSlot>, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RecipeSlot>(arg0)) {
            let v1 = 0x1::vector::borrow<RecipeSlot>(arg0, v0);
            if (&v1.part_key == arg1) {
                let v2 = 0;
                while (v2 < 0x1::vector::length<RecipeSlot>(arg0)) {
                    let v3 = 0x1::vector::borrow<RecipeSlot>(arg0, v2);
                    if (&v3.part_key == arg2) {
                        return &v1.color_hex == &v3.color_hex
                    };
                    v2 = v2 + 1;
                };
                return true
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun maker_admin_cap_id(arg0: &OCMaker) : 0x1::option::Option<0x2::object::ID> {
        arg0.admin_cap_id
    }

    public fun maker_archived(arg0: &OCMaker) : bool {
        arg0.archived
    }

    public fun maker_creator(arg0: &OCMaker) : address {
        arg0.creator
    }

    public fun maker_id(arg0: &OCMaker) : 0x2::object::ID {
        0x2::object::id<OCMaker>(arg0)
    }

    public fun maker_mint_fee_enabled(arg0: &OCMaker) : bool {
        arg0.mint_fee_enabled
    }

    public fun maker_mint_price_atomic(arg0: &OCMaker) : u64 {
        arg0.mint_price_atomic
    }

    public fun maker_minting_enabled(arg0: &OCMaker) : bool {
        arg0.minting_enabled
    }

    public fun maker_payment_coin_type(arg0: &OCMaker) : &0x1::string::String {
        &arg0.payment_coin_type
    }

    public fun maker_policy(arg0: &OCMaker) : LicensePolicy {
        arg0.policy
    }

    public fun maker_published(arg0: &OCMaker) : bool {
        arg0.published
    }

    public fun maker_treasury_id(arg0: &OCMaker) : 0x1::option::Option<0x2::object::ID> {
        arg0.treasury_id
    }

    public fun new_creator_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : CreatorProfile {
        assert_non_empty(&arg0);
        assert_max_bytes(&arg0, 128);
        assert_max_bytes(&arg1, 2000);
        assert_max_bytes(&arg2, 512);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = CreatorProfile{
            id             : 0x2::object::new(arg4),
            version        : 3,
            owner          : v0,
            display_name   : arg0,
            bio            : arg1,
            avatar_url     : arg2,
            payout_address : arg3,
            maker_count    : 0,
            maker_ids      : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = CreatorProfileCreated{
            profile_id     : 0x2::object::id<CreatorProfile>(&v1),
            owner          : v0,
            payout_address : arg3,
        };
        0x2::event::emit<CreatorProfileCreated>(v2);
        v1
    }

    public fun new_managed_oc_maker<T0>(arg0: &mut CreatorProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u16, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (OCMaker, MakerTreasury<T0>, MakerAdminCap) {
        assert_valid_fee_config(arg10, arg11, arg12);
        let v0 = new_oc_maker(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg13, arg14);
        let v1 = 0x2::object::id<OCMaker>(&v0);
        let v2 = MakerTreasury<T0>{
            id                      : 0x2::object::new(arg14),
            version                 : 3,
            maker_id                : v1,
            revenue                 : 0x2::balance::zero<T0>(),
            total_collected         : 0,
            total_royalty_collected : 0,
            total_withdrawn         : 0,
        };
        let v3 = 0x2::object::id<MakerTreasury<T0>>(&v2);
        let v4 = MakerAdminCap{
            id          : 0x2::object::new(arg14),
            version     : 3,
            maker_id    : v1,
            treasury_id : v3,
        };
        let v5 = 0x2::object::id<MakerAdminCap>(&v4);
        let v6 = payment_coin_type_name<T0>();
        v0.admin_cap_id = 0x1::option::some<0x2::object::ID>(v5);
        v0.treasury_id = 0x1::option::some<0x2::object::ID>(v3);
        v0.payment_coin_type = v6;
        v0.minting_enabled = arg10;
        v0.mint_fee_enabled = arg11;
        v0.mint_price_atomic = arg12;
        let v7 = OCMakerCreated{
            maker_id           : v1,
            admin_cap_id       : v5,
            treasury_id        : v3,
            creator            : 0x2::tx_context::sender(arg14),
            creator_profile_id : 0x2::object::id<CreatorProfile>(arg0),
            payment_coin_type  : v6,
            license_kind       : arg5,
            royalty_bps        : arg6,
            minting_enabled    : arg10,
            mint_fee_enabled   : arg11,
            mint_price_atomic  : arg12,
        };
        0x2::event::emit<OCMakerCreated>(v7);
        (v0, v2, v4)
    }

    fun new_oc_maker(arg0: &mut CreatorProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u16, arg7: bool, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : OCMaker {
        assert_owner(arg0.owner, arg11);
        assert_non_empty(&arg1);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 2000);
        assert_max_bytes(&arg3, 512);
        assert_max_bytes(&arg4, 512);
        assert_valid_royalty(arg6);
        assert_valid_license_kind(arg5);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = LicensePolicy{
            license_kind         : arg5,
            royalty_bps          : arg6,
            commercial_allowed   : arg7,
            remix_allowed        : arg8,
            attribution_required : arg9,
        };
        let v2 = OCMaker{
            id                 : 0x2::object::new(arg11),
            version            : 3,
            creator            : 0x2::tx_context::sender(arg11),
            creator_profile_id : 0x2::object::id<CreatorProfile>(arg0),
            name               : arg1,
            description        : arg2,
            cover_url          : arg3,
            manifest_blob_id   : arg4,
            policy             : v1,
            admin_cap_id       : 0x1::option::none<0x2::object::ID>(),
            treasury_id        : 0x1::option::none<0x2::object::ID>(),
            payment_coin_type  : 0x1::string::utf8(b""),
            minting_enabled    : true,
            mint_fee_enabled   : false,
            mint_price_atomic  : 0,
            parts              : 0x2::table::new<PartKey, PartRecord>(arg11),
            items_by_part      : 0x2::table::new<PartKey, vector<ItemRecord>>(arg11),
            part_keys          : 0x1::vector::empty<0x1::string::String>(),
            selection_rules    : 0x1::vector::empty<SelectionRule>(),
            palette_links      : 0x1::vector::empty<PaletteLink>(),
            part_count         : 0,
            item_count         : 0,
            rule_count         : 0,
            palette_link_count : 0,
            published          : false,
            archived           : false,
            created_at_ms      : v0,
            updated_at_ms      : v0,
        };
        arg0.maker_count = arg0.maker_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.maker_ids, 0x2::object::id<OCMaker>(&v2));
        v2
    }

    fun new_soul_mint_authorization(arg0: &OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<RecipeSlot>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : SoulMintAuthorization {
        assert!(arg0.published, 3);
        assert!(!arg0.archived, 17);
        assert_non_empty(&arg1);
        assert_max_bytes(&arg1, 128);
        assert!(0x1::vector::length<RecipeSlot>(&arg6) > 0, 7);
        assert!(0x1::vector::length<RecipeSlot>(&arg6) <= 750, 26);
        assert_blob_id(&arg2);
        assert_blob_id(&arg3);
        assert_non_empty(&arg4);
        assert_max_bytes(&arg4, 512);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 28);
        assert_valid_recipe(arg0, &arg6);
        assert!(arg5 == 0x1::hash::sha2_256(0x1::bcs::to_bytes<vector<RecipeSlot>>(&arg6)), 28);
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg0.treasury_id)) {
            *0x1::option::borrow<0x2::object::ID>(&arg0.treasury_id)
        } else {
            0x2::object::id<OCMaker>(arg0)
        };
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = SoulMintAuthorization{
            version                : 3,
            maker_id               : 0x2::object::id<OCMaker>(arg0),
            maker_treasury_id      : v0,
            maker_creator          : arg0.creator,
            payer                  : v1,
            name                   : arg1,
            profile_json_blob_id   : arg2,
            image_blob_id          : arg3,
            image_url              : arg4,
            recipe_hash            : arg5,
            license_snapshot       : arg0.policy,
            mint_payment_coin_type : arg0.payment_coin_type,
            mint_price_atomic      : arg0.mint_price_atomic,
            recipe                 : arg6,
            authorized_at_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        let v3 = SoulMintAuthorized{
            maker_id          : 0x2::object::id<OCMaker>(arg0),
            treasury_id       : v0,
            maker_creator     : arg0.creator,
            payer             : v1,
            recipe_hash       : arg5,
            license_kind      : arg0.policy.license_kind,
            royalty_bps       : arg0.policy.royalty_bps,
            mint_price_atomic : arg0.mint_price_atomic,
        };
        0x2::event::emit<SoulMintAuthorized>(v3);
        v2
    }

    fun part_colors_equal(arg0: &PartRecord, arg1: &PartRecord) : bool {
        if (0x1::vector::length<0x1::string::String>(&arg0.colors) != 0x1::vector::length<0x1::string::String>(&arg1.colors)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.colors)) {
            if (!part_has_color(arg1, 0x1::vector::borrow<0x1::string::String>(&arg0.colors, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun part_has_color(arg0: &PartRecord, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.colors)) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.colors, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun part_last_bastion() : u8 {
        2
    }

    public fun part_left_right_pair() : u8 {
        1
    }

    public fun part_standard() : u8 {
        0
    }

    fun payment_coin_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun profile_id(arg0: &CreatorProfile) : 0x2::object::ID {
        0x2::object::id<CreatorProfile>(arg0)
    }

    public fun profile_owner(arg0: &CreatorProfile) : address {
        arg0.owner
    }

    public fun protocol_version() : u64 {
        3
    }

    fun publish_maker(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert!(arg0.part_count > 0, 6);
        assert!(arg0.item_count > 0, 12);
        assert_blob_id(&arg1);
        assert_publishable_structure(arg0);
        arg0.manifest_blob_id = arg1;
        arg0.published = true;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = OCMakerPublished{
            maker_id         : 0x2::object::id<OCMaker>(arg0),
            creator          : 0x2::tx_context::sender(arg3),
            manifest_blob_id : arg1,
            part_count       : arg0.part_count,
            item_count       : arg0.item_count,
        };
        0x2::event::emit<OCMakerPublished>(v0);
    }

    fun recipe_contains(arg0: &vector<RecipeSlot>, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RecipeSlot>(arg0)) {
            let v1 = 0x1::vector::borrow<RecipeSlot>(arg0, v0);
            let v2 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg2)) == 0 || &v1.item_key == arg2;
            if (&v1.part_key == arg1 && v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun recipe_slot_color_hex(arg0: &RecipeSlot) : &0x1::string::String {
        &arg0.color_hex
    }

    public fun recipe_slot_item_key(arg0: &RecipeSlot) : &0x1::string::String {
        &arg0.item_key
    }

    public fun recipe_slot_part_key(arg0: &RecipeSlot) : &0x1::string::String {
        &arg0.part_key
    }

    public fun recipe_slot_render_order(arg0: &RecipeSlot) : u64 {
        arg0.render_order
    }

    public fun royalty_policy_bps(arg0: &RoyaltyPolicySnapshot) : u16 {
        arg0.royalty_bps
    }

    public fun royalty_policy_maker_id(arg0: &RoyaltyPolicySnapshot) : 0x2::object::ID {
        arg0.maker_id
    }

    public fun royalty_policy_treasury_id(arg0: &RoyaltyPolicySnapshot) : 0x2::object::ID {
        arg0.treasury_id
    }

    fun set_maker_archived(arg0: &mut OCMaker, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.published, 3);
        arg0.archived = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = OCMakerArchiveChanged{
            maker_id : 0x2::object::id<OCMaker>(arg0),
            creator  : 0x2::tx_context::sender(arg3),
            archived : arg1,
        };
        0x2::event::emit<OCMakerArchiveChanged>(v0);
    }

    public fun share_managed_maker<T0>(arg0: OCMaker, arg1: MakerTreasury<T0>, arg2: MakerAdminCap) : MakerAdminCap {
        assert_maker_admin(&arg0, &arg2);
        assert_treasury_matches<T0>(&arg0, &arg1);
        assert!(arg0.published, 3);
        0x2::transfer::share_object<OCMaker>(arg0);
        0x2::transfer::share_object<MakerTreasury<T0>>(arg1);
        arg2
    }

    fun share_published_maker(arg0: OCMaker, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.published, 3);
        0x2::transfer::share_object<OCMaker>(arg0);
    }

    public fun treasury_balance<T0>(arg0: &MakerTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.revenue)
    }

    public fun treasury_id<T0>(arg0: &MakerTreasury<T0>) : 0x2::object::ID {
        0x2::object::id<MakerTreasury<T0>>(arg0)
    }

    public fun treasury_maker_id<T0>(arg0: &MakerTreasury<T0>) : 0x2::object::ID {
        arg0.maker_id
    }

    public fun treasury_total_collected<T0>(arg0: &MakerTreasury<T0>) : u64 {
        arg0.total_collected
    }

    public fun treasury_total_royalty_collected<T0>(arg0: &MakerTreasury<T0>) : u64 {
        arg0.total_royalty_collected
    }

    public fun treasury_total_withdrawn<T0>(arg0: &MakerTreasury<T0>) : u64 {
        arg0.total_withdrawn
    }

    public fun update_creator_profile(arg0: &mut CreatorProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0.owner, arg5);
        assert_non_empty(&arg1);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 2000);
        assert_max_bytes(&arg3, 512);
        arg0.display_name = arg1;
        arg0.bio = arg2;
        arg0.avatar_url = arg3;
        arg0.payout_address = arg4;
    }

    fun update_maker_metadata(arg0: &mut OCMaker, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert_non_empty(&arg1);
        assert_max_bytes(&arg1, 128);
        assert_max_bytes(&arg2, 2000);
        assert_max_bytes(&arg3, 512);
        assert_max_bytes(&arg4, 512);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.cover_url = arg3;
        arg0.manifest_blob_id = arg4;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = OCMakerMetadataUpdated{
            maker_id : 0x2::object::id<OCMaker>(arg0),
            updater  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<OCMakerMetadataUpdated>(v0);
    }

    fun update_maker_policy(arg0: &mut OCMaker, arg1: u8, arg2: u16, arg3: bool, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_editable(arg0);
        assert_valid_royalty(arg2);
        assert_valid_license_kind(arg1);
        let v0 = LicensePolicy{
            license_kind         : arg1,
            royalty_bps          : arg2,
            commercial_allowed   : arg3,
            remix_allowed        : arg4,
            attribution_required : arg5,
        };
        arg0.policy = v0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg6);
    }

    public fun withdraw_maker_revenue<T0>(arg0: &MakerAdminCap, arg1: &OCMaker, arg2: &mut MakerTreasury<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_maker_admin(arg1, arg0);
        assert_treasury_matches<T0>(arg1, arg2);
        assert!(arg3 > 0 && arg3 <= 0x2::balance::value<T0>(&arg2.revenue), 39);
        arg2.total_withdrawn = arg2.total_withdrawn + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.revenue, arg3, arg5), arg4);
        let v0 = MakerRevenueWithdrawn{
            maker_id    : 0x2::object::id<OCMaker>(arg1),
            treasury_id : 0x2::object::id<MakerTreasury<T0>>(arg2),
            operator    : 0x2::tx_context::sender(arg5),
            recipient   : arg4,
            amount      : arg3,
        };
        0x2::event::emit<MakerRevenueWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

