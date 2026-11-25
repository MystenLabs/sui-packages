module 0x1bc676711fff5dbd043ded74226ced7d8766bf8a0e2947d9a2ec85f51c130e3a::gtkryptnoo {
    struct GTKRYPTNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKRYPTNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTKRYPTNOO>(arg0, 9, 0x1::string::utf8(b"GTKRYPTNOO"), 0x1::string::utf8(b"Kryptonuub"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Ylv6xFC_fJBTXbrsWlzanJblk5lw3S-LisWPIwEi64waJbzw-60hk6Mn-2zy6eKilXkb5zaTrMQAtQ5E1bJ3Hm2dfBR9lV2PL4HJFK6jLCawwLjs5gTKujHCdhgg3-YT3R3UwDCMnqlDzeeO4wVhtW-AaGSPt5dL0UQC7S1KG3XFfJMzn9AjWiHISWktESA5Rqh9lAD6jiwBYLoq14RQD_RFQ6uPKVmDDmJKgYvexi-0fy_PI2KHjr45FQSUGourvGnDTYKMXYmpwik7zEBMf4C4uG673de4HwRAQH1vbSzmSrBhQtZRzr4o3FVGzd_q9-dRSYTbG9f0WHIim7sm0w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTKRYPTNOO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTKRYPTNOO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

