module 0xd092b6a785ba47f7c158b8f22e62c733227646e05350e604437a304f8059d531::display_nft {
    struct GIT_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct DISPLAY_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISPLAY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://testnet.suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"a nft for git image"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://testnet.suivision.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"recursionhs"));
        let v4 = 0x2::package::claim<DISPLAY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GIT_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GIT_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GIT_NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GIT_NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"RecursionHs input url NFT"),
            url  : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/36094328?v=4"),
        };
        0x2::transfer::public_transfer<GIT_NFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GIT_NFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
            url  : arg1,
        };
        0x2::transfer::public_transfer<GIT_NFT>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

