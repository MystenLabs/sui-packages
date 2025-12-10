module 0x1df382f1d4ffecbf4e2ceaadca021a68b353bb502011e5a1c6bed2979b4be186::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct SuikamonCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_url: 0x1::string::String,
        creator: address,
    }

    struct SuikamonCollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct SuikamonCollectionCreatedEvent has copy, drop {
        creator: address,
        collection_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun new(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : (SuikamonCollection, SuikamonCollectionAdminCap) {
        let v0 = SuikamonCollection{
            id           : 0x2::object::new(arg5),
            name         : arg1,
            description  : arg2,
            image_url    : arg4,
            external_url : arg3,
            creator      : arg0,
        };
        let v1 = SuikamonCollectionAdminCap{
            id            : 0x2::object::new(arg5),
            collection_id : 0x2::object::id<SuikamonCollection>(&v0),
        };
        let v2 = SuikamonCollectionCreatedEvent{
            creator       : arg0,
            collection_id : 0x2::object::id<SuikamonCollection>(&v0),
            admin_cap_id  : 0x2::object::id<SuikamonCollectionAdminCap>(&v1),
            name          : arg1,
        };
        0x2::event::emit<SuikamonCollectionCreatedEvent>(v2);
        (v0, v1)
    }

    public fun creator(arg0: &SuikamonCollection) : address {
        arg0.creator
    }

    public fun description(arg0: &SuikamonCollection) : 0x1::string::String {
        arg0.description
    }

    public fun destroy_admin_cap(arg0: SuikamonCollectionAdminCap) {
        let SuikamonCollectionAdminCap {
            id            : v0,
            collection_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun external_url(arg0: &SuikamonCollection) : 0x1::string::String {
        arg0.external_url
    }

    public fun image_url(arg0: &SuikamonCollection) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<SuikamonCollection>(&v0, arg1);
        0x2::display::add<SuikamonCollection>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuikamonCollection>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuikamonCollection>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuikamonCollection>(&mut v1, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<SuikamonCollection>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::transfer::public_transfer<0x2::display::Display<SuikamonCollection>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &SuikamonCollection) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

