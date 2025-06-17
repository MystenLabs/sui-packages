module 0x70f8472eabffac803a8bba1cdbc124356122c8ae5f90ba22c57d4418cc2e91bb::collection {
    struct TrenchBuddyNftCollectionMeta has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        external_url: 0x2::url::Url,
        total_supply: u64,
        minted: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        minted_number: u64,
    }

    public entry fun create_collection(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TrenchBuddyNftCollectionMeta{
            id           : 0x2::object::new(arg6),
            name         : arg1,
            description  : arg2,
            url          : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg3))),
            external_url : 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg4))),
            total_supply : arg5,
            minted       : 0,
        };
        let v1 = CollectionCreated{
            collection_id : 0x2::object::id<TrenchBuddyNftCollectionMeta>(&v0),
            name          : v0.name,
            creator       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::public_share_object<TrenchBuddyNftCollectionMeta>(v0);
    }

    public fun get_description(arg0: &TrenchBuddyNftCollectionMeta) : &0x1::string::String {
        &arg0.description
    }

    public fun get_external_url(arg0: &TrenchBuddyNftCollectionMeta) : &0x2::url::Url {
        &arg0.external_url
    }

    public fun get_minted(arg0: &TrenchBuddyNftCollectionMeta) : u64 {
        arg0.minted
    }

    public fun get_name(arg0: &TrenchBuddyNftCollectionMeta) : &0x1::string::String {
        &arg0.name
    }

    public fun get_remaining(arg0: &TrenchBuddyNftCollectionMeta) : u64 {
        if (arg0.total_supply == 0) {
            return 0
        };
        arg0.total_supply - arg0.minted
    }

    public fun get_total_supply(arg0: &TrenchBuddyNftCollectionMeta) : u64 {
        arg0.total_supply
    }

    public fun get_url(arg0: &TrenchBuddyNftCollectionMeta) : &0x2::url::Url {
        &arg0.url
    }

    public fun increment_minted(arg0: &mut TrenchBuddyNftCollectionMeta, arg1: 0x2::object::ID) {
        arg0.minted = arg0.minted + 1;
        let v0 = NFTMinted{
            collection_id : 0x2::object::id<TrenchBuddyNftCollectionMeta>(arg0),
            nft_id        : arg1,
            minted_number : arg0.minted,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x2::display::new<TrenchBuddyNftCollectionMeta>(&v1, arg1);
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"total_supply"), 0x1::string::utf8(b"{total_supply}"));
        0x2::display::add<TrenchBuddyNftCollectionMeta>(&mut v2, 0x1::string::utf8(b"minted"), 0x1::string::utf8(b"{minted}"));
        0x2::display::update_version<TrenchBuddyNftCollectionMeta>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<TrenchBuddyNftCollectionMeta>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_collection(arg0: &AdminCap, arg1: &mut TrenchBuddyNftCollectionMeta, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.url = 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg4)));
        arg1.external_url = 0x2::url::new_unsafe(0x1::ascii::string(*0x1::string::bytes(&arg5)));
    }

    // decompiled from Move bytecode v6
}

