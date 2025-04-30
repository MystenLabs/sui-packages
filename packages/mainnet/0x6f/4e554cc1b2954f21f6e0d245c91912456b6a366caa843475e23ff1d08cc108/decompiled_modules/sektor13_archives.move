module 0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::sektor13_archives {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        walrus_image_url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        nft_ids: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        collection_id: 0x2::object::ID,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        owner: address,
    }

    struct SEKTOR13_ARCHIVES has drop {
        dummy_field: bool,
    }

    public fun create_collection(arg0: &AdminCap, arg1: &0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::Version, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::checkVersion(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NFTCollection{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            nft_ids     : 0x2::table_vec::empty<0x2::object::ID>(arg4),
        };
        0x2::transfer::public_transfer<NFTCollection>(v1, v0);
        let v2 = CollectionCreated{
            collection_id : 0x2::object::id<NFTCollection>(&v1),
            owner         : v0,
        };
        0x2::event::emit<CollectionCreated>(v2);
    }

    fun init(arg0: SEKTOR13_ARCHIVES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://sektor13.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sektor13"));
        let v5 = 0x2::package::claim<SEKTOR13_ARCHIVES>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &AdminCap, arg1: &0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::Version, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::checkVersion(arg1, 1);
        let v0 = NFT{
            id                     : 0x2::object::new(arg10),
            name                   : 0x1::string::utf8(arg3),
            description            : 0x1::string::utf8(arg4),
            image_url              : 0x2::url::new_unsafe_from_bytes(arg5),
            walrus_image_url       : 0x2::url::new_unsafe_from_bytes(arg6),
            collection_id          : arg2,
            collection_name        : 0x1::string::utf8(arg8),
            collection_description : 0x1::string::utf8(arg9),
        };
        0x2::transfer::transfer<NFT>(v0, arg7);
        let v1 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v0),
            creator       : arg7,
            collection_id : arg2,
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    public fun update_image_url(arg0: &0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::Version, arg1: &mut NFT, arg2: vector<u8>) {
        0x6f4e554cc1b2954f21f6e0d245c91912456b6a366caa843475e23ff1d08cc108::version::checkVersion(arg0, 1);
        arg1.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    // decompiled from Move bytecode v6
}

