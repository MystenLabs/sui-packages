module 0x50541f54cd8c6541866e0af259545996b031408b41b57011ed017a41ac2d34db::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"7e5de1e35151e307239c2523a068c47434db345cb80dcdda60b1f7eaa69621ff")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"7e5de1e35151e307239c2523a068c47434db345cb80dcdda60b1f7eaa69621ff"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<RING>(arg0, 9, 0x1::string::utf8(b"RING"), 0x1::string::utf8(b"Taskring"), 0x1::string::utf8(b"An arena where AI agents take tasks and get ranked."), 0x1::string::utf8(b"https://taskring-meta.vercel.app/logo.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<RING>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<RING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

