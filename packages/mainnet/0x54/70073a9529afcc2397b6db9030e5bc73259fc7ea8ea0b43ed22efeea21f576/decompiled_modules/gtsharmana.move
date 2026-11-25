module 0x5470073a9529afcc2397b6db9030e5bc73259fc7ea8ea0b43ed22efeea21f576::gtsharmana {
    struct GTSHARMANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSHARMANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSHARMANA>(arg0, 9, 0x1::string::utf8(b"GTSHARMANA"), 0x1::string::utf8(b"lakshay.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/YZLqYc6ovjg8BAayrF2oota_Sz38C4KjuKPBU9JzZrTj9fCLc2YYBX_RSQX2r2mCRtQIOlIqCRwuIb_M8Y4cxvGnCzFewL--VJTCVFv-ZT_IXLk32faklEcUx7I0KkDiDmPJZ3uh9U3NOto8BfCROeLyTVzxs_fCf9-q5WxdDg3zwK5U7skcl7H3x2_SnXUBXzu79_CmbRcguMyeXUnReNwNAwK_6jo0RQDZ38IsBEQgvJhck4BJ1XRPCMQ-lOnftYXKjWnlcxXEPxcS4UHn4m14I_kkQ910uZX-XlswzUCmAd4PhhXO3jvAXDgSTdy5Hb8lp7BQP5hvQHLhaYhAbg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSHARMANA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSHARMANA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

