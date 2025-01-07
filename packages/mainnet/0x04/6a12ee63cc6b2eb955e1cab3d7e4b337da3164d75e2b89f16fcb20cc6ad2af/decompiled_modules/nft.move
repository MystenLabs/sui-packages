module 0x46a12ee63cc6b2eb955e1cab3d7e4b337da3164d75e2b89f16fcb20cc6ad2af::nft {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        url: 0x2::url::Url,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{url}"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        let v5 = 0x2::display::new_with_fields<Nft>(&v0, v1, v3, arg1);
        0x2::display::update_version<Nft>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<Nft>>(v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"dirtmelon"),
            description : 0x1::string::utf8(b"dirtmelon NFT"),
            creator     : 0x2::tx_context::sender(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/12068299?v=4"),
        };
        0x2::transfer::public_transfer<Nft>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

