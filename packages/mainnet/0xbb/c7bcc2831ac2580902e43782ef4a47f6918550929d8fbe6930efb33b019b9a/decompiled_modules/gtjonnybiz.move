module 0xbbc7bcc2831ac2580902e43782ef4a47f6918550929d8fbe6930efb33b019b9a::gtjonnybiz {
    struct GTJONNYBIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJONNYBIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJONNYBIZ>(arg0, 9, 0x1::string::utf8(b"GTJONNYBIZ"), 0x1::string::utf8(b"Jon Bizzle"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/N2_1sMFLw-js6ZQK_TXQGHtSO8Wz9-CZlpzu5O3qtewNszDGm8_ZcbiBcpw5OdEkLtqvkqYSaiavhUf75zJ_swknwvQRpeFpoYFd1IdSwBp1ma7nTIElUY2UbHz-de076ZAosHSuG6ETFFSDPszmABT-gt8LXpLp5v2RgMzLIgQoNOx8dMmuy1cIpcKgdt-WU9YYLlA752BEO162E4GtPJ0VixVZcWLJXhkO5YBl0U6C_tASCc8cT6HfzjXX45FoG8hB4amLT26TEXTI-FEUDRAI4eZ2RjXvSSkHwu5Irl1FgdKmt71wAi1Tmo39_wlcKs6DfXGFMR1YSGgVU6bvzw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJONNYBIZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJONNYBIZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

