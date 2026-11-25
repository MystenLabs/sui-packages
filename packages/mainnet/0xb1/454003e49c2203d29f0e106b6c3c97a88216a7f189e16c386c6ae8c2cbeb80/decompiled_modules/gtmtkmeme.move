module 0xb1454003e49c2203d29f0e106b6c3c97a88216a7f189e16c386c6ae8c2cbeb80::gtmtkmeme {
    struct GTMTKMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMTKMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMTKMEME>(arg0, 9, 0x1::string::utf8(b"GTMTKMEME"), 0x1::string::utf8(b"Louis MTK"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/aSP8xiLlqRyqMDt9y4HPwYHX_syBABSZngfVqD-FGWQt_u57E9iCti20uc4fZBL5Eec5p4mrLcPKsReXarPe8Ulj6v2mCFGBwbP0lloto3XngcpA7Wwro1HJrUAk5u3tkM-ZhfObU5UWZMlEaoGAjQSGCTxO3XzGkdrT52MX5-_7zpUIX0rZvsXQiTvSdymxZukTxrDoJYoTj3982WS9w9Ge_dFOvGjm6l5QGTNF0jERk4n7NjUYPImgC_9Sq-ymyAlbN-Eq9pv_l63fV-hwJnbwbeX1znYeB5KQFrb8rxX0yIY6yZwQ-eN762Y3GOeZsTIc6bUbU77hAAKdQn9mbA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMTKMEME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMTKMEME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

