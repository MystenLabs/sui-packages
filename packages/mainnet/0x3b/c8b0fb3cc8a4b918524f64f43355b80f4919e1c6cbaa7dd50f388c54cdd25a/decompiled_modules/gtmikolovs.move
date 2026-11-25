module 0x3bc8b0fb3cc8a4b918524f64f43355b80f4919e1c6cbaa7dd50f388c54cdd25a::gtmikolovs {
    struct GTMIKOLOVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMIKOLOVS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMIKOLOVS>(arg0, 9, 0x1::string::utf8(b"GTMIKOLOVS"), 0x1::string::utf8(b"MIKO"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/YZcVhEankQvNDPiGBNDpP3zClFiHYXG5gajDlMqF0xwOLIrUeHvEdJY4JeCoGXRSYfbc1-zLgh7ABBbxXNiN5568XHExocgAPYEjpbCUDzYx_ieKm_H1qx0buwFSzZUsLQgYJ3dCYtYKlsuBvLZ_HzBoxBd-iri0MaZzBH6jjf-W0uzAa4D7sXPmFC56mNBuVXU6c55G1uQr7Kyb0jRYugGqzHshqG7_HWalvFW_flGAtrb4ZDrTzAe7y-DJdUaQzJ_DweiC3awqGxi780uotFhlAWzQn8ipTSOAo1PdiMpeevo0VU792gR1bYPvV72KxwwFRuAZ5yYeV4p-QNh_2Q.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMIKOLOVS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMIKOLOVS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

