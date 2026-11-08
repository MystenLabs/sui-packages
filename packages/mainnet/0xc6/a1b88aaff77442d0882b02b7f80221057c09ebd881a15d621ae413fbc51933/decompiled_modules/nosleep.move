module 0xc6a1b88aaff77442d0882b02b7f80221057c09ebd881a15d621ae413fbc51933::nosleep {
    struct NOSLEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSLEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a210093f542e8c7f1fbec01604d652d3bb801cf154436ed46d26a5b2b658a0f5")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a210093f542e8c7f1fbec01604d652d3bb801cf154436ed46d26a5b2b658a0f5"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NOSLEEP>(arg0, 9, 0x1::string::utf8(b"NOSLEEP"), 0x1::string::utf8(b"No Sleep Club"), 0x1::string::utf8(b"The market never sleeps. Neither does this tab."), 0x1::string::utf8(b""), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NOSLEEP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NOSLEEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

