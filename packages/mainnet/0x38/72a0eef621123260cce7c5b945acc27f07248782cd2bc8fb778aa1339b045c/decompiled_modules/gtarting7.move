module 0x3872a0eef621123260cce7c5b945acc27f07248782cd2bc8fb778aa1339b045c::gtarting7 {
    struct GTARTING7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTARTING7, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTARTING7>(arg0, 9, 0x1::string::utf8(b"GTARTING7"), 0x1::string::utf8(b"Arting7"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/KI9q_sS_-ZotL0Q-SejLyDfnfgJypiILva90wo_Vpk0ZMP9ZglibCgu9radoGA6oatZmEM05q-wBGHT0R-NnRw0f0AByv-Gtbgk-err_5vx_pX_2Ujn-9qecIGGqcf1fDlR4DzsmMm2XMQ3UWhe_8CkY281PPRwS9bDb2CpTmTG8hdZYaZTaxIWh67Yw8d_xLiSzCVoIJNiHMGP_vNocf9_izuFlzkPTINhG3cil2qt39CxOQmsQ_6t0S63x1kwSbbCrskxPNPaXaDDcsg-07N0j1vpmKCusyGj_ffcLq-2mrRBogvYEDewzJ8JvOpPjWr2woLtG6jpXpHqYrig7RQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTARTING7>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTARTING7>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

