module 0xaf0d681c70cf217805f2573c8edf5aa08f3020fcf028e8ed98e3082b2a342209::gtkabutoo9 {
    struct GTKABUTOO9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKABUTOO9, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKABUTOO9>(arg0, 9, 0x1::string::utf8(b"GTKABUTOO9"), 0x1::string::utf8(b"Kabuto"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/D-rrUFO65dEkfJcAEgFoYifmM9sXmDNsEpvTARaHEOPfoIsjoo-vmZJ0zRF9PKEs3oSG8sfyh38fCeWx00Azu7oQdWR4Ugdep4acCMuSPviXwgVKdysRV8IjPSHXFDFq4e7Uj6Q9-yOntmuoqHo8H-BGTqOuc6N0hyN3sVl-24Yl411nsy2uPhR-2gCrNTgSFkHoB9U-BGuR0Oenzs10ryNk0HTx12TjfxgOfxD7g_hXfQeNSyEQOhoqnizGNT6KEvwsGsUE5IPrfQ1yjiYBolmoZ4I9ebsWadhLMepu_apbHHOOosW2G8wNOfP9KFz2IPH3iHf-JdYTt5dH5xuP7A.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKABUTOO9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKABUTOO9>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

