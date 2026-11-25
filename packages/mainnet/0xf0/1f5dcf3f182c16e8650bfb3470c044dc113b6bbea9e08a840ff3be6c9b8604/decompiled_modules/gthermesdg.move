module 0xf01f5dcf3f182c16e8650bfb3470c044dc113b6bbea9e08a840ff3be6c9b8604::gthermesdg {
    struct GTHERMESDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTHERMESDG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTHERMESDG>(arg0, 9, 0x1::string::utf8(b"GTHERMESDG"), 0x1::string::utf8(b"HERMES dGOD"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Zru22xC73t6tR_mXbrEKz00N8noCmwohfs52kWkVah-Gas9UhArkeMtapGpdky5PmF6WO3r_IMUC5watbcH_6oqUxD4B3vzsEMb8bEdECoOOYcBCZ-Nn8nscCfFok09iD0u4tb9lobzIF8vD2Evn6zBA60sCqAB3FAZdcdMkmle2Qea9EhLY484PyQqWdHa6gjUXaK6Gc2RHDzb-Fs2co_AYWryR9hghKk5Rk4y63lEQuW_GH1y6lBiGLPjDEgW_LM8nMfiisKy-FGw7xeietO1rM9pQ_3V3bJX2FMZLwfkzE9YNKCHzCpyqZs8kpLeWFHibarsBcCY0wCNmlpoHkQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTHERMESDG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTHERMESDG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

