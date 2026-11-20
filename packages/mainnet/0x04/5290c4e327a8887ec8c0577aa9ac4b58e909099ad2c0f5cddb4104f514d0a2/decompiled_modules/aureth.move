module 0x45290c4e327a8887ec8c0577aa9ac4b58e909099ad2c0f5cddb4104f514d0a2::aureth {
    struct AURETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURETH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"e872a9abeda79f54867e9b29c91866207f5320048af6f04f0d9e6af923826056")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"e872a9abeda79f54867e9b29c91866207f5320048af6f04f0d9e6af923826056"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<AURETH>(arg0, 9, 0x1::string::utf8(b"AURETH"), 0x1::string::utf8(b"Aureth"), 0x1::string::utf8(b"Ideas meet liquidity."), 0x1::string::utf8(b"https://aureth-meta.vercel.app/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<AURETH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<AURETH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

