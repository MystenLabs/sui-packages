module 0xd09623dfb7222ae839aaa1f9396da4f5bcbc2c61b1dddb6099d77d56b5703a23::sealwax {
    struct SEALWAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALWAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"a4623927c6506c67b205977577354ef4940971c3a4b99347db3b9c779935396f")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"a4623927c6506c67b205977577354ef4940971c3a4b99347db3b9c779935396f"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<SEALWAX>(arg0, 9, 0x1::string::utf8(b"SEALWAX"), 0x1::string::utf8(b"Sealwax"), 0x1::string::utf8(b"Coins with their name sealed in. sealwax.world"), 0x1::string::utf8(b"https://sealwax.world/brand/pp.png"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<SEALWAX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<SEALWAX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

