module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::svg {
    fun build_awakened_overlay() : vector<u8> {
        b"<rect x=\"4\" y=\"4\" width=\"392\" height=\"392\" rx=\"8\" fill=\"none\" stroke=\"#00e5ff\" stroke-width=\"3\"/>"
    }

    fun build_evolution_overlay(arg0: u8, arg1: u64) : vector<u8> {
        if (arg0 == 0) {
            build_genesis_overlay(arg1)
        } else if (arg0 == 1) {
            build_awakened_overlay()
        } else if (arg0 == 2) {
            build_evolved_overlay()
        } else if (arg0 == 3) {
            build_legendary_overlay()
        } else {
            build_genesis_overlay(arg1)
        }
    }

    fun build_evolved_overlay() : vector<u8> {
        let v0 = b"<rect x=\"2\" y=\"2\" width=\"396\" height=\"396\" rx=\"10\" fill=\"none\" stroke=\"#22d3ee\" stroke-width=\"2\"/>";
        0x1::vector::append<u8>(&mut v0, b"<rect x=\"8\" y=\"8\" width=\"384\" height=\"384\" rx=\"6\" fill=\"none\" stroke=\"#22d3ee\" stroke-width=\"1\" opacity=\"0.5\"/>");
        v0
    }

    fun build_genesis_overlay(arg0: u64) : vector<u8> {
        let v0 = b"<rect width=\"400\" height=\"400\" fill=\"rgba(0,0,0,0.55)\"/>";
        0x1::vector::append<u8>(&mut v0, b"<rect x=\"20\" y=\"370\" width=\"360\" height=\"8\" rx=\"4\" fill=\"#1a1a2e\"/>");
        let v1 = b"<rect x=\"20\" y=\"370\" width=\"";
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(360 * arg0 / 100));
        0x1::vector::append<u8>(&mut v1, b"\" height=\"8\" rx=\"4\" fill=\"#6c3483\"/>");
        0x1::vector::append<u8>(&mut v0, v1);
        v0
    }

    fun build_hud(arg0: &0x1::string::String, arg1: u64, arg2: u8) : vector<u8> {
        let v0 = b"<rect x=\"0\" y=\"345\" width=\"400\" height=\"55\" fill=\"rgba(0,0,0,0.7)\"/>";
        0x1::vector::append<u8>(&mut v0, b"<text x=\"12\" y=\"365\" font-family=\"monospace\" font-size=\"11\" fill=\"#aaaaaa\">");
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, b"</text>");
        0x1::vector::append<u8>(&mut v0, b"<text x=\"12\" y=\"385\" font-family=\"monospace\" font-size=\"13\" font-weight=\"bold\" fill=\"#ffffff\">#");
        0x1::vector::append<u8>(&mut v0, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, b"</text>");
        let (v1, v2) = state_badge(arg2);
        0x1::vector::append<u8>(&mut v0, b"<rect x=\"310\" y=\"352\" width=\"80\" height=\"20\" rx=\"4\" fill=\"");
        0x1::vector::append<u8>(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, b"\" opacity=\"0.85\"/>");
        0x1::vector::append<u8>(&mut v0, b"<text x=\"350\" y=\"366\" font-family=\"monospace\" font-size=\"9\" font-weight=\"bold\" fill=\"#ffffff\" text-anchor=\"middle\">");
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::vector::append<u8>(&mut v0, b"</text>");
        v0
    }

    fun build_legendary_overlay() : vector<u8> {
        let v0 = b"<rect x=\"2\" y=\"2\" width=\"396\" height=\"396\" rx=\"10\" fill=\"none\" stroke=\"#f59e0b\" stroke-width=\"4\"/>";
        0x1::vector::append<u8>(&mut v0, b"<rect x=\"0\" y=\"0\" width=\"400\" height=\"400\" fill=\"none\" stroke=\"#fbbf24\" stroke-width=\"8\" opacity=\"0.3\"/>");
        0x1::vector::append<u8>(&mut v0, b"<text x=\"200\" y=\"210\" font-family=\"serif\" font-size=\"28\" font-weight=\"bold\" fill=\"#f59e0b\" opacity=\"0.18\" text-anchor=\"middle\" transform=\"rotate(-30 200 200)\">LEGENDARY</text>");
        v0
    }

    public fun compose_nft_svg(arg0: vector<0x1::string::String>, arg1: u8, arg2: &0x1::string::String, arg3: u64, arg4: u64, arg5: u64) : 0x1::string::String {
        let v0 = b"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 400 400\">";
        0x1::vector::append<u8>(&mut v0, b"<rect width=\"400\" height=\"400\" fill=\"#0a0a0f\"/>");
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(&arg0, v1)));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, build_evolution_overlay(arg1, arg4));
        0x1::vector::append<u8>(&mut v0, build_hud(arg2, arg3, arg1));
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        let v2 = b"data:image/svg+xml;utf8,";
        0x1::vector::append<u8>(&mut v2, encode_hashes(v0));
        0x1::string::utf8(v2)
    }

    fun encode_hashes(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 == 35) {
                0x1::vector::push_back<u8>(&mut v0, 37);
                0x1::vector::push_back<u8>(&mut v0, 50);
                0x1::vector::push_back<u8>(&mut v0, 51);
            } else {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun state_badge(arg0: u8) : (vector<u8>, vector<u8>) {
        if (arg0 == 0) {
            (b"GENESIS", b"#4a4a6a")
        } else if (arg0 == 1) {
            (b"AWAKENED", b"#0891b2")
        } else if (arg0 == 2) {
            (b"EVOLVED", b"#0d9488")
        } else {
            (b"LEGENDARY", b"#b45309")
        }
    }

    public fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    // decompiled from Move bytecode v7
}

