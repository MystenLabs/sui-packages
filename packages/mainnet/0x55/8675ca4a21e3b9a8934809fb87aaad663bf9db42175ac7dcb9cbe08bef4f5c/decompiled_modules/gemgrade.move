module 0x558675ca4a21e3b9a8934809fb87aaad663bf9db42175ac7dcb9cbe08bef4f5c::gemgrade {
    struct GEMGRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMGRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ed222aea5aed99f42db21d6f1cb039e44fd42df7e982fca661c5deea086eac45")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ed222aea5aed99f42db21d6f1cb039e44fd42df7e982fca661c5deea086eac45"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GEMGRADE>(arg0, 9, 0x1::string::utf8(b"GEMGRADE"), 0x1::string::utf8(b"Gemgrade"), 0x1::string::utf8(b"Presales graded on the jeweller's bench. gemgrade.fun"), 0x1::string::utf8(b"https://gemgrade.fun/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GEMGRADE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GEMGRADE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

