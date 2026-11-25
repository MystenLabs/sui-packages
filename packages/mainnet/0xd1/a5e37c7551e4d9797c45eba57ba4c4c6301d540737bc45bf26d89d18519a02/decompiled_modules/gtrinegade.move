module 0xd1a5e37c7551e4d9797c45eba57ba4c4c6301d540737bc45bf26d89d18519a02::gtrinegade {
    struct GTRINEGADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRINEGADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRINEGADE>(arg0, 9, 0x1::string::utf8(b"GTRINEGADE"), 0x1::string::utf8(b"rin cel"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/qUe3ylLHoHXWrwQXVtUnUG9J4eRe8miOqW0yiuvjP6ntgUIu6wyh4gWI0HCuwmi2bM8Ne9-mpw9j3YXtJQT2eMkZWNdjQ5H3iwGoyrR7k2IWcPGJH6aUuoTosS81i79txFBVfQ4r40SAc4jvC833g_aHRjZjWZJdz-nROD017HLbXbXxfBmPm1xrRruC0bUaEZWJR2GO6az-P6r3c0TdsFjwjyurM1DPJEgKVMfpiWC1xyQW_XR0B1be5_JIvAX1ekNitPXA6rPobfd3Cgq23hy3LHR2VK-QUco5h11ckHn_KbrORZsR18u_oPMfZywaoDJDEddfFQnpZKCq4aq5iA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRINEGADE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRINEGADE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

