module 0x1079f8ee4b632d8b96322f5b1613f957a7929d5f73f1831f38d9044c85ff7892::suiborg {
    struct SUIBORG has drop {
        dummy_field: bool,
    }

    struct Suiborg has store, key {
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
    }

    struct CollectionState has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        minted_count: u64,
        metadata_count: u64,
        display_v2_registered: bool,
        mint_price: u64,
        sale_phase: u8,
        paused: bool,
        treasury: address,
        minted: vector<bool>,
        metadata: vector<EditionMetadata>,
        allowlist: 0x2::table::Table<address, bool>,
        presale_claimed: 0x2::table::Table<address, bool>,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct SuiborgMinted has copy, drop {
        object_id: address,
        edition: u64,
        recipient: address,
        minter: address,
        price_paid_mist: u64,
    }

    struct SalePhaseUpdated has copy, drop {
        sale_phase: u8,
        updated_by: address,
    }

    struct MintPauseUpdated has copy, drop {
        paused: bool,
        updated_by: address,
    }

    struct MintPriceUpdated has copy, drop {
        price_mist: u64,
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

    struct EditionMetadataRegistered has copy, drop {
        edition: u64,
        updated_by: address,
        metadata_count: u64,
    }

    fun assert_admin(arg0: &CollectionState, arg1: &CollectionAdminCap) {
        assert!(arg1.collection_id == 0x2::object::id<CollectionState>(arg0), 1);
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
        v0
    }

    public fun display_v2_registered(arg0: &CollectionState) : bool {
        arg0.display_v2_registered
    }

    fun empty_metadata(arg0: u64) : EditionMetadata {
        EditionMetadata{
            edition     : arg0,
            name        : 0x1::string::utf8(b""),
            description : 0x1::string::utf8(b""),
            image_url   : 0x1::string::utf8(b""),
            background  : 0x1::string::utf8(b""),
            headwear    : 0x1::string::utf8(b""),
            hair        : 0x1::string::utf8(b""),
            eyewear     : 0x1::string::utf8(b""),
            face        : 0x1::string::utf8(b""),
            outfit      : 0x1::string::utf8(b""),
            accessory   : 0x1::string::utf8(b""),
            companion   : 0x1::string::utf8(b""),
            blood_type  : 0x1::string::utf8(b""),
            specialty   : 0x1::string::utf8(b""),
            clearance   : 0x1::string::utf8(b""),
            shift       : 0x1::string::utf8(b""),
            ward        : 0x1::string::utf8(b""),
        }
    }

    fun ensure_display_v2_registered(arg0: &mut CollectionState, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: &mut 0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.display_v2_registered) {
            let (v0, v1) = 0x2::display_registry::new_with_publisher<Suiborg>(arg1, arg2, arg3);
            let v2 = v1;
            let v3 = v0;
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{background}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"headwear"), 0x1::string::utf8(b"{headwear}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"hair"), 0x1::string::utf8(b"{hair}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"eyewear"), 0x1::string::utf8(b"{eyewear}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"face"), 0x1::string::utf8(b"{face}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"outfit"), 0x1::string::utf8(b"{outfit}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"accessory"), 0x1::string::utf8(b"{accessory}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"companion"), 0x1::string::utf8(b"{companion}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"blood_type"), 0x1::string::utf8(b"{blood_type}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"specialty"), 0x1::string::utf8(b"{specialty}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"clearance"), 0x1::string::utf8(b"{clearance}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"shift"), 0x1::string::utf8(b"{shift}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"ward"), 0x1::string::utf8(b"{ward}"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Suimon"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"SUIBORG"));
            0x2::display_registry::set<Suiborg>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Five unique one-of-one Suiborg battle machines built for a ruined future."));
            0x2::display_registry::share<Suiborg>(v3);
            0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Suiborg>>(v2, 0x2::tx_context::sender(arg3));
            arg0.display_v2_registered = true;
        };
    }

    public fun has_metadata(arg0: &CollectionState, arg1: u64) : bool {
        if (arg1 >= 1) {
            if (arg1 <= arg0.total_supply) {
                0x1::string::length(&0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg1 - 1).name) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun init(arg0: SUIBORG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIBORG>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Suiborg>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Suiborg>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Suiborg>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Suiborg>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v5 = vector[];
        let v6 = 0x1::vector::empty<EditionMetadata>();
        let v7 = 1;
        while (v7 <= 5) {
            0x1::vector::push_back<bool>(&mut v5, false);
            0x1::vector::push_back<EditionMetadata>(&mut v6, empty_metadata(v7));
            v7 = v7 + 1;
        };
        let v8 = CollectionState{
            id                    : 0x2::object::new(arg1),
            total_supply          : 5,
            minted_count          : 0,
            metadata_count        : 0,
            display_v2_registered : false,
            mint_price            : 0,
            sale_phase            : 0,
            paused                : true,
            treasury              : 0x2::tx_context::sender(arg1),
            minted                : v5,
            metadata              : v6,
            allowlist             : 0x2::table::new<address, bool>(arg1),
            presale_claimed       : 0x2::table::new<address, bool>(arg1),
        };
        let v9 = CollectionAdminCap{
            id            : 0x2::object::new(arg1),
            collection_id : 0x2::object::id<CollectionState>(&v8),
        };
        0x2::transfer::public_share_object<CollectionState>(v8);
        0x2::transfer::public_transfer<CollectionAdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_display_v2(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::package::Publisher, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        ensure_display_v2_registered(arg0, arg2, arg3, arg4);
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

    public fun is_paused(arg0: &CollectionState) : bool {
        arg0.paused
    }

    public fun metadata_count(arg0: &CollectionState) : u64 {
        arg0.metadata_count
    }

    fun mint_collectible(arg0: &mut CollectionState, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Suiborg {
        assert!(arg0.display_v2_registered, 17);
        assert!(arg1 >= 1 && arg1 <= arg0.total_supply, 2);
        assert!(arg0.minted_count < arg0.total_supply, 12);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, arg1 - 1), 3);
        assert!(0x1::string::length(&0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg1 - 1).name) > 0, 4);
        let v0 = 0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg1 - 1);
        let v1 = Suiborg{
            id          : 0x2::object::new(arg4),
            name        : v0.name,
            description : v0.description,
            image_url   : v0.image_url,
            attributes  : build_attributes(v0),
            edition     : v0.edition,
            background  : v0.background,
            headwear    : v0.headwear,
            hair        : v0.hair,
            eyewear     : v0.eyewear,
            face        : v0.face,
            outfit      : v0.outfit,
            accessory   : v0.accessory,
            companion   : v0.companion,
            blood_type  : v0.blood_type,
            specialty   : v0.specialty,
            clearance   : v0.clearance,
            shift       : v0.shift,
            ward        : v0.ward,
        };
        *0x1::vector::borrow_mut<bool>(&mut arg0.minted, arg1 - 1) = true;
        arg0.minted_count = arg0.minted_count + 1;
        let v2 = SuiborgMinted{
            object_id       : 0x2::object::uid_to_address(&v1.id),
            edition         : arg1,
            recipient       : arg2,
            minter          : 0x2::tx_context::sender(arg4),
            price_paid_mist : arg3,
        };
        0x2::event::emit<SuiborgMinted>(v2);
        v1
    }

    public fun mint_count(arg0: &CollectionState) : u64 {
        arg0.minted_count
    }

    public fun mint_edition(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &mut 0x2::display_registry::DisplayRegistry, arg4: &mut 0x2::package::Publisher, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_display_v2_registered(arg0, arg3, arg4, arg5);
        mint_edition_internal(arg0, arg1, arg2, arg5);
    }

    fun mint_edition_internal(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<Suiborg>(mint_collectible(arg0, arg2, v0, 0, arg3), v0);
    }

    public fun mint_edition_to(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::display_registry::DisplayRegistry, arg5: &mut 0x2::package::Publisher, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_display_v2_registered(arg0, arg4, arg5, arg6);
        mint_edition_to_internal(arg0, arg1, arg2, arg3, arg6);
    }

    fun mint_edition_to_internal(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg3 != @0x0, 6);
        0x2::transfer::public_transfer<Suiborg>(mint_collectible(arg0, arg2, arg3, 0, arg4), arg3);
    }

    public fun mint_next(arg0: &mut CollectionState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.display_v2_registered, 17);
        mint_next_internal(arg0, arg1, arg2);
    }

    fun mint_next_internal(arg0: &mut CollectionState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(arg0.sale_phase == 1 || arg0.sale_phase == 2, 9);
        assert!(arg0.metadata_count == arg0.total_supply, 16);
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg0.sale_phase == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v0) && *0x2::table::borrow<address, bool>(&arg0.allowlist, v0), 10);
            assert!(!0x2::table::contains<address, bool>(&arg0.presale_claimed, v0), 11);
            0x2::table::add<address, bool>(&mut arg0.presale_claimed, v0, true);
        };
        let v1 = next_available_edition(arg0);
        let v2 = arg0.mint_price;
        settle_payment(arg1, v2, arg0.treasury, v0, arg2);
        0x2::transfer::public_transfer<Suiborg>(mint_collectible(arg0, v1, v0, v2, arg2), v0);
    }

    public fun mint_price(arg0: &CollectionState) : u64 {
        arg0.mint_price
    }

    public fun mint_selected(arg0: &mut CollectionState, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.display_v2_registered, 17);
        mint_selected_internal(arg0, arg1, arg2, arg3);
    }

    fun mint_selected_internal(arg0: &mut CollectionState, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 8);
        assert!(arg0.sale_phase == 1 || arg0.sale_phase == 2, 9);
        assert!(arg0.metadata_count == arg0.total_supply, 16);
        assert!(arg1 >= 1 && arg1 <= arg0.total_supply, 2);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, arg1 - 1), 3);
        assert!(0x1::string::length(&0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg1 - 1).name) > 0, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.sale_phase == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v0) && *0x2::table::borrow<address, bool>(&arg0.allowlist, v0), 10);
            assert!(!0x2::table::contains<address, bool>(&arg0.presale_claimed, v0), 11);
            0x2::table::add<address, bool>(&mut arg0.presale_claimed, v0, true);
        };
        let v1 = arg0.mint_price;
        settle_payment(arg2, v1, arg0.treasury, v0, arg3);
        0x2::transfer::public_transfer<Suiborg>(mint_collectible(arg0, arg1, v0, v1, arg3), v0);
    }

    fun next_available_edition(arg0: &CollectionState) : u64 {
        let v0 = 0;
        while (v0 < arg0.total_supply) {
            if (!*0x1::vector::borrow<bool>(&arg0.minted, v0)) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        abort 12
    }

    public fun sale_phase(arg0: &CollectionState) : u8 {
        arg0.sale_phase
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

    public fun set_edition_metadata_fields(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: 0x1::string::String, arg19: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= arg0.total_supply, 2);
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, arg2 - 1), 3);
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
        let v1 = if (0x1::string::length(&arg6) > 0) {
            if (0x1::string::length(&arg7) > 0) {
                if (0x1::string::length(&arg8) > 0) {
                    if (0x1::string::length(&arg9) > 0) {
                        if (0x1::string::length(&arg10) > 0) {
                            if (0x1::string::length(&arg11) > 0) {
                                if (0x1::string::length(&arg12) > 0) {
                                    if (0x1::string::length(&arg13) > 0) {
                                        if (0x1::string::length(&arg14) > 0) {
                                            if (0x1::string::length(&arg15) > 0) {
                                                if (0x1::string::length(&arg16) > 0) {
                                                    if (0x1::string::length(&arg17) > 0) {
                                                        0x1::string::length(&arg18) > 0
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
        };
        assert!(v1, 4);
        let v2 = EditionMetadata{
            edition     : arg2,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            background  : arg6,
            headwear    : arg7,
            hair        : arg8,
            eyewear     : arg9,
            face        : arg10,
            outfit      : arg11,
            accessory   : arg12,
            companion   : arg13,
            blood_type  : arg14,
            specialty   : arg15,
            clearance   : arg16,
            shift       : arg17,
            ward        : arg18,
        };
        *0x1::vector::borrow_mut<EditionMetadata>(&mut arg0.metadata, arg2 - 1) = v2;
        if (!(0x1::string::length(&0x1::vector::borrow<EditionMetadata>(&arg0.metadata, arg2 - 1).name) > 0)) {
            arg0.metadata_count = arg0.metadata_count + 1;
        };
        let v3 = EditionMetadataRegistered{
            edition        : arg2,
            updated_by     : 0x2::tx_context::sender(arg19),
            metadata_count : arg0.metadata_count,
        };
        0x2::event::emit<EditionMetadataRegistered>(v3);
    }

    public fun set_mint_price(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.mint_price = arg2;
        let v0 = MintPriceUpdated{
            price_mist : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintPriceUpdated>(v0);
    }

    public fun set_paused(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        if (!arg2) {
            assert!(arg0.display_v2_registered, 17);
        };
        arg0.paused = arg2;
        let v0 = MintPauseUpdated{
            paused     : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintPauseUpdated>(v0);
    }

    public fun set_sale_phase(arg0: &mut CollectionState, arg1: &CollectionAdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg2 <= 2, 7);
        if (arg2 != 0) {
            assert!(arg0.display_v2_registered, 17);
            assert!(arg0.metadata_count == arg0.total_supply, 16);
        };
        if (arg2 == 1) {
            assert!(!0x2::table::is_empty<address, bool>(&arg0.allowlist), 14);
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
        assert!(arg2 != @0x0, 15);
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
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 13);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg4), arg2);
            if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
            };
        };
    }

    public fun total_supply(arg0: &CollectionState) : u64 {
        arg0.total_supply
    }

    public fun treasury(arg0: &CollectionState) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

