module 0x7e1bdc71ec98192daae6f2b3c80a961df721e2e171df2e396d9cf2d902751a1c::gtvirtuoso {
    struct GTVIRTUOSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTVIRTUOSO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTVIRTUOSO>(arg0, 9, 0x1::string::utf8(b"GTVIRTUOSO"), 0x1::string::utf8(b"Virtuoso"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/lp-Ut9v87CNkutypqppgqmGumMDUviwTw3nOn06wXh3eXkN1yXnk6BI_0lGBchVrpEOrcQKXFiSl8OY7DSMxTjIPc7xUyGm5zspDKv5klM1CdCb_YGmPPNx_WE0pejAW_0FY7Y5BGwTevzNtI7mi81kQx4K3733tdSNvj3JI0wIbsYq-YcRY6KOukq8QrIRCAzyfUgEn_khiHXOXs9B0m6577Uxsai56TfRAUhmQ2aQ9W1g1t9MuKV-f5DRWlLCM26XEucSgZUhOV1ohUXF3msmYOSX0Bjhqmw2gREEdv-Krg1Sp80VQC8H97V7lzVXWYsadEUrmoqdEgnSkzeBo4w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTVIRTUOSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTVIRTUOSO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

