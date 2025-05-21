module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::acl::new<CORE>(arg1);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::store::new(arg1);
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::mint::new(arg1);
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Botter Arc #{number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Botter Rule the Kingdom BARC BARC"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ipfs://{image}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::barc::Botter>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

