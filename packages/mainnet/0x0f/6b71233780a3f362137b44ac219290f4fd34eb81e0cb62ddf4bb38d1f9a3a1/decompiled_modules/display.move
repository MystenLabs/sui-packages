module 0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::display {
    struct PackageDisplay has copy, drop, store {
        gradient_from: 0x1::string::String,
        gradient_to: 0x1::string::String,
        text_color: 0x1::string::String,
        name: 0x1::string::String,
        uri_encoded_name: 0x1::string::String,
    }

    public fun default(arg0: 0x1::string::String) : PackageDisplay {
        new(arg0, 0x1::string::utf8(b"E0E1EC"), 0x1::string::utf8(b"BDBFEC"), 0x1::string::utf8(b"030F1C"))
    }

    public(friend) fun encode_label(arg0: &mut PackageDisplay, arg1: 0x1::string::String) {
        let v0 = arg0.name;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::string::utf8(b"");
        while (v1 < 0x1::string::length(&v0)) {
            let v4 = v1;
            let v5 = v1 + 17;
            v1 = v5;
            if (v5 > 0x1::string::length(&v0)) {
                v1 = 0x1::string::length(&v0);
            };
            0x1::string::append(&mut v3, new_svg_text(0x1::string::substring(&v0, v4, v1), 38, 70 + v2 * 46, 41, arg0.text_color));
            v2 = v2 + 1;
        };
        let v6 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v6, 0x1::string::substring(&arg1, 0, 6));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"..."));
        0x1::string::append(&mut v6, 0x1::string::substring(&arg1, 0x1::string::length(&arg1) - 6, 0x1::string::length(&arg1)));
        0x1::string::append(&mut v3, new_svg_text(v6, 38, 70 + v2 * 46, 18, arg0.text_color));
        arg0.uri_encoded_name = 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::urlencode::encode(*0x1::string::as_bytes(&v3));
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : PackageDisplay {
        assert!(0x1::string::length(&arg0) <= 68, 9223372195768565761);
        PackageDisplay{
            gradient_from    : arg1,
            gradient_to      : arg2,
            text_color       : arg3,
            name             : arg0,
            uri_encoded_name : 0x1::string::utf8(b""),
        }
    }

    public fun new_svg_text(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<text x='");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' font-family='Roboto Mono, Courier, monospace' letter-spacing='0' font-weight='bold' font-size='"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' fill='#"));
        0x1::string::append(&mut v0, arg4);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"'>"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</text>"));
        v0
    }

    // decompiled from Move bytecode v6
}

