module 0xd16396f6108c69e6f1c6df9fde753781c3d661df1a4f293d881a36b77824e1f3::gtyieldfa {
    struct GTYIELDFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTYIELDFA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTYIELDFA>(arg0, 9, 0x1::string::utf8(b"GTYIELDFA"), 0x1::string::utf8(b"Adeniyi"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/BKkVQyIFW7E3DxksMe5m7U1Aaw4veZNFI1eW-JfURbI4jmKDsZsYrnAr4u9RvViphhm0T4FsIj0w0XqpOJcSMo1JqRdMF63LY2Tj1NKNvEpNNGZrdm8NDfToIsZUW6CzTqJGJXIgZ9j0g7BTbtjm_wHT72QU_7FdidrHSDzez11gvl5RQL2YL6mnlynTON1EFy-_i5_VdOVocKs5IxwfNIeeKU00d_f68lwdrMa9mQgegHuM9mRJace8IfJXoQ8gVwUIkQaCV-g97MPbODPZ6bPP_h7WCdiFluC8Kw_xFo-8BvIk6JvlbyZ_0W9ztc0DgpC4LDQQW-UJCegImwCgag.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTYIELDFA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTYIELDFA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

