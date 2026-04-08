module 0x734322d3b6b738d690ecce8390f57e7d315c642ade607a634d47d801effdcb5a::canvas {
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

    public entry fun attach_pen(arg0: &mut CanvasNFT, arg1: RedPen) {
        0x2::dynamic_field::add<0x1::string::String, RedPen>(&mut arg0.id, 0x1::string::utf8(b"red_pen"), arg1);
    }

    public entry fun detach_pen(arg0: &mut CanvasNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RedPen>(0x2::dynamic_field::remove<0x1::string::String, RedPen>(&mut arg0.id, 0x1::string::utf8(b"red_pen")), 0x2::tx_context::sender(arg1));
    }

    fun encode_base64(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 == 0) {
            return 0x1::string::utf8(b"")
        };
        let v1 = b"";
        let v2 = 0;
        while (v2 < v0) {
            let v3 = (*0x1::vector::borrow<u8>(&arg0, v2) as u64);
            let v4 = if (v2 + 1 < v0) {
                (*0x1::vector::borrow<u8>(&arg0, v2 + 1) as u64)
            } else {
                0
            };
            let v5 = if (v2 + 2 < v0) {
                (*0x1::vector::borrow<u8>(&arg0, v2 + 2) as u64)
            } else {
                0
            };
            let v6 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v6, v3 >> 2));
            let v7 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v7, (v3 & 3) << 4 | v4 >> 4));
            if (v2 + 1 < v0) {
                let v8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v8, (v4 & 15) << 2 | v5 >> 6));
            } else {
                0x1::vector::push_back<u8>(&mut v1, 61);
            };
            if (v2 + 2 < v0) {
                let v9 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v9, v5 & 63));
            } else {
                0x1::vector::push_back<u8>(&mut v1, 61);
            };
            v2 = v2 + 3;
        };
        0x1::string::utf8(v1)
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;base64,{svg_data}"));
        let v5 = 0x2::display::new_with_fields<CanvasNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<CanvasNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Imagine Red Pen (V5)"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"data:image/svg+xml;base64,{svg_data}"));
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
        let v2 = render_canvas_svg(&v0);
        let v3 = CanvasNFT{
            id       : 0x2::object::new(arg0),
            pixels   : v0,
            svg_data : encode_base64(*0x1::string::bytes(&v2)),
        };
        0x2::transfer::public_transfer<CanvasNFT>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_red_pen(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 400) {
            let v2 = v1 % 20;
            let v3 = v1 / 20;
            let v4 = if (v2 == v3) {
                if (v2 > 5) {
                    v2 < 15
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                0x1::vector::push_back<u8>(&mut v0, 3);
            } else {
                let v5 = if (v2 == v3) {
                    if (v2 >= 15) {
                        v2 <= 17
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v5) {
                    0x1::vector::push_back<u8>(&mut v0, 2);
                } else {
                    0x1::vector::push_back<u8>(&mut v0, 0);
                };
            };
            v1 = v1 + 1;
        };
        let v6 = render_canvas_svg(&v0);
        let v7 = RedPen{
            id       : 0x2::object::new(arg0),
            pixels   : v0,
            svg_data : encode_base64(*0x1::string::bytes(&v6)),
        };
        0x2::transfer::public_transfer<RedPen>(v7, 0x2::tx_context::sender(arg0));
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
        let v1 = render_canvas_svg(&arg0.pixels);
        arg0.svg_data = encode_base64(*0x1::string::bytes(&v1));
    }

    fun render_canvas_svg(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 20 20' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect width='20' height='20' fill='#f0f0f0' />"));
        let v1 = 0;
        while (v1 < 400) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='"));
                0x1::string::append(&mut v0, u64_to_str(v1 % 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
                0x1::string::append(&mut v0, u64_to_str(v1 / 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='1' fill='"));
                if (v2 == 1) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"black"));
                } else if (v2 == 2) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"red"));
                } else if (v2 == 3) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"white"));
                };
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' />"));
            };
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

