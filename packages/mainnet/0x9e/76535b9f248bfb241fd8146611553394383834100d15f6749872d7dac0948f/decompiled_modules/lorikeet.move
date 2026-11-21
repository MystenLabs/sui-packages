module 0x9e76535b9f248bfb241fd8146611553394383834100d15f6749872d7dac0948f::lorikeet {
    struct LORIKEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORIKEET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"57c25a403b6b69300c6d4786658c5f5df4994d7430887a5d59788cdde87551f2")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"57c25a403b6b69300c6d4786658c5f5df4994d7430887a5d59788cdde87551f2"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LORIKEET>(arg0, 9, 0x1::string::utf8(b"LORIKEET"), 0x1::string::utf8(b"Lorikeet"), 0x1::string::utf8(b"Every dev post keeps its mcap. lorikeet.lol"), 0x1::string::utf8(b"https://lorikeet.lol/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LORIKEET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LORIKEET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

