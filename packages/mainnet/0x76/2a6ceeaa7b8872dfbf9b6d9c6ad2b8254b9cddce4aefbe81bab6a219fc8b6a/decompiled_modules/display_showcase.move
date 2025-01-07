module 0x762a6ceeaa7b8872dfbf9b6d9c6ad2b8254b9cddce4aefbe81bab6a219fc8b6a::display_showcase {
    struct DisplayShowcase has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct DISPLAY_SHOWCASE has drop {
        dummy_field: bool,
    }

    public entry fun create_showcase(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayShowcase{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::transfer<DisplayShowcase>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init(arg0: DISPLAY_SHOWCASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISPLAY_SHOWCASE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"action"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AAAAAAAAAAAA"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"BBBBBBBBBBBBBBBB"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://i.imgur.com/mkwmbWN.jpeg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"MODIFY"));
        let v5 = 0x2::display::new_with_fields<DisplayShowcase>(&v0, v1, v3, arg1);
        0x2::display::update_version<DisplayShowcase>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DisplayShowcase>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun modify_showcase(arg0: &mut DisplayShowcase) {
        arg0.value = arg0.value + 1;
    }

    // decompiled from Move bytecode v6
}

