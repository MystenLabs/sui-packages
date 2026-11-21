module 0xf49347e00329fcd7e04dd6a49f8a3769b3bd70a400fabe4f17dfc30946addc12::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"16fa95fb8b321f99564fd646d75bdec3b9cc629781fef37f78af8a75b15e7030")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"16fa95fb8b321f99564fd646d75bdec3b9cc629781fef37f78af8a75b15e7030"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TAXI>(arg0, 9, 0x1::string::utf8(b"TAXI"), 0x1::string::utf8(b"Taxiway"), 0x1::string::utf8(b"Every coin waits on the taxiway. taxiway.fun"), 0x1::string::utf8(b"https://taxiway.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TAXI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TAXI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

