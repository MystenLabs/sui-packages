module 0xc03f934e378becefc23df10cb61bec17d2123e469dc9928c875ecfdca794dc1b::chee_nft {
    struct CheeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct CHEE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<CHEE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CheeNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<CheeNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CheeNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = CheeNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"chee NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/chee-qi"),
        };
        0x2::transfer::public_transfer<CheeNFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CheeNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"chee NFT"),
            image_url : arg1,
        };
        0x2::transfer::transfer<CheeNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

