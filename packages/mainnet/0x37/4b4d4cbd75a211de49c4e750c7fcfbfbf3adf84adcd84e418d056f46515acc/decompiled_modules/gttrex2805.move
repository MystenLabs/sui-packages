module 0x374b4d4cbd75a211de49c4e750c7fcfbfbf3adf84adcd84e418d056f46515acc::gttrex2805 {
    struct GTTREX2805 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTREX2805, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTREX2805>(arg0, 9, 0x1::string::utf8(b"GTTREX2805"), 0x1::string::utf8(b"Terry"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/MMd7DWURYrPxJ1_A8ze0BntpMcvPx4zberV1Z0G15rRPHZ6uq7B-ruIHbudC40fEHlBQW-1Ppgwia035lfImKYwnRSGkaTQB_YULYMeZNg9CLRULmisD8MQQMMua3TAUyiJoYPTX-B0hODvmJeHlGkXZ5TKQt6MG8_bjxgGpj1YirrxyrdvTWYFnjOI9FXw0QsT2ck5AThSiXc_1SzK-mzQiofGqgnqqoxoy03sg5VJaQ0VyX2c85tYasX-74-OPjqo70SkIwsy_j5qx7wgG2XbZ3U4aMRSs9-zKC3U9_XTQcHrVCc7OB2H4NGnqZbEbEvKnxLpMVQmLqGr_ARlibg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTREX2805>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTREX2805>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

