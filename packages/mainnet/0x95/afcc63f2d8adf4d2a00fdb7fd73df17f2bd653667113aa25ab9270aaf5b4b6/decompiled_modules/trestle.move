module 0x95afcc63f2d8adf4d2a00fdb7fd73df17f2bd653667113aa25ab9270aaf5b4b6::trestle {
    struct TRESTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRESTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"d89127f7e1f89c0243772bc779c0be58b96fdbde064b88cc2bb8e33ac7b93d41")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"d89127f7e1f89c0243772bc779c0be58b96fdbde064b88cc2bb8e33ac7b93d41"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TRESTLE>(arg0, 9, 0x1::string::utf8(b"TRESTLE"), 0x1::string::utf8(b"Trestle"), 0x1::string::utf8(b"The house coin of trestle.lol, the launchpad for pons on Robinhood Chain."), 0x1::string::utf8(b"https://trestle.lol/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TRESTLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TRESTLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

