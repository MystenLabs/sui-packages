module 0xe7ce0b35bf227e116ae9eb001f1f7cc5584defa96cd410d4c0e970d6c5e2469d::litmus {
    struct LITMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"6b089ec0d8b1dd0aba8d469ab94d5507e80aaea6ca83b58660d39a1eaba26ca6")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"6b089ec0d8b1dd0aba8d469ab94d5507e80aaea6ca83b58660d39a1eaba26ca6"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LITMUS>(arg0, 9, 0x1::string::utf8(b"LITMUS"), 0x1::string::utf8(b"litmus"), 0x1::string::utf8(b"Dip it in. See what color it turns."), 0x1::string::utf8(b"https://litmus-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LITMUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LITMUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

