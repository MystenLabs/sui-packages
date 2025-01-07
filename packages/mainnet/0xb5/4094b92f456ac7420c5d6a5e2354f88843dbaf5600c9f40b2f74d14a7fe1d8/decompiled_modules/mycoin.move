module 0xb54094b92f456ac7420c5d6a5e2354f88843dbaf5600c9f40b2f74d14a7fe1d8::mycoin {
    struct Receipt has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
    }

    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"URGENT!!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://media.gq.com/photos/5b6b20e3a3a1320b7280f029/16:9/w_2560%2Cc_limit/The-Brutal-Wonders-Of-The-Architecture-World-GQ-Style-Fall-2018_07.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AA"));
        let v4 = 0x2::package::claim<MYCOIN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun send(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Receipt{
            id          : 0x2::object::new(arg2),
            description : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<Receipt>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

