module 0xaed25805636a7f1f1ff000502007487c6643266d06dfac2aa94e3d46d96be6f5::slip {
    struct SLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"56fac4bfe9699946ec71aa550dd0ea06d4a30de12f686c2c4c9cfd3a3c461afd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"56fac4bfe9699946ec71aa550dd0ea06d4a30de12f686c2c4c9cfd3a3c461afd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SLIP>(arg0, 9, 0x1::string::utf8(b"SLIP"), 0x1::string::utf8(b"Slipbook"), 0x1::string::utf8(b"Get in before the pool fills up. slipbook.xyz"), 0x1::string::utf8(b"https://slipbook.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SLIP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SLIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

