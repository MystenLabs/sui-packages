module 0xc4eb339c26f7d48d803a369c0da9aff09db346ba62916b915eb68df74d808b76::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        mint_price_mist: u64,
        mint_enabled: bool,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct StatBlock has copy, drop, store {
        stamina: u64,
        shooting: u64,
        strength: u64,
        stealth: u64,
        flying: u64,
        driving: u64,
        lung_capacity: u64,
    }

    struct Appearance has copy, drop, store {
        frame_type: u8,
        skin_tone: u8,
        hair_type: u8,
        hair_color: u8,
        height_class: u8,
        body_type: u8,
        face_style: u8,
        eye_color: u8,
        eye_style: u8,
        mouth_style: u8,
        facial_hair: u8,
    }

    struct BehaviorProfile has copy, drop, store {
        expression_profile: u8,
        voice_type: u8,
        style_type: u8,
        idle_style: u8,
        walk_style: u8,
        base_emote_pack: u8,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: vector<Attribute>,
        level: u64,
        xp: u64,
        unspent_stat_points: u64,
        appearance: Appearance,
        behavior: BehaviorProfile,
        base_stats: StatBlock,
        effective_stats: StatBlock,
        base_model_uri: 0x1::string::String,
        portrait_uri: 0x1::string::String,
    }

    struct Attachment has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        slot: u8,
        category: u8,
        subtype: 0x1::string::String,
        model_uri: 0x1::string::String,
        texture_uri: 0x1::string::String,
        animation_profile: 0x1::string::String,
        interaction_type: u8,
        hold_anchor: u8,
        bonus_stats: StatBlock,
    }

    struct AvatarMinted has copy, drop {
        avatar_id: 0x2::object::ID,
        owner: address,
    }

    struct AttachmentMinted has copy, drop {
        attachment_id: 0x2::object::ID,
        owner: address,
        slot: u8,
        category: u8,
        interaction_type: u8,
    }

    struct Equipped has copy, drop {
        avatar_id: 0x2::object::ID,
        attachment_id: 0x2::object::ID,
        owner: address,
        slot: u8,
    }

    struct Unequipped has copy, drop {
        avatar_id: 0x2::object::ID,
        attachment_id: 0x2::object::ID,
        owner: address,
        slot: u8,
    }

    struct XpGained has copy, drop {
        avatar_id: 0x2::object::ID,
        gained_xp: u64,
        new_xp: u64,
        old_level: u64,
        new_level: u64,
        gained_stat_points: u64,
        new_unspent_stat_points: u64,
    }

    struct StatPointsSpent has copy, drop {
        avatar_id: 0x2::object::ID,
        spent_points: u64,
        remaining_points: u64,
    }

    struct StatsUpdated has copy, drop {
        avatar_id: 0x2::object::ID,
        level: u64,
        xp: u64,
        unspent_stat_points: u64,
        stamina: u64,
        shooting: u64,
        strength: u64,
        stealth: u64,
        flying: u64,
        driving: u64,
        lung_capacity: u64,
    }

    struct AppearanceUpdated has copy, drop {
        avatar_id: 0x2::object::ID,
    }

    struct BehaviorUpdated has copy, drop {
        avatar_id: 0x2::object::ID,
    }

    struct RenderUrisUpdated has copy, drop {
        avatar_id: 0x2::object::ID,
    }

    struct MarketMetadataUpdated has copy, drop {
        avatar_id: 0x2::object::ID,
    }

    fun add_stats(arg0: &StatBlock, arg1: &StatBlock) : StatBlock {
        StatBlock{
            stamina       : add_with_cap(arg0.stamina, arg1.stamina, 5000000, 36),
            shooting      : add_with_cap(arg0.shooting, arg1.shooting, 5000000, 36),
            strength      : add_with_cap(arg0.strength, arg1.strength, 5000000, 36),
            stealth       : add_with_cap(arg0.stealth, arg1.stealth, 5000000, 36),
            flying        : add_with_cap(arg0.flying, arg1.flying, 5000000, 36),
            driving       : add_with_cap(arg0.driving, arg1.driving, 5000000, 36),
            lung_capacity : add_with_cap(arg0.lung_capacity, arg1.lung_capacity, 5000000, 36),
        }
    }

    fun add_with_cap(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 <= arg2, arg3);
        assert!(arg1 <= arg2, arg3);
        assert!(arg0 <= arg2 - arg1, arg3);
        arg0 + arg1
    }

    public entry fun admin_grant_xp(arg0: &AdminCap, arg1: &mut Avatar, arg2: u64) {
        let v0 = arg1.level;
        arg1.xp = add_with_cap(arg1.xp, arg2, 1000000000, 35);
        let v1 = level_from_xp(arg1.xp);
        assert!(v1 >= v0, 25);
        let v2 = stat_points_between_levels(v0, v1);
        arg1.level = v1;
        arg1.unspent_stat_points = add_with_cap(arg1.unspent_stat_points, v2, 1000000, 37);
        recompute_effective_stats(arg1);
        let v3 = XpGained{
            avatar_id               : 0x2::object::id<Avatar>(arg1),
            gained_xp               : arg2,
            new_xp                  : arg1.xp,
            old_level               : v0,
            new_level               : v1,
            gained_stat_points      : v2,
            new_unspent_stat_points : arg1.unspent_stat_points,
        };
        0x2::event::emit<XpGained>(v3);
        emit_stats_updated(arg1);
    }

    public entry fun admin_mint_attachment(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u8, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        validate_attachment_strings(&arg2, &arg5, &arg6, &arg7, &arg8);
        assert!(valid_slot(arg3), 0);
        assert!(valid_item_category(arg4), 22);
        assert!(valid_interaction_type(arg9), 23);
        assert!(valid_hold_anchor(arg10), 24);
        assert!(slot_accepts_category(arg3, arg4), 29);
        assert!(attachment_configuration_is_valid(arg3, arg4, arg9, arg10), 30);
        validate_effective_stat_value(arg11);
        validate_effective_stat_value(arg12);
        validate_effective_stat_value(arg13);
        validate_effective_stat_value(arg14);
        validate_effective_stat_value(arg15);
        validate_effective_stat_value(arg16);
        validate_effective_stat_value(arg17);
        let v0 = StatBlock{
            stamina       : arg11,
            shooting      : arg12,
            strength      : arg13,
            stealth       : arg14,
            flying        : arg15,
            driving       : arg16,
            lung_capacity : arg17,
        };
        let v1 = Attachment{
            id                : 0x2::object::new(arg18),
            name              : arg2,
            slot              : arg3,
            category          : arg4,
            subtype           : arg5,
            model_uri         : arg6,
            texture_uri       : arg7,
            animation_profile : arg8,
            interaction_type  : arg9,
            hold_anchor       : arg10,
            bonus_stats       : v0,
        };
        let v2 = AttachmentMinted{
            attachment_id    : 0x2::object::id<Attachment>(&v1),
            owner            : arg1,
            slot             : arg3,
            category         : arg4,
            interaction_type : arg9,
        };
        0x2::event::emit<AttachmentMinted>(v2);
        0x2::transfer::public_transfer<Attachment>(v1, arg1);
    }

    public entry fun admin_mint_avatar(arg0: &AdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<Attribute>, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u8, arg12: u8, arg13: u8, arg14: u8, arg15: u8, arg16: u8, arg17: u8, arg18: u8, arg19: u8, arg20: u8, arg21: u8, arg22: u8, arg23: 0x1::string::String, arg24: 0x1::string::String, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &mut 0x2::tx_context::TxContext) {
        validate_avatar_market_metadata(&arg2, &arg3, &arg4, &arg23, &arg24, &arg5);
        validate_appearance(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        validate_behavior(arg17, arg18, arg19, arg20, arg21, arg22);
        validate_base_stat_value(arg25);
        validate_base_stat_value(arg26);
        validate_base_stat_value(arg27);
        validate_base_stat_value(arg28);
        validate_base_stat_value(arg29);
        validate_base_stat_value(arg30);
        validate_base_stat_value(arg31);
        let v0 = StatBlock{
            stamina       : arg25,
            shooting      : arg26,
            strength      : arg27,
            stealth       : arg28,
            flying        : arg29,
            driving       : arg30,
            lung_capacity : arg31,
        };
        let v1 = Appearance{
            frame_type   : arg6,
            skin_tone    : arg7,
            hair_type    : arg8,
            hair_color   : arg9,
            height_class : arg10,
            body_type    : arg11,
            face_style   : arg12,
            eye_color    : arg13,
            eye_style    : arg14,
            mouth_style  : arg15,
            facial_hair  : arg16,
        };
        let v2 = BehaviorProfile{
            expression_profile : arg17,
            voice_type         : arg18,
            style_type         : arg19,
            idle_style         : arg20,
            walk_style         : arg21,
            base_emote_pack    : arg22,
        };
        let v3 = Avatar{
            id                  : 0x2::object::new(arg32),
            name                : arg2,
            description         : arg3,
            image_url           : arg4,
            attributes          : arg5,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            appearance          : v1,
            behavior            : v2,
            base_stats          : v0,
            effective_stats     : v0,
            base_model_uri      : arg23,
            portrait_uri        : arg24,
        };
        let v4 = 0x2::object::id<Avatar>(&v3);
        let v5 = AvatarMinted{
            avatar_id : v4,
            owner     : arg1,
        };
        0x2::event::emit<AvatarMinted>(v5);
        let v6 = StatsUpdated{
            avatar_id           : v4,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            stamina             : v0.stamina,
            shooting            : v0.shooting,
            strength            : v0.strength,
            stealth             : v0.stealth,
            flying              : v0.flying,
            driving             : v0.driving,
            lung_capacity       : v0.lung_capacity,
        };
        0x2::event::emit<StatsUpdated>(v6);
        0x2::transfer::public_transfer<Avatar>(v3, arg1);
    }

    public fun appearance_of(arg0: &Avatar) : Appearance {
        arg0.appearance
    }

    fun attachment_configuration_is_valid(arg0: u8, arg1: u8, arg2: u8, arg3: u8) : bool {
        if (slot_accepts_category(arg0, arg1)) {
            if (interaction_compatible_with_category(arg1, arg2)) {
                hold_anchor_compatible_with_slot(arg0, arg3)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun attachment_id(arg0: &Avatar, arg1: u8) : 0x1::option::Option<0x2::object::ID> {
        assert!(valid_slot(arg1), 0);
        0x2::dynamic_object_field::id<u8>(&arg0.id, arg1)
    }

    public fun attributes_of(arg0: &Avatar) : &vector<Attribute> {
        &arg0.attributes
    }

    public fun base_model_uri_of(arg0: &Avatar) : &0x1::string::String {
        &arg0.base_model_uri
    }

    public fun base_stats_of(arg0: &Avatar) : StatBlock {
        arg0.base_stats
    }

    public fun behavior_of(arg0: &Avatar) : BehaviorProfile {
        arg0.behavior
    }

    fun compute_total_stats(arg0: &Avatar) : StatBlock {
        let v0 = slot_bonus(arg0, 0);
        let v1 = add_stats(&arg0.base_stats, &v0);
        let v2 = slot_bonus(arg0, 1);
        let v3 = add_stats(&v1, &v2);
        let v4 = slot_bonus(arg0, 2);
        let v5 = add_stats(&v3, &v4);
        let v6 = slot_bonus(arg0, 3);
        let v7 = add_stats(&v5, &v6);
        let v8 = slot_bonus(arg0, 4);
        let v9 = add_stats(&v7, &v8);
        let v10 = slot_bonus(arg0, 5);
        let v11 = add_stats(&v9, &v10);
        let v12 = slot_bonus(arg0, 6);
        let v13 = add_stats(&v11, &v12);
        let v14 = slot_bonus(arg0, 7);
        let v15 = add_stats(&v13, &v14);
        let v16 = slot_bonus(arg0, 8);
        let v17 = add_stats(&v15, &v16);
        let v18 = slot_bonus(arg0, 9);
        let v19 = add_stats(&v17, &v18);
        let v20 = slot_bonus(arg0, 10);
        let v21 = add_stats(&v19, &v20);
        let v22 = slot_bonus(arg0, 11);
        let v23 = add_stats(&v21, &v22);
        let v24 = slot_bonus(arg0, 12);
        let v25 = add_stats(&v23, &v24);
        let v26 = slot_bonus(arg0, 13);
        let v27 = add_stats(&v25, &v26);
        let v28 = slot_bonus(arg0, 14);
        let v29 = add_stats(&v27, &v28);
        let v30 = slot_bonus(arg0, 15);
        let v31 = add_stats(&v29, &v30);
        let v32 = slot_bonus(arg0, 16);
        let v33 = add_stats(&v31, &v32);
        let v34 = slot_bonus(arg0, 17);
        let v35 = add_stats(&v33, &v34);
        let v36 = slot_bonus(arg0, 18);
        add_stats(&v35, &v36)
    }

    public entry fun create_avatar_transfer_policy_with_lock_rule(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<Avatar>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun cumulative_stat_points_for_level(arg0: u64) : u64 {
        if (arg0 <= 1) {
            return 0
        };
        arg0 - 1 + arg0 / 5
    }

    public fun description_of(arg0: &Avatar) : &0x1::string::String {
        &arg0.description
    }

    public fun effective_stats_of(arg0: &Avatar) : StatBlock {
        arg0.effective_stats
    }

    fun emit_stats_updated(arg0: &Avatar) {
        let v0 = arg0.effective_stats;
        let v1 = StatsUpdated{
            avatar_id           : 0x2::object::id<Avatar>(arg0),
            level               : arg0.level,
            xp                  : arg0.xp,
            unspent_stat_points : arg0.unspent_stat_points,
            stamina             : v0.stamina,
            shooting            : v0.shooting,
            strength            : v0.strength,
            stealth             : v0.stealth,
            flying              : v0.flying,
            driving             : v0.driving,
            lung_capacity       : v0.lung_capacity,
        };
        0x2::event::emit<StatsUpdated>(v1);
    }

    public entry fun equip(arg0: &mut Avatar, arg1: Attachment, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<Avatar>(arg0);
        let v2 = arg1.slot;
        let v3 = arg1.category;
        let v4 = arg1.interaction_type;
        let v5 = arg1.hold_anchor;
        assert!(valid_slot(v2), 0);
        assert!(valid_item_category(v3), 22);
        assert!(valid_interaction_type(v4), 23);
        assert!(valid_hold_anchor(v5), 24);
        assert!(slot_accepts_category(v2, v3), 29);
        assert!(attachment_configuration_is_valid(v2, v3, v4, v5), 30);
        if (v2 == 8 || v2 == 9) {
            let v6 = other_hand_slot(v2);
            let v7 = 0x2::dynamic_object_field::exists_<u8>(&arg0.id, v6) && 0x2::dynamic_object_field::borrow<u8, Attachment>(&arg0.id, v6).hold_anchor == 3;
            if (v5 == 3 || v7) {
                remove_slot_if_present(arg0, v6, v0, v1);
            };
        };
        remove_slot_if_present(arg0, v2, v0, v1);
        0x2::dynamic_object_field::add<u8, Attachment>(&mut arg0.id, v2, arg1);
        recompute_effective_stats(arg0);
        let v8 = Equipped{
            avatar_id     : v1,
            attachment_id : 0x2::object::id<Attachment>(&arg1),
            owner         : v0,
            slot          : v2,
        };
        0x2::event::emit<Equipped>(v8);
        emit_stats_updated(arg0);
    }

    public fun has_attachment(arg0: &Avatar, arg1: u8) : bool {
        assert!(valid_slot(arg1), 0);
        0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg1)
    }

    fun hold_anchor_compatible_with_slot(arg0: u8, arg1: u8) : bool {
        if (arg0 == 8) {
            if (arg1 == 0) {
                true
            } else if (arg1 == 1) {
                true
            } else {
                arg1 == 3
            }
        } else if (arg0 == 9) {
            if (arg1 == 0) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 3
            }
        } else {
            arg0 == 10 && (arg1 == 0 || arg1 == 4) || arg0 == 15 && (arg1 == 0 || arg1 == 5) || arg1 == 0
        }
    }

    public fun image_url_of(arg0: &Avatar) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Avatar>(&v0, arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = MintConfig{
            id              : 0x2::object::new(arg1),
            mint_price_mist : 0,
            mint_enabled    : false,
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<AdminCap>(v3, v5);
        0x2::transfer::share_object<MintConfig>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Avatar>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Avatar>>(v2, v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v5);
    }

    fun interaction_compatible_with_category(arg0: u8, arg1: u8) : bool {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 6) {
            true
        } else {
            arg0 == 7
        };
        if (v0) {
            arg1 == 0
        } else if (arg0 == 1 || arg0 == 5) {
            if (arg1 == 0) {
                true
            } else if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else if (arg1 == 3) {
                true
            } else if (arg1 == 8) {
                true
            } else {
                arg1 == 9
            }
        } else if (arg0 == 2) {
            if (arg1 == 4) {
                true
            } else if (arg1 == 5) {
                true
            } else {
                arg1 == 6
            }
        } else {
            arg0 == 3 && (arg1 == 0 || arg1 == 7)
        }
    }

    public fun level_from_xp(arg0: u64) : u64 {
        if (arg0 < 900) {
            return 1 + arg0 / 100
        };
        let v0 = arg0 - 900;
        if (v0 < 3750) {
            return 10 + v0 / 250
        };
        let v1 = v0 - 3750;
        if (v1 < 12500) {
            return 25 + v1 / 500
        };
        let v2 = v1 - 12500;
        if (v2 < 50000) {
            return 50 + v2 / 1000
        };
        100 + (v2 - 50000) / 2000
    }

    public entry fun mint_avatar(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<Attribute>, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u8, arg12: u8, arg13: u8, arg14: u8, arg15: u8, arg16: u8, arg17: u8, arg18: u8, arg19: u8, arg20: u8, arg21: u8, arg22: u8, arg23: 0x1::string::String, arg24: 0x1::string::String, arg25: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 2);
        validate_avatar_market_metadata(&arg2, &arg3, &arg4, &arg23, &arg24, &arg5);
        validate_appearance(arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        validate_behavior(arg17, arg18, arg19, arg20, arg21, arg22);
        let v0 = arg0.mint_price_mist;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 3);
        let v2 = 0x2::tx_context::sender(arg25);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - v0, arg25), v2);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = starter_stats();
        let v4 = Appearance{
            frame_type   : arg6,
            skin_tone    : arg7,
            hair_type    : arg8,
            hair_color   : arg9,
            height_class : arg10,
            body_type    : arg11,
            face_style   : arg12,
            eye_color    : arg13,
            eye_style    : arg14,
            mouth_style  : arg15,
            facial_hair  : arg16,
        };
        let v5 = BehaviorProfile{
            expression_profile : arg17,
            voice_type         : arg18,
            style_type         : arg19,
            idle_style         : arg20,
            walk_style         : arg21,
            base_emote_pack    : arg22,
        };
        let v6 = Avatar{
            id                  : 0x2::object::new(arg25),
            name                : arg2,
            description         : arg3,
            image_url           : arg4,
            attributes          : arg5,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            appearance          : v4,
            behavior            : v5,
            base_stats          : v3,
            effective_stats     : v3,
            base_model_uri      : arg23,
            portrait_uri        : arg24,
        };
        let v7 = 0x2::object::id<Avatar>(&v6);
        let v8 = AvatarMinted{
            avatar_id : v7,
            owner     : v2,
        };
        0x2::event::emit<AvatarMinted>(v8);
        let v9 = StatsUpdated{
            avatar_id           : v7,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            stamina             : v3.stamina,
            shooting            : v3.shooting,
            strength            : v3.strength,
            stealth             : v3.stealth,
            flying              : v3.flying,
            driving             : v3.driving,
            lung_capacity       : v3.lung_capacity,
        };
        0x2::event::emit<StatsUpdated>(v9);
        0x2::transfer::public_transfer<Avatar>(v6, v2);
    }

    public entry fun mint_avatar_free(arg0: &mut MintConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<Attribute>, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u8, arg12: u8, arg13: u8, arg14: u8, arg15: u8, arg16: u8, arg17: u8, arg18: u8, arg19: u8, arg20: u8, arg21: u8, arg22: 0x1::string::String, arg23: 0x1::string::String, arg24: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 2);
        assert!(arg0.mint_price_mist == 0, 4);
        validate_avatar_market_metadata(&arg1, &arg2, &arg3, &arg22, &arg23, &arg4);
        validate_appearance(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        validate_behavior(arg16, arg17, arg18, arg19, arg20, arg21);
        let v0 = 0x2::tx_context::sender(arg24);
        let v1 = starter_stats();
        let v2 = Appearance{
            frame_type   : arg5,
            skin_tone    : arg6,
            hair_type    : arg7,
            hair_color   : arg8,
            height_class : arg9,
            body_type    : arg10,
            face_style   : arg11,
            eye_color    : arg12,
            eye_style    : arg13,
            mouth_style  : arg14,
            facial_hair  : arg15,
        };
        let v3 = BehaviorProfile{
            expression_profile : arg16,
            voice_type         : arg17,
            style_type         : arg18,
            idle_style         : arg19,
            walk_style         : arg20,
            base_emote_pack    : arg21,
        };
        let v4 = Avatar{
            id                  : 0x2::object::new(arg24),
            name                : arg1,
            description         : arg2,
            image_url           : arg3,
            attributes          : arg4,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            appearance          : v2,
            behavior            : v3,
            base_stats          : v1,
            effective_stats     : v1,
            base_model_uri      : arg22,
            portrait_uri        : arg23,
        };
        let v5 = 0x2::object::id<Avatar>(&v4);
        let v6 = AvatarMinted{
            avatar_id : v5,
            owner     : v0,
        };
        0x2::event::emit<AvatarMinted>(v6);
        let v7 = StatsUpdated{
            avatar_id           : v5,
            level               : 1,
            xp                  : 0,
            unspent_stat_points : 0,
            stamina             : v1.stamina,
            shooting            : v1.shooting,
            strength            : v1.strength,
            stealth             : v1.stealth,
            flying              : v1.flying,
            driving             : v1.driving,
            lung_capacity       : v1.lung_capacity,
        };
        0x2::event::emit<StatsUpdated>(v7);
        0x2::transfer::public_transfer<Avatar>(v4, v0);
    }

    public fun mint_is_enabled(arg0: &MintConfig) : bool {
        arg0.mint_enabled
    }

    public fun mint_price(arg0: &MintConfig) : u64 {
        arg0.mint_price_mist
    }

    public fun name_of(arg0: &Avatar) : &0x1::string::String {
        &arg0.name
    }

    fun other_hand_slot(arg0: u8) : u8 {
        if (arg0 == 8) {
            9
        } else {
            8
        }
    }

    public entry fun pause_mint(arg0: &AdminCap, arg1: &mut MintConfig) {
        arg1.mint_enabled = false;
    }

    public fun portrait_uri_of(arg0: &Avatar) : &0x1::string::String {
        &arg0.portrait_uri
    }

    fun recompute_effective_stats(arg0: &mut Avatar) {
        arg0.effective_stats = compute_total_stats(arg0);
    }

    fun remove_slot_if_present(arg0: &mut Avatar, arg1: u8, arg2: address, arg3: 0x2::object::ID) {
        if (0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_object_field::remove<u8, Attachment>(&mut arg0.id, arg1);
            0x2::transfer::public_transfer<Attachment>(v0, arg2);
            let v1 = Unequipped{
                avatar_id     : arg3,
                attachment_id : 0x2::object::id<Attachment>(&v0),
                owner         : arg2,
                slot          : arg1,
            };
            0x2::event::emit<Unequipped>(v1);
        };
    }

    public entry fun resume_mint(arg0: &AdminCap, arg1: &mut MintConfig) {
        arg1.mint_enabled = true;
    }

    public entry fun set_mint_price(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.mint_price_mist = arg2;
    }

    fun slot_accepts_category(arg0: u8, arg1: u8) : bool {
        if (arg1 == 0) {
            if (arg0 == 0) {
                true
            } else if (arg0 == 1) {
                true
            } else if (arg0 == 2) {
                true
            } else if (arg0 == 3) {
                true
            } else if (arg0 == 4) {
                true
            } else if (arg0 == 5) {
                true
            } else if (arg0 == 6) {
                true
            } else if (arg0 == 7) {
                true
            } else if (arg0 == 8) {
                true
            } else if (arg0 == 9) {
                true
            } else if (arg0 == 10) {
                true
            } else if (arg0 == 11) {
                true
            } else if (arg0 == 12) {
                true
            } else {
                arg0 == 13
            }
        } else if (arg1 == 1 || arg1 == 5) {
            if (arg0 == 8) {
                true
            } else if (arg0 == 9) {
                true
            } else {
                arg0 == 10
            }
        } else {
            arg1 == 2 && arg0 == 15 || arg1 == 3 && arg0 == 14 || arg1 == 4 && arg0 == 16 || arg1 == 6 && arg0 == 17 || arg1 == 7 && arg0 == 18
        }
    }

    fun slot_bonus(arg0: &Avatar, arg1: u8) : StatBlock {
        if (0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::borrow<u8, Attachment>(&arg0.id, arg1).bonus_stats
        } else {
            zero_stats()
        }
    }

    public entry fun spend_stat_points(arg0: &mut Avatar, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = add_with_cap(add_with_cap(add_with_cap(add_with_cap(add_with_cap(add_with_cap(arg1, arg2, arg0.unspent_stat_points, 26), arg3, arg0.unspent_stat_points, 26), arg4, arg0.unspent_stat_points, 26), arg5, arg0.unspent_stat_points, 26), arg6, arg0.unspent_stat_points, 26), arg7, arg0.unspent_stat_points, 26);
        assert!(v0 > 0, 27);
        assert!(arg0.unspent_stat_points >= v0, 26);
        arg0.base_stats.stamina = add_with_cap(arg0.base_stats.stamina, arg1, 1000000, 36);
        arg0.base_stats.shooting = add_with_cap(arg0.base_stats.shooting, arg2, 1000000, 36);
        arg0.base_stats.strength = add_with_cap(arg0.base_stats.strength, arg3, 1000000, 36);
        arg0.base_stats.stealth = add_with_cap(arg0.base_stats.stealth, arg4, 1000000, 36);
        arg0.base_stats.flying = add_with_cap(arg0.base_stats.flying, arg5, 1000000, 36);
        arg0.base_stats.driving = add_with_cap(arg0.base_stats.driving, arg6, 1000000, 36);
        arg0.base_stats.lung_capacity = add_with_cap(arg0.base_stats.lung_capacity, arg7, 1000000, 36);
        arg0.unspent_stat_points = arg0.unspent_stat_points - v0;
        recompute_effective_stats(arg0);
        let v1 = StatPointsSpent{
            avatar_id        : 0x2::object::id<Avatar>(arg0),
            spent_points     : v0,
            remaining_points : arg0.unspent_stat_points,
        };
        0x2::event::emit<StatPointsSpent>(v1);
        emit_stats_updated(arg0);
    }

    fun starter_stats() : StatBlock {
        StatBlock{
            stamina       : 10,
            shooting      : 10,
            strength      : 10,
            stealth       : 10,
            flying        : 10,
            driving       : 10,
            lung_capacity : 10,
        }
    }

    fun stat_points_between_levels(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        cumulative_stat_points_for_level(arg1) - cumulative_stat_points_for_level(arg0)
    }

    public fun total_driving(arg0: &Avatar) : u64 {
        arg0.effective_stats.driving
    }

    public fun total_flying(arg0: &Avatar) : u64 {
        arg0.effective_stats.flying
    }

    public fun total_lung_capacity(arg0: &Avatar) : u64 {
        arg0.effective_stats.lung_capacity
    }

    public fun total_shooting(arg0: &Avatar) : u64 {
        arg0.effective_stats.shooting
    }

    public fun total_stamina(arg0: &Avatar) : u64 {
        arg0.effective_stats.stamina
    }

    public fun total_stats(arg0: &Avatar) : StatBlock {
        arg0.effective_stats
    }

    public fun total_stealth(arg0: &Avatar) : u64 {
        arg0.effective_stats.stealth
    }

    public fun total_strength(arg0: &Avatar) : u64 {
        arg0.effective_stats.strength
    }

    public fun treasury_balance(arg0: &MintConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public entry fun unequip(arg0: &mut Avatar, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<Avatar>(arg0);
        assert!(valid_slot(arg1), 0);
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg1), 1);
        let v2 = 0x2::dynamic_object_field::remove<u8, Attachment>(&mut arg0.id, arg1);
        0x2::transfer::public_transfer<Attachment>(v2, v0);
        recompute_effective_stats(arg0);
        let v3 = Unequipped{
            avatar_id     : v1,
            attachment_id : 0x2::object::id<Attachment>(&v2),
            owner         : v0,
            slot          : arg1,
        };
        0x2::event::emit<Unequipped>(v3);
        emit_stats_updated(arg0);
    }

    public fun unspent_stat_points_of(arg0: &Avatar) : u64 {
        arg0.unspent_stat_points
    }

    public entry fun update_appearance(arg0: &mut Avatar, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8, arg11: u8) {
        validate_appearance(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = Appearance{
            frame_type   : arg1,
            skin_tone    : arg2,
            hair_type    : arg3,
            hair_color   : arg4,
            height_class : arg5,
            body_type    : arg6,
            face_style   : arg7,
            eye_color    : arg8,
            eye_style    : arg9,
            mouth_style  : arg10,
            facial_hair  : arg11,
        };
        arg0.appearance = v0;
        let v1 = AppearanceUpdated{avatar_id: 0x2::object::id<Avatar>(arg0)};
        0x2::event::emit<AppearanceUpdated>(v1);
    }

    public entry fun update_behavior(arg0: &mut Avatar, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8) {
        validate_behavior(arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = BehaviorProfile{
            expression_profile : arg1,
            voice_type         : arg2,
            style_type         : arg3,
            idle_style         : arg4,
            walk_style         : arg5,
            base_emote_pack    : arg6,
        };
        arg0.behavior = v0;
        let v1 = BehaviorUpdated{avatar_id: 0x2::object::id<Avatar>(arg0)};
        0x2::event::emit<BehaviorUpdated>(v1);
    }

    public entry fun update_market_metadata(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<Attribute>) {
        validate_required_string(&arg1, 280);
        validate_required_uri(&arg2);
        validate_attributes(&arg3);
        arg0.description = arg1;
        arg0.image_url = arg2;
        arg0.attributes = arg3;
        let v0 = MarketMetadataUpdated{avatar_id: 0x2::object::id<Avatar>(arg0)};
        0x2::event::emit<MarketMetadataUpdated>(v0);
    }

    public entry fun update_render_uris(arg0: &mut Avatar, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        validate_required_uri(&arg1);
        validate_required_uri(&arg2);
        arg0.base_model_uri = arg1;
        arg0.portrait_uri = arg2;
        let v0 = RenderUrisUpdated{avatar_id: 0x2::object::id<Avatar>(arg0)};
        0x2::event::emit<RenderUrisUpdated>(v0);
    }

    fun valid_body_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    fun valid_emote_pack(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun valid_expression_profile(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_eye_color(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_eye_style(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_face_style(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_facial_hair(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun valid_frame_type(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    fun valid_hair_color(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else {
            arg0 == 9
        }
    }

    fun valid_hair_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else {
            arg0 == 8
        }
    }

    fun valid_height_class(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    fun valid_hold_anchor(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_idle_style(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun valid_interaction_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else {
            arg0 == 9
        }
    }

    fun valid_item_category(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else {
            arg0 == 7
        }
    }

    fun valid_mouth_style(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_skin_tone(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun valid_slot(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else if (arg0 == 15) {
            true
        } else if (arg0 == 16) {
            true
        } else if (arg0 == 17) {
            true
        } else {
            arg0 == 18
        }
    }

    fun valid_style_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_voice_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        }
    }

    fun valid_walk_style(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else {
            arg0 == 4
        }
    }

    fun validate_appearance(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: u8, arg9: u8, arg10: u8) {
        assert!(valid_frame_type(arg0), 5);
        assert!(valid_skin_tone(arg1), 6);
        assert!(valid_hair_type(arg2), 7);
        assert!(valid_hair_color(arg3), 8);
        assert!(valid_height_class(arg4), 9);
        assert!(valid_body_type(arg5), 10);
        assert!(valid_face_style(arg6), 11);
        assert!(valid_eye_color(arg7), 12);
        assert!(valid_eye_style(arg8), 13);
        assert!(valid_mouth_style(arg9), 14);
        assert!(valid_facial_hair(arg10), 15);
    }

    fun validate_attachment_strings(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) {
        validate_required_string(arg0, 32);
        validate_required_string(arg1, 32);
        validate_required_uri(arg2);
        validate_optional_uri(arg3);
        validate_optional_string(arg4, 64);
    }

    fun validate_attributes(arg0: &vector<Attribute>) {
        let v0 = 0x1::vector::length<Attribute>(arg0);
        assert!(v0 <= 32, 38);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Attribute>(arg0, v1);
            assert!(0x1::string::length(&v2.trait_type) > 0, 39);
            assert!(0x1::string::length(&v2.trait_type) <= 32, 39);
            assert!(0x1::string::length(&v2.value) > 0, 39);
            assert!(0x1::string::length(&v2.value) <= 64, 39);
            v1 = v1 + 1;
        };
    }

    fun validate_avatar_market_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: &vector<Attribute>) {
        validate_required_string(arg0, 32);
        validate_required_string(arg1, 280);
        validate_required_uri(arg2);
        validate_required_uri(arg3);
        validate_required_uri(arg4);
        validate_attributes(arg5);
    }

    fun validate_base_stat_value(arg0: u64) {
        assert!(arg0 <= 1000000, 36);
    }

    fun validate_behavior(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) {
        assert!(valid_expression_profile(arg0), 16);
        assert!(valid_voice_type(arg1), 17);
        assert!(valid_style_type(arg2), 18);
        assert!(valid_idle_style(arg3), 19);
        assert!(valid_walk_style(arg4), 20);
        assert!(valid_emote_pack(arg5), 21);
    }

    fun validate_effective_stat_value(arg0: u64) {
        assert!(arg0 <= 5000000, 36);
    }

    fun validate_optional_string(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::string::length(arg0) <= arg1, 32);
    }

    fun validate_optional_uri(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) <= 512, 34);
    }

    fun validate_required_string(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0, 31);
        assert!(v0 <= arg1, 32);
    }

    fun validate_required_uri(arg0: &0x1::string::String) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0, 33);
        assert!(v0 <= 512, 34);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury) >= arg2, 28);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun zero_stats() : StatBlock {
        StatBlock{
            stamina       : 0,
            shooting      : 0,
            strength      : 0,
            stealth       : 0,
            flying        : 0,
            driving       : 0,
            lung_capacity : 0,
        }
    }

    // decompiled from Move bytecode v6
}

