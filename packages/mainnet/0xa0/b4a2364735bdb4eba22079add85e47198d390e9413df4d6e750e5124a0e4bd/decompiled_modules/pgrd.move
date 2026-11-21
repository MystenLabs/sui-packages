module 0xa0b4a2364735bdb4eba22079add85e47198d390e9413df4d6e750e5124a0e4bd::pgrd {
    struct PGRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"123d6db163a8aca0fa0c285d530b6e24c4eb643fad36f85d3eb7d496529422ce")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"123d6db163a8aca0fa0c285d530b6e24c4eb643fad36f85d3eb7d496529422ce"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PGRD>(arg0, 9, 0x1::string::utf8(b"PGRD"), 0x1::string::utf8(b"Pregrade"), 0x1::string::utf8(b"Token presales on Robinhood Chain, graded before you buy. pregrade.fun"), 0x1::string::utf8(b"https://pregrade.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PGRD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PGRD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

