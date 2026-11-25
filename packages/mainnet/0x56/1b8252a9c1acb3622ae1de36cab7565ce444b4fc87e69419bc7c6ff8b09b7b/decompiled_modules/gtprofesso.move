module 0x561b8252a9c1acb3622ae1de36cab7565ce444b4fc87e69419bc7c6ff8b09b7b::gtprofesso {
    struct GTPROFESSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPROFESSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPROFESSO>(arg0, 9, 0x1::string::utf8(b"GTPROFESSO"), 0x1::string::utf8(b"Hafizh"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/LM84mkihQJPwisHs65ZYwGTQ2bJVfXiF-Ay60vgiU-L3vQ7i-0_jlooqnje396SQX5GW4p2yryDoG2RIds7WPmHkXsqk4tFRpXOPxuJY_LU69IZehuGrO05e2Ai1jNLr5d7Mw22EbcPQlMUVvnY9Wb5WXZxWi2eyIl3o1JlQzv04mQ0b8b-kbZNW6vT3uMtgC2bfY-zUelaJHL7lO1pPPqLnm7pCet9l6ffeNY5WIjSrAz56zUT_AlStw_yOLIHzbCaOECRtKv2g4N5jx3XUmK1TWaFC1-n30oyBD1PgLMlJ27zBqt_gbz_rt4V1OFrJJ5r60mzEhfaIezNrhhAP4A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPROFESSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPROFESSO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

