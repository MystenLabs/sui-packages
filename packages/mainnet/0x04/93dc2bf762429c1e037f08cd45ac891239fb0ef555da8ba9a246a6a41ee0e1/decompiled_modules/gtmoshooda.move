module 0x493dc2bf762429c1e037f08cd45ac891239fb0ef555da8ba9a246a6a41ee0e1::gtmoshooda {
    struct GTMOSHOODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTMOSHOODA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTMOSHOODA>(arg0, 9, 0x1::string::utf8(b"GTMOSHOODA"), 0x1::string::utf8(b"Moshood"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/uasyC88zAiynQQixzoS-fpUTka4VvTZdFcvd21bG32QadmmqSrLisv1l5hgmZFWSXkvrrvFWnQQb73_c-VpHajM59I-XddUnqFOyJmSVOxT3Gi85qrCX9jDbGbEOJYcIEBS-xceAIIHyXWcFDQtYpF2M98poErxmD1wr3QmhaRYnma-m6Inp2vNY8Jf1oiSTCeDatR54E8382YSg2URc6KLnmcgMCIN6VUZTzHRQ062yQ5y5FjhpO1LPx8g_cPzK_GEYhYR4VfNvM2XVrRiVt2r1kOCKd3LwU_9Tli03cNbUGm0xcMRkcfyK2-dStJt1W-opghx6GoyNVjEnYmR5hw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTMOSHOODA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTMOSHOODA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

