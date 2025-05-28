module 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::admin {
    public(friend) fun assert_is_authorized(arg0: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::AccessControl, arg1: &0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::Admin) {
        assert!(0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::has_role(arg1, arg0, 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::constants::treasurer_role()), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::add(&v2, &mut v3, 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::constants::treasurer_role());
        0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::grant(&v2, &mut v3, 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::constants::treasurer_role(), 0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::addy(&v2));
        0x2::transfer::public_share_object<0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::AccessControl>(v3);
        0x2::transfer::public_transfer<0xbe2e0766813127e94e2b4a192848464c18a40fcc70da214334741d31cbd5945b::access_control::Admin>(v2, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

