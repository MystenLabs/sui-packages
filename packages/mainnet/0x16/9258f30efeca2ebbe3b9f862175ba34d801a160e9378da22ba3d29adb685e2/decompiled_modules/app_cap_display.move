module 0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::app_cap_display {
    struct AppCapDisplay has copy, drop, store {
        title: 0x1::string::String,
        link_opacity: u8,
        uri_encoded_text: 0x1::string::String,
    }

    public(friend) fun new(arg0: 0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::name::Name, arg1: bool) : AppCapDisplay {
        let v0 = if (arg1) {
            100
        } else {
            0
        };
        AppCapDisplay{
            title            : 0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::name::to_string(&arg0),
            link_opacity     : v0,
            uri_encoded_text : uri_encode_text(arg0),
        }
    }

    fun new_svg_text(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"<text x='");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' y='"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' font-family='Roboto Mono, Courier, monospace' letter-spacing='0' font-size='"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' fill='#"));
        0x1::string::append(&mut v0, arg4);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"'>"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</text>"));
        v0
    }

    fun render_batch(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String) : (0x1::string::String, u64) {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0;
        let v2 = arg2;
        while (v1 < 0x1::string::length(&arg0)) {
            let v3 = v1;
            let v4 = v1 + arg1;
            v1 = v4;
            if (v4 > 0x1::string::length(&arg0)) {
                v1 = 0x1::string::length(&arg0);
            };
            0x1::string::append(&mut v0, new_svg_text(0x1::string::substring(&arg0, v3, v1), 20, v2, arg3, arg5));
            v2 = v2 + arg4;
        };
        (v0, v2)
    }

    public(friend) fun set_link_opacity(arg0: &mut AppCapDisplay, arg1: bool) {
        let v0 = if (arg1) {
            100
        } else {
            0
        };
        arg0.link_opacity = v0;
    }

    public(friend) fun uri_encode_text(arg0: 0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::name::Name) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::name::org_to_string(&arg0);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"/"));
        let (v2, v3) = render_batch(v1, 22, 40, 15, 18, 0x1::string::utf8(b"91A3B1"));
        0x1::string::append(&mut v0, v2);
        let (v4, _) = render_batch(0x169258f30efeca2ebbe3b9f862175ba34d801a160e9378da22ba3d29adb685e2::name::app_to_string(&arg0), 13, v3 + 10, 26, 26, 0x1::string::utf8(b"FFFFFF"));
        0x1::string::append(&mut v0, v4);
        0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::urlencode::encode(*0x1::string::as_bytes(&v0))
    }

    // decompiled from Move bytecode v6
}

