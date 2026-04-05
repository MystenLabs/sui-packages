module 0x1fdd07bf243c4758a714afa160f293da5e8afc903305aba4396750c5a32f8db5::circle_nft {
    struct CircleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pixels: vector<u8>,
        svg_data: 0x1::string::String,
    }

    struct CIRCLE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CIRCLE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"On-Chain Square"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,{svg_data}"));
        let v5 = 0x2::display::new_with_fields<CircleNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<CircleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CircleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_border(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 100) {
            let v2 = v1 % 10;
            let v3 = v1 / 10;
            let v4 = if (v2 == 0) {
                true
            } else if (v2 == 9) {
                true
            } else if (v3 == 0) {
                true
            } else {
                v3 == 9
            };
            if (v4) {
                0x1::vector::push_back<u8>(&mut v0, 1);
            } else {
                0x1::vector::push_back<u8>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        let v5 = CircleNFT{
            id       : 0x2::object::new(arg0),
            name     : 0x1::string::utf8(b"On-Chain Border"),
            pixels   : v0,
            svg_data : render_vector_as_svg(&v0),
        };
        0x2::transfer::public_transfer<CircleNFT>(v5, 0x2::tx_context::sender(arg0));
    }

    fun render_vector_as_svg(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 10 10' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        let v1 = 0;
        while (v1 < 100) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == 1) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='"));
                0x1::string::append(&mut v0, u8_to_string(v1 % 10));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
                0x1::string::append(&mut v0, u8_to_string(v1 / 10));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='1' fill='red' />"));
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        v0
    }

    fun u8_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

