module 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_display {
    struct VE_SCA_DISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VE_SCA_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VE_SCA_DISPLAY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"VeSCA Key"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.scallop.io/vesca"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ipfs://bafkreibaercu3fplp3k4qd3rnvbuotndy3upykeajirfiba2ueu3tnc7ki"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The key to prove the ownership of vote-escrowed SCA"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scallop Labs"));
        let v5 = 0x2::display::new_with_fields<0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca::VeScaKey>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca::VeScaKey>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca::VeScaKey>>(v5, v6);
    }

    // decompiled from Move bytecode v6
}

