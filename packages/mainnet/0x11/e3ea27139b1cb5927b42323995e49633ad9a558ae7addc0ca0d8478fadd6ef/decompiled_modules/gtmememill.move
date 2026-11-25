module 0x11e3ea27139b1cb5927b42323995e49633ad9a558ae7addc0ca0d8478fadd6ef::gtmememill {
    struct GTMEMEMILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMEMEMILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMEMEMILL>(arg0, 9, 0x1::string::utf8(b"GTMEMEMILL"), 0x1::string::utf8(b"greenghost"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/JkMzww6SAgGn1QLYeQsMqZc2g4JTRXTvfsYvpfS0EemAlvE3jCjMHwLjBwkNTHDfnU2RHWGSczjvP9S-TsyKB3fUG1Pgo_8fTmoPYpaxasSxsEplq00_Z5Ha_6f2fEgtPZkuqaLp6K-U_B5F0QJYRJ8xrjETw8bTmY2XABwUVVY7RMHf8a_GYAmaq-rF-rV7abNcSbu_tCEvL6NobM1FMZL4oGgwkRMT43n7-OxlP4F0PwTF6coMlksT8IAZlUqv_HwG5Mot41Vl53YVIgW_zyxJ2CK5xp81vgiDd-hbsO53LZun_mq0I8TQlxrsr0On6h_2laaJQvVixIYpesi5PQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMEMEMILL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMEMEMILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

