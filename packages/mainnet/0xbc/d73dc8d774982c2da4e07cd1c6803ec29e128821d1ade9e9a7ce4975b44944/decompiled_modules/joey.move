module 0xbcd73dc8d774982c2da4e07cd1c6803ec29e128821d1ade9e9a7ce4975b44944::joey {
    struct JOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (true) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"c16ea473427fb9c674cb5a3db92cf803b90a6355a68a3658eff7724ecc455623")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"c16ea473427fb9c674cb5a3db92cf803b90a6355a68a3658eff7724ecc455623"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<JOEY>(arg0, 9, 0x1::string::utf8(b"JOEY"), 0x1::string::utf8(b"JOEY"), 0x1::string::utf8(x"4a4f455920e2809420424c5542277320474420776f6f6620776f6f6620f09f90b6"), 0x1::string::utf8(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/416127b55ce440a19852a222da758f58dc0a12749a7148856abbcebe6ddde562.webp"), v0, true, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<JOEY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<JOEY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

