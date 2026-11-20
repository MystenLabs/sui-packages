module 0xa808617535b2ff0b95fb5278054d79cb5cb6711df220151a69fa2683c85bab4a::crumb {
    struct CRUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"dcdde429d37e06309aef41ece614696f7c0235b06f64679e6a3a2a4ec59b23d4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"dcdde429d37e06309aef41ece614696f7c0235b06f64679e6a3a2a4ec59b23d4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CRUMB>(arg0, 9, 0x1::string::utf8(b"CRUMB"), 0x1::string::utf8(b"Crumb"), 0x1::string::utf8(b"One city pigeon, one whole sandwich. crumbe.xyz"), 0x1::string::utf8(b"https://crumbe.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CRUMB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CRUMB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

