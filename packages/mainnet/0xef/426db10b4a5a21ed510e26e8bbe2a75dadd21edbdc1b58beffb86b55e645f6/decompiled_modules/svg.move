module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::svg {
    public fun generate_dynamic(arg0: &0x1::string::String, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8) : 0x1::string::String {
        let (v0, v1, v2) = rarity_colors(arg1);
        let v3 = if (arg5 == 0) {
            100
        } else {
            let v4 = arg4 * 100 / arg5;
            if (v4 > 100) {
                100
            } else {
                v4
            }
        };
        let v5 = if (arg7 == 0) {
            b"FUNDING"
        } else {
            b"LIVE"
        };
        let v6 = if (arg7 == 0) {
            b"#FF9F1C"
        } else {
            b"#2EC4B6"
        };
        let v7 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v7, b"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 400 450\" width=\"400\" height=\"450\">");
        0x1::vector::append<u8>(&mut v7, b"<defs><linearGradient id=\"bg\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\">");
        0x1::vector::append<u8>(&mut v7, b"<stop offset=\"0%\" stop-color=\"");
        0x1::vector::append<u8>(&mut v7, v1);
        0x1::vector::append<u8>(&mut v7, b"\"/><stop offset=\"100%\" stop-color=\"");
        0x1::vector::append<u8>(&mut v7, v2);
        0x1::vector::append<u8>(&mut v7, b"\"/></linearGradient></defs>");
        0x1::vector::append<u8>(&mut v7, b"<rect width=\"400\" height=\"450\" rx=\"24\" fill=\"url(#bg)\"/>");
        0x1::vector::append<u8>(&mut v7, b"<rect width=\"396\" height=\"446\" x=\"2\" y=\"2\" rx=\"22\" fill=\"none\" stroke=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\" stroke-width=\"3\"/>");
        0x1::vector::append<u8>(&mut v7, b"<rect width=\"400\" height=\"76\" rx=\"24\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\" opacity=\"0.9\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"20\" y=\"28\" font-family=\"monospace\" font-size=\"13\" font-weight=\"bold\" fill=\"#ffffff\" opacity=\"0.6\">VAULTZ</text>");
        0x1::vector::append<u8>(&mut v7, b"<rect x=\"296\" y=\"12\" width=\"80\" height=\"22\" rx=\"6\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v6);
        0x1::vector::append<u8>(&mut v7, b"\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"336\" y=\"27\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"10\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, v5);
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"50\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"22\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, rarity_label(arg1));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<polygon points=\"200,96 232,138 200,180 168,138\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\" opacity=\"0.7\"/>");
        0x1::vector::append<u8>(&mut v7, b"<polygon points=\"200,108 224,138 200,168 176,138\" fill=\"#ffffff\" opacity=\"0.25\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"210\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"17\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, *0x1::string::bytes(arg0));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<line x1=\"40\" y1=\"224\" x2=\"360\" y2=\"224\" stroke=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\" stroke-width=\"1\" opacity=\"0.35\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"252\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"10\" fill=\"#aaaaaa\" letter-spacing=\"2\">TOKEN ALLOCATION</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"278\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"18\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(arg2 / 1000000000));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"60\" y=\"305\" font-family=\"monospace\" font-size=\"9\" fill=\"#888888\">RAISED</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"340\" y=\"305\" text-anchor=\"end\" font-family=\"monospace\" font-size=\"9\" fill=\"#888888\">GOAL</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"60\" y=\"320\" font-family=\"monospace\" font-size=\"12\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(arg4 / 1000000000));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"340\" y=\"320\" text-anchor=\"end\" font-family=\"monospace\" font-size=\"12\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(arg5 / 1000000000));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<rect x=\"60\" y=\"328\" width=\"280\" height=\"10\" rx=\"5\" fill=\"#333333\"/>");
        0x1::vector::append<u8>(&mut v7, b"<rect x=\"60\" y=\"328\" width=\"");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(v3 * 280 / 100));
        0x1::vector::append<u8>(&mut v7, b"\" height=\"10\" rx=\"5\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"354\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"9\" fill=\"#888888\">");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(v3));
        0x1::vector::append<u8>(&mut v7, x"252066756e6465642020e280a22020");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(arg6));
        0x1::vector::append<u8>(&mut v7, b" minted</text>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"380\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"9\" fill=\"#666666\">#");
        0x1::vector::append<u8>(&mut v7, u64_to_bytes(arg3));
        0x1::vector::append<u8>(&mut v7, b"</text>");
        0x1::vector::append<u8>(&mut v7, b"<rect x=\"40\" y=\"400\" width=\"320\" height=\"26\" rx=\"8\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, b"\" opacity=\"0.12\"/>");
        0x1::vector::append<u8>(&mut v7, b"<text x=\"200\" y=\"417\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"9\" letter-spacing=\"2\" fill=\"");
        0x1::vector::append<u8>(&mut v7, v0);
        0x1::vector::append<u8>(&mut v7, x"223e44594e414d4943204e46542020e280a220204f4e20434841494e2020e280a220205641554c545a3c2f746578743e");
        0x1::vector::append<u8>(&mut v7, b"</svg>");
        0x1::string::utf8(v7)
    }

    public fun generate_static(arg0: &0x1::string::String, arg1: u8, arg2: u64, arg3: u64) : 0x1::string::String {
        let (v0, v1, v2) = rarity_colors(arg1);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, b"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 400 400\" width=\"400\" height=\"400\">");
        0x1::vector::append<u8>(&mut v3, b"<defs><linearGradient id=\"bg\" x1=\"0\" y1=\"0\" x2=\"1\" y2=\"1\">");
        0x1::vector::append<u8>(&mut v3, b"<stop offset=\"0%\" stop-color=\"");
        0x1::vector::append<u8>(&mut v3, v1);
        0x1::vector::append<u8>(&mut v3, b"\"/><stop offset=\"100%\" stop-color=\"");
        0x1::vector::append<u8>(&mut v3, v2);
        0x1::vector::append<u8>(&mut v3, b"\"/></linearGradient></defs>");
        0x1::vector::append<u8>(&mut v3, b"<rect width=\"400\" height=\"400\" rx=\"24\" fill=\"url(#bg)\"/>");
        0x1::vector::append<u8>(&mut v3, b"<rect width=\"396\" height=\"396\" x=\"2\" y=\"2\" rx=\"22\" fill=\"none\" stroke=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"\" stroke-width=\"3\"/>");
        0x1::vector::append<u8>(&mut v3, b"<rect width=\"400\" height=\"76\" rx=\"24\" fill=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"\" opacity=\"0.9\"/>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"20\" y=\"28\" font-family=\"monospace\" font-size=\"13\" font-weight=\"bold\" fill=\"#ffffff\" opacity=\"0.6\">VAULTZ</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"50\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"22\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v3, rarity_label(arg1));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<polygon points=\"200,96 232,140 200,184 168,140\" fill=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"\" opacity=\"0.7\"/>");
        0x1::vector::append<u8>(&mut v3, b"<polygon points=\"200,108 224,140 200,172 176,140\" fill=\"#ffffff\" opacity=\"0.25\"/>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"218\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"17\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(arg0));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<line x1=\"40\" y1=\"232\" x2=\"360\" y2=\"232\" stroke=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"\" stroke-width=\"1\" opacity=\"0.35\"/>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"264\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"10\" fill=\"#aaaaaa\" letter-spacing=\"2\">TOKEN ALLOCATION</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"296\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"20\" font-weight=\"bold\" fill=\"#ffffff\">");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg2 / 1000000000));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"328\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"10\" fill=\"#888888\">#");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg3));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<rect x=\"40\" y=\"352\" width=\"320\" height=\"26\" rx=\"8\" fill=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"\" opacity=\"0.12\"/>");
        0x1::vector::append<u8>(&mut v3, b"<text x=\"200\" y=\"369\" text-anchor=\"middle\" font-family=\"monospace\" font-size=\"9\" letter-spacing=\"2\" fill=\"");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, x"223e4e46542020e280a220204f4e20434841494e2020e280a220205641554c545a3c2f746578743e");
        0x1::vector::append<u8>(&mut v3, b"</svg>");
        0x1::string::utf8(v3)
    }

    fun rarity_colors(arg0: u8) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == 0) {
            (b"#FFD700", b"#1a0533", b"#FFF5CC")
        } else if (arg0 == 1) {
            (b"#00B4D8", b"#0a1628", b"#E0F4FF")
        } else {
            (b"#52B788", b"#0d2b1f", b"#EBFAEF")
        }
    }

    fun rarity_label(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"MYTHIC"
        } else if (arg0 == 1) {
            b"RARE"
        } else {
            b"COMMON"
        }
    }

    public fun to_data_uri(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"data:image/svg+xml;utf8,");
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(arg0));
        0x1::string::utf8(v0)
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v7
}

