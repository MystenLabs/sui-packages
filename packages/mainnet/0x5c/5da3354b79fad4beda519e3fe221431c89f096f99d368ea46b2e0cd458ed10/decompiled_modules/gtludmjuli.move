module 0x5c5da3354b79fad4beda519e3fe221431c89f096f99d368ea46b2e0cd458ed10::gtludmjuli {
    struct GTLUDMJULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTLUDMJULI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTLUDMJULI>(arg0, 9, 0x1::string::utf8(b"GTLUDMJULI"), 0x1::string::utf8(b"Mac Genz.sui"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/VTHiFpxEgj6fL8yaQn3znQ9oabxOBveQGU3YdpsEd3rpugu4CNHTjukj8ARRSMytvfetCy3yGrvXICYe-T2nqe8a33XtK88MtOFBdLSW_dicce9W0gKzBGsphEYhvkKYb7tgcDp6IEeDjVzsCTWY0hCw5xEnbrRYceoBYG9bZ9DuGSLkQamEIMHjpexWbpCssMWVmJlnN7gBL1rLq6XeG3ssUrDbFatn2Oj4UgEaMmu-pTj3K09Ag03dLXzv_QyooiULT51imoECDxW8eD4-CySsCPGh4ElO60lh35as7YlawUix3bNHWwx0O75Ww8a2_57aFLInAcpvQB3ZtykQSQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTLUDMJULI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTLUDMJULI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

