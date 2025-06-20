module 0x548e6a6d41d70f4935e59a3f18bd415d2d86131bc7df0c6fe576f0cd488230a1::CrossmintCollection {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct CROSSMINTCOLLECTION has drop {
        dummy_field: bool,
    }

    struct CollectionConfiguration has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        version: u64,
    }

    struct MinterAdded has copy, drop {
        config_id: 0x2::object::ID,
        minter: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        config_id: 0x2::object::ID,
        version: u64,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ConfigCreated has copy, drop {
        object_id: 0x2::object::ID,
    }

    public entry fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun add_minter(arg0: &AdminCap, arg1: &CollectionConfiguration, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        0x2::transfer::public_transfer<MinterCap>(v0, arg2);
        let v1 = MinterAdded{
            config_id : 0x2::object::id<CollectionConfiguration>(arg1),
            minter    : arg2,
        };
        0x2::event::emit<MinterAdded>(v1);
    }

    fun assert_is_collection_nft(arg0: &CollectionConfiguration, arg1: &NFT) {
        assert!(0x2::object::id<CollectionConfiguration>(arg0) == arg1.config_id, 2);
    }

    fun assert_not_paused(arg0: &CollectionConfiguration) {
        assert!(!arg0.is_paused, 3);
    }

    public entry fun burn(arg0: &AdminCap, arg1: &mut CollectionConfiguration, arg2: NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        ensure_latest_version(v0, arg1);
        burn_internal(arg2, arg1);
    }

    fun burn_internal(arg0: NFT, arg1: &CollectionConfiguration) {
        assert_not_paused(arg1);
        assert_is_collection_nft(arg1, &arg0);
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            config_id   : _,
            version     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun create_configuration(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionConfiguration{
            id        : 0x2::object::new(arg1),
            is_paused : false,
            version   : 1,
        };
        let v1 = ConfigCreated{object_id: 0x2::object::id<CollectionConfiguration>(&v0)};
        0x2::event::emit<ConfigCreated>(v1);
        0x2::transfer::public_transfer<CollectionConfiguration>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    fun ensure_latest_version(arg0: &mut NFT, arg1: &mut CollectionConfiguration) {
        if (arg0.version < 1) {
            migrate_nft(arg0);
        };
        if (arg1.version < 1) {
            migrate_collection(arg1);
        };
    }

    fun init(arg0: CROSSMINTCOLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<CROSSMINTCOLLECTION>(arg0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        create_configuration(&v2, arg1);
        let v4 = 0x2::display::new<NFT>(&v1, arg1);
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<NFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v4, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        0x2::transfer::public_transfer<MinterCap>(v3, v0);
    }

    fun migrate_collection(arg0: &mut CollectionConfiguration) {
        arg0.version = 1;
    }

    fun migrate_nft(arg0: &mut NFT) {
        arg0.version = 1;
    }

    public entry fun mint_to_recipient(arg0: &MinterCap, arg1: &CollectionConfiguration, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        mint_to_recipient_internal(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mint_to_recipient_and_authorize(arg0: &AdminCap, arg1: &CollectionConfiguration, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        add_minter(arg0, arg1, arg6, arg7);
        mint_to_recipient_internal(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    fun mint_to_recipient_internal(arg0: &CollectionConfiguration, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            config_id   : 0x2::object::id<CollectionConfiguration>(arg0),
            version     : arg0.version,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v0),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg4);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun pause_collection(arg0: &AdminCap, arg1: &mut CollectionConfiguration, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1.is_paused) {
            abort 4
        };
        arg1.is_paused = true;
    }

    public entry fun unpause_collection(arg0: &AdminCap, arg1: &mut CollectionConfiguration, arg2: &mut 0x2::tx_context::TxContext) {
        if (!arg1.is_paused) {
            abort 5
        };
        arg1.is_paused = false;
    }

    public entry fun update_metadata(arg0: &AdminCap, arg1: &mut CollectionConfiguration, arg2: &mut NFT, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_latest_version(arg2, arg1);
        update_metadata_internal(arg2, arg1, arg3, arg4, arg5);
    }

    fun update_metadata_internal(arg0: &mut NFT, arg1: &CollectionConfiguration, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>) {
        assert_not_paused(arg1);
        assert_is_collection_nft(arg1, arg0);
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            arg0.name = 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg2));
        };
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
            arg0.description = 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&arg3));
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            arg0.url = 0x2::url::new_unsafe_from_bytes(*0x1::option::borrow<vector<u8>>(&arg4));
        };
    }

    // decompiled from Move bytecode v6
}

