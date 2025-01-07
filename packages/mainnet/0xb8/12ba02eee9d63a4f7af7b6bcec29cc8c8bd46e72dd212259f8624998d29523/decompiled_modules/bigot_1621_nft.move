module 0xb812ba02eee9d63a4f7af7b6bcec29cc8c8bd46e72dd212259f8624998d29523::bigot_1621_nft {
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
        description: 0x1::string::String,
        creator: address,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        sealed: bool,
        url: 0x2::url::Url,
        nft_type: u32,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        creator: address,
        serial_number: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        collection: address,
        url: 0x2::url::Url,
        serial_number: u64,
        frozen: bool,
        owner: address,
        metadata_hash: vector<u8>,
    }

    struct CollectionCreated has copy, drop {
        collection_id: address,
        creator: address,
        max_supply: 0x1::option::Option<u64>,
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

    public fun create_bigot_collection(arg0: &mut AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<u64>, arg4: vector<u8>, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 4);
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg7)), 2);
        assert!(arg5 == 1 || arg5 == 2, 0);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(0x1::option::destroy_some<u64>(arg3) > 0, 6);
        };
        let v0 = NFTCollection{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg1),
            description    : 0x1::string::utf8(arg2),
            creator        : arg6,
            max_supply     : arg3,
            current_supply : 0,
            sealed         : false,
            url            : 0x2::url::new_unsafe_from_bytes(arg4),
            nft_type       : arg5,
        };
        let v1 = CollectionCreated{
            collection_id : 0x2::object::id_address<NFTCollection>(&v0),
            creator       : arg6,
            max_supply    : arg3,
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

    public fun mint_nft(arg0: &mut NFTCollection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg0.max_supply)) {
            assert!(arg0.current_supply < 0x1::option::destroy_some<u64>(arg0.max_supply), 6);
        };
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 4);
        arg0.current_supply = arg0.current_supply + 1;
        let v0 = NFT{
            id            : 0x2::object::new(arg5),
            name          : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            collection    : 0x2::object::id_address<NFTCollection>(arg0),
            url           : arg0.url,
            serial_number : arg0.current_supply,
            frozen        : false,
            owner         : 0x2::tx_context::sender(arg5),
            metadata_hash : arg3,
        };
        let v1 = NFTMinted{
            nft_id        : 0x2::object::id_address<NFT>(&v0),
            creator       : 0x2::tx_context::sender(arg5),
            serial_number : arg0.current_supply,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<NFT>(v0, arg4);
    }

    public fun remove_admin_super(arg0: &SuperAdminCap, arg1: &mut AdminCap, arg2: address) {
        let (_, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        0x1::vector::remove<address>(&mut arg1.admins, v1);
        let v2 = AdminRemoved{admin: arg2};
        0x2::event::emit<AdminRemoved>(v2);
    }

    // decompiled from Move bytecode v6
}

