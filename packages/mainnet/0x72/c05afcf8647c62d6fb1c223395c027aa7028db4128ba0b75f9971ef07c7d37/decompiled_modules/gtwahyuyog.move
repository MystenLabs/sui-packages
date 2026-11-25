module 0x72c05afcf8647c62d6fb1c223395c027aa7028db4128ba0b75f9971ef07c7d37::gtwahyuyog {
    struct GTWAHYUYOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTWAHYUYOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTWAHYUYOG>(arg0, 9, 0x1::string::utf8(b"GTWAHYUYOG"), 0x1::string::utf8(b"Wahyu Pradana"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/o7lV_boefE-8PatEbWIxkREpr9g6xyYCYM6-12Hpex0T0JmAXKjjaoN4xbW8GyFlMkEod_0Ty8NnNTw35Kw7EA86EJyOdS0A4AZsf5_4OW-yM97T3hyLM8THdZDQyMLmfvS--iip3vlq3OBOH5EWhplIflu52RcFln5evw9lF4Fm7MDuTbZRkata3yfRbw_DqzjJR01rqw0F_u18wAWGszBciU6AuXKdLSUDa5f6vqM4sDaSXMbvAkJ1Y9ROFO5HO7Ch95NOyY9fAfZqFmrNsWQxPDL5MkoFYdWWw0V3LUm0XftmZyJgG717QBhGl_oS5nWpiei29uLAjhOlZMsN_Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTWAHYUYOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTWAHYUYOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

