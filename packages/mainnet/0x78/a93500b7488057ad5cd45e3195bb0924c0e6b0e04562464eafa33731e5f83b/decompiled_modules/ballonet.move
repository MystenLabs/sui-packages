module 0x78a93500b7488057ad5cd45e3195bb0924c0e6b0e04562464eafa33731e5f83b::ballonet {
    struct BALLONET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLONET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"eb4e99d384c08d1bec4e8225184d87c75d49cece5dabc44ea32111844f0c7ed3")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"eb4e99d384c08d1bec4e8225184d87c75d49cece5dabc44ea32111844f0c7ed3"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<BALLONET>(arg0, 9, 0x1::string::utf8(b"BALLONET"), 0x1::string::utf8(b"Ballonet"), 0x1::string::utf8(b"No lift, no launch. ballonet.xyz"), 0x1::string::utf8(b"https://ballonet.xyz/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<BALLONET>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<BALLONET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

