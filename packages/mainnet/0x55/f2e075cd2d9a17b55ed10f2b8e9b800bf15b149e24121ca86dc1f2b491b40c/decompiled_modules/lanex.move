module 0x55f2e075cd2d9a17b55ed10f2b8e9b800bf15b149e24121ca86dc1f2b491b40c::lanex {
    struct LANEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a2aafa2a587564e20c189d4dfc3404b5aa17925f515935304786f92c0e319527")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a2aafa2a587564e20c189d4dfc3404b5aa17925f515935304786f92c0e319527"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LANEX>(arg0, 9, 0x1::string::utf8(b"LANEX"), 0x1::string::utf8(b"Lanex"), 0x1::string::utf8(b"Open market for AI inference. Sellers list GPU time, buyers pay per call, every receipt is signed."), 0x1::string::utf8(b"https://lanexai.xyz/x/x-pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LANEX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LANEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

