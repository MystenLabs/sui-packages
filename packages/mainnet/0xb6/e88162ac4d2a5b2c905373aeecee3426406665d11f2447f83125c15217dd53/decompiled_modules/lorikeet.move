module 0xb6e88162ac4d2a5b2c905373aeecee3426406665d11f2447f83125c15217dd53::lorikeet {
    struct LORIKEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORIKEET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"cd72dc84b0f196383c9fb7e52bd339fd9eaf2f55a0818516c4fbb4d7e85d354b")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"cd72dc84b0f196383c9fb7e52bd339fd9eaf2f55a0818516c4fbb4d7e85d354b"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LORIKEET>(arg0, 9, 0x1::string::utf8(b"LORIKEET"), 0x1::string::utf8(b"Lorikeet"), 0x1::string::utf8(b"Every dev post keeps its mcap. lorikeet.lol"), 0x1::string::utf8(b"https://lorikeet.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LORIKEET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LORIKEET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

