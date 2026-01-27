module 0xeadb0f40df46897d18a66e2cddaea4f4d9bf1057f21ddc5b47c54c1bcf43cb8b::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        cover_url: 0x2::url::Url,
        kiosk: 0x2::object::ID,
        creator: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        real_name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        serial_number: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct MintAuthorization has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        collection_creator: address,
        name: 0x1::string::String,
        real_name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x2::url::Url,
        serial_number: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        price: u64,
        recipient: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        creator: address,
    }

    struct MintAuthorized has copy, drop {
        authorization_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
        price: u64,
    }

    struct NFTMinted has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        minter: address,
    }

    public entry fun atomic_mint(arg0: &mut MintCap, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::KioskOwnerCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: u64, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg11) >= arg10, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg11, arg12);
        let v0 = NFT{
            id            : 0x2::object::new(arg13),
            collection_id : 0x2::object::id<Collection>(arg1),
            name          : 0x1::string::utf8(arg4),
            real_name     : 0x1::string::utf8(arg5),
            description   : 0x1::string::utf8(arg6),
            uri           : 0x2::url::new_unsafe_from_bytes(arg7),
            serial_number : 0x1::string::utf8(arg8),
            attributes    : parse_attributes(arg9, arg13),
        };
        let v1 = NFTMinted{
            collection_id : 0x2::object::id<Collection>(arg1),
            nft_id        : 0x2::object::id<NFT>(&v0),
            name          : 0x1::string::utf8(arg4),
            minter        : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::kiosk::place<NFT>(arg2, arg3, v0);
    }

    public fun claim_nft_with_authorization_internal(arg0: MintAuthorization, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = NFT{
            id            : 0x2::object::new(arg3),
            collection_id : arg0.collection_id,
            name          : arg0.name,
            real_name     : arg0.real_name,
            description   : arg0.description,
            uri           : arg0.uri,
            serial_number : arg0.serial_number,
            attributes    : arg0.attributes,
        };
        let v1 = 0x2::object::id<NFT>(&v0);
        let v2 = NFTMinted{
            collection_id : 0x2::object::id<NFT>(&v0),
            nft_id        : v1,
            name          : v0.name,
            minter        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::kiosk::place<NFT>(arg1, arg2, v0);
        let MintAuthorization {
            id                 : v3,
            collection_id      : _,
            collection_creator : _,
            name               : _,
            real_name          : _,
            description        : _,
            uri                : _,
            serial_number      : _,
            attributes         : _,
            price              : _,
            recipient          : _,
        } = arg0;
        0x2::object::delete(v3);
        v1
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x2::kiosk::new(arg3);
        let v3 = v1;
        let v4 = 0x2::object::id<0x2::kiosk::Kiosk>(&v3);
        let v5 = Collection{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            cover_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            kiosk       : v4,
            creator     : v0,
        };
        let v6 = 0x2::object::id<Collection>(&v5);
        let v7 = MintCap{
            id            : 0x2::object::new(arg3),
            collection_id : v6,
        };
        let v8 = CollectionCreated{
            collection_id : v6,
            kiosk_id      : v4,
            creator       : v0,
        };
        0x2::event::emit<CollectionCreated>(v8);
        0x2::transfer::public_share_object<Collection>(v5);
        0x2::transfer::public_share_object<MintCap>(v7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, v0);
    }

    public fun create_mint_authorization_internal(arg0: &MintCap, arg1: &Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) : MintAuthorization {
        assert!(0x2::object::id<Collection>(arg1) == arg0.collection_id, 0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg7)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg7, v1);
            let v3 = 0;
            let v4 = 0x1::vector::empty<u8>();
            let v5 = 0x1::vector::empty<u8>();
            let v6 = false;
            while (v3 < 0x1::vector::length<u8>(v2)) {
                let v7 = *0x1::vector::borrow<u8>(v2, v3);
                if (v7 == 58 && !v6) {
                    v6 = true;
                } else if (v6) {
                    0x1::vector::push_back<u8>(&mut v5, v7);
                } else {
                    0x1::vector::push_back<u8>(&mut v4, v7);
                };
                v3 = v3 + 1;
            };
            if (0x1::vector::is_empty<u8>(&v4) || 0x1::vector::is_empty<u8>(&v5)) {
                abort 4
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(v4), 0x1::string::utf8(v5));
            v1 = v1 + 1;
        };
        let v8 = MintAuthorization{
            id                 : 0x2::object::new(arg10),
            collection_id      : 0x2::object::id<Collection>(arg1),
            collection_creator : arg1.creator,
            name               : 0x1::string::utf8(arg2),
            real_name          : 0x1::string::utf8(arg3),
            description        : 0x1::string::utf8(arg4),
            uri                : 0x2::url::new_unsafe_from_bytes(arg5),
            serial_number      : 0x1::string::utf8(arg6),
            attributes         : v0,
            price              : arg8,
            recipient          : arg9,
        };
        let v9 = MintAuthorized{
            authorization_id : 0x2::object::id<MintAuthorization>(&v8),
            collection_id    : v8.collection_id,
            recipient        : v8.recipient,
            name             : v8.name,
            price            : v8.price,
        };
        0x2::event::emit<MintAuthorized>(v9);
        v8
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/{uri}"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"https://www.thumbs-nft.xyz"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"Thumbs NFT"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"serial_number"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"{serial_number}"));
        0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(&mut v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v3, v4, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"{cover_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"https://www.thumbs-nft.xyz"));
        0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(b"Thumbs NFT"));
        let v8 = 0x2::display::new_with_fields<Collection>(&v0, v6, v7, arg1);
        0x2::display::update_version<Collection>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun parse_attributes(arg0: vector<vector<u8>>, arg1: &0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg0, v1);
            let v3 = 0;
            let v4 = 0x1::vector::empty<u8>();
            let v5 = 0x1::vector::empty<u8>();
            let v6 = false;
            while (v3 < 0x1::vector::length<u8>(v2)) {
                let v7 = *0x1::vector::borrow<u8>(v2, v3);
                if (v7 == 58 && !v6) {
                    v6 = true;
                } else if (!v6) {
                    0x1::vector::push_back<u8>(&mut v4, v7);
                } else {
                    0x1::vector::push_back<u8>(&mut v5, v7);
                };
                v3 = v3 + 1;
            };
            if (0x1::vector::length<u8>(&v4) > 0 && v6) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(v4), 0x1::string::utf8(v5));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<NFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<NFT>, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<NFT>(arg0, arg1, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

