module 0x3ece2d5dd427e5ebc700ed16c80a6567f6ec83007b92cb7577b10e26867bb38::videos_nft {
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
        video_url: 0x2::url::Url,
        price: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        creator: address,
        serial_number: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        collection: address,
        url: 0x2::url::Url,
        owner: address,
        price: u64,
        serial_number: u64,
        video_url: 0x2::url::Url,
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

    public fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 4);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 4);
        assert!(arg2 > 0, 6);
        let v0 = NFTCollection{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg0),
            title          : 0x1::string::utf8(arg1),
            creator        : arg4,
            max_supply     : arg2,
            current_supply : 0,
            url            : 0x2::url::new_unsafe_from_bytes(arg3),
            video_url      : 0x2::url::new_unsafe_from_bytes(arg5),
            price          : arg6,
        };
        let v1 = CollectionCreated{
            collection_id : 0x2::object::id_address<NFTCollection>(&v0),
            creator       : arg4,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::share_object<NFTCollection>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_nft(arg0: &mut NFTCollection, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_supply < arg0.max_supply, 6);
        arg0.current_supply = arg0.current_supply + 1;
        let v0 = NFT{
            id            : 0x2::object::new(arg1),
            name          : arg0.name,
            collection    : 0x2::object::id_address<NFTCollection>(arg0),
            url           : arg0.url,
            owner         : 0x2::tx_context::sender(arg1),
            price         : arg0.price,
            serial_number : arg0.current_supply,
            video_url     : arg0.video_url,
        };
        let v1 = NFTMinted{
            nft_id        : 0x2::object::id_address<NFT>(&v0),
            creator       : 0x2::tx_context::sender(arg1),
            serial_number : arg0.current_supply,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

