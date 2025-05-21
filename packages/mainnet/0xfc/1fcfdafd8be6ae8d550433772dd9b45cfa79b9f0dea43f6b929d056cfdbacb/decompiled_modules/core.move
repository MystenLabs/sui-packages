module 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::acl::new<CORE>(arg1);
        0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::store::new(arg1);
        0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::mint::new(arg1);
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Botter #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Botter Rule the Kingdom BARC BARC"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ipfs://{image}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::barc::Botter>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

