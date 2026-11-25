module 0xd5e86e7835ba81d0334ee36954b43e748921182e301656b39f195c984a7e3c6c::gtfreshpan {
    struct GTFRESHPAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFRESHPAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFRESHPAN>(arg0, 9, 0x1::string::utf8(b"GTFRESHPAN"), 0x1::string::utf8(b"freshpants2x"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/f5nMHSzCWlXYr__OGHxsslGfp6iVrRASHPyvxymX1SAhR_1QmZMX2L2PIfHQz6-lrWwfdP4lE7bkW5JCs97uE4gefeqjDSVP6V93RJlMDggOw3UMH1aaYNkdIJleEiVXGCwwLWYkz5jUY59OxhoBwoWBeHq8ltSgrIRz323OeziOFDvMLqfNK0XRnmxp6dvHsv2TYxSzxQXDhmFj5JLFpWN6rmFZVhXPhBqGvfWoWYSvHOPtrvTsgXYCQbsm1tjruhJu2jzMDt_4NNhTzvBDsFGn5G0Tlpt3BhqXy5G2M5nIi17KAlsDRsmSlk9Gd7J05sOUMEz7KP8tYqCSg4WeNw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFRESHPAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFRESHPAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

