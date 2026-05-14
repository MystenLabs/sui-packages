module 0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::nft_display {
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://timevyn.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::anniversary_vault::Today365>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::anniversary_vault::Today365>(&mut v5);
        0x2::transfer::public_share_object<0x2::display::Display<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::anniversary_vault::Today365>>(v5);
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
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://timevyn.com"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{year}"));
        let v10 = 0x2::display::new_with_fields<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::nostalgia_ticket::NostalgiaTicket>(&v0, v6, v8, arg1);
        0x2::display::update_version<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::nostalgia_ticket::NostalgiaTicket>(&mut v10);
        0x2::transfer::public_share_object<0x2::display::Display<0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::nostalgia_ticket::NostalgiaTicket>>(v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

