module 0x9a9977fdaaf4d97f626baf74898085d90bc122484686154582a620b6d5228df0::gttruong77 {
    struct GTTRUONG77 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTRUONG77, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTRUONG77>(arg0, 9, 0x1::string::utf8(b"GTTRUONG77"), 0x1::string::utf8(x"4368c6b0e1bb9d6e67676767"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/rtm154GHK8uh_LS7RacSJO5D-H_c5hyBwVPlOFzTGAoGE_qaxhfwJ4jW8fVKhyn8dhqtxy8CDkhEjLbSf6mXn5AE8m5B2h5ytpRsSOFHBc35RuGbjd8W70AVa1d15ojIqWSRxYFb2Cl0GPyevA-zgAZSj3rmMGdbJLW4TcSSFBNkb2wGWbcQyxXX5BZCF8al_ejY1gAd9Iw-TEo_7UPBF1i7qAtQ2B3HhLEpdWfaLV7K4bhj0Xiw-VL_d010__rikkYvefhxvO4RinMjrV5yZZa76uVPgn5J2Lbh6-72-PaRxa1LEKc3q3anyDzPRp8EK_d4mbBg_jqohgD9yL6JJw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTRUONG77>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTRUONG77>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

