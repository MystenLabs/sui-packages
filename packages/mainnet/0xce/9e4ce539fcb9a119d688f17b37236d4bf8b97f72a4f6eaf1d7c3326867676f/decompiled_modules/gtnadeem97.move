module 0xce9e4ce539fcb9a119d688f17b37236d4bf8b97f72a4f6eaf1d7c3326867676f::gtnadeem97 {
    struct GTNADEEM97 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTNADEEM97, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTNADEEM97>(arg0, 9, 0x1::string::utf8(b"GTNADEEM97"), 0x1::string::utf8(b"Nadeem"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/aTB2eCI_tAXdyTwZIa5RNBaJPWJmL75zEbQvGE_6841FMJ-NNor_yn82RMTrr2q3SM8b2-fAnYvFhe3Xg6oX25l0VVe78iZe8_8GnOXcWTWhhVOXm53p6PZNuHcl6fyUDeVHQr1vfzxo5NBMrcd7LXO2oN3FbECTGpqW0B1O4jbIO_NtBKQE9TY3HBVEcSAIi9vZSYSylh57uhB8uZzdoqrHODWjEdARgDn36agGhyDWzovvaYcFNhq-H3ZzaOVgjNETQvA8mNT-PzxVUyJJQ8Lz1IkyUF568S7r507AN8-NpuvqrR35Oy8N-2JxdROj50s2wg0x8txUWLBGn2rWlw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTNADEEM97>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTNADEEM97>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

