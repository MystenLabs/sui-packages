module 0x5981f0ec8311031a48de83edbff771c8e5b6dd734c5f25ceb30b2626a1a7b4a8::elang {
    struct ELANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"f1532a91987cbb2a9e30dbd52554c9267cc4f88d0a4508e176543eb7bf01c49a")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"f1532a91987cbb2a9e30dbd52554c9267cc4f88d0a4508e176543eb7bf01c49a"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<ELANG>(arg0, 9, 0x1::string::utf8(b"ELANG"), 0x1::string::utf8(b"ELANG AI"), 0x1::string::utf8(b"An eagle-eyed coin launchpad. elang.world"), 0x1::string::utf8(b"https://elang.world/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<ELANG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<ELANG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

