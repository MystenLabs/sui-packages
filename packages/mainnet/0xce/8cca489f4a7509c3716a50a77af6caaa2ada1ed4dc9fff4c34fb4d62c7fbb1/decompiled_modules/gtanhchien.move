module 0xce8cca489f4a7509c3716a50a77af6caaa2ada1ed4dc9fff4c34fb4d62c7fbb1::gtanhchien {
    struct GTANHCHIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTANHCHIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTANHCHIEN>(arg0, 9, 0x1::string::utf8(b"GTANHCHIEN"), 0x1::string::utf8(b"Viking"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/iVoduAm72TVgxB6ewTPUEeATWZiK8y8mOrXuCxGKjqFMx4f0FmY_mVbICNGRemBr2pRmfhnNM9OiX4t8Xtmkj6BF_fbOYKC5O4-kaAQwRA_REL9OYew2OPRMkIOAI-Q9qmB7LIXfQIrbMFCU2WKPTduJceIjthZko_23S85NaZ9YNbOejFpXBlxf6eWwA3iKtkyJUlzeHOWG0XJI-cd5a3rXDBUizxYnUrPdu7oMUK3k7X80---y6rcVyJZeOFBGDJb2gtadkNo_ECEcBdZKk74z5EkMn8LEbJNmPnxXHvqBfvELSuSiHSFZfm6NOOWznyQXdw7Uw8H6jCf8gZ9Jvw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTANHCHIEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTANHCHIEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

