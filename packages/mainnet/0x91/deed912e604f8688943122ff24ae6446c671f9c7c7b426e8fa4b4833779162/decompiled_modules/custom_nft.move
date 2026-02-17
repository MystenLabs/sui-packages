module 0x91deed912e604f8688943122ff24ae6446c671f9c7c7b426e8fa4b4833779162::custom_nft {
    struct CUSTOM_NFT has drop {
        dummy_field: bool,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_url: 0x1::string::String,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct CustomNft has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_source_kind: u8,
        image_url: 0x1::string::String,
        image_object_id: 0x1::string::String,
        external_url: 0x1::string::String,
        attributes_json: 0x1::string::String,
        has_collection: bool,
        collection_id: address,
        royalty_bps: u64,
        created_at_ms: u64,
    }

    struct CollectionCreated has copy, drop {
        id: address,
        owner: address,
    }

    struct CollectionUpdated has copy, drop {
        id: address,
        owner: address,
    }

    struct CollectionDeleted has copy, drop {
        id: address,
        owner: address,
    }

    struct NftMinted has copy, drop {
        id: address,
        creator: address,
        owner: address,
        image_source_kind: u8,
        has_collection: bool,
        collection_id: address,
    }

    struct NftUpdated has copy, drop {
        id: address,
        updater: address,
    }

    struct NftCollectionUpdated has copy, drop {
        id: address,
        updater: address,
        has_collection: bool,
        collection_id: address,
    }

    struct NftBurned has copy, drop {
        id: address,
        burner: address,
    }

    fun assert_max_len(arg0: &0x1::string::String, arg1: u64) {
        assert!(0x1::vector::length<u8>(0x1::string::bytes(arg0)) <= arg1, 6);
    }

    public entry fun burn(arg0: CustomNft, arg1: &0x2::tx_context::TxContext) {
        let CustomNft {
            id                : v0,
            creator           : _,
            name              : _,
            symbol            : _,
            description       : _,
            image_source_kind : _,
            image_url         : _,
            image_object_id   : _,
            external_url      : _,
            attributes_json   : _,
            has_collection    : _,
            collection_id     : _,
            royalty_bps       : _,
            created_at_ms     : _,
        } = arg0;
        0x2::object::delete(v0);
        let v14 = NftBurned{
            id     : 0x2::object::id_address<CustomNft>(&arg0),
            burner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NftBurned>(v14);
    }

    public entry fun clear_nft_collection(arg0: &mut CustomNft, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 8);
        arg0.has_collection = false;
        arg0.collection_id = @0x0;
        let v0 = NftCollectionUpdated{
            id             : 0x2::object::id_address<CustomNft>(arg0),
            updater        : 0x2::tx_context::sender(arg1),
            has_collection : false,
            collection_id  : @0x0,
        };
        0x2::event::emit<NftCollectionUpdated>(v0);
    }

    public entry fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        validate_collection_metadata(&arg0, &arg1, &arg2, &arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = Collection{
            id            : 0x2::object::new(arg4),
            owner         : v0,
            name          : arg0,
            description   : arg1,
            image_url     : arg2,
            external_url  : arg3,
            created_at_ms : v1,
            updated_at_ms : v1,
        };
        let v3 = CollectionCreated{
            id    : 0x2::object::id_address<Collection>(&v2),
            owner : v0,
        };
        0x2::event::emit<CollectionCreated>(v3);
        0x2::transfer::public_transfer<Collection>(v2, v0);
    }

    public entry fun delete_collection(arg0: Collection, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 10);
        let Collection {
            id            : v0,
            owner         : v1,
            name          : _,
            description   : _,
            image_url     : _,
            external_url  : _,
            created_at_ms : _,
            updated_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v8 = CollectionDeleted{
            id    : 0x2::object::id_address<Collection>(&arg0),
            owner : v1,
        };
        0x2::event::emit<CollectionDeleted>(v8);
    }

    fun init(arg0: CUSTOM_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CUSTOM_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_id"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_id}"));
        let v5 = 0x2::display::new_with_fields<CustomNft>(&v0, v1, v3, arg1);
        0x2::display::update_version<CustomNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CustomNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun is_empty(arg0: &0x1::string::String) : bool {
        0x1::vector::length<u8>(0x1::string::bytes(arg0)) == 0
    }

    fun mint_internal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: bool, arg10: address, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        validate_nft_metadata(&arg0, &arg1, &arg2, arg3, &arg4, &arg5, &arg6, &arg7, arg8);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = CustomNft{
            id                : 0x2::object::new(arg12),
            creator           : v0,
            name              : arg0,
            symbol            : arg1,
            description       : arg2,
            image_source_kind : arg3,
            image_url         : arg4,
            image_object_id   : arg5,
            external_url      : arg6,
            attributes_json   : arg7,
            has_collection    : arg9,
            collection_id     : arg10,
            royalty_bps       : arg8,
            created_at_ms     : 0x2::tx_context::epoch_timestamp_ms(arg12),
        };
        let v2 = NftMinted{
            id                : 0x2::object::id_address<CustomNft>(&v1),
            creator           : v0,
            owner             : arg11,
            image_source_kind : arg3,
            has_collection    : arg9,
            collection_id     : arg10,
        };
        0x2::event::emit<NftMinted>(v2);
        0x2::transfer::public_transfer<CustomNft>(v1, arg11);
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, @0x0, arg9, arg10);
    }

    public entry fun mint_to_address_with_collection(arg0: &Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg11), 10);
        mint_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, 0x2::object::id_address<Collection>(arg0), arg10, arg11);
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, @0x0, v0, arg9);
    }

    public entry fun mint_to_sender_with_collection(arg0: &Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg0.owner == v0, 10);
        mint_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, 0x2::object::id_address<Collection>(arg0), v0, arg10);
    }

    public entry fun set_nft_collection(arg0: &mut CustomNft, arg1: &Collection, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 8);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 10);
        arg0.has_collection = true;
        arg0.collection_id = 0x2::object::id_address<Collection>(arg1);
        let v0 = NftCollectionUpdated{
            id             : 0x2::object::id_address<CustomNft>(arg0),
            updater        : 0x2::tx_context::sender(arg2),
            has_collection : true,
            collection_id  : arg0.collection_id,
        };
        0x2::event::emit<NftCollectionUpdated>(v0);
    }

    public fun source_image_id_kind() : u8 {
        2
    }

    public fun source_url_kind() : u8 {
        1
    }

    public entry fun update_collection(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 10);
        validate_collection_metadata(&arg1, &arg2, &arg3, &arg4);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
        arg0.external_url = arg4;
        arg0.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v0 = CollectionUpdated{
            id    : 0x2::object::id_address<Collection>(arg0),
            owner : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectionUpdated>(v0);
    }

    public entry fun update_nft_metadata(arg0: &mut CustomNft, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg10), 8);
        validate_nft_metadata(&arg1, &arg2, &arg3, arg4, &arg5, &arg6, &arg7, &arg8, arg9);
        arg0.name = arg1;
        arg0.symbol = arg2;
        arg0.description = arg3;
        arg0.image_source_kind = arg4;
        arg0.image_url = arg5;
        arg0.image_object_id = arg6;
        arg0.external_url = arg7;
        arg0.attributes_json = arg8;
        arg0.royalty_bps = arg9;
        let v0 = NftUpdated{
            id      : 0x2::object::id_address<CustomNft>(arg0),
            updater : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<NftUpdated>(v0);
    }

    fun validate_collection_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String) {
        assert!(!is_empty(arg0), 9);
        assert_max_len(arg0, 128);
        assert_max_len(arg1, 2048);
        assert_max_len(arg2, 2048);
        assert_max_len(arg3, 2048);
    }

    fun validate_nft_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u8, arg4: &0x1::string::String, arg5: &0x1::string::String, arg6: &0x1::string::String, arg7: &0x1::string::String, arg8: u64) {
        assert!(!is_empty(arg0), 1);
        assert!(!is_empty(arg1), 2);
        assert!(arg3 == 1 || arg3 == 2, 3);
        assert!(arg8 <= 10000, 7);
        assert_max_len(arg0, 128);
        assert_max_len(arg1, 128);
        assert_max_len(arg2, 2048);
        assert_max_len(arg4, 2048);
        assert_max_len(arg5, 96);
        assert_max_len(arg6, 2048);
        assert_max_len(arg7, 16384);
        assert!(!is_empty(arg4), 4);
        if (arg3 == 2) {
            assert!(!is_empty(arg5), 5);
        };
    }

    // decompiled from Move bytecode v6
}

