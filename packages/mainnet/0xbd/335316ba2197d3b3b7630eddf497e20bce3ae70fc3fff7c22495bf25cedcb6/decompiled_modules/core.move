module 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::new<CORE>(arg1);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::new_sale(arg1);
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"TEST NFT #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"TEST NFT DESCRIPTION"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Pass for the whitelist sale"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://raw.githubusercontent.com/Iamknownasfesal/lofi-image/refs/heads/main/whitelist_pass.jpg"));
        let v10 = 0x2::display::new_with_fields<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WhitelistPass>(&v0, v6, v8, arg1);
        0x2::display::update_version<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WhitelistPass>(&mut v10);
        let (v11, v12) = 0x2::transfer_policy::new<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>(&v0, arg1);
        let (v13, v14) = 0x2::transfer_policy::new<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>(&v0, arg1);
        let v15 = v14;
        let v16 = v13;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti, 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WITNESS_RULE>(&mut v16, &v15);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>>(v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>>(v16);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>>(v12, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WhitelistPass>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>>(v15, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

