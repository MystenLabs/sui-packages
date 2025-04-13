module 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::new<CORE>(arg1);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::new_sale(arg1);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::new(arg1);
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Mystic Yeti #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"4d7973746963205965746973206973206120756e6971756520636f6c6c656374696f6e206f662068616e642d63726166746564206469676974616c2061727420746861742063617074757265732074686520737069726974206f6620616e6369656e7420796574697320696e20746865204c6f666920756e6976657273652e2045616368204e465420666561747572657320612064697374696e63742c206f6e652d6f662d612d6b696e642079657469206368617261637465722065787564696e6720626f746820776973646f6d20616e64206d7973746572792e2041732070617274206f6620746865204c6f666920636f6d6d756e6974792c20796f75e280997265206e6f74206a75737420636f6c6c656374696e6720617274202d20796f75e280997265206761696e696e672061636365737320746f20616e2065766f6c76696e672065636f73797374656d206f6620636f6d6d756e6974792c20636f6c6c61626f726174696f6e732c20616e6420657870657269656e6365732e"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let (v5, v6) = 0x2::transfer_policy::new<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>(&v0, arg1);
        let (v7, v8) = 0x2::transfer_policy::new<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>(&v0, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti, 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::WITNESS_RULE>(&mut v10, &v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>>(v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>>(0x2::display::new_with_fields<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>(&v0, v1, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>>(v9, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

