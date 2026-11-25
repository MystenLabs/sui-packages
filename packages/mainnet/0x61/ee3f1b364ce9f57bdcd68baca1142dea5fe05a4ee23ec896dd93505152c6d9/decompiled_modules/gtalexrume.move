module 0x61ee3f1b364ce9f57bdcd68baca1142dea5fe05a4ee23ec896dd93505152c6d9::gtalexrume {
    struct GTALEXRUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTALEXRUME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTALEXRUME>(arg0, 9, 0x1::string::utf8(b"GTALEXRUME"), 0x1::string::utf8(b"Alex Rume"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/pFu1mESNKt7TkI9T_mqXOTGrn-LhfIX-CO2aDAPmHcbWsO7UYj48FOjevnG4zWdWPzRKf-yossUXIYtHwEzg6sT_lyr8OUSIKwWB6FcUmPeng_LNtOjtXdntZwK_zZHo-zN4qm6BDuO8ezGaZ6hQZPsLdqCvDudW9Qd5XjIoNY6cQDeUv58y9eA2Md8R3zH0tdyPtytZttTdhHBhTs87FqxXJJA50q82zmXmUwvQuXwje3YWlaHdpFyWQmRSwpvnmZXET4jRSGYRseLo5XVTjW7Y3399I2CKjtztptHsdq3MP92a9-jH9zp0OpmT9cHb6jxcyyakyfmlaqgPjTTRNQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTALEXRUME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTALEXRUME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

