module 0x7f46e51eb240e1642e0329ab12edcc1b9afe5f784e4b51985ab77f6f39544286::sky_series {
    struct SkySeries has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
    }

    struct ExtendedSkySeries has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
    }

    struct SKY_SERIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY_SERIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sky Series"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeifqswxfgr6qj7golgm2cirnqbzxrvytscsclh45xmnpivxgfcplbm/{token_id}.json"));
        let v4 = 0x2::package::claim<SKY_SERIES>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SkySeries>(&v4, v0, v2, arg1);
        let v6 = 0x2::display::new_with_fields<ExtendedSkySeries>(&v4, v0, v2, arg1);
        0x2::display::update_version<SkySeries>(&mut v5);
        0x2::display::update_version<ExtendedSkySeries>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SkySeries>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ExtendedSkySeries>>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SkySeries{
            id      : 0x2::object::new(arg2),
            name    : 0x1::string::utf8(arg0),
            img_url : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        0x2::transfer::transfer<SkySeries>(v0, 0x2::tx_context::sender(arg2));
    }

    entry fun mint_extended(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ExtendedSkySeries{
            id      : 0x2::object::new(arg3),
            name    : 0x1::string::utf8(arg0),
            img_url : 0x2::url::new_unsafe_from_bytes(arg1),
            url     : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::transfer<ExtendedSkySeries>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

