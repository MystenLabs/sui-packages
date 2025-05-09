module 0xfc6546038e20dca9c256662be9719034f0fcc6243f889e5b0bcf43f950357966::frosty {
    struct Passport has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frostyswap.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frostyswap.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap"));
        let v4 = 0x2::package::claim<FROSTY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Passport>(&v4, v0, v2, arg1);
        0x2::display::update_version<Passport>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Passport>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Passport{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            img_url : arg1,
        };
        0x2::transfer::public_transfer<Passport>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

