module 0xaf878dd77027f6df7f74629bf07b4bd3984b08901152a3d0b5bfa2bd7bf5a4f2::gtphish0 {
    struct GTPHISH0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPHISH0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPHISH0>(arg0, 9, 0x1::string::utf8(b"GTPHISH0"), 0x1::string::utf8(b"Phish"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/Iz7UJlqDZd0Y13Ye78dfhsiqNY1-EyPjJofEStQutvGbGoZpd6yNW8Z4V6c_FSIk0kWdtiw2B-S4ULj1ZsIne3hRRdg0MnPGiyYQtedL7AMnLboLpiBQj4o8lqfnJIm_OdVJy4k7y7jGsiN425VTGhH3Z2ifRzaKt3s-xLzIBy84nI3gg0wnGvr6kkAK8TVg1Yd8CxmB3iYdLv4jC0hyRP8SWOs-HMg9CPtBCXK_8kSEKYph93uXDupV4_C6id9iqiWyqMnbskcELnleu14PpjK8QYu3xaGKN2lW26qTD43BP9CZJuirhJDbqdlv9vJijnZ8ny_Y_Gykcd-d_T62Lg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPHISH0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPHISH0>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

