module 0x66cea10fc2c22c91ab4ea6c65a7ebc36116e17f1e7814f824d2cf6546cc13574::gtnathanba {
    struct GTNATHANBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNATHANBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNATHANBA>(arg0, 9, 0x1::string::utf8(b"GTNATHANBA"), 0x1::string::utf8(b"JBars"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/tXRU7zAAcWRA_Kr8jFJHTwcPyIeUyf6TxPmWwlPfeZ65X7unfDB2GZthxuE9xrSs780ILvriepCMQSvFAvM3HAQFGeM_Z251Ixam4J_uq1tOz8EAwqDjqyBKHGaDLsC0YGSN__tUkPKi7Wt6mGwsuwtQmt9z9E1b7X42LXZqRXkV0uq0NvH933CVSAIuS9G0MBPyEDmYUnNYP89H-zJ9JFmtmfMyc20V7qiD-LdOGbUUmAErTdVZ-KGT-m6lYC5j3mAeAH4gayf2J2IUhza_OKn-0Ao6z0LpeIfhqY5_jNr_SADcvzHC6QJEQ-RfvAbHKgecJGjVQa_EoSQgJLYrWA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNATHANBA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNATHANBA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

