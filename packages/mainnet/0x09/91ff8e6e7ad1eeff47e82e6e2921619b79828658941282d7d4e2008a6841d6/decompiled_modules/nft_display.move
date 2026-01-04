module 0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::nft_display {
    struct NFT_DISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_DISPLAY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://timekeepsyou.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::anniversary_vault::Today365>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::anniversary_vault::Today365>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::anniversary_vault::Today365>>(v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"year"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://timekeepsyou.com"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{year}"));
        let v10 = 0x2::display::new_with_fields<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::nostalgia_ticket::NostalgiaTicket>(&v0, v6, v8, arg1);
        0x2::display::update_version<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::nostalgia_ticket::NostalgiaTicket>(&mut v10);
        0x2::transfer::public_share_object<0x2::display::Display<0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::nostalgia_ticket::NostalgiaTicket>>(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

