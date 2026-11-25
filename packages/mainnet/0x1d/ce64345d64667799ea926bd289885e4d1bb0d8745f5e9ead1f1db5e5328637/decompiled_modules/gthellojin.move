module 0x1dce64345d64667799ea926bd289885e4d1bb0d8745f5e9ead1f1db5e5328637::gthellojin {
    struct GTHELLOJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHELLOJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHELLOJIN>(arg0, 9, 0x1::string::utf8(b"GTHELLOJIN"), 0x1::string::utf8(b"jintao (big diesel)"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/OqgtwFMupPgN4ctsvraPWTl6ldnqsOa45cLYy6a0f9jaBILmNJ4koMtxPsRLSGbSEB0e1mBDX5iVtQb5ng4bW1jGnpCfz8F7SAUHJjaeFBkn4cVhnjKWaAMFFFtv7F2soIpq-EndutKysa7Kffcp-0EvvrbaWzQsHMKsV5FzSzZmXD1VtpdwqBKvCbKozVw4rU5DMiX2J5XBIfYiGazBu_yBI1uil-kKQX35H9YBE0g2SI8-5hjOdxUE7m96jYiuyaIn5XJwptcQYafer6ERiR7f6I3lH8uad4NBFFIefQJSP2q829iCHpzREWp_y2Ck794P49ARoEH6KjdvOQiYIg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHELLOJIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHELLOJIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

