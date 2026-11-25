module 0xe6ac4e5bd712008c64893fa304ce9050c2ba3e3d029219495b45ac7df3535efc::gtocubann {
    struct GTOCUBANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOCUBANN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOCUBANN>(arg0, 9, 0x1::string::utf8(b"GTOCUBANN"), 0x1::string::utf8(b"cuban"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/JulHblCT-wpR53hfoG1izrVeurNFH3LT-rwhaKJ5zP5CVn8_xUXZLdykCAuoBBczX1YJO7P6nXLB3zl66mqFdjqb9XApV7vtSv9_iioi_fdRzHgPja78ftKLrrlZgtC3RWuqacum3LEX_iw4G5Go-HGwtNBqFeHNy9ahY04blFBdzl5NWEzkBr-upSIduTTc4SccH0etyHW6pPLw6Qr3ieRH345YxlhMslogqDFY25zkEoPzfMZefV887op2lr8aKIElGYRaNBulc3K3iFBaJtmgxfb3KZVmFLiOLWml4-18X6XS107TsMr-O71ZXP3OIapz-kP69oP6BZWL6BcPeg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOCUBANN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOCUBANN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

