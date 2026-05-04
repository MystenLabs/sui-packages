module 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct SoulCollection has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        extra_royalty_bps: u16,
        tradeable: bool,
        current_holder: address,
        current_holder_kiosk_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
    }

    struct SoulCollectionRight has store, key {
        id: 0x2::object::UID,
        version: u64,
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SoulCollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        creator: address,
        current_holder: address,
        tradeable: bool,
        max_supply: 0x1::option::Option<u64>,
    }

    struct SoulAddedToCollection has copy, drop {
        collection_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        current_supply: u64,
        max_supply: 0x1::option::Option<u64>,
    }

    struct CollectionHolderUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        previous_holder: address,
        current_holder: address,
    }

    public fun add_soul(arg0: &mut SoulCollection, arg1: &mut 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::state_creator(arg1) == arg0.creator, 3);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg1, 0x2::tx_context::sender(arg2));
        assert!(!0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::is_listed(arg1), 6);
        if (0x1::option::is_some<u64>(&arg0.max_supply)) {
            assert!(arg0.current_supply < *0x1::option::borrow<u64>(&arg0.max_supply), 4);
        };
        arg0.current_supply = arg0.current_supply + 1;
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::bind_collection(arg1, 0x2::object::id<SoulCollection>(arg0));
        let v0 = SoulAddedToCollection{
            collection_id  : 0x2::object::id<SoulCollection>(arg0),
            soul_id        : 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg1),
            current_supply : arg0.current_supply,
            max_supply     : arg0.max_supply,
        };
        0x2::event::emit<SoulAddedToCollection>(v0);
    }

    public(friend) fun assert_tradeable(arg0: &SoulCollection) {
        assert!(arg0.tradeable, 2);
    }

    public fun collection_id(arg0: &SoulCollectionRight) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun collection_right_version(arg0: &SoulCollectionRight) : u64 {
        arg0.version
    }

    public fun collection_version(arg0: &SoulCollection) : u64 {
        arg0.version
    }

    public(friend) fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16, arg4: bool, arg5: 0x1::option::Option<u64>, arg6: address, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : (SoulCollection, SoulCollectionRight) {
        assert!(arg3 <= 10000, 0);
        assert!(0x1::option::is_none<u64>(&arg5) || *0x1::option::borrow<u64>(&arg5) >= 1, 5);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = SoulCollectionRight{
            id            : 0x2::object::new(arg8),
            version       : 1,
            collection_id : v2,
            creator       : v0,
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
        };
        let v4 = 0x2::object::id<SoulCollectionRight>(&v3);
        let v5 = SoulCollection{
            id                      : v1,
            version                 : 1,
            creator                 : v0,
            extra_royalty_bps       : arg3,
            tradeable               : arg4,
            current_holder          : arg6,
            current_holder_kiosk_id : arg7,
            right_id                : v4,
            max_supply              : arg5,
            current_supply          : 0,
        };
        let v6 = SoulCollectionCreated{
            collection_id  : v2,
            right_id       : v4,
            creator        : v0,
            current_holder : arg6,
            tradeable      : arg4,
            max_supply     : arg5,
        };
        0x2::event::emit<SoulCollectionCreated>(v6);
        (v5, v3)
    }

    fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<SoulCollectionRight> {
        let v0 = 0x2::display::new<SoulCollectionRight>(arg0, arg1);
        0x2::display::add<SoulCollectionRight>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SoulCollectionRight>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SoulCollectionRight>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SoulCollectionRight>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<SoulCollectionRight>(&mut v0);
        v0
    }

    public fun creator(arg0: &SoulCollection) : address {
        arg0.creator
    }

    public fun current_holder(arg0: &SoulCollection) : address {
        arg0.current_holder
    }

    public fun current_holder_kiosk_id(arg0: &SoulCollection) : 0x2::object::ID {
        arg0.current_holder_kiosk_id
    }

    public fun current_supply(arg0: &SoulCollection) : u64 {
        arg0.current_supply
    }

    public fun extra_royalty_bps(arg0: &SoulCollection) : u16 {
        arg0.extra_royalty_bps
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = create_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<SoulCollectionRight>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public fun max_supply(arg0: &SoulCollection) : 0x1::option::Option<u64> {
        arg0.max_supply
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun right_id(arg0: &SoulCollection) : 0x2::object::ID {
        arg0.right_id
    }

    public(friend) fun share_collection(arg0: SoulCollection) {
        0x2::transfer::share_object<SoulCollection>(arg0);
    }

    public fun tradeable(arg0: &SoulCollection) : bool {
        arg0.tradeable
    }

    public(friend) fun update_holder(arg0: &mut SoulCollection, arg1: address, arg2: 0x2::object::ID) {
        arg0.current_holder = arg1;
        arg0.current_holder_kiosk_id = arg2;
        let v0 = CollectionHolderUpdated{
            collection_id   : 0x2::object::id<SoulCollection>(arg0),
            previous_holder : arg0.current_holder,
            current_holder  : arg1,
        };
        0x2::event::emit<CollectionHolderUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

