module 0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_poap {
    struct SUILENS_POAP has drop {
        dummy_field: bool,
    }

    struct POAPCollection has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: 0x1::option::Option<u64>,
        claimed_count: u64,
        claimers: 0x2::vec_set::VecSet<address>,
        is_active: bool,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
    }

    struct POAP has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        claimed_by: address,
        claimed_at: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct POAPRegistry has key {
        id: 0x2::object::UID,
        collections: 0x2::table::Table<0x2::object::ID, POAPCollection>,
        event_collections: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        user_poaps: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        total_collections: u64,
        total_poaps_minted: u64,
    }

    struct POAPCollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct POAPClaimed has copy, drop {
        poap_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        claimer: address,
    }

    public fun add_collection_metadata(arg0: &mut POAPRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, POAPCollection>(&arg0.collections, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, POAPCollection>(&mut arg0.collections, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.metadata, arg2, arg3);
    }

    public fun claim_poap(arg0: &mut POAPRegistry, arg1: &0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::has_attended_event(arg1, arg2, v0), 4);
        assert!(v1 > 0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::get_event_end_date(arg1, arg2), 5);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg2), 2);
        let v2 = *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg2);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, POAPCollection>(&mut arg0.collections, v2);
        assert!(v3.is_active, 6);
        assert!(!0x2::vec_set::contains<address>(&v3.claimers, &v0), 3);
        if (0x1::option::is_some<u64>(&v3.max_supply)) {
            assert!(v3.claimed_count < *0x1::option::borrow<u64>(&v3.max_supply), 7);
        };
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = POAP{
            id            : v4,
            collection_id : v2,
            event_id      : arg2,
            name          : v3.name,
            description   : v3.description,
            image_url     : v3.image_url,
            claimed_by    : v0,
            claimed_at    : v1,
            attributes    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6.attributes, 0x1::string::utf8(b"event_title"), 0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::get_event_title(arg1, arg2));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6.attributes, 0x1::string::utf8(b"event_location"), 0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::get_event_location(arg1, arg2));
        v3.claimed_count = v3.claimed_count + 1;
        0x2::vec_set::insert<address>(&mut v3.claimers, v0);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_poaps, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_poaps, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_poaps, v0), v5);
        arg0.total_poaps_minted = arg0.total_poaps_minted + 1;
        0x2::transfer::public_transfer<POAP>(v6, v0);
        let v7 = POAPClaimed{
            poap_id       : v5,
            collection_id : v2,
            event_id      : arg2,
            claimer       : v0,
        };
        0x2::event::emit<POAPClaimed>(v7);
    }

    public fun create_poap_collection(arg0: &mut POAPRegistry, arg1: &0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core::get_event_creator(arg1, arg2) == v0, 0);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg2), 3);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = POAPCollection{
            id            : v1,
            event_id      : arg2,
            creator       : v0,
            name          : arg3,
            description   : arg4,
            image_url     : arg5,
            max_supply    : arg6,
            claimed_count : 0,
            claimers      : 0x2::vec_set::empty<address>(),
            is_active     : true,
            metadata      : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            created_at    : 0x2::clock::timestamp_ms(arg7),
        };
        let v4 = POAPCollectionCreated{
            collection_id : v2,
            event_id      : arg2,
            creator       : v0,
            name          : v3.name,
        };
        0x2::event::emit<POAPCollectionCreated>(v4);
        0x2::table::add<0x2::object::ID, POAPCollection>(&mut arg0.collections, v2, v3);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.event_collections, arg2, v2);
        arg0.total_collections = arg0.total_collections + 1;
    }

    public fun deactivate_collection(arg0: &mut POAPRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, POAPCollection>(&arg0.collections, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, POAPCollection>(&mut arg0.collections, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg2), 0);
        v0.is_active = false;
    }

    public fun get_collection(arg0: &POAPRegistry, arg1: 0x2::object::ID) : &POAPCollection {
        0x2::table::borrow<0x2::object::ID, POAPCollection>(&arg0.collections, arg1)
    }

    public fun get_collection_claims(arg0: &POAPRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, POAPCollection>(&arg0.collections, arg1).claimed_count
    }

    public fun get_event_collection(arg0: &POAPRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_total_poaps_minted(arg0: &POAPRegistry) : u64 {
        arg0.total_poaps_minted
    }

    public fun get_user_poaps(arg0: &POAPRegistry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_poaps, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_poaps, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun has_claimed_poap(arg0: &POAPRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<0x2::object::ID, POAPCollection>(&arg0.collections, *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.event_collections, arg1)).claimers, &arg2)
    }

    fun init(arg0: SUILENS_POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = POAPRegistry{
            id                 : 0x2::object::new(arg1),
            collections        : 0x2::table::new<0x2::object::ID, POAPCollection>(arg1),
            event_collections  : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            user_poaps         : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
            total_collections  : 0,
            total_poaps_minted : 0,
        };
        let v1 = 0x2::package::claim<SUILENS_POAP>(arg0, arg1);
        let v2 = 0x2::display::new<POAP>(&v1, arg1);
        0x2::display::add<POAP>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<POAP>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<POAP>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<POAP>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suilens.xyz"));
        0x2::display::add<POAP>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SUI-Lens Platform"));
        0x2::display::update_version<POAP>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<POAP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<POAPRegistry>(v0);
    }

    public fun update_collection(arg0: &mut POAPRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, POAPCollection>(&arg0.collections, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, POAPCollection>(&mut arg0.collections, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg5), 0);
        v0.name = arg2;
        v0.description = arg3;
        v0.image_url = arg4;
    }

    // decompiled from Move bytecode v6
}

