module 0x288dd35bbab9c9288f52efb492023e8566b88621583f95aa1d72d6ae6dbd9a70::grid {
    struct GRID has drop {
        dummy_field: bool,
    }

    struct Grid has key {
        id: 0x2::object::UID,
        data_url: 0x1::string::String,
    }

    entry fun new(arg0: u64, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::sqrt(arg0);
        assert!(v0 * v0 == arg0, 0);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = b"";
        0x1::vector::append<u8>(&mut v2, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v0)));
        0x1::vector::append<u8>(&mut v2, b" ");
        0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v0)));
        0x1::vector::append<u8>(&mut v2, b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'><style>rect { width: 1px; height: 1px; }</style>");
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::append<u8>(&mut v2, b"<g transform='translate(0, ");
            0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v3)));
            0x1::vector::append<u8>(&mut v2, b")'>");
            let v4 = 0;
            while (v4 < v0) {
                let v5 = 0x2::random::generate_u32(&mut v1);
                0x1::vector::append<u8>(&mut v2, b"<rect x='");
                0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v4)));
                0x1::vector::append<u8>(&mut v2, b"' fill='#");
                0x1::vector::append<u8>(&mut v2, rgb_to_hex(((v5 & 255) as u8), ((v5 >> 8 & 255) as u8), ((v5 >> 16 & 255) as u8)));
                0x1::vector::append<u8>(&mut v2, b"'/>");
                v4 = v4 + 1;
            };
            0x1::vector::append<u8>(&mut v2, b"</g>");
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        let v6 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append(&mut v6, 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64::encode(v2));
        let v7 = Grid{
            id       : 0x2::object::new(arg2),
            data_url : v6,
        };
        0x2::transfer::transfer<Grid>(v7, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: GRID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GRID>(arg0, arg1);
        let v1 = 0x2::display::new<Grid>(&v0, arg1);
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"MiraiGrid"));
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{data_url}"));
        0x2::display::update_version<Grid>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Grid>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun rgb_to_hex(arg0: u8, arg1: u8, arg2: u8) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::bcs::to_bytes<u8>(&arg0)));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::bcs::to_bytes<u8>(&arg1)));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::bcs::to_bytes<u8>(&arg2)));
        v0
    }

    // decompiled from Move bytecode v6
}

