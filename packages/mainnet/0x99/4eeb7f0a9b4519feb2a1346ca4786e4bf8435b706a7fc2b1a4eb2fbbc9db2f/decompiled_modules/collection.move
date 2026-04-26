module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct SoulCollection has key {
        id: 0x2::object::UID,
        creator: address,
        extra_royalty_bps: u16,
        tradeable: bool,
        current_holder: address,
        current_holder_kiosk_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
    }

    struct SoulCollectionRight has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        extra_royalty_bps: u16,
        tradeable: bool,
    }

    struct SoulCollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        creator: address,
        current_holder: address,
        tradeable: bool,
    }

    struct SoulAddedToCollection has copy, drop {
        collection_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct CollectionHolderUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        previous_holder: address,
        current_holder: address,
    }

    public fun add_soul(arg0: &SoulCollection, arg1: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::state_creator(arg1) == arg0.creator, 3);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg2));
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::bind_collection(arg1, 0x2::object::id<SoulCollection>(arg0));
        let v0 = SoulAddedToCollection{
            collection_id : 0x2::object::id<SoulCollection>(arg0),
            soul_id       : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1),
        };
        0x2::event::emit<SoulAddedToCollection>(v0);
    }

    public(friend) fun assert_tradeable(arg0: &SoulCollection) {
        assert!(arg0.tradeable, 2);
    }

    public fun collection_id(arg0: &SoulCollectionRight) : 0x2::object::ID {
        arg0.collection_id
    }

    public(friend) fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u16, arg4: bool, arg5: address, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : (SoulCollection, SoulCollectionRight) {
        assert!(arg3 <= 10000, 0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = SoulCollectionRight{
            id                : 0x2::object::new(arg7),
            collection_id     : v2,
            creator           : v0,
            name              : arg0,
            description       : arg1,
            image_url         : arg2,
            extra_royalty_bps : arg3,
            tradeable         : arg4,
        };
        let v4 = 0x2::object::id<SoulCollectionRight>(&v3);
        let v5 = SoulCollection{
            id                      : v1,
            creator                 : v0,
            extra_royalty_bps       : arg3,
            tradeable               : arg4,
            current_holder          : arg5,
            current_holder_kiosk_id : arg6,
            right_id                : v4,
        };
        let v6 = SoulCollectionCreated{
            collection_id  : v2,
            right_id       : v4,
            creator        : v0,
            current_holder : arg5,
            tradeable      : arg4,
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

    public fun extra_royalty_bps(arg0: &SoulCollection) : u16 {
        arg0.extra_royalty_bps
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = create_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<SoulCollectionRight>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public fun right_id(arg0: &SoulCollection) : 0x2::object::ID {
        arg0.right_id
    }

    public fun right_tradeable(arg0: &SoulCollectionRight) : bool {
        arg0.tradeable
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

