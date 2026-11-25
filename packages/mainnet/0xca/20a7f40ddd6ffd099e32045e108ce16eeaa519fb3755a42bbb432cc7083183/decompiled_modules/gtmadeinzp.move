module 0xca20a7f40ddd6ffd099e32045e108ce16eeaa519fb3755a42bbb432cc7083183::gtmadeinzp {
    struct GTMADEINZP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMADEINZP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMADEINZP>(arg0, 9, 0x1::string::utf8(b"GTMADEINZP"), 0x1::string::utf8(b"madeinzp"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iO5REQHyUlXM1HUw_TpigsXY-4uskPKUrOBwShujhaGJaJVlWAZqJOlDygzYLBQ2E1s4-kQLi1mxZPS_Uwu5FSvnRoB019iAMaCWAvCO6ogFvIq8jAfMXgH7RItfg1dyhdaBRf9xbVu6XQ97Q8mq_Q-RK82E5EzmMXPMM75PjAQBoIegk_MeYaFrThIjpo2kcbNyiwEkV1WNdGqaswzeu-kxqpZ9UKAYZly6ZR1byXlZdF7pNbwFhbFemy6ug29qZmj6jhuAR4XwLLvyKFTvDxzUGSJhul5tCjhYjb6IIKaTzEbIsPRDxukFo1GQ7dNBDOdsE2GqCMNcjaB62u2kNw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMADEINZP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMADEINZP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

