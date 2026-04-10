module 0x66de77fa92e779ddc9351ebf2428b93f953ee417228814bf22cbfdece657aadc::canvas {
    struct Attribute has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct CanvasNFT has store, key {
        id: 0x2::object::UID,
        pixels: vector<u8>,
        ink_level: u64,
        palette_tier: u8,
        mint_number: u64,
        svg_data: 0x1::string::String,
        attributes: vector<Attribute>,
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

    fun get_color_hex(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            return 0x1::string::utf8(b"#1a1a1a")
        };
        if (arg0 == 2) {
            return 0x1::string::utf8(b"#e63946")
        };
        if (arg0 == 3) {
            return 0x1::string::utf8(b"#457b9d")
        };
        if (arg0 == 4) {
            return 0x1::string::utf8(b"#a8dadc")
        };
        if (arg0 == 5) {
            return 0x1::string::utf8(b"#495057")
        };
        if (arg0 == 6) {
            return 0x1::string::utf8(b"#3d5a80")
        };
        if (arg0 == 12) {
            return 0x1::string::utf8(b"#ee6c4d")
        };
        if (arg0 == 13) {
            return 0x1::string::utf8(b"#39ff14")
        };
        if (arg0 == 30) {
            return 0x1::string::utf8(b"#ff00ff")
        };
        if (arg0 == 31) {
            return 0x1::string::utf8(b"#ffd700")
        };
        if (arg0 == 255) {
            return 0x1::string::utf8(b"#b9f2ff")
        };
        0x1::string::utf8(b"#000000")
    }

    fun init(arg0: CANVAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CANVAS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Imagine Canvas #{mint_number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;base64,{svg_data}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A dynamic generative canvas on Sui."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://imagine.art"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
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

    entry fun mint(arg0: &mut GlobalState, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_supply < 3000, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x5e77ec4d75dbdefc676753e54073cd7ae0ded3cb28e9776a19e2666355a0cd90);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let (v2, v3) = if (v1 <= 60) {
            (0, 0x1::string::utf8(b"Common"))
        } else if (v1 <= 85) {
            (1, 0x1::string::utf8(b"Uncommon"))
        } else if (v1 <= 97) {
            (2, 0x1::string::utf8(b"Rare"))
        } else if (v1 <= 99) {
            (3, 0x1::string::utf8(b"Epic"))
        } else {
            (4, 0x1::string::utf8(b"Legendary"))
        };
        let v4 = b"";
        let v5 = 0;
        while (v5 < 400) {
            0x1::vector::push_back<u8>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = 400;
        let v7 = render_canvas_svg(&v4, v6, v2);
        arg0.total_supply = arg0.total_supply + 1;
        let v8 = Attribute{
            key   : 0x1::string::utf8(b"Rarity"),
            value : v3,
        };
        let v9 = Attribute{
            key   : 0x1::string::utf8(b"Ink Level"),
            value : u64_to_str(v6),
        };
        let v10 = 0x1::vector::empty<Attribute>();
        let v11 = &mut v10;
        0x1::vector::push_back<Attribute>(v11, v8);
        0x1::vector::push_back<Attribute>(v11, v9);
        let v12 = CanvasNFT{
            id           : 0x2::object::new(arg3),
            pixels       : v4,
            ink_level    : v6,
            palette_tier : v2,
            mint_number  : arg0.total_supply,
            svg_data     : encode_base64(*0x1::string::as_bytes(&v7)),
            attributes   : v10,
        };
        0x2::transfer::public_transfer<CanvasNFT>(v12, 0x2::tx_context::sender(arg3));
    }

    entry fun paint_overwrite(arg0: &mut CanvasNFT, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 400, 3);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 400) {
            let v2 = *0x1::vector::borrow<u8>(&arg1, v0);
            if (arg0.palette_tier == 0) {
                assert!(v2 <= 5, 4);
            } else if (arg0.palette_tier == 1) {
                assert!(v2 <= 12, 4);
            } else if (arg0.palette_tier == 2) {
                assert!(v2 <= 30, 4);
            } else if (arg0.palette_tier == 3) {
                assert!(v2 <= 60, 4);
            };
            if (*0x1::vector::borrow<u8>(&arg0.pixels, v0) != v2) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        assert!(arg0.ink_level >= v1, 2);
        arg0.ink_level = arg0.ink_level - v1;
        arg0.pixels = arg1;
        0x1::vector::borrow_mut<Attribute>(&mut arg0.attributes, 1).value = u64_to_str(arg0.ink_level);
        let v3 = render_canvas_svg(&arg0.pixels, arg0.ink_level, arg0.palette_tier);
        arg0.svg_data = encode_base64(*0x1::string::as_bytes(&v3));
    }

    entry fun refill_ink(arg0: &mut CanvasNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x5e77ec4d75dbdefc676753e54073cd7ae0ded3cb28e9776a19e2666355a0cd90);
        arg0.ink_level = arg0.ink_level + 100;
        0x1::vector::borrow_mut<Attribute>(&mut arg0.attributes, 1).value = u64_to_str(arg0.ink_level);
        let v0 = render_canvas_svg(&arg0.pixels, arg0.ink_level, arg0.palette_tier);
        arg0.svg_data = encode_base64(*0x1::string::as_bytes(&v0));
    }

    fun render_canvas_svg(arg0: &vector<u8>, arg1: u64, arg2: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 21 20' xmlns='http://www.w3.org/2000/svg' shape-rendering='crispEdges'>");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<style>"));
        if (arg2 >= 3) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"@keyframes glitch{0%{opacity:1}50%{opacity:.7}100%{opacity:1}}.g{animation:glitch .2s infinite}"));
        };
        if (arg2 == 4) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"@keyframes pulse{0%{filter:brightness(1)}50%{filter:brightness(1.5)}100%{filter:brightness(1)}}.p{animation:pulse 2s infinite}"));
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</style>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect width='20' height='20' fill='#ffffff' />"));
        let v1 = 0;
        while (v1 < 400) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='"));
                0x1::string::append(&mut v0, u64_to_str(v1 % 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
                0x1::string::append(&mut v0, u64_to_str(v1 / 20));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='1' fill='"));
                0x1::string::append(&mut v0, get_color_hex(v2));
                0x1::string::append(&mut v0, 0x1::string::utf8(b"'"));
                if (arg2 >= 3 && v2 >= 13) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b" class='g'"));
                };
                if (arg2 == 4 && v2 >= 31) {
                    0x1::string::append(&mut v0, 0x1::string::utf8(b" class='p'"));
                };
                0x1::string::append(&mut v0, 0x1::string::utf8(b" />"));
            };
            v1 = v1 + 1;
        };
        let v3 = if (arg1 >= 400) {
            20
        } else {
            arg1 * 20 / 400
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect x='20' y='"));
        0x1::string::append(&mut v0, u64_to_str(20 - v3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' width='1' height='"));
        0x1::string::append(&mut v0, u64_to_str(v3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' fill='#00FF00' /></svg>"));
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

