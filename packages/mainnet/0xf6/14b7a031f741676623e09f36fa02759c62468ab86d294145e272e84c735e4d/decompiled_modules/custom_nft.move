module 0xf614b7a031f741676623e09f36fa02759c62468ab86d294145e272e84c735e4d::custom_nft {
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
        has_cover: bool,
        cover_nft_id: address,
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
        collection_name: 0x1::string::String,
        cover_tag: 0x1::string::String,
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

    struct CollectionCoverUpdated has copy, drop {
        collection_id: address,
        owner: address,
        cover_nft_id: address,
    }

    struct NftMinted has copy, drop {
        id: address,
        creator: address,
        owner: address,
        image_source_kind: u8,
        has_collection: bool,
        collection_id: address,
        is_collection_cover: bool,
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
        is_collection_cover: bool,
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
            collection_name   : _,
            cover_tag         : _,
            royalty_bps       : _,
            created_at_ms     : _,
        } = arg0;
        0x2::object::delete(v0);
        let v16 = NftBurned{
            id     : 0x2::object::id_address<CustomNft>(&arg0),
            burner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NftBurned>(v16);
    }

    public entry fun clear_collection_cover(arg0: &mut Collection, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.owner == v0, 10);
        arg0.has_cover = false;
        arg0.cover_nft_id = @0x0;
        arg0.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = CollectionCoverUpdated{
            collection_id : 0x2::object::id_address<Collection>(arg0),
            owner         : v0,
            cover_nft_id  : @0x0,
        };
        0x2::event::emit<CollectionCoverUpdated>(v1);
    }

    public entry fun clear_nft_collection(arg0: &mut CustomNft, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 8);
        arg0.has_collection = false;
        arg0.collection_id = @0x0;
        arg0.collection_name = empty_string();
        arg0.cover_tag = empty_string();
        let v0 = NftCollectionUpdated{
            id                  : 0x2::object::id_address<CustomNft>(arg0),
            updater             : 0x2::tx_context::sender(arg1),
            has_collection      : false,
            collection_id       : @0x0,
            is_collection_cover : false,
        };
        0x2::event::emit<NftCollectionUpdated>(v0);
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::bytes(arg0))
    }

    fun cover_string() : 0x1::string::String {
        0x1::string::utf8(x"e5b081e99da2")
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
            has_cover     : false,
            cover_nft_id  : @0x0,
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
            has_cover     : _,
            cover_nft_id  : _,
            created_at_ms : _,
            updated_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
        let v10 = CollectionDeleted{
            id    : 0x2::object::id_address<Collection>(&arg0),
            owner : v1,
        };
        0x2::event::emit<CollectionDeleted>(v10);
    }

    fun empty_string() : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    fun init(arg0: CUSTOM_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CUSTOM_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"cover"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes_json"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{cover_tag}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes_json}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes_json}"));
        let v5 = 0x2::display::new_with_fields<CustomNft>(&v0, v1, v3, arg1);
        0x2::display::update_version<CustomNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CustomNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun is_empty(arg0: &0x1::string::String) : bool {
        0x1::vector::length<u8>(0x1::string::bytes(arg0)) == 0
    }

    fun mint_internal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: bool, arg10: address, arg11: 0x1::string::String, arg12: bool, arg13: 0x1::string::String, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : address {
        validate_nft_metadata(&arg0, &arg1, &arg2, arg3, &arg4, &arg5, &arg6, &arg7, arg8);
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = CustomNft{
            id                : 0x2::object::new(arg15),
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
            collection_name   : arg11,
            cover_tag         : arg13,
            royalty_bps       : arg8,
            created_at_ms     : 0x2::tx_context::epoch_timestamp_ms(arg15),
        };
        let v2 = 0x2::object::id_address<CustomNft>(&v1);
        let v3 = NftMinted{
            id                  : v2,
            creator             : v0,
            owner               : arg14,
            image_source_kind   : arg3,
            has_collection      : arg9,
            collection_id       : arg10,
            is_collection_cover : arg12,
        };
        0x2::event::emit<NftMinted>(v3);
        0x2::transfer::public_transfer<CustomNft>(v1, arg14);
        v2
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, @0x0, empty_string(), false, empty_string(), arg9, arg10);
    }

    public entry fun mint_to_address_with_collection(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg11), 10);
        let v0 = !arg0.has_cover && same_string(&arg5, &arg0.image_url);
        let v1 = if (v0) {
            cover_string()
        } else {
            empty_string()
        };
        let v2 = mint_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, 0x2::object::id_address<Collection>(arg0), clone_string(&arg0.name), v0, v1, arg10, arg11);
        if (v0) {
            arg0.has_cover = true;
            arg0.cover_nft_id = v2;
            arg0.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg11);
        };
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, false, @0x0, empty_string(), false, empty_string(), v0, arg9);
    }

    public entry fun mint_to_sender_with_collection(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg0.owner == v0, 10);
        let v1 = !arg0.has_cover && same_string(&arg5, &arg0.image_url);
        let v2 = if (v1) {
            cover_string()
        } else {
            empty_string()
        };
        let v3 = mint_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, true, 0x2::object::id_address<Collection>(arg0), clone_string(&arg0.name), v1, v2, v0, arg10);
        if (v1) {
            arg0.has_cover = true;
            arg0.cover_nft_id = v3;
            arg0.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg10);
        };
    }

    fun same_string(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = 0x1::string::bytes(arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        if (v2 != 0x1::vector::length<u8>(v1)) {
            return false
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(v0, v3) != *0x1::vector::borrow<u8>(v1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public entry fun set_collection_cover(arg0: &mut Collection, arg1: &mut CustomNft, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 10);
        assert!(arg1.creator == v0, 8);
        let v1 = 0x2::object::id_address<Collection>(arg0);
        assert!(arg1.has_collection, 11);
        assert!(arg1.collection_id == v1, 11);
        arg0.has_cover = true;
        arg0.cover_nft_id = 0x2::object::id_address<CustomNft>(arg1);
        arg0.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg2);
        arg1.collection_name = clone_string(&arg0.name);
        arg1.cover_tag = cover_string();
        let v2 = CollectionCoverUpdated{
            collection_id : v1,
            owner         : v0,
            cover_nft_id  : arg0.cover_nft_id,
        };
        0x2::event::emit<CollectionCoverUpdated>(v2);
        let v3 = NftCollectionUpdated{
            id                  : 0x2::object::id_address<CustomNft>(arg1),
            updater             : v0,
            has_collection      : true,
            collection_id       : v1,
            is_collection_cover : true,
        };
        0x2::event::emit<NftCollectionUpdated>(v3);
    }

    public entry fun set_nft_collection(arg0: &mut CustomNft, arg1: &mut Collection, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 8);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 10);
        let v0 = 0x2::object::id_address<CustomNft>(arg0);
        arg0.has_collection = true;
        arg0.collection_id = 0x2::object::id_address<Collection>(arg1);
        arg0.collection_name = clone_string(&arg1.name);
        if (!arg1.has_cover && same_string(&arg0.image_url, &arg1.image_url)) {
            arg1.has_cover = true;
            arg1.cover_nft_id = v0;
            arg1.updated_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg2);
        };
        if (arg1.cover_nft_id == v0) {
            arg0.cover_tag = cover_string();
        } else {
            arg0.cover_tag = empty_string();
        };
        let v1 = NftCollectionUpdated{
            id                  : v0,
            updater             : 0x2::tx_context::sender(arg2),
            has_collection      : true,
            collection_id       : arg0.collection_id,
            is_collection_cover : arg1.cover_nft_id == v0,
        };
        0x2::event::emit<NftCollectionUpdated>(v1);
    }

    public fun source_image_id_kind() : u8 {
        2
    }

    public fun source_url_kind() : u8 {
        1
    }

    public entry fun sync_nft_collection_metadata(arg0: &mut CustomNft, arg1: &Collection, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0, 8);
        assert!(arg1.owner == v0, 10);
        let v1 = 0x2::object::id_address<Collection>(arg1);
        assert!(arg0.has_collection, 11);
        assert!(arg0.collection_id == v1, 11);
        arg0.collection_name = clone_string(&arg1.name);
        if (arg1.has_cover && arg1.cover_nft_id == 0x2::object::id_address<CustomNft>(arg0)) {
            arg0.cover_tag = cover_string();
        } else {
            arg0.cover_tag = empty_string();
        };
        let v2 = arg1.has_cover && arg1.cover_nft_id == 0x2::object::id_address<CustomNft>(arg0);
        let v3 = NftCollectionUpdated{
            id                  : 0x2::object::id_address<CustomNft>(arg0),
            updater             : v0,
            has_collection      : true,
            collection_id       : v1,
            is_collection_cover : v2,
        };
        0x2::event::emit<NftCollectionUpdated>(v3);
    }

    public entry fun update_collection(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 10);
        validate_collection_metadata(&arg1, &arg2, &arg3, &arg4);
        arg0.name = arg1;
        arg0.description = arg2;
        if (!same_string(&arg0.image_url, &arg3)) {
            arg0.has_cover = false;
            arg0.cover_nft_id = @0x0;
        };
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

