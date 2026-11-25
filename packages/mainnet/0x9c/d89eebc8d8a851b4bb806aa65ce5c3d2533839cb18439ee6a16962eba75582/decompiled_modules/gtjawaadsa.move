module 0x9cd89eebc8d8a851b4bb806aa65ce5c3d2533839cb18439ee6a16962eba75582::gtjawaadsa {
    struct GTJAWAADSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJAWAADSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJAWAADSA>(arg0, 9, 0x1::string::utf8(b"GTJAWAADSA"), 0x1::string::utf8(b"Jawaad"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/PttYcEo0JtvzRa8fOvr94aqFtvhMSg75NNnjhR3PrG5QTSAlZxu8dlMxCDOCc-_2ObdAMC0L12WFii7qdWwUgVJ6ltW0tcwTBP12QoO5Dd27gLXe6RM7X2a0KBECbdl11CEiRdv3bwhXWB5I1bIHbho2NVVbsxF8IpLDXWrld6-8L6Gh7HSmjBFxSUebLLNUFn71VZCediMl5iNOlbc4uz7vao59oYjf-zUImwwANitP2eIDiKdo-ILHN_p__MjgBWe1sJYlh-Rbj2XZNISkVicGSWaRH6QDURlczLdXttLYcDxhJ6-YIQR4DPdSU14Mf8re3hxQaIszX1O1tUCPzA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJAWAADSA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJAWAADSA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

