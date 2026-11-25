module 0x6843a5b1555c33b413c3b27bceeacd9ea17f4d8bc00854a31ab7d07704eb968e::gtsherdilc {
    struct GTSHERDILC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSHERDILC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSHERDILC>(arg0, 9, 0x1::string::utf8(b"GTSHERDILC"), 0x1::string::utf8(b"Sher Dil Crypto"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Ko9EnK5WlbegqVf6f7N8aPPKMSC_DuiOQLXNsgXy4qNHO3s2kY6QYM1QMSbnlXYfxhPyRBSRXNVcb_1hLXIPM2NnJv3vxxSsZZnlEe4f--8iz3PsaL7ga_iGckOAwX-lSs_NSCbmDqAO1utY1GlyBI-4ohYkCDjF1BrO1dKc3jkUbt1n-DaNU4h6LqYgUbbYI1sT0i-xCawIqpMwaZAwPK5MHp7AoNd_tdkWNRoeS9SpdUSAzmYDDhKl8DAfH0bNMY3XCogZLB3VC-7JXnyZ-Zzh4FeQubh_x2up_Q7opzkWToOZuBJ95se2i3TotlsWjPDH5N40ai8df91xVk3raA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSHERDILC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSHERDILC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

