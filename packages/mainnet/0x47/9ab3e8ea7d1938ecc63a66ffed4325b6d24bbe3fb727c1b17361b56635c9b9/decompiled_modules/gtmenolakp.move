module 0x479ab3e8ea7d1938ecc63a66ffed4325b6d24bbe3fb727c1b17361b56635c9b9::gtmenolakp {
    struct GTMENOLAKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMENOLAKP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMENOLAKP>(arg0, 9, 0x1::string::utf8(b"GTMENOLAKP"), 0x1::string::utf8(b"Gojo Is Here"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/MsIL8C_VVyy27QbOCr_gL6Ap2gLoe6xLJJPS_9mtRdImoJ9kQL-p5TEXZw5jXZUM0cLN345kFNJRpdZOAIv-o_f8Gw4C5z_IKRQdGzMwG9w3o9xJY6T6LVQ7YjeEXtZLBW50XKrBhwPggAGlvfqF7I97xKKD-XVRf7wp6QcCF9gwXlhjzY1BNkWg92MrgieprZC3ocwM-FCghCY8IgVv4Gy61P9Rtx2hQ_zEUEvAvh4lWub_6V5HFtlfxPn1IOsL6tlmB8rAMlJizC6gtf4Zp--rOBUp_OWgr-jc-DOvVOE4bzLRtyWpyCrkjoUHr1JCWwYgxs8QOuL1YV6a5J_hFQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMENOLAKP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMENOLAKP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

