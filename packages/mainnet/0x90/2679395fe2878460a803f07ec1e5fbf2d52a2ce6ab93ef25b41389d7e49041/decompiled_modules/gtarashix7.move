module 0x902679395fe2878460a803f07ec1e5fbf2d52a2ce6ab93ef25b41389d7e49041::gtarashix7 {
    struct GTARASHIX7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTARASHIX7, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTARASHIX7>(arg0, 9, 0x1::string::utf8(b"GTARASHIX7"), 0x1::string::utf8(b"Arashii"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/OdvLX_SlcXhlzYikIWkC0qwivWu38hVw_cavCPPI3Ym3PoKUnb1sa1n2JXJO77drjb9SHLXk7R10jr1X0raIY0q5_ugNaDmjLIWqYZFTXDZctuSt31lPKw_xdOYhBdEmP7KjHEpdsDMZAIXVDm5LkEw0tdH73MdbNPToSU3y3-YaP9m4juq3bVN9jhkhSFyiwXjmZmiZkfgsSmacC1tSs4LLq-cJeC23KTnLNCZXeNM-GxnlU8u1nQL4hXImgi5F9e1J4nGaKbkqWC3GXKC-S5ptjg6Wcme-wlZhLuIn9AO3NWF2j9K5OjGF-U695Bt_ngLmqk2sIuOPvfLpFmQUUQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTARASHIX7>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTARASHIX7>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

