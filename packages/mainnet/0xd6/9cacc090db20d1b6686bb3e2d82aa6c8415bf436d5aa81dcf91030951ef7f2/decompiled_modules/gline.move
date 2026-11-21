module 0xd69cacc090db20d1b6686bb3e2d82aa6c8415bf436d5aa81dcf91030951ef7f2::gline {
    struct GLINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"afcc294af649e0b5e5d31a38d04904231edab36aada3f9a6720a7a1f413056af")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"afcc294af649e0b5e5d31a38d04904231edab36aada3f9a6720a7a1f413056af"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GLINE>(arg0, 9, 0x1::string::utf8(b"GLINE"), 0x1::string::utf8(b"Greenline"), 0x1::string::utf8(b"Trade the line. greenline.lol"), 0x1::string::utf8(b"https://greenline.lol/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GLINE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GLINE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

