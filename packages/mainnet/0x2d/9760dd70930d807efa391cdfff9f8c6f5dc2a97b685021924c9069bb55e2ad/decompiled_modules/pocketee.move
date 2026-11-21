module 0x2d9760dd70930d807efa391cdfff9f8c6f5dc2a97b685021924c9069bb55e2ad::pocketee {
    struct POCKETEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCKETEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6a370c4a772fc14d3033054014948e2de23feaf48e3b48b2d3b593afb1308d43")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6a370c4a772fc14d3033054014948e2de23feaf48e3b48b2d3b593afb1308d43"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<POCKETEE>(arg0, 9, 0x1::string::utf8(b"POCKETEE"), 0x1::string::utf8(b"Pocketee"), 0x1::string::utf8(b"A computer that fits in your shirt pocket. pocketee.xyz"), 0x1::string::utf8(b"https://pocketee.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<POCKETEE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<POCKETEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

