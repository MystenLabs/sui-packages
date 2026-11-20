module 0xb0f765174240a686d0fac3ed9522042a301ed25d7611638e435e65db38499038::clip {
    struct CLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"da04ec0cbdf054855cc2c027831e8617abca254c038d95efb410d354d09456c4")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"da04ec0cbdf054855cc2c027831e8617abca254c038d95efb410d354d09456c4"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<CLIP>(arg0, 9, 0x1::string::utf8(b"CLIP"), 0x1::string::utf8(b"Clipstock"), 0x1::string::utf8(b"Coins that pay dividends. clipstock.fun"), 0x1::string::utf8(b"https://clipstock.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<CLIP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<CLIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

