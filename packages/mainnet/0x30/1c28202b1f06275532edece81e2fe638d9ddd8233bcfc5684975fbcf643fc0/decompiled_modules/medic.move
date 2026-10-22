module 0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic {
    struct MEDIC has drop {
        dummy_field: bool,
    }

    struct Medic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct MedicWithTraits has store, key {
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

    struct MedicMinted has copy, drop {
        object_id: address,
        creator: address,
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
        publisher: 0x2::package::Publisher,
        total_supply: u64,
        minted_count: u64,
        metadata_count: u64,
        display_v2_registered: bool,
        common_price_mist: u64,
        uncommon_price_mist: u64,
        rare_price_mist: u64,
        epic_price_mist: u64,
        legendary_price_mist: u64,
        mythic_price_mist: u64,
        sale_phase: u8,
        paused: bool,
        treasury: address,
        minted_editions: vector<bool>,
        metadata: 0x2::table::Table<u64, EditionMetadata>,
        allowlist: 0x2::table::Table<address, bool>,
        presale_claimed: 0x2::table::Table<address, bool>,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct CollectionInitialized has copy, drop {
        collection_id: address,
        admin: address,
        total_supply: u64,
    }

    struct EditionMetadataRegistered has copy, drop {
        edition: u64,
        metadata_count: u64,
        updated_by: address,
    }

    struct RarityPriceUpdated has copy, drop {
        rarity: u8,
        old_price_mist: u64,
        new_price_mist: u64,
        updated_by: address,
    }

    struct SalePhaseUpdated has copy, drop {
        sale_phase: u8,
        updated_by: address,
    }

    struct MintPauseUpdated has copy, drop {
        paused: bool,
        updated_by: address,
    }

    struct TreasuryUpdated has copy, drop {
        treasury: address,
        updated_by: address,
    }

    struct AllowlistUpdated has copy, drop {
        account: address,
        enabled: bool,
        updated_by: address,
    }

    struct EditionMinted has copy, drop {
        object_id: address,
        minter: address,
        edition: u64,
        price_paid_mist: u64,
    }

    fun assert_admin(arg0: &CollectionState, arg1: &CollectionAdminCap) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 102);
    }

    fun build_attributes(arg0: &EditionMetadata) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
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
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), arg0.rarity);
        v0
    }

    public fun collection_summary(arg0: &CollectionState) : (u64, u64, u64, u64, u8, bool, address) {
        (arg0.total_supply, arg0.minted_count, arg0.metadata_count, 0x2::table::length<address, bool>(&arg0.allowlist), arg0.sale_phase, arg0.paused, arg0.treasury)
    }

    fun configure_medic_transfer_policy(arg0: &mut 0x2::transfer_policy::TransferPolicy<MedicWithTraits>, arg1: &0x2::transfer_policy::TransferPolicyCap<MedicWithTraits>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<MedicWithTraits>(arg0, arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<MedicWithTraits>(arg0, arg1, 250, 0);
    }

    public fun description(arg0: &Medic) : 0x1::string::String {
        arg0.description
    }

    public fun edition_is_minted(arg0: &CollectionState, arg1: u64) : bool {
        assert!(arg1 >= 1 && arg1 <= arg0.total_supply, 103);
        *0x1::vector::borrow<bool>(&arg0.minted_editions, arg1 - 1)
    }

    public fun has_edition_metadata(arg0: &CollectionState, arg1: u64) : bool {
        0x2::table::contains<u64, EditionMetadata>(&arg0.metadata, arg1)
    }

    public fun image_url(arg0: &Medic) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: MEDIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MEDIC>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<MedicWithTraits>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        configure_medic_transfer_policy(v5, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<MedicWithTraits>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<MedicWithTraits>>(v3, 0x2::tx_context::sender(arg1));
        let v6 = 0x2::tx_context::sender(arg1);
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 249) {
            0x1::vector::push_back<bool>(&mut v7, false);
            v8 = v8 + 1;
        };
        let v9 = CollectionState{
            id                    : 0x2::object::new(arg1),
            publisher             : v0,
            total_supply          : 249,
            minted_count          : 0,
            metadata_count        : 0,
            display_v2_registered : false,
            common_price_mist     : 15000000000,
            uncommon_price_mist   : 16000000000,
            rare_price_mist       : 17000000000,
            epic_price_mist       : 18000000000,
            legendary_price_mist  : 19000000000,
            mythic_price_mist     : 20000000000,
            sale_phase            : 0,
            paused                : true,
            treasury              : v6,
            minted_editions       : v7,
            metadata              : 0x2::table::new<u64, EditionMetadata>(arg1),
            allowlist             : 0x2::table::new<address, bool>(arg1),
            presale_claimed       : 0x2::table::new<address, bool>(arg1),
        };
        let v10 = CollectionAdminCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<CollectionState>(&v9),
        };
        let v11 = CollectionInitialized{
            collection_id : 0x2::object::uid_to_address(&v9.id),
            admin         : v6,
            total_supply  : 249,
        };
        0x2::event::emit<CollectionInitialized>(v11);
        0x2::transfer::public_share_object<CollectionState>(v9);
        0x2::transfer::public_transfer<CollectionAdminCap>(v10, v6);
    }

    public fun initialize_display_v2(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut CollectionState, arg2: &CollectionAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg2);
        if (!arg1.display_v2_registered) {
            let (v0, v1) = 0x2::display_registry::new_with_publisher<MedicWithTraits>(arg0, &mut arg1.publisher, arg3);
            let v2 = v1;
            let v3 = v0;
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{background}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"headwear"), 0x1::string::utf8(b"{headwear}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"hair"), 0x1::string::utf8(b"{hair}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"eyewear"), 0x1::string::utf8(b"{eyewear}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"face"), 0x1::string::utf8(b"{face}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"outfit"), 0x1::string::utf8(b"{outfit}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"accessory"), 0x1::string::utf8(b"{accessory}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"companion"), 0x1::string::utf8(b"{companion}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"blood_type"), 0x1::string::utf8(b"{blood_type}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"specialty"), 0x1::string::utf8(b"{specialty}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"clearance"), 0x1::string::utf8(b"{clearance}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"shift"), 0x1::string::utf8(b"{shift}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"ward"), 0x1::string::utf8(b"{ward}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"team_rank"), 0x1::string::utf8(b"{team_rank}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"rarity_rank"), 0x1::string::utf8(b"{rarity_rank}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"rarity_score"), 0x1::string::utf8(b"{rarity_score}"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Suimon"));
            0x2::display_registry::set<MedicWithTraits>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Mysten Medics"));
            0x2::display_registry::share<MedicWithTraits>(v3);
            0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<MedicWithTraits>>(v2, 0x2::tx_context::sender(arg3));
            arg1.display_v2_registered = true;
        };
    }

    fun metadata_equal(arg0: &EditionMetadata, arg1: &EditionMetadata) : bool {
        if (arg0.edition == arg1.edition) {
            if (arg0.name == arg1.name) {
                if (arg0.description == arg1.description) {
                    if (arg0.image_url == arg1.image_url) {
                        if (arg0.background == arg1.background) {
                            if (arg0.headwear == arg1.headwear) {
                                if (arg0.hair == arg1.hair) {
                                    if (arg0.eyewear == arg1.eyewear) {
                                        if (arg0.face == arg1.face) {
                                            if (arg0.outfit == arg1.outfit) {
                                                if (arg0.accessory == arg1.accessory) {
                                                    if (arg0.companion == arg1.companion) {
                                                        if (arg0.blood_type == arg1.blood_type) {
                                                            if (arg0.specialty == arg1.specialty) {
                                                                if (arg0.clearance == arg1.clearance) {
                                                                    if (arg0.shift == arg1.shift) {
                                                                        if (arg0.ward == arg1.ward) {
                                                                            if (arg0.team_rank == arg1.team_rank) {
                                                                                if (arg0.rarity_rank == arg1.rarity_rank) {
                                                                                    if (arg0.rarity == arg1.rarity) {
                                                                                        arg0.rarity_score == arg1.rarity_score
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
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        abort 100
    }

    public fun mint_edition(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 103);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted_editions, arg2 - 1), 104);
        assert!(0x2::table::contains<u64, EditionMetadata>(&arg0.metadata, arg2), 105);
        let v0 = *0x2::table::borrow<u64, EditionMetadata>(&arg0.metadata, arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        mint_from_metadata(arg0, v0, v1, 0, arg3);
    }

    public entry fun mint_edition_to(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 103);
        assert!(arg3 != @0x0, 120);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted_editions, arg2 - 1), 104);
        assert!(0x2::table::contains<u64, EditionMetadata>(&arg0.metadata, arg2), 105);
        let v0 = *0x2::table::borrow<u64, EditionMetadata>(&arg0.metadata, arg2);
        mint_from_metadata(arg0, v0, arg3, 0, arg4);
    }

    fun mint_from_metadata(arg0: &mut CollectionState, arg1: EditionMetadata, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let EditionMetadata {
            edition      : v0,
            name         : v1,
            description  : v2,
            image_url    : v3,
            background   : v4,
            headwear     : v5,
            hair         : v6,
            eyewear      : v7,
            face         : v8,
            outfit       : v9,
            accessory    : v10,
            companion    : v11,
            blood_type   : v12,
            specialty    : v13,
            clearance    : v14,
            shift        : v15,
            ward         : v16,
            team_rank    : v17,
            rarity_rank  : v18,
            rarity       : v19,
            rarity_score : v20,
        } = arg1;
        assert!(arg0.display_v2_registered, 121);
        assert!(v0 >= 1 && v0 <= arg0.total_supply, 103);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted_editions, v0 - 1), 104);
        *0x1::vector::borrow_mut<bool>(&mut arg0.minted_editions, v0 - 1) = true;
        arg0.minted_count = arg0.minted_count + 1;
        let v21 = EditionMetadata{
            edition      : v0,
            name         : v1,
            description  : v2,
            image_url    : v3,
            background   : v4,
            headwear     : v5,
            hair         : v6,
            eyewear      : v7,
            face         : v8,
            outfit       : v9,
            accessory    : v10,
            companion    : v11,
            blood_type   : v12,
            specialty    : v13,
            clearance    : v14,
            shift        : v15,
            ward         : v16,
            team_rank    : v17,
            rarity_rank  : v18,
            rarity       : v19,
            rarity_score : v20,
        };
        let v22 = MedicWithTraits{
            id           : 0x2::object::new(arg4),
            name         : v1,
            description  : v2,
            image_url    : v3,
            attributes   : build_attributes(&v21),
            edition      : v0,
            background   : v4,
            headwear     : v5,
            hair         : v6,
            eyewear      : v7,
            face         : v8,
            outfit       : v9,
            accessory    : v10,
            companion    : v11,
            blood_type   : v12,
            specialty    : v13,
            clearance    : v14,
            shift        : v15,
            ward         : v16,
            team_rank    : v17,
            rarity_rank  : v18,
            rarity       : v19,
            rarity_score : v20,
        };
        let v23 = EditionMinted{
            object_id       : 0x2::object::uid_to_address(&v22.id),
            minter          : 0x2::tx_context::sender(arg4),
            edition         : v0,
            price_paid_mist : arg3,
        };
        0x2::event::emit<EditionMinted>(v23);
        0x2::transfer::public_transfer<MedicWithTraits>(v22, arg2);
    }

    public fun mint_next(arg0: &mut CollectionState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 111);
        assert!(arg0.sale_phase == 1 || arg0.sale_phase == 2, 112);
        assert!(arg0.metadata_count == arg0.total_supply, 109);
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg0.sale_phase == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v0) && *0x2::table::borrow<address, bool>(&arg0.allowlist, v0), 113);
            assert!(!0x2::table::contains<address, bool>(&arg0.presale_claimed, v0), 114);
            0x2::table::add<address, bool>(&mut arg0.presale_claimed, v0, true);
        };
        let v1 = *0x2::table::borrow<u64, EditionMetadata>(&arg0.metadata, next_available_edition(arg0));
        let v2 = price_for_rarity(arg0, &v1.rarity);
        settle_payment(arg1, v2, arg0.treasury, v0, arg2);
        mint_from_metadata(arg0, v1, v0, v2, arg2);
    }

    public fun mint_selected(arg0: &mut CollectionState, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 111);
        assert!(arg0.sale_phase == 1 || arg0.sale_phase == 2, 112);
        assert!(arg0.metadata_count == arg0.total_supply, 109);
        assert!(arg1 >= 1 && arg1 <= arg0.total_supply, 103);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted_editions, arg1 - 1), 104);
        assert!(0x2::table::contains<u64, EditionMetadata>(&arg0.metadata, arg1), 105);
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.sale_phase == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v0) && *0x2::table::borrow<address, bool>(&arg0.allowlist, v0), 113);
            assert!(!0x2::table::contains<address, bool>(&arg0.presale_claimed, v0), 114);
            0x2::table::add<address, bool>(&mut arg0.presale_claimed, v0, true);
        };
        let v1 = *0x2::table::borrow<u64, EditionMetadata>(&arg0.metadata, arg1);
        let v2 = price_for_rarity(arg0, &v1.rarity);
        settle_payment(arg2, v2, arg0.treasury, v0, arg3);
        mint_from_metadata(arg0, v1, v0, v2, arg3);
    }

    public fun mint_traits_sample(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        abort 100
    }

    public fun name(arg0: &Medic) : 0x1::string::String {
        arg0.name
    }

    fun next_available_edition(arg0: &CollectionState) : u64 {
        let v0 = 0;
        while (v0 < arg0.total_supply) {
            if (!*0x1::vector::borrow<bool>(&arg0.minted_editions, v0)) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        abort 115
    }

    fun price_for_rarity(arg0: &CollectionState, arg1: &0x1::string::String) : u64 {
        if (*arg1 == 0x1::string::utf8(b"Common")) {
            arg0.common_price_mist
        } else if (*arg1 == 0x1::string::utf8(b"Uncommon")) {
            arg0.uncommon_price_mist
        } else if (*arg1 == 0x1::string::utf8(b"Rare")) {
            arg0.rare_price_mist
        } else if (*arg1 == 0x1::string::utf8(b"Epic")) {
            arg0.epic_price_mist
        } else if (*arg1 == 0x1::string::utf8(b"Legendary")) {
            arg0.legendary_price_mist
        } else {
            assert!(*arg1 == 0x1::string::utf8(b"Mythic"), 122);
            arg0.mythic_price_mist
        }
    }

    fun register_metadata(arg0: &mut CollectionState, arg1: EditionMetadata, arg2: address) {
        let v0 = arg1.edition;
        assert!(v0 >= 1 && v0 <= arg0.total_supply, 103);
        assert!(0x1::string::length(&arg1.name) > 0, 107);
        assert!(0x1::string::length(&arg1.description) > 0, 107);
        assert!(0x1::string::length(&arg1.image_url) > 0, 107);
        assert!(arg1.team_rank >= 1 && arg1.team_rank <= arg0.total_supply, 107);
        assert!(arg1.rarity_rank >= 1 && arg1.rarity_rank <= arg0.total_supply, 107);
        if (0x2::table::contains<u64, EditionMetadata>(&arg0.metadata, v0)) {
            if (*0x1::vector::borrow<bool>(&arg0.minted_editions, v0 - 1)) {
                assert!(metadata_equal(0x2::table::borrow<u64, EditionMetadata>(&arg0.metadata, v0), &arg1), 106);
            } else {
                0x2::table::remove<u64, EditionMetadata>(&mut arg0.metadata, v0);
                0x2::table::add<u64, EditionMetadata>(&mut arg0.metadata, v0, arg1);
            };
        } else {
            0x2::table::add<u64, EditionMetadata>(&mut arg0.metadata, v0, arg1);
            arg0.metadata_count = arg0.metadata_count + 1;
        };
        let v1 = EditionMetadataRegistered{
            edition        : v0,
            metadata_count : arg0.metadata_count,
            updated_by     : arg2,
        };
        0x2::event::emit<EditionMetadataRegistered>(v1);
    }

    public fun set_allowlist_address(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        if (arg3) {
            if (0x2::table::contains<address, bool>(&arg0.allowlist, arg2)) {
                *0x2::table::borrow_mut<address, bool>(&mut arg0.allowlist, arg2) = true;
            } else {
                0x2::table::add<address, bool>(&mut arg0.allowlist, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(&arg0.allowlist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.allowlist, arg2);
        };
        let v0 = AllowlistUpdated{
            account    : arg2,
            enabled    : arg3,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AllowlistUpdated>(v0);
    }

    public fun set_edition_metadata(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: EditionMetadata, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        register_metadata(arg0, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun set_edition_metadata_fields(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: u64, arg20: u64, arg21: 0x1::string::String, arg22: 0x1::string::String, arg23: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = EditionMetadata{
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
        register_metadata(arg0, v0, 0x2::tx_context::sender(arg23));
    }

    public fun set_metadata_batch(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: vector<EditionMetadata>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x1::vector::length<EditionMetadata>(&arg2);
        assert!(v0 > 0 && v0 <= 25, 108);
        let v1 = 0;
        while (v1 < v0) {
            register_metadata(arg0, *0x1::vector::borrow<EditionMetadata>(&arg2, v1), 0x2::tx_context::sender(arg3));
            v1 = v1 + 1;
        };
    }

    public fun set_paused(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        if (!arg2) {
            assert!(arg0.display_v2_registered, 121);
        };
        arg0.paused = arg2;
        let v0 = MintPauseUpdated{
            paused     : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintPauseUpdated>(v0);
    }

    public fun set_rarity_price(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u8, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg0.sale_phase == 0 && arg0.paused, 123);
        let v0 = if (arg2 == 1) {
            arg0.common_price_mist = arg3;
            arg0.common_price_mist
        } else if (arg2 == 2) {
            arg0.uncommon_price_mist = arg3;
            arg0.uncommon_price_mist
        } else if (arg2 == 3) {
            arg0.rare_price_mist = arg3;
            arg0.rare_price_mist
        } else if (arg2 == 4) {
            arg0.epic_price_mist = arg3;
            arg0.epic_price_mist
        } else if (arg2 == 5) {
            arg0.legendary_price_mist = arg3;
            arg0.legendary_price_mist
        } else {
            assert!(arg2 == 6, 122);
            arg0.mythic_price_mist = arg3;
            arg0.mythic_price_mist
        };
        let v1 = RarityPriceUpdated{
            rarity         : arg2,
            old_price_mist : v0,
            new_price_mist : arg3,
            updated_by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RarityPriceUpdated>(v1);
    }

    public fun set_sale_phase(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 <= 2, 110);
        if (arg2 != 0) {
            assert!(arg0.display_v2_registered, 121);
            assert!(arg0.metadata_count == arg0.total_supply, 109);
        };
        if (arg2 == 1) {
            assert!(!0x2::table::is_empty<address, bool>(&arg0.allowlist), 117);
        };
        arg0.sale_phase = arg2;
        let v0 = SalePhaseUpdated{
            sale_phase : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SalePhaseUpdated>(v0);
    }

    public fun set_treasury(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 != @0x0, 118);
        arg0.treasury = arg2;
        let v0 = TreasuryUpdated{
            treasury   : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    fun settle_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 116);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg4), arg2);
            if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
            };
        };
    }

    // decompiled from Move bytecode v7
}

