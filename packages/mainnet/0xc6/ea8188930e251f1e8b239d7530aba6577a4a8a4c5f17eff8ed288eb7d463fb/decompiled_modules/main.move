module 0xc6ea8188930e251f1e8b239d7530aba6577a4a8a4c5f17eff8ed288eb7d463fb::main {
    struct WalletArt has key {
        id: 0x2::object::UID,
        number: u64,
        size: u64,
        data_url: 0x1::string::String,
        owner: address,
        version: u8,
        soulbound: bool,
    }

    struct WalletArtRegistry has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct MAIN has drop {
        dummy_field: bool,
    }

    public entry fun new(arg0: &mut WalletArtRegistry, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        assert!(v0 < 18446744073709551615 - 1, 0);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = generate_colors_from_address(v2);
        let v4 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v5 = 256;
        let v6 = &mut v1;
        0x1::string::append(&mut v4, hyper_encode(generate_svg_8(&v3, v6, v5)));
        let v7 = WalletArt{
            id        : 0x2::object::new(arg2),
            number    : v0 + 1,
            size      : v5,
            data_url  : v4,
            owner     : v2,
            version   : 1,
            soulbound : true,
        };
        arg0.count = v0 + 1;
        0x2::transfer::transfer<WalletArt>(v7, v2);
    }

    fun encode_8(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = &v0;
        let v2 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        while (0x1::vector::length<u8>(&arg0) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v4 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v5 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v6 = if (v4 == 0) {
                64
            } else {
                (v4 & 15) << 2 | v5 >> 6
            };
            let v7 = if (v5 == 0) {
                64
            } else {
                v5 & 63
            };
            let v8 = 0x1::vector::empty<u8>();
            let v9 = &mut v8;
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, ((v3 >> 2) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (((v3 & 3) << 4 | v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (v6 as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (v7 as u64)));
            0x1::vector::append<u8>(&mut v2, v8);
        };
        0x1::string::utf8(v2)
    }

    fun generate_colors_from_address(arg0: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(&arg0)));
        let v2 = b"Address hex: ";
        0x1::debug::print<vector<u8>>(&v2);
        0x1::debug::print<0x1::string::String>(&v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 + 6 <= 0x1::string::length(&v1) && v4 < 8) {
            let v5 = 0x1::string::utf8(b"#");
            0x1::string::append(&mut v5, 0x1::string::substring(&v1, v3, v3 + 6));
            0x1::vector::push_back<0x1::string::String>(&mut v0, v5);
            v3 = v3 + 6;
            v4 = v4 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&v0) < 3) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"#FF5733"));
        };
        v0
    }

    fun generate_colors_from_address_bytes(arg0: address) : vector<0x1::string::String> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 + 3 <= 0x1::vector::length<u8>(&v0) && 0x1::vector::length<0x1::string::String>(&v1) < 4) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = *0x1::vector::borrow<u8>(&v0, v2 + 1);
            let v5 = *0x1::vector::borrow<u8>(&v0, v2 + 2);
            let v6 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v6, 35);
            let v7 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v3 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v3 & 15) as u64)));
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v4 & 15) as u64)));
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v7, ((v5 & 15) as u64)));
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(v6));
            v2 = v2 + 3;
        };
        if (0x1::vector::is_empty<0x1::string::String>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"#FF5733"));
        };
        v1
    }

    fun generate_minimal_colors(arg0: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x2::bcs::to_bytes<address>(&arg0);
        let v2 = 0;
        let v3 = 0;
        while (v2 + 2 < 0x1::vector::length<u8>(&v1) && v3 < 4) {
            let v4 = 0x1::string::utf8(b"#");
            let v5 = 0x1::vector::empty<u8>();
            let v6 = &mut v5;
            0x1::vector::push_back<u8>(v6, *0x1::vector::borrow<u8>(&v1, v2));
            0x1::vector::push_back<u8>(v6, *0x1::vector::borrow<u8>(&v1, v2 + 1));
            0x1::vector::push_back<u8>(v6, *0x1::vector::borrow<u8>(&v1, v2 + 2));
            0x1::string::append(&mut v4, 0x1::string::utf8(0x2::hex::encode(v5)));
            0x1::vector::push_back<0x1::string::String>(&mut v0, v4);
            v2 = v2 + 3;
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<0x1::string::String>(&v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"#000000"));
        };
        v0
    }

    fun generate_optimized_svg(arg0: &vector<0x1::string::String>, arg1: u64) : vector<u8> {
        let v0 = 0x1::u64::sqrt(arg1);
        let v1 = 0x1::vector::length<0x1::string::String>(arg0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        let v3 = 0x1::u64::to_string(v0);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v2, b" ");
        let v4 = 0x1::u64::to_string(v0);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v4));
        0x1::vector::append<u8>(&mut v2, b"'>");
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::append<u8>(&mut v2, b"<path fill='");
            0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, v5)));
            0x1::vector::append<u8>(&mut v2, b"' d='");
            let v6 = 0;
            while (v6 < v0) {
                let v7 = 0;
                while (v7 < v0) {
                    if ((v7 * 31 + v6 * 17) % v1 == v5) {
                        0x1::vector::append<u8>(&mut v2, b"M");
                        let v8 = 0x1::u64::to_string(v7);
                        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v8));
                        0x1::vector::append<u8>(&mut v2, b",");
                        let v9 = 0x1::u64::to_string(v6);
                        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v9));
                        0x1::vector::append<u8>(&mut v2, b"h1v1h-1z");
                    };
                    v7 = v7 + 1;
                };
                v6 = v6 + 1;
            };
            0x1::vector::append<u8>(&mut v2, b"'/>");
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        v2
    }

    fun generate_svg_8(arg0: &vector<0x1::string::String>, arg1: &mut 0x2::random::RandomGenerator, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::u64::sqrt(arg2);
        let v2 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b" ");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b"' style='width:100vw;height:100vh;image-rendering:pixelated'>");
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::u64::to_string(v3);
            let v5 = 0;
            while (v5 < v1) {
                0x1::vector::append<u8>(&mut v0, b"<rect x='");
                let v6 = 0x1::u64::to_string(v5);
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v6));
                0x1::vector::append<u8>(&mut v0, b"' y='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v4));
                0x1::vector::append<u8>(&mut v0, b"' fill='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(select_random_element(arg1, arg0)));
                0x1::vector::append<u8>(&mut v0, b"' width='1' height='1'/>");
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    fun generate_svg_deterministic(arg0: &vector<0x1::string::String>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::u64::sqrt(arg1);
        let v2 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b" ");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b"' style='width:100vw;height:100vh;image-rendering:pixelated'>");
        let v3 = 0;
        while (v3 < v1) {
            let v4 = 0x1::u64::to_string(v3);
            let v5 = 0;
            while (v5 < v1) {
                0x1::vector::append<u8>(&mut v0, b"<rect x='");
                let v6 = 0x1::u64::to_string(v5);
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v6));
                0x1::vector::append<u8>(&mut v0, b"' y='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v4));
                0x1::vector::append<u8>(&mut v0, b"' fill='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, (((v5 + v3) % 0x1::vector::length<0x1::string::String>(arg0)) as u64))));
                0x1::vector::append<u8>(&mut v0, b"' width='1' height='1'/>");
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    fun generate_svg_minimal(arg0: &vector<0x1::string::String>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::u64::sqrt(arg1);
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        let v2 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b" ");
        let v3 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v0, b"'>");
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::u64::to_string(v4);
            let v6 = 0;
            while (v6 < v1) {
                0x1::vector::append<u8>(&mut v0, b"<rect x='");
                let v7 = 0x1::u64::to_string(v6);
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v7));
                0x1::vector::append<u8>(&mut v0, b"' y='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v5));
                0x1::vector::append<u8>(&mut v0, b"' fill='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg0, (((v6 ^ v4) % 0x1::vector::length<0x1::string::String>(arg0)) as u64))));
                0x1::vector::append<u8>(&mut v0, b"' width='1' height='1'/>");
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    public fun get_nft_data_url(arg0: &WalletArt) : &0x1::string::String {
        &arg0.data_url
    }

    public fun get_nft_number(arg0: &WalletArt) : u64 {
        arg0.number
    }

    public fun get_nft_owner(arg0: &WalletArt) : address {
        arg0.owner
    }

    public fun get_nft_size(arg0: &WalletArt) : u64 {
        arg0.size
    }

    public fun get_registry_count(arg0: &WalletArtRegistry) : u64 {
        arg0.count
    }

    fun hyper_encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        let v1 = 0x1::vector::length<u8>(&arg0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 + 3 <= v1) {
            let v4 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64) << 16 | (*0x1::vector::borrow<u8>(&arg0, v3 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0, v3 + 2) as u64);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 >> 18 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 >> 12 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 >> 6 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v4 & 63) as u64)));
            v3 = v3 + 3;
        };
        if (v3 + 2 == v1) {
            let v5 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64) << 16 | (*0x1::vector::borrow<u8>(&arg0, v3 + 1) as u64) << 8;
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v5 >> 18 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v5 >> 12 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v5 >> 6 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
        } else if (v3 + 1 == v1) {
            let v6 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64) << 16;
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v6 >> 18 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((v6 >> 12 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v2, 61);
            0x1::vector::push_back<u8>(&mut v2, 61);
        };
        0x1::string::utf8(v2)
    }

    fun hyper_optimized_svg(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::u64::sqrt(arg1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        let v3 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v2, b" ");
        let v4 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v4));
        0x1::vector::append<u8>(&mut v2, b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'>");
        0x1::vector::append<u8>(&mut v2, b"<style>rect { width: 1px; height: 1px; }</style>");
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::append<u8>(&mut v2, b"<g transform='translate(0, ");
            let v6 = 0x1::u64::to_string(v5);
            0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v6));
            0x1::vector::append<u8>(&mut v2, b")'>");
            let v7 = 0;
            while (v7 < v1) {
                let v8 = *0x1::vector::borrow<u8>(&v0, (v5 * v1 + v7) % 0x1::vector::length<u8>(&v0));
                let v9 = 0x1::string::utf8(b"#");
                let v10 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v10, (((v8 >> 5 & 7) * 36) as u8));
                let v11 = 0x1::string::utf8(0x2::hex::encode(v10));
                let v12 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v12, (((v8 >> 2 & 7) * 36) as u8));
                let v13 = 0x1::string::utf8(0x2::hex::encode(v12));
                let v14 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v14, (((v8 & 3) * 85) as u8));
                let v15 = 0x1::string::utf8(0x2::hex::encode(v14));
                if (0x1::string::length(&v11) == 1) {
                    0x1::string::append(&mut v9, 0x1::string::utf8(b"0"));
                };
                0x1::string::append(&mut v9, v11);
                if (0x1::string::length(&v13) == 1) {
                    0x1::string::append(&mut v9, 0x1::string::utf8(b"0"));
                };
                0x1::string::append(&mut v9, v13);
                if (0x1::string::length(&v15) == 1) {
                    0x1::string::append(&mut v9, 0x1::string::utf8(b"0"));
                };
                0x1::string::append(&mut v9, v15);
                0x1::vector::append<u8>(&mut v2, b"<rect x='");
                let v16 = 0x1::u64::to_string(v7);
                0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v16));
                0x1::vector::append<u8>(&mut v2, b"' fill='");
                0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v9));
                0x1::vector::append<u8>(&mut v2, b"'/>");
                v7 = v7 + 1;
            };
            0x1::vector::append<u8>(&mut v2, b"</g>");
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        v2
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MAIN>(arg0, arg1);
        let v1 = 0x2::display::new<WalletArt>(&v0, arg1);
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"rNFT #{number}"));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A regenerative {size}-pixel NFT, compiled from color codes within your Sui wallet address."));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{data_url}"));
        0x2::display::update_version<WalletArt>(&mut v1);
        let v2 = WalletArtRegistry{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalletArt>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<WalletArtRegistry>(v2);
    }

    public entry fun mint_optimized(arg0: &mut WalletArtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        assert!(v0 < 18446744073709551615 - 1, 0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v3 = 256;
        0x1::string::append(&mut v2, hyper_encode(hyper_optimized_svg(v1, v3)));
        let v4 = WalletArt{
            id        : 0x2::object::new(arg1),
            number    : v0 + 1,
            size      : v3,
            data_url  : v2,
            owner     : v1,
            version   : 1,
            soulbound : true,
        };
        arg0.count = v0 + 1;
        0x2::transfer::transfer<WalletArt>(v4, v1);
    }

    public entry fun new_devnet(arg0: &mut WalletArtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        assert!(v0 < 18446744073709551615 - 1, 0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = generate_colors_from_address(v1);
        let v3 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v4 = 256;
        0x1::string::append(&mut v3, hyper_encode(generate_svg_deterministic(&v2, v4)));
        let v5 = WalletArt{
            id        : 0x2::object::new(arg1),
            number    : v0 + 1,
            size      : v4,
            data_url  : v3,
            owner     : v1,
            version   : 1,
            soulbound : true,
        };
        arg0.count = v0 + 1;
        0x2::transfer::transfer<WalletArt>(v5, v1);
    }

    public entry fun new_devnet_minimal(arg0: &mut WalletArtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        assert!(v0 < 18446744073709551615 - 1, 0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = generate_minimal_colors(v1);
        let v3 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v4 = 1024;
        0x1::string::append(&mut v3, hyper_encode(generate_svg_minimal(&v2, v4)));
        let v5 = WalletArt{
            id        : 0x2::object::new(arg1),
            number    : v0 + 1,
            size      : v4,
            data_url  : v3,
            owner     : v1,
            version   : 1,
            soulbound : true,
        };
        arg0.count = v0 + 1;
        0x2::transfer::transfer<WalletArt>(v5, v1);
    }

    public entry fun new_ultra_optimized(arg0: &mut WalletArtRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        assert!(v0 < 18446744073709551615 - 1, 0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v3 = 256;
        0x1::string::append(&mut v2, hyper_encode(ultra_optimized_svg_from_address(v1, v3)));
        let v4 = WalletArt{
            id        : 0x2::object::new(arg1),
            number    : v0 + 1,
            size      : v3,
            data_url  : v2,
            owner     : v1,
            version   : 1,
            soulbound : true,
        };
        arg0.count = v0 + 1;
        0x2::transfer::transfer<WalletArt>(v4, v1);
    }

    fun select_random_element(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<0x1::string::String>) : &0x1::string::String {
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        assert!(v0 > 0, 1);
        let v1 = if (v0 == 1) {
            0
        } else {
            0x2::random::generate_u64_in_range(arg0, 0, v0 - 1)
        };
        assert!(v1 < v0, 2);
        0x1::vector::borrow<0x1::string::String>(arg1, v1)
    }

    fun ultra_optimized_svg_from_address(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::u64::sqrt(arg1);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        let v3 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v2, b" ");
        let v4 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v4));
        0x1::vector::append<u8>(&mut v2, b"' style='width:100vw;height:100vh'>");
        let v5 = 3;
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 + v5 <= 0x1::vector::length<u8>(&v0) && 0x1::vector::length<vector<u8>>(&v6) < 4) {
            let v8 = 0x1::vector::empty<u8>();
            let v9 = 0;
            while (v9 < v5) {
                0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&v0, v7 + v9));
                v9 = v9 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v6, v8);
            v7 = v7 + v5;
        };
        if (0x1::vector::is_empty<vector<u8>>(&v6)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, x"ff5733");
        };
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = 0;
        while (v11 < v1) {
            0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::u64::to_string(v11));
            v11 = v11 + 1;
        };
        let v12 = 0;
        while (v12 < v1) {
            let v13 = 0x1::vector::borrow<0x1::string::String>(&v10, v12);
            let v14 = 0;
            while (v14 < v1) {
                0x1::vector::append<u8>(&mut v2, b"<rect x='");
                let v15 = 0x1::u64::to_string(v14);
                0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v15));
                0x1::vector::append<u8>(&mut v2, b"' y='");
                0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(v13));
                0x1::vector::append<u8>(&mut v2, b"' fill='#");
                let v16 = 0x1::string::utf8(0x2::hex::encode(*0x1::vector::borrow<vector<u8>>(&v6, ((v14 ^ v12) + v14 * v12 % 29) % 0x1::vector::length<vector<u8>>(&v6))));
                0x1::vector::append<u8>(&mut v2, *0x1::string::as_bytes(&v16));
                0x1::vector::append<u8>(&mut v2, b"' width='1' height='1'/>");
                v14 = v14 + 1;
            };
            v12 = v12 + 1;
        };
        0x1::vector::append<u8>(&mut v2, b"</svg>");
        v2
    }

    // decompiled from Move bytecode v6
}

