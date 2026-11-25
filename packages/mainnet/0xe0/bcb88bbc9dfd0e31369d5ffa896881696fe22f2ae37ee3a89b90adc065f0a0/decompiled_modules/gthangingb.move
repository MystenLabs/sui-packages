module 0xe0bcb88bbc9dfd0e31369d5ffa896881696fe22f2ae37ee3a89b90adc065f0a0::gthangingb {
    struct GTHANGINGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHANGINGB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHANGINGB>(arg0, 9, 0x1::string::utf8(b"GTHANGINGB"), 0x1::string::utf8(b"wind"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/SZd2ObxWPoJw2Ub14Hkn3l5uo42Qdtq2H9gyjKOFGMEvMDoo5F39SOq256iVJqFs6jv1hSKDpTFZwFMnxEa7nhYGZ1OmJPCee6LJIIMoll9JvMpPGiQTX4YOdwVBawvzel9u0z2BlLWVVDPoeA3M0oaXvoa3guIs0MMb8BTRVt_w0IpAdl1kczE_ys-AdhoiKXaw1gWTj2sOxqyAA9N9ZBhkg3vip6mcbVzKvIVvoBX_ubBzBv2OC5bUjaWN4z1baFPrgzOBs6yAnsLvnefX-afGKpv2Yzdb2KdFjKXkiGLxPW0HsR_N8ZorSIJsLMWrBDIZSrDBBxZV_S_lsSbxgA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHANGINGB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHANGINGB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

