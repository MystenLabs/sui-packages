module 0x5cd58fe4c280e7e5ebfcf148197fb02421502caad8bb788c51ae3eba928c0621::crowned_dominion {
    struct CROWNED_DOMINION has drop {
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
        EditionMetadata{
            edition      : arg0,
            name         : choose_string(arg0, 0x1::string::utf8(b"Crowned Pitch: Golden Dominion"), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion"), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion"), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion")),
            description  : choose_string(arg0, 0x1::string::utf8(b"Crowned Pitch: Golden Dominion is a distinct football art collectible featuring the original crowned-ball artwork, gold accents and expressive ink splashes."), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion is a distinct football art collectible featuring the original crowned-ball artwork, gold accents and expressive ink splashes."), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion is a distinct football art collectible featuring the original crowned-ball artwork, gold accents and expressive ink splashes."), 0x1::string::utf8(b"Crowned Pitch: Golden Dominion is a distinct football art collectible featuring the original crowned-ball artwork, gold accents and expressive ink splashes.")),
            image_url    : arg1,
            background   : choose_string(arg0, 0x1::string::utf8(b"Ivory Splatter"), 0x1::string::utf8(b"Ivory Splatter"), 0x1::string::utf8(b"Ivory Splatter"), 0x1::string::utf8(b"Ivory Splatter")),
            headwear     : choose_string(arg0, 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None")),
            hair         : choose_string(arg0, 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None")),
            eyewear      : choose_string(arg0, 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None")),
            face         : choose_string(arg0, 0x1::string::utf8(b"Stylized Ball"), 0x1::string::utf8(b"Stylized Ball"), 0x1::string::utf8(b"Stylized Ball"), 0x1::string::utf8(b"Stylized Ball")),
            outfit       : choose_string(arg0, 0x1::string::utf8(b"Football"), 0x1::string::utf8(b"Football"), 0x1::string::utf8(b"Football"), 0x1::string::utf8(b"Football")),
            accessory    : choose_string(arg0, 0x1::string::utf8(b"Gold Crown Emblem"), 0x1::string::utf8(b"Gold Crown Emblem"), 0x1::string::utf8(b"Gold Crown Emblem"), 0x1::string::utf8(b"Gold Crown Emblem")),
            companion    : choose_string(arg0, 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None"), 0x1::string::utf8(b"None")),
            blood_type   : choose_string(arg0, 0x1::string::utf8(b"N/A"), 0x1::string::utf8(b"N/A"), 0x1::string::utf8(b"N/A"), 0x1::string::utf8(b"N/A")),
            specialty    : choose_string(arg0, 0x1::string::utf8(b"Football Art"), 0x1::string::utf8(b"Football Art"), 0x1::string::utf8(b"Football Art"), 0x1::string::utf8(b"Football Art")),
            clearance    : choose_string(arg0, 0x1::string::utf8(b"Champion"), 0x1::string::utf8(b"Champion"), 0x1::string::utf8(b"Champion"), 0x1::string::utf8(b"Champion")),
            shift        : choose_string(arg0, 0x1::string::utf8(b"Match Day"), 0x1::string::utf8(b"Match Day"), 0x1::string::utf8(b"Match Day"), 0x1::string::utf8(b"Match Day")),
            ward         : choose_string(arg0, 0x1::string::utf8(b"Stadium"), 0x1::string::utf8(b"Stadium"), 0x1::string::utf8(b"Stadium"), 0x1::string::utf8(b"Stadium")),
            team_rank    : 1,
            rarity_rank  : 1,
            rarity       : choose_string(arg0, 0x1::string::utf8(b"Legendary"), 0x1::string::utf8(b"Legendary"), 0x1::string::utf8(b"Legendary"), 0x1::string::utf8(b"Legendary")),
            rarity_score : choose_string(arg0, 0x1::string::utf8(b"100.0"), 0x1::string::utf8(b"100.0"), 0x1::string::utf8(b"100.0"), 0x1::string::utf8(b"100.0")),
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

    fun init(arg0: CROWNED_DOMINION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CROWNED_DOMINION>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"headwear"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"hair"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"eyewear"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"face"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"outfit"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"accessory"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"companion"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"blood_type"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"specialty"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"clearance"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"shift"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"ward"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"team_rank"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity_rank"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"rarity_score"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{edition}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{background}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{headwear}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{hair}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{eyewear}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{face}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{outfit}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{accessory}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{companion}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{blood_type}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{specialty}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{clearance}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{shift}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{ward}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{team_rank}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity_rank}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{rarity_score}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Suimon"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Crowned Dominion Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A new collection of football-inspired digital art collectibles, preserving the original artwork and trait metadata."));
        let v5 = 0x2::display::new_with_fields<CompatibilityCollectible>(&v0, v1, v3, arg1);
        0x2::display::update_version<CompatibilityCollectible>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<CompatibilityCollectible>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 249) {
            0x1::vector::push_back<bool>(&mut v6, false);
            v7 = v7 + 1;
        };
        let v8 = CollectionState{
            id           : 0x2::object::new(arg1),
            total_supply : 249,
            minted_count : 0,
            minted       : v6,
            metadata     : 0x1::vector::empty<EditionMetadata>(),
        };
        let v9 = CollectionAdminCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<CollectionState>(&v8),
        };
        0x2::transfer::public_share_object<CollectionState>(v8);
        0x2::transfer::public_transfer<CollectionAdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public entry fun initialize_display_v2(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<CompatibilityCollectible>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
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
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Crowned Dominion Collection"));
        0x2::display_registry::set<CompatibilityCollectible>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"A new collection of football-inspired digital art collectibles, preserving the original artwork and trait metadata."));
        0x2::display_registry::share<CompatibilityCollectible>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<CompatibilityCollectible>>(v2, 0x2::tx_context::sender(arg2));
    }

    public entry fun initialize_golden_dominion_metadata(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: &0x2::tx_context::TxContext) {
        initialize_test_metadata(arg0, arg1, 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeicm2a6zy3y77xiylmmyar4lcqnnyuegbxkqwxoso4bkqydx6aoyqi"), arg2);
    }

    public fun initialize_test_metadata(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
        assert!(0x1::vector::length<EditionMetadata>(&arg0.metadata) == 0, 6);
        register_fixture(arg0, arg1, fixture_metadata(1, arg2), arg3);
    }

    public fun initialize_test_metadata_for_edition(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 2);
        assert!(!has_metadata(arg0, arg2), 6);
        register_fixture(arg0, arg1, fixture_metadata(arg2, arg3), arg4);
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

    fun mint_collectible(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : CompatibilityCollectible {
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
            id           : 0x2::object::new(arg3),
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
            minter    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CollectibleMinted>(v3);
        v2
    }

    public fun mint_count(arg0: &CollectionState) : u64 {
        arg0.minted_count
    }

    public fun mint_edition_to(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CompatibilityCollectible>(mint_collectible(arg0, arg1, arg2, arg4), arg3);
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

