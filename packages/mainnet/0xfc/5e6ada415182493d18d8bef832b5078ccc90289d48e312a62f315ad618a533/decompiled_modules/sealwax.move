module 0xfc5e6ada415182493d18d8bef832b5078ccc90289d48e312a62f315ad618a533::sealwax {
    struct SEALWAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALWAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"5ddd36f4e2f40976e1197d9fe6f504a9806caf7bcbbdb94f3d4de25097c683ad")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"5ddd36f4e2f40976e1197d9fe6f504a9806caf7bcbbdb94f3d4de25097c683ad"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SEALWAX>(arg0, 9, 0x1::string::utf8(b"SEALWAX"), 0x1::string::utf8(b"Sealwax"), 0x1::string::utf8(b"Coins with their name sealed in. sealwax.world"), 0x1::string::utf8(b"https://sealwax.world/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SEALWAX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SEALWAX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

