module 0x7c3ba4341a58165326157d54e0a98b984c98e9b78b771d561150a6246f0487d0::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<INIT>(arg0, arg1);
        let v1 = 0x2::display::new<0x7c3ba4341a58165326157d54e0a98b984c98e9b78b771d561150a6246f0487d0::kiosk::AssetNft>(&v0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.link}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{metadata.thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://bityou.app/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"bityou.app"));
        0x2::display::add_multiple<0x7c3ba4341a58165326157d54e0a98b984c98e9b78b771d561150a6246f0487d0::kiosk::AssetNft>(&mut v1, v2, v4);
        0x2::transfer::public_transfer<0x2::display::Display<0x7c3ba4341a58165326157d54e0a98b984c98e9b78b771d561150a6246f0487d0::kiosk::AssetNft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

