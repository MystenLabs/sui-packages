module 0x4e990797f8210a9c6a90466ff965f12dd80111f09b51ca8a560813ded68b1f47::perfin {
    struct PERFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"68f69a79e63c2b17b69003ecae32063ff49036ef250dfe2778840c886bac1a9e")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"68f69a79e63c2b17b69003ecae32063ff49036ef250dfe2778840c886bac1a9e"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<PERFIN>(arg0, 9, 0x1::string::utf8(b"PERFIN"), 0x1::string::utf8(b"Perfin"), 0x1::string::utf8(b"Every coin gets its own stamp. perfinpress.xyz"), 0x1::string::utf8(b"https://perfinpress.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<PERFIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<PERFIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

