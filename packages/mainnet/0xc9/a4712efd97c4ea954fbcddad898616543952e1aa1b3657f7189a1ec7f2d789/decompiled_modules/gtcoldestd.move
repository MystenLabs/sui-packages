module 0xc9a4712efd97c4ea954fbcddad898616543952e1aa1b3657f7189a1ec7f2d789::gtcoldestd {
    struct GTCOLDESTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCOLDESTD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCOLDESTD>(arg0, 9, 0x1::string::utf8(b"GTCOLDESTD"), 0x1::string::utf8(b"Suigma"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/m6HPWfb-jQ76kDQUfQwhgAm6j7fY64J-nPw-JBUqYW0s87Mnjdk_62Q495MH7t6NfjxHHiYbbNTmobMqGoyQFIS9BO1QYaTTmORMXHkWxmj93pxD7zsJgXYRCvZWsY2cpNQM7rzrPJ_jEmx1kYwm1c51imHd8Wa4JInU-WUziCcNPQNw5V74-Dq6tYDCRPZ7l26z3DXqFyHU8SwQ4kX3VC2dukKjhv8TsyjdRYCHCk_QrB1UznDpCYzkg89ufmT3A7uNidp8rCTEm2Rk3OFDnU_ZpeJZv51qBqvE6Ga6PmP96IlQFrXTYB73nv4KVNJJqcYuSU0OOJmLKAcSVTJaYQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCOLDESTD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCOLDESTD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

