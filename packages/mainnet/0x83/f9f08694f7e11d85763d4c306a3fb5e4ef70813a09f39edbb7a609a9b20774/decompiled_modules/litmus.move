module 0x83f9f08694f7e11d85763d4c306a3fb5e4ef70813a09f39edbb7a609a9b20774::litmus {
    struct LITMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"8caa58636684959c4f9a3043a3481f2fa321e9f2642e1d09196f76c0e0daccd8")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"8caa58636684959c4f9a3043a3481f2fa321e9f2642e1d09196f76c0e0daccd8"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<LITMUS>(arg0, 9, 0x1::string::utf8(b"LITMUS"), 0x1::string::utf8(b"litmus"), 0x1::string::utf8(b"Dip it in. See what color it turns."), 0x1::string::utf8(b"https://litmus-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<LITMUS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<LITMUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

