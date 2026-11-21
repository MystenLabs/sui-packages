module 0x82215a5d6a09092650060befdb083c610d51b2f7ee9a7f1094701cf1d38527b7::muster {
    struct MUSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a800889c3481131d8cd73cfcffa8f733e1c74e7921a5f6579d22ce84a1810e1f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a800889c3481131d8cd73cfcffa8f733e1c74e7921a5f6579d22ce84a1810e1f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<MUSTER>(arg0, 9, 0x1::string::utf8(b"MUSTER"), 0x1::string::utf8(b"Muster"), 0x1::string::utf8(b"The Muster platform coin. Pledge-to-launch on Solana."), 0x1::string::utf8(b"https://musterup.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<MUSTER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<MUSTER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

