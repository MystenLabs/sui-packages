module 0x8c17d23917938aa01bb61fa9ee8ffab5c999f4ef2b47978ffabe111c5c4827b4::chenmingnan_nft {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        url: 0x2::url::Url,
    }

    struct CHENMINGNAN_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENMINGNAN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHENMINGNAN_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
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
            name        : 0x1::string::utf8(b"chenmingnan"),
            description : 0x1::string::utf8(b"chenmingnan NFT"),
            creator     : 0x2::tx_context::sender(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/62949979?v=4"),
        };
        0x2::transfer::public_transfer<Nft>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

