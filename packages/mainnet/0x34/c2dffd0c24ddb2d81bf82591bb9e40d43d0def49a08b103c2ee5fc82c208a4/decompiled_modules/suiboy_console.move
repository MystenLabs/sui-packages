module 0x34c2dffd0c24ddb2d81bf82591bb9e40d43d0def49a08b103c2ee5fc82c208a4::suiboy_console {
    struct SUIBOY_CONSOLE has drop {
        dummy_field: bool,
    }

    struct SuiBoyConsole has store, key {
        id: 0x2::object::UID,
        color: 0x1::string::String,
        brand: 0x1::string::String,
    }

    fun init(arg0: SUIBOY_CONSOLE, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiBoy Custom Hardcore Console Shell"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun/arcade"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun/assets/consoles/shell.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A fully dynamic on-chain modular game layout pipeline device object."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiBoy Labs Engine Group"));
        let v4 = 0x2::package::claim<SUIBOY_CONSOLE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiBoyConsole>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiBoyConsole>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiBoyConsole>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_console(arg0: 0x1::string::String, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 3000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg2), @0xe1089d77e25643ea64ea003106ee093f9d066ad1579027ac8f5f2e0779e190a8);
        let v1 = if (arg0 == 0x1::string::utf8(b"#a855f7")) {
            0x1::string::utf8(b"SuiBoy Nebula")
        } else {
            0x1::string::utf8(b"SuiBoy Custom")
        };
        let v2 = SuiBoyConsole{
            id    : 0x2::object::new(arg2),
            color : arg0,
            brand : v1,
        };
        0x2::transfer::public_transfer<SuiBoyConsole>(v2, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

