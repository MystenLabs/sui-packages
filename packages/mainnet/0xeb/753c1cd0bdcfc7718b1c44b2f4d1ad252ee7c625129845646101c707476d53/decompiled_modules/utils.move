module 0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::utils {
    public(friend) fun calculate_chunk_identifier_hash(arg0: u16, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u16>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, arg1);
        calculate_hash(&v1)
    }

    public(friend) fun calculate_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public(friend) fun render_svg_image(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"500\" height=\"500\" viewBox=\"0 0 500 500\">"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<defs>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<radialGradient id=\"a\" cx=\"50%\" cy=\"50%\" r=\"50%\">"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<stop offset=\"0\" stop-color=\"#374151\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<stop offset=\"70%\" stop-color=\"#111827\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<stop offset=\"100%\" stop-color=\"#000\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</radialGradient>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</defs>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<rect width=\"500\" height=\"500\" fill=\"url(#a)\"/>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<text x=\"250\" y=\"250\" font-family=\"ui-monospace,'Cascadia Code',monospace\" font-size=\"50\" font-weight=\"bold\" fill=\"#fff\" text-anchor=\"middle\" dominant-baseline=\"middle\">"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</text>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<text x=\"250\" y=\"310\" font-family=\"ui-monospace,'Cascadia Code',monospace\" font-size=\"25\" fill=\"#fff\" text-anchor=\"middle\" dominant-baseline=\"middle\">22345095 bytes</text>"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        let v1 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        0x1::string::append(&mut v1, 0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::base64::encode(v0));
        v1
    }

    public fun transfer_objs<T0: store + key>(arg0: vector<T0>, arg1: address) {
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

