module 0xa2f2c5fec833b1763b2709633bf44c46bb58eb0149bf5cbdc1d5dbc33802d0e8::grid {
    struct GRID has drop {
        dummy_field: bool,
    }

    struct Grid has key {
        id: 0x2::object::UID,
        number: u64,
        size: u64,
        data_url: 0x1::string::String,
    }

    struct GridRegistry has key {
        id: 0x2::object::UID,
        count: u64,
    }

    entry fun new(arg0: u64, arg1: &mut GridRegistry, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 1024, 0);
        let v0 = 0x1::u64::sqrt(arg0);
        assert!(v0 * v0 == arg0, 1);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ";
        let v3 = 0x1::string::into_bytes(0x1::u64::to_string(v0));
        0x1::vector::append<u8>(&mut v2, v3);
        0x1::vector::append<u8>(&mut v2, b" ");
        0x1::vector::append<u8>(&mut v2, v3);
        0x1::vector::append<u8>(&mut v2, b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'><style>rect { width: 1px; height: 1px; }</style>");
        let v4 = 0;
        while (v4 < v0) {
            0x1::vector::append<u8>(&mut v2, b"<g transform='translate(0, ");
            0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v4)));
            0x1::vector::append<u8>(&mut v2, b")'>");
            let v5 = 0;
            while (v5 < v0) {
                let v6 = 0x2::random::generate_u32(&mut v1);
                0x1::vector::append<u8>(&mut v2, b"<rect x='");
                0x1::vector::append<u8>(&mut v2, 0x1::string::into_bytes(0x1::u64::to_string(v5)));
                0x1::vector::append<u8>(&mut v2, b"' fill='#");
                0x1::vector::append<u8>(&mut v2, rgb_to_hex(((v6 & 255) as u8), ((v6 >> 8 & 255) as u8), ((v6 >> 16 & 255) as u8)));
                0x1::vector::append<u8>(&mut v2, b"'/>");
                v5 = v5 + 1;
            };
            0x1::vector::append<u8>(&mut v2, b"</g>");
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        let v7 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append(&mut v7, 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64::encode(v2));
        let v8 = Grid{
            id       : 0x2::object::new(arg3),
            number   : arg1.count + 1,
            size     : arg0,
            data_url : v7,
        };
        arg1.count = arg1.count + 1;
        0x2::transfer::transfer<Grid>(v8, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: GRID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GRID>(arg0, arg1);
        let v1 = 0x2::display::new<Grid>(&v0, arg1);
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"RGB #{number}"));
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A {size}-pixel square, simple yet endlessly expressive."));
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<Grid>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{data_url}"));
        0x2::display::update_version<Grid>(&mut v1);
        let v2 = GridRegistry{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Grid>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GridRegistry>(v2);
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

