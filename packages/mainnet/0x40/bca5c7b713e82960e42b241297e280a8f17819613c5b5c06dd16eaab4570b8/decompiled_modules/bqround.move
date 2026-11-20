module 0x40bca5c7b713e82960e42b241297e280a8f17819613c5b5c06dd16eaab4570b8::bqround {
    struct BQROUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BQROUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"60c21ac82da43705607acd2f529beec57ed640928c3d846c609c8809ecbecb57")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"60c21ac82da43705607acd2f529beec57ed640928c3d846c609c8809ecbecb57"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BQROUND>(arg0, 9, 0x1::string::utf8(b"BQROUND"), 0x1::string::utf8(b"Blast QA Opening"), 0x1::string::utf8(b"Blast pre-launch QA only. No value. Do not trade."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BQROUND>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BQROUND>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

