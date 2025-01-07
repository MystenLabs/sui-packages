module 0x1e5eac6391bdcdf45d32a6f84de1778f98926585d69c871a6c2fa8f24d604e7c::suidouble_color {
    struct ColorCreated has copy, drop {
        id: 0x2::object::ID,
        r: u8,
        g: u8,
        b: u8,
    }

    struct Color has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        r: u8,
        g: u8,
        b: u8,
        img_url: 0x1::string::String,
    }

    struct SUIDOUBLE_COLOR has drop {
        dummy_field: bool,
    }

    public fun encode(arg0: &vector<u8>) : vector<u8> {
        if (0x1::vector::is_empty<u8>(arg0)) {
            return 0x1::vector::empty<u8>()
        };
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 61;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v4, (((*0x1::vector::borrow<u8>(arg0, v3) & 252) >> 2) as u64)));
            if (v3 + 3 >= v0) {
                if (v0 % 3 == 1) {
                    let v5 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v5, (((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) as u64)));
                    0x1::vector::push_back<u8>(&mut v2, v1);
                    0x1::vector::push_back<u8>(&mut v2, v1);
                } else if (v0 % 3 == 2) {
                    let v6 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v6, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                    let v7 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v7, (((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) as u64)));
                    0x1::vector::push_back<u8>(&mut v2, v1);
                } else {
                    let v8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v8, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                    let v9 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v9, ((((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) + ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 192) >> 6)) as u64)));
                    let v10 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v10, ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 63) as u64)));
                };
            } else {
                let v11 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v11, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                let v12 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v12, ((((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) + ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 192) >> 6)) as u64)));
                let v13 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v13, ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 63) as u64)));
            };
            v3 = v3 + 3;
        };
        v2
    }

    fun init(arg0: SUIDOUBLE_COLOR, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suidouble-color.herokuapp.com/color/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"What a nice color. Isn't it?"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suidouble-color.herokuapp.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Jeka"));
        let v4 = 0x2::package::claim<SUIDOUBLE_COLOR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Color>(&v4, v0, v2, arg1);
        0x2::display::update_version<Color>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Color>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 255, 0);
        assert!(arg2 >= 0 && arg2 <= 255, 0);
        assert!(arg3 >= 0 && arg3 <= 255, 0);
        let v0 = 0x2::object::new(arg4);
        let v1 = ColorCreated{
            id : 0x2::object::uid_to_inner(&v0),
            r  : arg1,
            g  : arg2,
            b  : arg3,
        };
        0x2::event::emit<ColorCreated>(v1);
        let v2 = x"47494638396101000100800100";
        0x1::vector::insert<u8>(&mut v2, arg1, 13);
        0x1::vector::insert<u8>(&mut v2, arg2, 14);
        0x1::vector::insert<u8>(&mut v2, arg3, 15);
        0x1::vector::append<u8>(&mut v2, x"00000021f904010a0001002c00000000010001000002024401003b");
        let v3 = 0x1::string::utf8(b"data:image/gif;base64,");
        0x1::string::append(&mut v3, 0x1::string::utf8(encode(&v2)));
        let v4 = Color{
            id      : v0,
            name    : arg0,
            r       : arg1,
            g       : arg2,
            b       : arg3,
            img_url : v3,
        };
        0x2::transfer::transfer<Color>(v4, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

