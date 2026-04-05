module 0xd8596c76242e71a815ae19d025e021fc1f49d598b1dd4144dcf712854258ac68::canvas {
    struct CanvasNFT has store, key {
        id: 0x2::object::UID,
        pixels: vector<u8>,
        svg_data: 0x1::string::String,
    }

    struct RedPen has store, key {
        id: 0x2::object::UID,
        pixels: vector<u8>,
        svg_data: 0x1::string::String,
    }

    struct CANVAS has drop {
        dummy_field: bool,
    }

    fun append_rect(arg0: &mut 0x1::string::String, arg1: u64, arg2: u64, arg3: u8) {
        0x1::string::append(arg0, 0x1::string::utf8(b"<rect x='"));
        0x1::string::append(arg0, u64_to_str(arg1));
        0x1::string::append(arg0, 0x1::string::utf8(b"' y='"));
        0x1::string::append(arg0, u64_to_str(arg2));
        0x1::string::append(arg0, 0x1::string::utf8(b"' width='1' height='1' fill='"));
        if (arg3 == 1) {
            0x1::string::append(arg0, 0x1::string::utf8(b"black"));
        } else if (arg3 == 2) {
            0x1::string::append(arg0, 0x1::string::utf8(b"red"));
        };
        0x1::string::append(arg0, 0x1::string::utf8(b"' />"));
    }

    public entry fun attach_pen(arg0: &mut CanvasNFT, arg1: RedPen) {
        0x2::dynamic_field::add<0x1::string::String, RedPen>(&mut arg0.id, 0x1::string::utf8(b"red_pen"), arg1);
    }

    public entry fun detach_pen(arg0: &mut CanvasNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RedPen>(0x2::dynamic_field::remove<0x1::string::String, RedPen>(&mut arg0.id, 0x1::string::utf8(b"red_pen")), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: CANVAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CANVAS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Imagine Canvas (20x20)"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,{svg_data}"));
        let v5 = 0x2::display::new_with_fields<CanvasNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<CanvasNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Imagine Red Pen"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"data:image/svg+xml;utf8,{svg_data}"));
        let v10 = 0x2::display::new_with_fields<RedPen>(&v0, v6, v8, arg1);
        0x2::display::update_version<RedPen>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CanvasNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RedPen>>(v10, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_blank(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 400) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = CanvasNFT{
            id       : 0x2::object::new(arg0),
            pixels   : v0,
            svg_data : render_canvas_svg(&v0),
        };
        0x2::transfer::public_transfer<CanvasNFT>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_red_pen(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = x"010101010101010202020101010101010102020201010101010101020202";
        let v1 = RedPen{
            id       : 0x2::object::new(arg0),
            pixels   : v0,
            svg_data : render_pen_svg(&v0),
        };
        0x2::transfer::public_transfer<RedPen>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun paint_overwrite(arg0: &mut CanvasNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 400, 1);
        let v0 = 0;
        while (v0 < 400) {
            if (*0x1::vector::borrow<u8>(&arg1, v0) == 2) {
                assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"red_pen")), 2);
            };
            v0 = v0 + 1;
        };
        arg0.pixels = arg1;
        arg0.svg_data = render_canvas_svg(&arg0.pixels);
    }

    fun render_canvas_svg(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 20 20' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        let v1 = 0;
        while (v1 < 400) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 > 0) {
                let v3 = &mut v0;
                append_rect(v3, v1 % 20, v1 / 20, v2);
            };
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        v0
    }

    fun render_pen_svg(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 10 3' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        let v1 = 0;
        while (v1 < 30) {
            let v2 = &mut v0;
            append_rect(v2, v1 % 10, v1 / 10, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        v0
    }

    fun u64_to_str(arg0: u64) : 0x1::string::String {
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

