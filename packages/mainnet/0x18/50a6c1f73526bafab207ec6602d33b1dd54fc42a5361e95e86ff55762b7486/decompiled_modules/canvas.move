module 0x1850a6c1f73526bafab207ec6602d33b1dd54fc42a5361e95e86ff55762b7486::canvas {
    struct CanvasNFT has store, key {
        id: 0x2::object::UID,
        pixels: vector<u8>,
        svg_data: 0x1::string::String,
    }

    struct CANVAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANVAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CANVAS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Interactive Canvas"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,{svg_data}"));
        let v5 = 0x2::display::new_with_fields<CanvasNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<CanvasNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CanvasNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_blank(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = CanvasNFT{
            id       : 0x2::object::new(arg0),
            pixels   : v0,
            svg_data : render_svg(&v0),
        };
        0x2::transfer::public_transfer<CanvasNFT>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun paint_overwrite(arg0: &mut CanvasNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 100, 1);
        arg0.pixels = arg1;
        arg0.svg_data = render_svg(&arg0.pixels);
    }

    fun render_svg(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 10 10' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        let v1 = 0;
        while (v1 < 100) {
            if (*0x1::vector::borrow<u8>(arg0, v1) == 1) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='"));
                0x1::string::append(&mut v0, u8_to_str(v1 % 10));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
                0x1::string::append(&mut v0, u8_to_str(v1 / 10));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='1' fill='red' />"));
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        v0
    }

    fun u8_to_str(arg0: u64) : 0x1::string::String {
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

