module 0xbbb31f90510648ff335457ea743169c1f8693ade089cbe56c9759fdc161f2c47::gtflugei {
    struct GTFLUGEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFLUGEI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFLUGEI>(arg0, 9, 0x1::string::utf8(b"GTFLUGEI"), 0x1::string::utf8(b"Flugel"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/tDsqKimc24vmHzcT-Os5GWzXmOS6ROblj_TDrUZ2dX9KdR_Hf7way7fCN6Arh-mjDiSkWKJcMQi1jk8zq4_5oOKOK77JJLLDc3AFdzP9OXbMDDzMpIfHuJxI5NX70oIGvmr7F5lpkwENGs7Fv0ywamJnikEyt_odVvnrigqcdFotQ1xId2h1d1pMYTBVkxL_56qZ2t-MOU-h7_x-ZA6G6evN-YskLKFmGst7Pjswu9txn69UOog3nAFNp2tRcIi2POTK7hCZEaMwF8kQTW0HWa1nazlq3sAk4zTFawgGDr7fpy45o-_Karo63G-ZwbEwJXdiXTBZFwtX5dGJg2_heA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFLUGEI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFLUGEI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

