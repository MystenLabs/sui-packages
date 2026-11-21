module 0xc22574bccbec90b27150675124c8c08be2d0f2394479e684f1987af031d4e977::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"ea0678063c6a2153fc0f5099495f7e2380269af831a80c0843afd6867a3bd8ef")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"ea0678063c6a2153fc0f5099495f7e2380269af831a80c0843afd6867a3bd8ef"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<FOMO>(arg0, 9, 0x1::string::utf8(b"FOMO"), 0x1::string::utf8(b"fomo"), 0x1::string::utf8(b"FOMO: Turning crypto profits into hope and a brighter future for orphaned children"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/f95ac8d6840af2306bbd8599c4a6f22bdece80dc072543cca161219f4747d169.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<FOMO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<FOMO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

