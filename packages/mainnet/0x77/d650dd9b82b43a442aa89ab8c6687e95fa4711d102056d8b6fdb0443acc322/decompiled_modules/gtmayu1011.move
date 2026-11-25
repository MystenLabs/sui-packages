module 0x77d650dd9b82b43a442aa89ab8c6687e95fa4711d102056d8b6fdb0443acc322::gtmayu1011 {
    struct GTMAYU1011 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAYU1011, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAYU1011>(arg0, 9, 0x1::string::utf8(b"GTMAYU1011"), 0x1::string::utf8(b"Mayu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Ia0Z2Uxr82y5krKzYBLa5e-p8fnTBd8YWuRDL3xEhARysvdIY6tEglkYDbEo9E3-dNHer4n-4C5yQ10QjmSYYg3So-_3rkLDXTsHQSOLMTMCtmFeQgRGssci5anGoprCcURnis6Hsld4QXk_xatzrLsl8IFUoiJpp-Pxj7hUZF_X6BpzxWUObMJulvDEdgHrc6-g2d2H0y58BbtnFNVqqelgc-r88Gkve2j6sf_X4_uaSr-1KUKlzTkoeb9I7gTNrLPeeknrQ5rAFGzlSugp_jIb1pfPCshwz_sy2IhbcrGB1BFMsM0quN8EpuCEfmX1nWGuRfecIXZEe6rE6jcHDA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAYU1011>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAYU1011>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

