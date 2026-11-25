module 0x481d4c5ff2322fc1c785378dd3823578faa3619e99d208115defb11f716920fd::gtserg650f {
    struct GTSERG650F has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSERG650F, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSERG650F>(arg0, 9, 0x1::string::utf8(b"GTSERG650F"), 0x1::string::utf8(b"Serg"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/iHdcFiSMZnKd1NAV-09WYH7ZHxo3j-Os2hrXwWMFzIuLl_EPIZ234pIP36C9FVj8tcYKTJSfxXOHJN5ZZakd_-QSTYeZXzCFR1cbPu1iCp4ps-1I7ytrvetJTLta1j7Tze6cbo7SzwZOdjHwcCbNXN29cr4THaDpYAxlQMZCneQnxVlcXoBCXEqNqaMfSY8kI75b8bSe53_MfuSa_qdyVnunfz5vMmBFeyWrONvPdj4yiVKWXzF3G8GWt_Qg1e0wGLwxCsnSECmuS1FNyuppoHmBUiKWUyVuaX8_r3COfarjhLk8zRdkJz6Kg29Url3b5DFeYYDHYb7gA_S9_IsLWw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSERG650F>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSERG650F>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

