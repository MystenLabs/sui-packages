module 0x21bc91f80aa92a6b4dccf470478c3d59e649c0328406fbacbcef9689e29f8ea1::bcats2 {
    struct BCATS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCATS2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"884a14ec6760e453e2d21d5325ce20b755b503fe5dd20cb3462f6377b5809473")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"884a14ec6760e453e2d21d5325ce20b755b503fe5dd20cb3462f6377b5809473"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BCATS2>(arg0, 9, 0x1::string::utf8(b"BCATS2"), 0x1::string::utf8(b"BLAST CAT SELL 2"), 0x1::string::utf8(b"BLAST BOT test coin. Paired with TEST_SUI only, no value."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BCATS2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BCATS2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

