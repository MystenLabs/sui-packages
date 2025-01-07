module 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::ve_sca_display {
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ve-sca.scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://vrr7y7aent4hea3r444jrrsvgvgwsz6zi2r2vv2odhgfrgvvs6iq.arweave.net/rGP8fARs-HIDcec4mMZVNU1pZ9lGo6rXThnMWJq1l5E"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The key to prove the ownership of vote-escrowed SCA"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Scallop Labs"));
        let v5 = 0x2::display::new_with_fields<0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::ve_sca::VeScaKey>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::ve_sca::VeScaKey>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::ve_sca::VeScaKey>>(v5, v6);
    }

    // decompiled from Move bytecode v6
}

