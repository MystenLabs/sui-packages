module 0x1c3b661832bfc42d162412a22de688bafa132cc5c7a799817332a2d6dab796e9::gtmaxlensh {
    struct GTMAXLENSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMAXLENSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMAXLENSH>(arg0, 9, 0x1::string::utf8(b"GTMAXLENSH"), 0x1::string::utf8(b"Magnus Lensherr"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/JtFIInX9UXVdb4AN9g1acD8G3Q3-Ta3iMC0f8Xf6svj-U27KeagySV-0XQCSKBfmmF5yNJUp-_-9MOVR892q6YPECTU-gWZtYWS7GHpwHBtSq5Fj4C59yCcOJDnz5d8wkykrYdLG_NC0pxyrKR2KQPQlHYrHOZmdtkozpQUfB_ykfohrH4uIRjVf6YRoMqtKAjKJ6-D0LZY9v8TmK0IHNixglicQLiuj_myc9MygGLLz_vQqxtoQHokjJc85uhwDczWcnKR9i_FwzSlBgteHMcnoID7TjN_vTFJcKOHjJUnuBEKJrJiIHq_BXwTMj-QxsTvFJ3MJ7GJFVCa3MCJm4Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMAXLENSH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMAXLENSH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

