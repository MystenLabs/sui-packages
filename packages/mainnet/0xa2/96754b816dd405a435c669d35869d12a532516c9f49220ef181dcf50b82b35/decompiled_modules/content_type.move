module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::content_type {
    public fun content_type_application_bcs() : 0x1::string::String {
        0x1::string::utf8(b"application/bcs")
    }

    public fun content_type_application_bcs_with_type_name<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"application/bcs");
        0x1::string::append_utf8(&mut v0, b"; type_name=");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>()));
        v0
    }

    public fun content_type_application_json() : 0x1::string::String {
        0x1::string::utf8(b"application/json")
    }

    public fun content_type_application_pdf() : 0x1::string::String {
        0x1::string::utf8(b"application/pdf")
    }

    public fun content_type_image_bmp() : 0x1::string::String {
        0x1::string::utf8(b"image/bmp")
    }

    public fun content_type_image_gif() : 0x1::string::String {
        0x1::string::utf8(b"image/gif")
    }

    public fun content_type_image_jpeg() : 0x1::string::String {
        0x1::string::utf8(b"image/jpeg")
    }

    public fun content_type_image_png() : 0x1::string::String {
        0x1::string::utf8(b"image/png")
    }

    public fun content_type_image_svg() : 0x1::string::String {
        0x1::string::utf8(b"image/svg+xml")
    }

    public fun content_type_image_webp() : 0x1::string::String {
        0x1::string::utf8(b"image/webp")
    }

    public fun content_type_text_css() : 0x1::string::String {
        0x1::string::utf8(b"text/css")
    }

    public fun content_type_text_html() : 0x1::string::String {
        0x1::string::utf8(b"text/html")
    }

    public fun content_type_text_javascript() : 0x1::string::String {
        0x1::string::utf8(b"text/javascript")
    }

    public fun content_type_text_plain() : 0x1::string::String {
        0x1::string::utf8(b"text/plain")
    }

    public fun content_type_text_xml() : 0x1::string::String {
        0x1::string::utf8(b"text/xml")
    }

    public fun get_bcs_type_name(arg0: &0x1::string::String) : 0x1::option::Option<0x1::ascii::String> {
        if (!is_bcs(arg0)) {
            0x1::option::none<0x1::ascii::String>()
        } else {
            let v1 = 0x1::string::bytes(arg0);
            let v2 = b"type_name=";
            let (v3, v4) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::index_of(v1, &v2);
            if (v3) {
                0x1::option::some<0x1::ascii::String>(0x1::ascii::string(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::substring(v1, v4 + 10, 0x1::vector::length<u8>(v1))))
            } else {
                0x1::option::none<0x1::ascii::String>()
            }
        }
    }

    public fun is_bcs(arg0: &0x1::string::String) : bool {
        let v0 = b"application/bcs";
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::starts_with(0x1::string::bytes(arg0), &v0)
    }

    public fun is_image(arg0: &0x1::string::String) : bool {
        let v0 = b"image/";
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::starts_with(0x1::string::bytes(arg0), &v0)
    }

    public fun is_text(arg0: &0x1::string::String) : bool {
        let v0 = b"text/";
        if (0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::starts_with(0x1::string::bytes(arg0), &v0)) {
            true
        } else {
            let v2 = b"application/json";
            0x1::string::bytes(arg0) == &v2
        }
    }

    public fun new_ascii_metadata(arg0: &0x1::ascii::String) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::new_metadata(content_type_text_plain(), *0x1::ascii::as_bytes(arg0))
    }

    public fun new_bcs_metadata<T0>(arg0: &T0) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::new_metadata(content_type_application_bcs_with_type_name<T0>(), 0x2::bcs::to_bytes<T0>(arg0))
    }

    public fun new_string_metadata(arg0: &0x1::string::String) : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::new_metadata(content_type_text_plain(), *0x1::string::bytes(arg0))
    }

    // decompiled from Move bytecode v6
}

