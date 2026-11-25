module 0xa1595dd45234d72b1ec472adfc03b1caa7945bb3cfdb05d43c39a1719943afc3::gtaqlam9 {
    struct GTAQLAM9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAQLAM9, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAQLAM9>(arg0, 9, 0x1::string::utf8(b"GTAQLAM9"), 0x1::string::utf8(b"Aqlam"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/FWMy5-5MQolLSSD87FSFq-ebFR7ppc5SbgMalZrdktjEslMPG6a1rXM48ksuzJ02gqWFsSBv0_VjxJLNux9qSGUu8Me-Lz9O_xTbV3cSQ2Whl3FW0iInbMjMNYqqXW2xQxxdpQbA6P9Fo76Xi9Mcj0TDmXFqARiE08YzjUbrQP4Yn5itIjdhHD09_5WZj6_7XwhNw4LtIukvatKFAGl2CxfIGQf4Z3ZUD0ysPqewdiFbzqvtLBm29-JnZa9xLKTNvkrt5tL-XXqIFGRt5sSMwrFEbah6zwLJpuBX7on6NZbVumLZgTZVsbSARY5acSy-qSWsAK7fn0i4TvHEkiOkSA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAQLAM9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAQLAM9>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

