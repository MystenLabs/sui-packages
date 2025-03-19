module 0x9d79d0b3b4f72142b568f112312f1866982c77132d496c9d9c44acdf6f008953::CrossmintCollection {
    struct CROSSMINTCOLLECTION has drop {
        dummy_field: bool,
    }

    struct CollectionConfiguration has store, key {
        id: 0x2::object::UID,
        admin: address,
        delegated_admins: vector<address>,
        is_paused: bool,
    }

    struct DelegatedAdminAdded has copy, drop {
        collection_id: 0x2::object::ID,
        delegated_admin: address,
    }

    struct DelegatedAdminRemoved has copy, drop {
        collection_id: 0x2::object::ID,
        delegated_admin: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct CollectionCreated has copy, drop {
        object_id: 0x2::object::ID,
        admin: address,
    }

    public entry fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun add_delegated_admin(arg0: &mut CollectionConfiguration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(get_admin(arg0) == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<address>(&mut arg0.delegated_admins, arg1);
        let v0 = DelegatedAdminAdded{
            collection_id   : 0x2::object::id<CollectionConfiguration>(arg0),
            delegated_admin : arg1,
        };
        0x2::event::emit<DelegatedAdminAdded>(v0);
    }

    public entry fun burn(arg0: &CollectionConfiguration, arg1: NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CollectionConfiguration>(arg0) == arg1.collection_id, 2);
        assert!(is_sender_authorized(arg0, 0x2::tx_context::sender(arg2)), 1);
        let NFT {
            id            : v0,
            name          : _,
            description   : _,
            url           : _,
            collection_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun create_collection(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionConfiguration{
            id               : 0x2::object::new(arg1),
            admin            : arg0,
            delegated_admins : 0x1::vector::empty<address>(),
            is_paused        : false,
        };
        let v1 = CollectionCreated{
            object_id : 0x2::object::id<CollectionConfiguration>(&v0),
            admin     : v0.admin,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::public_transfer<CollectionConfiguration>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    fun get_admin(arg0: &CollectionConfiguration) : address {
        arg0.admin
    }

    fun init(arg0: CROSSMINTCOLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<CROSSMINTCOLLECTION>(arg0, arg1);
        create_collection(v0, arg1);
        let v2 = 0x2::display::new<NFT>(&v1, arg1);
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<NFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    fun is_sender_authorized(arg0: &CollectionConfiguration, arg1: address) : bool {
        arg1 == get_admin(arg0) || 0x1::vector::contains<address>(&arg0.delegated_admins, &arg1)
    }

    public entry fun mint_to_recipient(arg0: &CollectionConfiguration, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_sender_authorized(arg0, v0), 1);
        let v1 = NFT{
            id            : 0x2::object::new(arg5),
            name          : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            url           : 0x2::url::new_unsafe_from_bytes(arg3),
            collection_id : 0x2::object::id<CollectionConfiguration>(arg0),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, arg4);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun remove_delegated_admin(arg0: &mut CollectionConfiguration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(get_admin(arg0) == 0x2::tx_context::sender(arg2), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.delegated_admins, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.delegated_admins, v1);
        let v2 = DelegatedAdminRemoved{
            collection_id   : 0x2::object::id<CollectionConfiguration>(arg0),
            delegated_admin : arg1,
        };
        0x2::event::emit<DelegatedAdminRemoved>(v2);
    }

    public entry fun update_metadata(arg0: &CollectionConfiguration, arg1: &mut NFT, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CollectionConfiguration>(arg0) == arg1.collection_id, 2);
        assert!(is_sender_authorized(arg0, 0x2::tx_context::sender(arg5)), 1);
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            arg1.name = 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg2));
        };
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
            arg1.description = 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg3));
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            arg1.url = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg4));
        };
    }

    // decompiled from Move bytecode v6
}

