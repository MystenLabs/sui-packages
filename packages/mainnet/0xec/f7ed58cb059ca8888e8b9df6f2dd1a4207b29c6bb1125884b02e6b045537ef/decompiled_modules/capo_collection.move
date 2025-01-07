module 0xecf7ed58cb059ca8888e8b9df6f2dd1a4207b29c6bb1125884b02e6b045537ef::capo_collection {
    struct CAPO_COLLECTION has drop {
        dummy_field: bool,
    }

    struct CapoCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
    }

    struct CapoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
    }

    public entry fun create_collection_and_mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = CapoCollection{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : 0x2::tx_context::sender(arg6),
        };
        let v1 = CapoNFT{
            id            : 0x2::object::new(arg6),
            name          : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            url           : 0x2::url::new_unsafe_from_bytes(arg5),
            collection_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<CapoCollection>(v0);
        0x2::transfer::transfer<CapoNFT>(v1, 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: CAPO_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAPO_COLLECTION>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<CapoCollection>(&v0, v1, v3, arg1);
        0x2::display::update_version<CapoCollection>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"collection_id"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{collection_id}"));
        let v10 = 0x2::display::new_with_fields<CapoNFT>(&v0, v6, v8, arg1);
        0x2::display::update_version<CapoNFT>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CapoCollection>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CapoNFT>>(v10, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

