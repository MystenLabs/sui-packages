module 0x66c23fc34e7e0bd1c189bb4c1d3b8b65c039c3a26607727f74396799a95374db::spinoff {
    struct SPINOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"2f0dd8678380289d8d1a73b151767cc2af58cfa1d5d5e3f121fd60963baa6a77")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"2f0dd8678380289d8d1a73b151767cc2af58cfa1d5d5e3f121fd60963baa6a77"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SPINOFF>(arg0, 9, 0x1::string::utf8(b"SPINOFF"), 0x1::string::utf8(b"Spinoff"), 0x1::string::utf8(b"Meme coins with a stock for a parent. spinoff.lol"), 0x1::string::utf8(b"https://spinoff.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SPINOFF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SPINOFF>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

