module 0x968763e8653d29345327273a0a2602029499c141ae5b8487ad766ed715cae179::taciturneyes_nft {
    struct TACITURNEYES_NFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: TACITURNEYES_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/77370454?v=4"));
        let v4 = 0x2::package::claim<TACITURNEYES_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"TACITURNEYES_NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/77370454?v=4"),
        };
        0x2::transfer::public_transfer<NFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

