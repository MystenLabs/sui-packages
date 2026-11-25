module 0xf059835ca22444e3851a661cfc1653d00439b5cc451c60635339ca72888b2c85::gtayodamol {
    struct GTAYODAMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTAYODAMOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTAYODAMOL>(arg0, 9, 0x1::string::utf8(b"GTAYODAMOL"), 0x1::string::utf8(b"Damz Pawtato"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/EGPnMbg--bRZE6f7wPl0bB6tg7trk3RRDK_jDHhXcUJvfg_EWErfL-wfP_fKyt5tEEZV3v2acEJkimPhL2HM7JYYPsos9W7TB3bwiMa3Opfdy9XGefRyjifPcDBHWbEEEPZwYY2hyYjSZzmYsD4FEHaVyg8rMpPajSBqsBoLsKmS4PsXh5bASIA-IOKeQIhUPkdUl8AE1HVu1KQFlD_5bFtvVKixKRiVdIF2RJ03yI8L00KijX8ze9_ceet15R_LDuXRPPzXSH5dBDeMCfLj9TiriCWNpEQvnlEybWuKAVQDDGvYnVPzipQdHMIC4v-ctQTAIlsvFlIY_nsrGrPLOA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTAYODAMOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTAYODAMOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

