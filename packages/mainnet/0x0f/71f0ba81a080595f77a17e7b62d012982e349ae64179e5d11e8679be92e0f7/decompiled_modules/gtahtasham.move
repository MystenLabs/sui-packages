module 0xf71f0ba81a080595f77a17e7b62d012982e349ae64179e5d11e8679be92e0f7::gtahtasham {
    struct GTAHTASHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAHTASHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAHTASHAM>(arg0, 9, 0x1::string::utf8(b"GTAHTASHAM"), 0x1::string::utf8(b"Shamiii"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/IChE1uHxkvMnyVKW50hLIpzg0bTVU5gdjI8dUKd2dNZYCIYmG3y9cp9ot7ChgRnNXkSKbUKzn2UT03tqRV7Odb1txmazTw314MyBMXwMbOuUSOvLXe41jv35A0f4tjQ2P_I5vf5Cj0EwSB67M821HbeUsLT4IETKNKoLOJbW58WYsm7kgiTHQ4RF-CpPmrM4Y1zQ2aHAP5apRxsPITsvxHIXk-aOaCzOehYdJ4idI8vlM55FU7PYdDJy6iTGj33oRlaW-WsgILLxH4F7UXfgRGWag2s1EoSvfzmXDQfmXsE-tgSY5t67UIKC6NQVamCxa76gck72Qfb4tImbqfz2NA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAHTASHAM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAHTASHAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

