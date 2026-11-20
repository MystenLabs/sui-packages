module 0x8cf9b19e41a11f1cf8a1d38a3a41ca0d049c9246f0869df806cc3edb2533e694::senba {
    struct SENBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"aaba486e818d280fddf13e872a44fcb1a82471547d3be267041781cf03ca3abd")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"aaba486e818d280fddf13e872a44fcb1a82471547d3be267041781cf03ca3abd"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SENBA>(arg0, 9, 0x1::string::utf8(b"SENBA"), 0x1::string::utf8(b"Senba"), 0x1::string::utf8(b"Fold ten sheets into a crane, mine SENBA. senba.vercel.app"), 0x1::string::utf8(b"https://senba.vercel.app/brand/token.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SENBA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SENBA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

