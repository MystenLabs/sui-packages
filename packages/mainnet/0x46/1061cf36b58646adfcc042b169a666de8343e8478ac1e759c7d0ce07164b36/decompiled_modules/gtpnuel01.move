module 0x461061cf36b58646adfcc042b169a666de8343e8478ac1e759c7d0ce07164b36::gtpnuel01 {
    struct GTPNUEL01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPNUEL01, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPNUEL01>(arg0, 9, 0x1::string::utf8(b"GTPNUEL01"), 0x1::string::utf8(b"Manuel"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/ke4hwkril2iXnBtm9KA67I-ZmBrDy1aXzn7qv4B-hwflJAZqDZ2pSGmCegJInz9OORDxIyKxQjHfDvR_U70qvNaZdW3gfD8UqYk81ONUTsO27NEzOVTXOlWYI8-_CFm8ysUrxB7OxTjEc__7A65jGQsScvXWi40bshNWqKqqKMcsok1P5w4CQyqi7hmXgIV5daqYZtWE0xUm03FMF6i2qfFiQjae-NyckuS_3MXHRV28XZMfNuLX76-3cPy6XWyUknu9xAA2ZgeN6FwLZdZmOEmJBdPRzUYTZy1Ew3zjfvrhvCzPA8F9r_7A4ajCAWba2Qxvitn4unBqGtCeUzRiAQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPNUEL01>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPNUEL01>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

