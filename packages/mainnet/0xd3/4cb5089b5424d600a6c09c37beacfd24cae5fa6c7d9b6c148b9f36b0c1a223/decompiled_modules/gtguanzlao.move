module 0xd34cb5089b5424d600a6c09c37beacfd24cae5fa6c7d9b6c148b9f36b0c1a223::gtguanzlao {
    struct GTGUANZLAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGUANZLAO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGUANZLAO>(arg0, 9, 0x1::string::utf8(b"GTGUANZLAO"), 0x1::string::utf8(b"Guanz Lao"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/rEavbtumq75xwQTfm4MiU59Wo1VwKKEcqKqypS05oHUq6UZwtqOSFoA2yhv90qMKjUyrqebbQ_2JQWakHDl--Ez64d-Ebsd1CCosb8TK_rIa9nieYxZS6d67vUEQ3SCDBtTuaDj46AojL4RcZBlo5pZ7D2J9gongsQhO7Z9lRzJubPuOSSHRu5SSE7R38XLJh06_GDfe4wl6uNfstzz9or33dYmW5Yfbgvo0I-mF7-mx89rGtZO2zjLJO1o_vqlkWrrcE0J1VF9YSEQueuO8AVSGx2d3t_y1pQGVe5Mcxgw5DNWzE-bdlgnd_i4S7Jc_W8tejUSBBmQ-M1eGGXZ5lw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGUANZLAO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGUANZLAO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

