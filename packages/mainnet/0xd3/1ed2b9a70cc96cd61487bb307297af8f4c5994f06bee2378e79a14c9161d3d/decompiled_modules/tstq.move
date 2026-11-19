module 0xd31ed2b9a70cc96cd61487bb307297af8f4c5994f06bee2378e79a14c9161d3d::tstq {
    struct TSTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<TSTQ>(arg0, 9, 0x1::string::utf8(b"TSTQ"), 0x1::string::utf8(b"Inflex Test Q"), 0x1::string::utf8(b"bot test, do not buy"), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<TSTQ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<TSTQ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

