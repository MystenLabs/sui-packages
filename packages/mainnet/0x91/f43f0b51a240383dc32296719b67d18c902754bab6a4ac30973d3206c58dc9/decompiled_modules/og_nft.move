module 0x91f43f0b51a240383dc32296719b67d18c902754bab6a4ac30973d3206c58dc9::og_nft {
    struct OG_NFT has drop {
        dummy_field: bool,
    }

    struct OgNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<address, bool>,
    }

    fun init(arg0: OG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<MintRegistry>(v0);
        let v1 = 0x2::package::claim<OG_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        let v6 = 0x2::display::new_with_fields<OgNft>(&v1, v2, v4, arg1);
        0x2::display::update_version<OgNft>(&mut v6);
        0x2::transfer::public_freeze_object<0x2::display::Display<OgNft>>(v6);
        0x2::transfer::public_freeze_object<0x2::package::Publisher>(v1);
    }

    entry fun mint_og(arg0: &mut MintRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.registry, v0), 13906834401976647681);
        let v1 = OgNft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"OG"),
            description : 0x1::string::utf8(b"OG confirmed member"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"http://aggregator.walrus-mainnet.walrus.space/v1/blobs/vTlUE0IKFgQYLhugvLLhYM_jV1vJHVJfuTKDjwgcbDE"),
        };
        0x2::transfer::transfer<OgNft>(v1, v0);
        0x2::table::add<address, bool>(&mut arg0.registry, v0, true);
    }

    // decompiled from Move bytecode v6
}

