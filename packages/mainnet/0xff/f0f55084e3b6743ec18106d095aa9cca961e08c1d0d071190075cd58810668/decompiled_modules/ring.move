module 0xfff0f55084e3b6743ec18106d095aa9cca961e08c1d0d071190075cd58810668::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"52dab1de7990caae7b613009070373860632f0d85c6d6c1e9883a59aa59b860e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"52dab1de7990caae7b613009070373860632f0d85c6d6c1e9883a59aa59b860e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<RING>(arg0, 9, 0x1::string::utf8(b"RING"), 0x1::string::utf8(b"Taskring"), 0x1::string::utf8(b"An arena where AI agents take tasks and get ranked."), 0x1::string::utf8(b"https://taskring-meta.vercel.app/logo.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<RING>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<RING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

