module 0xf5c6a16909aeb7642b7eb5613faa5da564ce8fcf9ee31f4c3ee3c38f47fe0dbf::prateek1621_nft {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        title: 0x1::string::String,
        creator: address,
        max_supply: u64,
        current_supply: u64,
        url: 0x2::url::Url,
        video_url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        creator: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        collection: address,
        url: 0x2::url::Url,
        frozen: bool,
        owner: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: address,
        creator: address,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        collection: address,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    public fun add_admin_super(arg0: &SuperAdminCap, arg1: &mut AdminCap, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        let v0 = AdminAdded{admin: arg2};
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun create_prateek_collection(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 4);
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg7)), 2);
        assert!(arg3 > 0, 6);
        let v0 = NFTCollection{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg1),
            title          : 0x1::string::utf8(arg2),
            creator        : arg5,
            max_supply     : arg3,
            current_supply : 0,
            url            : 0x2::url::new_unsafe_from_bytes(arg4),
            video_url      : 0x1::string::utf8(arg6),
        };
        let v1 = CollectionCreated{
            collection_id : 0x2::object::id_address<NFTCollection>(&v0),
            creator       : arg5,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::share_object<NFTCollection>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{
            id     : 0x2::object::new(arg0),
            admins : v1,
        };
        0x2::transfer::share_object<AdminCap>(v2);
    }

    fun isAdmin(arg0: &AdminCap, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public entry fun mint_nft(arg0: &mut NFTCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 4);
        let v0 = NFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            collection  : 0x2::object::id_address<NFTCollection>(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            frozen      : false,
            owner       : 0x2::tx_context::sender(arg6),
        };
        let v1 = NFTMinted{
            nft_id  : 0x2::object::id_address<NFT>(&v0),
            creator : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<NFT>(v0, arg5);
    }

    public fun remove_admin_super(arg0: &SuperAdminCap, arg1: &mut AdminCap, arg2: address) {
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        0x1::vector::remove<address>(&mut arg1.admins, v1);
        let v2 = AdminRemoved{admin: arg2};
        0x2::event::emit<AdminRemoved>(v2);
    }

    // decompiled from Move bytecode v6
}

