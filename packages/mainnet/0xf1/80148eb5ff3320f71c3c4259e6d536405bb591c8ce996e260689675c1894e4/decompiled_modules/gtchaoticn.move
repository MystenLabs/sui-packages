module 0xf180148eb5ff3320f71c3c4259e6d536405bb591c8ce996e260689675c1894e4::gtchaoticn {
    struct GTCHAOTICN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHAOTICN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHAOTICN>(arg0, 9, 0x1::string::utf8(b"GTCHAOTICN"), 0x1::string::utf8(b"Eric"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/kf8OcOt0lXPYWi_cdcYd-RWx-Lm3yCZYMYDg-rx5VJEi82Qr6XYb8Cg2zXmmfii0EIVQ5rTop_pHloAX_1yZIhqHAXH6gxQOrR1dELRzAV6jqaA1M8TwD54mjeXHkKLVeGdtxOpuHwRHi5mauiRDyJ8jm4RalnY02H4jMnPpfa5CyyC_vBUb4OZ1WypxIdoe0W7S94AInZA_YVyc8aeBs3ptRhFTmvw1S-iMa19L0fXPkfgeDo8ZOWJtlvvcwS0E-VDxdacM0cS6qPQ3bzS24uoBkKABJ7_ZlcvStIDSo7dB5Tg5UDIZk2-_VckOfeN48ccrcImQt-O4Qqd5YMWauw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHAOTICN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHAOTICN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

