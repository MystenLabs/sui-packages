module 0xc3507b477b2af08fd648e4838e1c095c714189ecbc4dd3f0a22601150e492e66::gteke1208 {
    struct GTEKE1208 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEKE1208, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEKE1208>(arg0, 9, 0x1::string::utf8(b"GTEKE1208"), 0x1::string::utf8(b"Eke"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/pvfg-a8gCLxcHdgKEt3ysqGuUtpt94HRbudBNsSsmefcHb1ytVeZqeskefDGbTCRrDYctiQtSUg9wP3ebvDA3MJCoQO3nI9iK0KHOmwAy-6wHqjv2XumA6I94q4tLljpT-5B9PsdbSLX5bEzKcYHD70tQrGX8j4aT2mlCA2z0VW2sMuauw_FSQSdO3qytx_iNVleiQAGZoRvcNBb5S48nH_YI9tDORBuvYyd-40A74Gmfwt6Vv99vnL-8V_dpdeKlQAiZ2E951oRQkF3fcsX__1aKZlz1vQNuAiWqBMpesHM8IQdvxUqmragF6EzJ1QNZVA6KzsNgli9ts3SaJspPw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEKE1208>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEKE1208>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

