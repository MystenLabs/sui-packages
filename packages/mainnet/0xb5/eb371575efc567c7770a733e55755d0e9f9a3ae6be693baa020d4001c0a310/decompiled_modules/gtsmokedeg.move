module 0xb5eb371575efc567c7770a733e55755d0e9f9a3ae6be693baa020d4001c0a310::gtsmokedeg {
    struct GTSMOKEDEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSMOKEDEG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSMOKEDEG>(arg0, 9, 0x1::string::utf8(b"GTSMOKEDEG"), 0x1::string::utf8(b"Smoke"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/M52VyEwBfstk8owRQKeLCdaOBPUTbRtJZO27UF3H-0dtxyhOEtsnPsrk28CYFL_RS1HJaOKTbKxQ0D3CV987q8roDsFE7nNS3NC2xvkQcLuzHs4gY3QozXkiNM_sfl2BaSKNKnMlAP_0fhOgYTN55AskPEHrCZH4J3fbg7vWGg2XwlJcPB9KdVwDufX4CfdlBgjnvQVQZ_Xa2CkLmbzbzdERWTiA_d6fF5N1J-MO-BleygwP-ocpY0e8OxUSuV4vQRM0Ci-9gyQ3nLNqezxYEPcvyH_N54TuP6lZqcajSqNRDKPE2_dm3ktM18KBBlhn2NmlVWGwhAQePSUnCi0tIg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSMOKEDEG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSMOKEDEG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

