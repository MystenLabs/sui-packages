module 0xa918d0f6f638bda6618e1695ee65954cf2e2346249582115f105e6e9ec591862::hlyd {
    struct HLYD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLYD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"4f03b505aa89517920de5cccd11241321e75f8a5bdba936c4d28e5c0dc049527")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"4f03b505aa89517920de5cccd11241321e75f8a5bdba936c4d28e5c0dc049527"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<HLYD>(arg0, 9, 0x1::string::utf8(b"HLYD"), 0x1::string::utf8(b"Halyard"), 0x1::string::utf8(b"Hoist a coin. halyard.world"), 0x1::string::utf8(b"https://halyard.world/social/avatar.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<HLYD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<HLYD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

