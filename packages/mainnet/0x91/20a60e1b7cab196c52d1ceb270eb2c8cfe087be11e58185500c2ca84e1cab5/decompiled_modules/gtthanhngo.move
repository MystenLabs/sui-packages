module 0x9120a60e1b7cab196c52d1ceb270eb2c8cfe087be11e58185500c2ca84e1cab5::gtthanhngo {
    struct GTTHANHNGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTTHANHNGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTTHANHNGO>(arg0, 9, 0x1::string::utf8(b"GTTHANHNGO"), 0x1::string::utf8(b"Thanh Ngo"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/OOVpa8Rk84S-tizSnn4nVDRmdJbShHtGwpXni68-I386-BbkHWrusCH4sf6MWN4JdPxAZgLG8T1enLUVU6md4sbgQ9xl1p_hFVdHl30LJ_Bl9X2SMsmVaZxG-oNOESLPnqal8j6Kdi2bdOc_v6chE7mTKAoLtzglT7Yet_PA5cHzfWYNj4y1ldtFuTb3ebiP4DOCo21W8QhKnbb0c_9dbIo3ncT4yXvki4uqnTPJSd2Fbv_Z9xM7O116YDN1pW5uC3q5tbyXDR1EGHUAfbalBb4tpHAHWVhynfIMZWRDDL861be5eOeS5oCPQJbMv43WqibZqh9SfzKHYNrVGar6Kw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTTHANHNGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTTHANHNGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

