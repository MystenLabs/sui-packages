module 0x835feb8894c3b666555efdfae0e0687e3291b9a7da741f896e43d3d07ab2cdaa::compatibility {
    struct COMPATIBILITY has drop {
        dummy_field: bool,
    }

    struct CompatibilityCollectible has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        edition: u64,
        background: 0x1::string::String,
        headwear: 0x1::string::String,
        hair: 0x1::string::String,
        eyewear: 0x1::string::String,
        face: 0x1::string::String,
        outfit: 0x1::string::String,
        accessory: 0x1::string::String,
        companion: 0x1::string::String,
        blood_type: 0x1::string::String,
        specialty: 0x1::string::String,
        clearance: 0x1::string::String,
        shift: 0x1::string::String,
        ward: 0x1::string::String,
        team_rank: u64,
        rarity_rank: u64,
        rarity: 0x1::string::String,
        rarity_score: 0x1::string::String,
    }

    struct EditionMetadata has copy, drop, store {
        edition: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        background: 0x1::string::String,
        headwear: 0x1::string::String,
        hair: 0x1::string::String,
        eyewear: 0x1::string::String,
        face: 0x1::string::String,
        outfit: 0x1::string::String,
        accessory: 0x1::string::String,
        companion: 0x1::string::String,
        blood_type: 0x1::string::String,
        specialty: 0x1::string::String,
        clearance: 0x1::string::String,
        shift: 0x1::string::String,
        ward: 0x1::string::String,
        team_rank: u64,
        rarity_rank: u64,
        rarity: 0x1::string::String,
        rarity_score: 0x1::string::String,
    }

    struct CollectionState has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        minted_count: u64,
        minted: vector<bool>,
        metadata: vector<EditionMetadata>,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct CollectibleMinted has copy, drop {
        object_id: address,
        edition: u64,
        minter: address,
    }

    fun build_attributes(arg0: &EditionMetadata) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Creator"), 0x1::string::utf8(b"Suimon"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Background"), arg0.background);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Headwear"), arg0.headwear);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Hair"), arg0.hair);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Eyewear"), arg0.eyewear);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Face"), arg0.face);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Outfit"), arg0.outfit);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Accessory"), arg0.accessory);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Companion"), arg0.companion);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Blood Type"), arg0.blood_type);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Specialty"), arg0.specialty);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Clearance"), arg0.clearance);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Shift"), arg0.shift);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Ward"), arg0.ward);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Team Rank"), 0x1::u64::to_string(arg0.team_rank));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity Rank"), 0x1::u64::to_string(arg0.rarity_rank));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), arg0.rarity);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity Score"), arg0.rarity_score);
        v0
    }

    fun choose_string(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) : 0x1::string::String {
        if (arg0 == 1) {
            arg1
        } else if (arg0 == 2) {
            arg2
        } else if (arg0 == 3) {
            arg3
        } else {
            arg4
        }
    }

    fun fixture_metadata(arg0: u64, arg1: 0x1::string::String) : EditionMetadata {
        assert!(arg0 >= 1 && arg0 <= 249, 2);
        let v0 = if (arg0 == 1) {
            85
        } else if (arg0 == 2) {
            62
        } else if (arg0 == 3) {
            35
        } else {
            12
        };
        let v1 = if (arg0 == 1) {
            85
        } else if (arg0 == 2) {
            62
        } else if (arg0 == 3) {
            35
        } else {
            12
        };
        EditionMetadata{
            edition      : arg0,
            name         : choose_string(arg0, 0x1::string::utf8(b"Compatibility Test #01"), 0x1::string::utf8(b"Compatibility Test #02"), 0x1::string::utf8(b"Compatibility Test #03"), 0x1::string::utf8(b"Compatibility Test #04")),
            description  : choose_string(arg0, 0x1::string::utf8(b"Compatibility Test #01 is a standalone test collectible created by Suimon for Sui Mainnet marketplace compatibility checks. Test asset only; not the official Mysten Medics collection."), 0x1::string::utf8(b"Compatibility Test #02 is a standalone test collectible created by Suimon for Sui Mainnet marketplace compatibility checks. Test asset only; not the official Mysten Medics collection."), 0x1::string::utf8(b"Compatibility Test #03 is a standalone test collectible created by Suimon for Sui Mainnet marketplace compatibility checks. Test asset only; not the official Mysten Medics collection."), 0x1::string::utf8(b"Compatibility Test #04 is a standalone test collectible created by Suimon for Sui Mainnet marketplace compatibility checks. Test asset only; not the official Mysten Medics collection.")),
            image_url    : arg1,
            background   : choose_string(arg0, 0x1::string::utf8(b"Purple"), 0x1::string::utf8(b"Blue"), 0x1::string::utf8(b"Green"), 0x1::string::utf8(b"Orange")),
            headwear     : choose_string(arg0, 0x1::string::utf8(b"Arc Cap"), 0x1::string::utf8(b"Wave Hood"), 0x1::string::utf8(b"Sprout Crown"), 0x1::string::utf8(b"Comet Ears")),
            hair         : choose_string(arg0, 0x1::string::utf8(b"Indigo"), 0x1::string::utf8(b"Slate"), 0x1::string::utf8(b"Mint"), 0x1::string::utf8(b"Copper")),
            eyewear      : choose_string(arg0, 0x1::string::utf8(b"Prism Visor"), 0x1::string::utf8(b"Twin Lenses"), 0x1::string::utf8(b"Leaf Shades"), 0x1::string::utf8(b"Solar Lens")),
            face         : choose_string(arg0, 0x1::string::utf8(b"Spark Smile"), 0x1::string::utf8(b"Calm Focus"), 0x1::string::utf8(b"Bright Grin"), 0x1::string::utf8(b"Bold Smile")),
            outfit       : choose_string(arg0, 0x1::string::utf8(b"Explorer Suit"), 0x1::string::utf8(b"Navigator Suit"), 0x1::string::utf8(b"Field Suit"), 0x1::string::utf8(b"Trail Suit")),
            accessory    : choose_string(arg0, 0x1::string::utf8(b"Signal Orb"), 0x1::string::utf8(b"Map Cube"), 0x1::string::utf8(b"Seed Compass"), 0x1::string::utf8(b"Beacon Tag")),
            companion    : choose_string(arg0, 0x1::string::utf8(b"Tiny Drone"), 0x1::string::utf8(b"Pixel Finch"), 0x1::string::utf8(b"Moss Sprite"), 0x1::string::utf8(b"Mini Rover")),
            blood_type   : choose_string(arg0, 0x1::string::utf8(b"Type A"), 0x1::string::utf8(b"Type B"), 0x1::string::utf8(b"Type C"), 0x1::string::utf8(b"Type D")),
            specialty    : choose_string(arg0, 0x1::string::utf8(b"Signal Mapping"), 0x1::string::utf8(b"Route Finding"), 0x1::string::utf8(b"Pattern Study"), 0x1::string::utf8(b"Signal Relay")),
            clearance    : choose_string(arg0, 0x1::string::utf8(b"Test Level 1"), 0x1::string::utf8(b"Test Level 2"), 0x1::string::utf8(b"Test Level 3"), 0x1::string::utf8(b"Test Level 4")),
            shift        : choose_string(arg0, 0x1::string::utf8(b"Day Shift"), 0x1::string::utf8(b"Night Shift"), 0x1::string::utf8(b"Swing Shift"), 0x1::string::utf8(b"Flex Shift")),
            ward         : choose_string(arg0, 0x1::string::utf8(b"Blue Room"), 0x1::string::utf8(b"North Room"), 0x1::string::utf8(b"Garden Room"), 0x1::string::utf8(b"South Room")),
            team_rank    : v0,
            rarity_rank  : v1,
            rarity       : choose_string(arg0, 0x1::string::utf8(b"Common"), 0x1::string::utf8(b"Uncommon"), 0x1::string::utf8(b"Rare"), 0x1::string::utf8(b"Epic")),
            rarity_score : choose_string(arg0, 0x1::string::utf8(b"12.4"), 0x1::string::utf8(b"28.6"), 0x1::string::utf8(b"47.2"), 0x1::string::utf8(b"76.9")),
        }
    }

    public fun has_metadata(arg0: &CollectionState, arg1: u64) : bool {
        if (arg1 >= 1) {
            if (arg1 <= 0x1::vector::length<EditionMetadata>(&arg0.metadata)) {
                0x1::string::length(&0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg1 - 1).name) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun init(arg0: COMPATIBILITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COMPATIBILITY>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<CompatibilityCollectible>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<CompatibilityCollectible>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CompatibilityCollectible>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CompatibilityCollectible>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 249) {
            0x1::vector::push_back<bool>(&mut v5, false);
            v6 = v6 + 1;
        };
        let v7 = CollectionState{
            id           : 0x2::object::new(arg1),
            total_supply : 249,
            minted_count : 0,
            minted       : v5,
            metadata     : 0x1::vector::empty<EditionMetadata>(),
        };
        let v8 = CollectionAdminCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<CollectionState>(&v7),
        };
        0x2::transfer::public_share_object<CollectionState>(v7);
        0x2::transfer::public_transfer<CollectionAdminCap>(v8, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<CompatibilityCollectible>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{background}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"headwear"), 0x1::string::utf8(b"{headwear}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"hair"), 0x1::string::utf8(b"{hair}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"eyewear"), 0x1::string::utf8(b"{eyewear}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"face"), 0x1::string::utf8(b"{face}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"outfit"), 0x1::string::utf8(b"{outfit}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"accessory"), 0x1::string::utf8(b"{accessory}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"companion"), 0x1::string::utf8(b"{companion}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"blood_type"), 0x1::string::utf8(b"{blood_type}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"specialty"), 0x1::string::utf8(b"{specialty}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"clearance"), 0x1::string::utf8(b"{clearance}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"shift"), 0x1::string::utf8(b"{shift}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"ward"), 0x1::string::utf8(b"{ward}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"team_rank"), 0x1::string::utf8(b"{team_rank}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"rarity_rank"), 0x1::string::utf8(b"{rarity_rank}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"rarity_score"), 0x1::string::utf8(b"{rarity_score}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Suimon"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(x"5472616465506f727420436f6d7061746962696c697479204c616220e28094204d61696e6e6574205465737420436f6c6c656374696f6e"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"An isolated Mainnet test collection created to validate TradePort compatibility before Mysten Medics integration. Test assets only; not the official Mysten Medics collection."));
        0x2::display_registry::share<CompatibilityCollectible>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<CompatibilityCollectible>>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun initialize_test_metadata(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
        assert!(0x1::vector::length<EditionMetadata>(&arg0.metadata) == 0, 6);
        register_fixture(arg0, arg1, fixture_metadata(1, arg2), arg3);
    }

    public fun is_minted(arg0: &CollectionState, arg1: u64) : bool {
        if (arg1 >= 1) {
            if (arg1 <= arg0.total_supply) {
                *0x1::vector::borrow<bool>(&arg0.minted, arg1 - 1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun mint_count(arg0: &CollectionState) : u64 {
        arg0.minted_count
    }

    public fun mint_edition_to(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 2);
        assert!(arg0.minted_count < arg0.total_supply, 5);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, arg2 - 1), 3);
        assert!(0x1::vector::length<EditionMetadata>(&arg0.metadata) >= arg2, 4);
        let v0 = 0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg2 - 1);
        let v1 = if (0x1::string::length(&v0.name) > 0) {
            if (0x1::string::length(&v0.description) > 0) {
                0x1::string::length(&v0.image_url) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        let v2 = CompatibilityCollectible{
            id           : 0x2::object::new(arg4),
            name         : v0.name,
            description  : v0.description,
            image_url    : v0.image_url,
            attributes   : build_attributes(v0),
            edition      : v0.edition,
            background   : v0.background,
            headwear     : v0.headwear,
            hair         : v0.hair,
            eyewear      : v0.eyewear,
            face         : v0.face,
            outfit       : v0.outfit,
            accessory    : v0.accessory,
            companion    : v0.companion,
            blood_type   : v0.blood_type,
            specialty    : v0.specialty,
            clearance    : v0.clearance,
            shift        : v0.shift,
            ward         : v0.ward,
            team_rank    : v0.team_rank,
            rarity_rank  : v0.rarity_rank,
            rarity       : v0.rarity,
            rarity_score : v0.rarity_score,
        };
        *0x1::vector::borrow_mut<bool>(&mut arg0.minted, arg2 - 1) = true;
        arg0.minted_count = arg0.minted_count + 1;
        let v3 = CollectibleMinted{
            object_id : 0x2::object::uid_to_address(&v2.id),
            edition   : arg2,
            minter    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CollectibleMinted>(v3);
        0x2::transfer::public_transfer<CompatibilityCollectible>(v2, arg3);
    }

    public fun mint_selected(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        mint_edition_to(arg0, arg1, arg2, v0, arg3);
    }

    fun register_fixture(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: EditionMetadata, arg3: &0x2::tx_context::TxContext) {
        set_edition_metadata_fields(arg0, arg1, arg2.edition, arg2.name, arg2.description, arg2.image_url, arg2.background, arg2.headwear, arg2.hair, arg2.eyewear, arg2.face, arg2.outfit, arg2.accessory, arg2.companion, arg2.blood_type, arg2.specialty, arg2.clearance, arg2.shift, arg2.ward, arg2.team_rank, arg2.rarity_rank, arg2.rarity, arg2.rarity_score, arg3);
    }

    public fun set_edition_metadata_fields(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u64, arg20: u64, arg21: 0x1::string::String, arg22: 0x1::string::String, arg23: &0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 2);
        let v0 = if (0x1::string::length(&arg3) > 0) {
            if (0x1::string::length(&arg4) > 0) {
                0x1::string::length(&arg5) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, arg2 - 1), 3);
        let v1 = EditionMetadata{
            edition      : arg2,
            name         : arg3,
            description  : arg4,
            image_url    : arg5,
            background   : arg6,
            headwear     : arg7,
            hair         : arg8,
            eyewear      : arg9,
            face         : arg10,
            outfit       : arg11,
            accessory    : arg12,
            companion    : arg13,
            blood_type   : arg14,
            specialty    : arg15,
            clearance    : arg16,
            shift        : arg17,
            ward         : arg18,
            team_rank    : arg19,
            rarity_rank  : arg20,
            rarity       : arg21,
            rarity_score : arg22,
        };
        let v2 = 0x1::vector::length<EditionMetadata>(&arg0.metadata);
        if (v2 < arg2) {
            assert!(v2 + 1 == arg2, 2);
            0x1::vector::push_back<EditionMetadata>(&mut arg0.metadata, v1);
        } else {
            *0x1::vector::borrow_mut<EditionMetadata>(&mut arg0.metadata, arg2 - 1) = v1;
        };
    }

    public fun total_supply(arg0: &CollectionState) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v7
}

