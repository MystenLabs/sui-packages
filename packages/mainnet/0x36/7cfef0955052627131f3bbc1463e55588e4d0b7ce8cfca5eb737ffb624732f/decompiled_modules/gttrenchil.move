module 0x367cfef0955052627131f3bbc1463e55588e4d0b7ce8cfca5eb737ffb624732f::gttrenchil {
    struct GTTRENCHIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTRENCHIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTRENCHIL>(arg0, 9, 0x1::string::utf8(b"GTTRENCHIL"), 0x1::string::utf8(b"trenchilada"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/F9JsX7yKqTZCrFSVGbGrauo9G3CfgwqPP4_BqC539ogKMiet_MtrtobnUchIh4cb3B8jjwW_s6nJy6u1kyVquw0j5zS8oxUHkU5pBdhzUamZOuakcp7TFtGcgW50hyYYLNPpStygtyKqMkWVMqcK-W39NfDz8UgFmMOPDJF4fmTQ6cWWjTYJapf9jABw83VnhoEnXQKNfgmX2yXS0DWYr8yZFgwYAZwYdgK5GPCFR6bq-uTZld23xNWm9TP--wU9b85d1sS7u5xkhX60vdka0Sdzlqo6B2778_OjipYuQSmEZ34vaeyaHv1P9WDZryPEsevbjM_0kRJCSyyy3XIJcw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTRENCHIL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTRENCHIL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

