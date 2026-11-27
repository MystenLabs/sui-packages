module 0x21b2c1e876bba1e76aa3ccf2fe7a4dc93c7a50bb806765dd9aff532ba3ff836e::niyi {
    struct NIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"9e06771f725faafa7c53e7e6edb2b794e44a67050716916822dae8e5ebdebf95"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<NIYI>(arg0, 9, 0x1::string::utf8(b"NIYI"), 0x1::string::utf8(b"NIYIs heavy petting zoo"), 0x1::string::utf8(b"Why touch grass when you can touch wool"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/486204332726f417c810c4e71e1efbd3fa64707348d9d5d174ac9e30065b3db6.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<NIYI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<NIYI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

