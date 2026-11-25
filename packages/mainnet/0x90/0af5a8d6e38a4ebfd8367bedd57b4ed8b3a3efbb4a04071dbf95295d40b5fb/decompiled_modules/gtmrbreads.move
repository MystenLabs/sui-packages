module 0x900af5a8d6e38a4ebfd8367bedd57b4ed8b3a3efbb4a04071dbf95295d40b5fb::gtmrbreads {
    struct GTMRBREADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMRBREADS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMRBREADS>(arg0, 9, 0x1::string::utf8(b"GTMRBREADS"), 0x1::string::utf8(b"Mr Breadsmith"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/BFPwxOz_QBX07SJ-mi9T_HZA4WXPiaXB5WXX26sw9fM1mO2REDa6uw4GDMZdkTULO5nZ-mBAuG2XtLMvONgUxF5VGQ7qzB1ZZgYxCHurEhUaRhSbRwtUVFn-KSYpju4W8Z7njikbqinEHiDJn6V3IHYxqtmyZ2Z1bN0RyqylfgnYKsEbx-hy0le58fZvR34vC1Ow3vZnTToNA7F18cN2rExJPLn0QBiZHkwUJjMP-HclHitRLQcWgJ6LUNOxrzPSoGcJouJ8h_3SFmbuHgO_Ogr_JrJQDj8oAPBRi8V2y6N4DwVRWMO0lKOy5Tfl9Z-bItHObCjp3QGuA3mWr17GVw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMRBREADS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMRBREADS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

