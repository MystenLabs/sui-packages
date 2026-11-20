module 0x66be996d0bbf51b14e6f6d3d7bc9a2a7ca34e6cb3d8f241410c70d6cb87500bd::pingo {
    struct PINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"dcdde429d37e06309aef41ece614696f7c0235b06f64679e6a3a2a4ec59b23d4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"dcdde429d37e06309aef41ece614696f7c0235b06f64679e6a3a2a4ec59b23d4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PINGO>(arg0, 9, 0x1::string::utf8(b"PINGO"), 0x1::string::utf8(b"Pingo"), 0x1::string::utf8(b"Every coin is a blip on the scope. pingo.wtf"), 0x1::string::utf8(b"https://pingo.wtf/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PINGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PINGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

