module 0x8dbe9d78df09c183ca1dbc9767653d94d371571dd879653ae9705ed5faea153a::gtoxgrabb {
    struct GTOXGRABB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXGRABB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXGRABB>(arg0, 9, 0x1::string::utf8(b"GTOXGRABB"), 0x1::string::utf8(b"0xGRABB"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/WeHtDDOUyqYxCrSyfcfsNEjkYNsZ-Ct06C5brIGwAG51D7yjbd8hK2T-KPv0kziXud8kWIiR31RanFJPfcqNAZiolgFalbeHuaK1VnNpDtSfEwY1tETHoZEob91o4-TA9vhWYryS6yclN8X-En9gYGk6M7cfst_B7X7MCyvzAleIB5IbPsYP5CoN72R4XLqYVp0HcNmg_U98_n1f31mcWk6Xxf9EdkLPgE5RTJuEQB9N4FammmcmeqF0bIPoZWZ6WD4zGrIbzPb8ssF1yVsm7UZVIW0GyXbb95hud3ucldbqu5iInLEhzjo77QvF2k4J3GIQlSxNn8H_wE06iW-Ohw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXGRABB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXGRABB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

