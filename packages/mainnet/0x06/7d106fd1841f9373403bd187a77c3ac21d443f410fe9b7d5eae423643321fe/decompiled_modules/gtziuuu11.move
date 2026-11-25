module 0x67d106fd1841f9373403bd187a77c3ac21d443f410fe9b7d5eae423643321fe::gtziuuu11 {
    struct GTZIUUU11 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTZIUUU11, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTZIUUU11>(arg0, 9, 0x1::string::utf8(b"GTZIUUU11"), 0x1::string::utf8(b"ziuuu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/ZrvLyzoSwu8i9gPUb7jW5oKJ2NXPlwhS3wdfY_gg6k3dEykOqT4cNdp9ZHM7CZXtEprtw6TJVdb16t4pX5qy_eJZrymSjxRWVOTfsroWiMZ2vlxpjR4vrXovIesGbylp8bz6ldkarO7yU-bvdUsSDMvoLZV373pECJuOtvdP0C57N5UTZ_tLCtL2hYGFBV4WvwKAtIgcYp1EzvWdGP6cT0NhGgBSn30i5io_x-aMurod8p3EqKgfFDJvwy_SaKbDZBvbWG_YbExm_Sp8nhsepE4m4OewidTYrrLk5ddiWzeieJwtfAwRnWe4txzco1_328p6uxNHoLpdtt3O8QiQpA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTZIUUU11>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTZIUUU11>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

