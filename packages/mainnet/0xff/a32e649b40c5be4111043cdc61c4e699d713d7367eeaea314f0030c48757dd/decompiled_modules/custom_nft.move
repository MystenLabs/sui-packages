module 0xffa32e649b40c5be4111043cdc61c4e699d713d7367eeaea314f0030c48757dd::custom_nft {
    struct CUSTOM_NFT has drop {
        dummy_field: bool,
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
        collection: 0x1::string::String,
        royalty_bps: u64,
        created_at_ms: u64,
    }

    struct NftMinted has copy, drop {
        id: address,
        creator: address,
        owner: address,
        image_source_kind: u8,
    }

    struct NftUpdated has copy, drop {
        id: address,
        updater: address,
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
            collection        : _,
            royalty_bps       : _,
            created_at_ms     : _,
        } = arg0;
        0x2::object::delete(v0);
        let v13 = NftBurned{
            id     : 0x2::object::id_address<CustomNft>(&arg0),
            burner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NftBurned>(v13);
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
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<CustomNft>(&v0, v1, v3, arg1);
        0x2::display::update_version<CustomNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CustomNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun is_empty(arg0: &0x1::string::String) : bool {
        0x1::vector::length<u8>(0x1::string::bytes(arg0)) == 0
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        validate_metadata(&arg0, &arg1, &arg2, arg3, &arg4, &arg5, &arg6, &arg7, &arg8, arg9);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = CustomNft{
            id                : 0x2::object::new(arg11),
            creator           : v0,
            name              : arg0,
            symbol            : arg1,
            description       : arg2,
            image_source_kind : arg3,
            image_url         : arg4,
            image_object_id   : arg5,
            external_url      : arg6,
            attributes_json   : arg7,
            collection        : arg8,
            royalty_bps       : arg9,
            created_at_ms     : 0x2::tx_context::epoch_timestamp_ms(arg11),
        };
        let v2 = NftMinted{
            id                : 0x2::object::id_address<CustomNft>(&v1),
            creator           : v0,
            owner             : arg10,
            image_source_kind : arg3,
        };
        0x2::event::emit<NftMinted>(v2);
        0x2::transfer::public_transfer<CustomNft>(v1, arg10);
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        mint_to_address(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10);
    }

    public fun source_image_id_kind() : u8 {
        2
    }

    public fun source_url_kind() : u8 {
        1
    }

    public entry fun update_nft_metadata(arg0: &mut CustomNft, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg11), 8);
        validate_metadata(&arg1, &arg2, &arg3, arg4, &arg5, &arg6, &arg7, &arg8, &arg9, arg10);
        arg0.name = arg1;
        arg0.symbol = arg2;
        arg0.description = arg3;
        arg0.image_source_kind = arg4;
        arg0.image_url = arg5;
        arg0.image_object_id = arg6;
        arg0.external_url = arg7;
        arg0.attributes_json = arg8;
        arg0.collection = arg9;
        arg0.royalty_bps = arg10;
        let v0 = NftUpdated{
            id      : 0x2::object::id_address<CustomNft>(arg0),
            updater : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<NftUpdated>(v0);
    }

    fun validate_metadata(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u8, arg4: &0x1::string::String, arg5: &0x1::string::String, arg6: &0x1::string::String, arg7: &0x1::string::String, arg8: &0x1::string::String, arg9: u64) {
        assert!(!is_empty(arg0), 1);
        assert!(!is_empty(arg1), 2);
        assert!(arg3 == 1 || arg3 == 2, 3);
        assert!(arg9 <= 10000, 7);
        assert_max_len(arg0, 128);
        assert_max_len(arg1, 128);
        assert_max_len(arg2, 2048);
        assert_max_len(arg6, 2048);
        assert_max_len(arg8, 128);
        assert_max_len(arg7, 16384);
        if (arg3 == 1) {
            assert!(!is_empty(arg4), 4);
            assert_max_len(arg4, 2048);
        } else {
            assert!(!is_empty(arg5), 5);
            assert_max_len(arg5, 96);
            assert!(!is_empty(arg4), 4);
            assert_max_len(arg4, 2048);
        };
    }

    // decompiled from Move bytecode v6
}

