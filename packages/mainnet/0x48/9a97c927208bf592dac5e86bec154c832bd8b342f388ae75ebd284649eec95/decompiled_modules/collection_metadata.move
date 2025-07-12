module 0x489a97c927208bf592dac5e86bec154c832bd8b342f388ae75ebd284649eec95::collection_metadata {
    struct COLLECTION_METADATA has drop {
        dummy_field: bool,
    }

    struct CollectionMetadata has store, key {
        id: 0x2::object::UID,
        item_type: 0x1::type_name::TypeName,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        external_url: 0x1::string::String,
        image_uri: 0x1::string::String,
    }

    struct CollectionMetadataCreatedEvent has copy, drop {
        creator: address,
        collection_metadata_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
    }

    public(friend) fun new<T0: key>(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : CollectionMetadata {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = CollectionMetadata{
            id           : 0x2::object::new(arg5),
            item_type    : v0,
            creator      : arg0,
            name         : arg1,
            description  : arg2,
            external_url : arg3,
            image_uri    : arg4,
        };
        let v2 = CollectionMetadataCreatedEvent{
            creator                : arg0,
            collection_metadata_id : 0x2::object::id<CollectionMetadata>(&v1),
            item_type              : v0,
        };
        0x2::event::emit<CollectionMetadataCreatedEvent>(v2);
        v1
    }

    public fun collection_manager_id(arg0: &CollectionMetadata) : 0x2::object::ID {
        *0x2::dynamic_field::borrow<vector<u8>, 0x2::object::ID>(&arg0.id, b"COLLECTION_MANAGER_ID")
    }

    public fun creator(arg0: &CollectionMetadata) : address {
        arg0.creator
    }

    public fun description(arg0: &CollectionMetadata) : 0x1::string::String {
        arg0.description
    }

    public fun external_url(arg0: &CollectionMetadata) : 0x1::string::String {
        arg0.external_url
    }

    public fun image_uri(arg0: &CollectionMetadata) : 0x1::string::String {
        arg0.image_uri
    }

    fun init(arg0: COLLECTION_METADATA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION_METADATA>(arg0, arg1);
        let v1 = 0x2::display::new<CollectionMetadata>(&v0, arg1);
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"item_type"), 0x1::string::utf8(b"{item_type}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"image_uri"), 0x1::string::utf8(b"walrus://{image_uri}"));
        0x2::display::add<CollectionMetadata>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://testnet.wal.gg/{image_uri}"));
        0x2::transfer::public_transfer<0x2::display::Display<CollectionMetadata>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun item_type(arg0: &CollectionMetadata) : 0x1::type_name::TypeName {
        arg0.item_type
    }

    public fun name(arg0: &CollectionMetadata) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun uid_mut(arg0: &mut CollectionMetadata) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

