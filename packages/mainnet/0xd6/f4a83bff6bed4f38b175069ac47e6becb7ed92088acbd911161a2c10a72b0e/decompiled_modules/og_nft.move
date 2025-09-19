module 0xd6f4a83bff6bed4f38b175069ac47e6becb7ed92088acbd911161a2c10a72b0e::og_nft {
    struct OgNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct OG_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        let v5 = 0x2::display::new_with_fields<OgNft>(&v0, v1, v3, arg1);
        0x2::display::update_version<OgNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OgNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OgNft{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"OG"),
            description : 0x1::string::utf8(b"Sui Bootcamp"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.h2o-nodes.com/v1/blobs/vTlUE0IKFgQYLhugvLLhYM_jV1vJHVJfuTKDjwgcbDE"),
        };
        0x2::transfer::public_transfer<OgNft>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

