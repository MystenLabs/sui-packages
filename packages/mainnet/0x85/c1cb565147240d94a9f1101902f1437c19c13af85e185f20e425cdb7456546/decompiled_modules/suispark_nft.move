module 0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
    }

    struct SUISPARK_NFT has drop {
        dummy_field: bool,
    }

    public fun buy_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 1000000, 0);
        let v0 = NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0xb19ea168be3908ceb7e98753833d54f76a431337f16de4fa5b9b24429e164c5);
        let v1 = NFTMinted{
            nft_id  : 0x2::object::id<NFT>(&v0),
            creator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    fun init(arg0: SUISPARK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suispark.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUISPARK_NFT"));
        let v4 = 0x2::package::claim<SUISPARK_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mintNFT(arg0: &0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::admin::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::public_transfer<NFT>(v0, arg4);
        let v1 = NFTMinted{
            nft_id  : 0x2::object::id<NFT>(&v0),
            creator : arg4,
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

