module 0xa3a48d4f3e8f64dc02cfe06852ff8f64318d7771478a8c8b28e2ea3566b2cae4::gtoxjade {
    struct GTOXJADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXJADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXJADE>(arg0, 9, 0x1::string::utf8(b"GTOXJADE"), 0x1::string::utf8(b"Jade"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/vQTbdszzjwPgbheJT9XvP9Z0P_bSkxWjneXYyxWdyQ1fk_ODZEg5CZk89r5DVDKjJulB2eanS-M8Na1q43FYAFFbXyAP8yYLAVD9lM14n-hWlBzphmU-Ig4vG9_ljc8P9AvVG3b9BPrlu5yDH9tsm3LCa2qd0AHnf9O-Rgunpc6dM3046SsjDha-E1E-1Cd-MjQR6RfPzMAh9BXQzTQ8_WW6fkdP9Z4tBo782bQvbaK6ZR7x2WmdNmG4OG90AgVeNpAH0-u1h5T38_Gzghr6yozWtibc_CbpDFwpWf8mYjGd8a-nALNQagoTLvLcPyR_rA1MfmQ9dg1wH3k-7Uxpkw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXJADE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXJADE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

