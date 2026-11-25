module 0xfc0503bb0560d40f1d4dcf0c631c2a9a015196412c815eab1cf72f202dc7babc::gtrhodzlhy {
    struct GTRHODZLHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRHODZLHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTRHODZLHY>(arg0, 9, 0x1::string::utf8(b"GTRHODZLHY"), 0x1::string::utf8(b"Rhoda Angelica Mikhaela"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/gdmKpYsPSOvD4U1Eu85L2V0PVU6-T_5I9iG0yBW6fUs6RmX4HvHTzwRLGAiw1SwFV050l1k-IrQcyxxZGsMSXKXOH38qm--cEdj6bVzZPvWAj7VSdpKnCRSCWQ6Mx_R9UanzTsim6iRdVBaYY3wkBIFtX5qR8RKfnNXcPSvR31snr7clDvZCphUBiM28rlPgDXBUqob9oPHRLhgCZRyp_iqX88CqXiCA75FWdyPO_brUuiUnOg3YzyD7fZNtK3o0b5g-HXdvVjLuAyEjoSwWGTXoobir8SnuMZmz4gxb6p05uP0uukUFk-lE807b3UpHpg0MvDTFjiSp8N0o5walhg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTRHODZLHY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTRHODZLHY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

