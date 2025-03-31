module 0x4767c5725e7402e3084d7110e02ac5b19c5244aaf01d7d3af2abc8d058250a4d::sizu_nft {
    struct SizuNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct SIZU_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZU_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIZU_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SizuNFT>>(0x2::display::new_with_fields<SizuNFT>(&v0, v1, v3, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SizuNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"new_sizu"),
            description : 0x1::string::utf8(b"Sizu testnet NFT mint"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1902838502804393984/kfhcMML1_400x400.jpg"),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<SizuNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg0),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<SizuNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_with_details(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SizuNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1902838502804393984/kfhcMML1_400x400.jpg"),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<SizuNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<SizuNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

