module 0x79856893b3a0ca56793c58f198889e8ee5c687cd1c00c0f5e93117305a06691a::gtidislike {
    struct GTIDISLIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTIDISLIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTIDISLIKE>(arg0, 9, 0x1::string::utf8(b"GTIDISLIKE"), 0x1::string::utf8(b"caked"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/ZppG5GCo6cvWd3lLY4AFaHQMf0fEK4G9gqoTMNive1Rp_zsAicceb-00sAn7OSkJKy1h_NmX5iSNMXYW0Oxv7-Yj0yLZ12CCEvbhRjAoGz3-9x50pIMZuPWN5ZymRaNeB57kDs8DmDzlfskYqWwJaNqMKQW5uXfaWocRJKjcz_qfWqBJAv2_okQHiQjHppIZ3OyFckrbuYvOPqevNvNNkAPDSqbiXkMwPTwGCHvA7tAhjOQV60q7icQCSqpocy0D_csk6bMPRucY0onnH4q6Du5YMZhb8C4T_OngT0JgyxlUYaoxDk3HZ0QZeEoYhMA4PKKNKaGbSljPeKzWh29YEg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTIDISLIKE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTIDISLIKE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

