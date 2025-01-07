module 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::ve_sca_display {
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"VeSca"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ve-sca.scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"VeSca is vesting token for Sca."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scallop Labs"));
        let v5 = 0x2::display::new_with_fields<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::linear_ve_sca::LinearVeSca>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::linear_ve_sca::LinearVeSca>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::linear_ve_sca::LinearVeSca>>(v5, v6);
    }

    // decompiled from Move bytecode v6
}

