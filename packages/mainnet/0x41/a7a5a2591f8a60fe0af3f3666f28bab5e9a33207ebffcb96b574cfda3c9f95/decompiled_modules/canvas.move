module 0x41a7a5a2591f8a60fe0af3f3666f28bab5e9a33207ebffcb96b574cfda3c9f95::canvas {
    struct CanvasNFT has store, key {
        id: 0x2::object::UID,
        pixels: vector<u8>,
        ink_level: u64,
        svg_data: 0x1::string::String,
    }

    struct GlobalState has key {
        id: 0x2::object::UID,
        total_supply: u64,
    }

    struct CANVAS has drop {
        dummy_field: bool,
    }

    fun encode_base64(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 == 0) {
            return 0x1::string::utf8(b"")
        };
        let v1 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v2 = b"";
        let v3 = 0;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64);
            let v5 = if (v3 + 1 < v0) {
                (*0x1::vector::borrow<u8>(&arg0, v3 + 1) as u64)
            } else {
                0
            };
            let v6 = if (v3 + 2 < v0) {
                (*0x1::vector::borrow<u8>(&arg0, v3 + 2) as u64)
            } else {
                0
            };
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v4 >> 2));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (v4 & 3) << 4 | v5 >> 4));
            if (v3 + 1 < v0) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, (v5 & 15) << 2 | v6 >> 6));
            } else {
                0x1::vector::push_back<u8>(&mut v2, 61);
            };
            if (v3 + 2 < v0) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v6 & 63));
            } else {
                0x1::vector::push_back<u8>(&mut v2, 61);
            };
            v3 = v3 + 3;
        };
        0x1::string::utf8(v2)
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
        let v6 = GlobalState{
            id           : 0x2::object::new(arg1),
            total_supply : 0,
        };
        0x2::transfer::share_object<GlobalState>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CanvasNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut GlobalState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_supply < 888, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x5e77ec4d75dbdefc676753e54073cd7ae0ded3cb28e9776a19e2666355a0cd90);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 400) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = 400;
        let v3 = render_canvas_svg(&v0, v2);
        let v4 = CanvasNFT{
            id        : 0x2::object::new(arg2),
            pixels    : v0,
            ink_level : v2,
            svg_data  : encode_base64(*0x1::string::as_bytes(&v3)),
        };
        arg0.total_supply = arg0.total_supply + 1;
        0x2::transfer::public_transfer<CanvasNFT>(v4, 0x2::tx_context::sender(arg2));
    }

    entry fun paint_overwrite(arg0: &mut CanvasNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 400, 3);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 400) {
            if (*0x1::vector::borrow<u8>(&arg0.pixels, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        assert!(arg0.ink_level >= v1, 2);
        arg0.ink_level = arg0.ink_level - v1;
        arg0.pixels = arg1;
        let v2 = render_canvas_svg(&arg0.pixels, arg0.ink_level);
        arg0.svg_data = encode_base64(*0x1::string::as_bytes(&v2));
    }

    entry fun refill_ink(arg0: &mut CanvasNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x5e77ec4d75dbdefc676753e54073cd7ae0ded3cb28e9776a19e2666355a0cd90);
        arg0.ink_level = arg0.ink_level + 100;
        let v0 = render_canvas_svg(&arg0.pixels, arg0.ink_level);
        arg0.svg_data = encode_base64(*0x1::string::as_bytes(&v0));
    }

    fun render_canvas_svg(arg0: &vector<u8>, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 21 20' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect width='20' height='20' fill='#f0f0f0' />"));
        let v1 = if (arg1 >= 400) {
            20
        } else {
            arg1 * 20 / 400
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='20' y='"));
        0x1::string::append(&mut v0, u64_to_str(20 - v1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='"));
        0x1::string::append(&mut v0, u64_to_str(v1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' fill='#00FF00' />"));
        let v2 = 0;
        while (v2 < 400) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='"));
                0x1::string::append(&mut v0, u64_to_str(v2 % 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
                0x1::string::append(&mut v0, u64_to_str(v2 / 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='1' fill='"));
                if (v3 == 1) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"black"));
                } else if (v3 == 2) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"red"));
                } else if (v3 == 3) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b"white"));
                };
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' />"));
            };
            v2 = v2 + 1;
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

    // decompiled from Move bytecode v7
}

