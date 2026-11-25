module 0xc4cf7f84b9e4718409f628cf8102afded508fc7b4651ee728ec51d7f410a8cc1::gtgilbagu {
    struct GTGILBAGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGILBAGU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGILBAGU>(arg0, 9, 0x1::string::utf8(b"GTGILBAGU"), 0x1::string::utf8(b"Gil"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/NeF9FSEAs5qowLsCvUUr549aBVv326vlgukRbQNzhGVdtCtb0tcRahwVPPbZD-RaWP0nk27B9W4bosauw3evz4kiPP-gk8QYJ5Fu-3xa81Z_v2I0fXs8BCO_BRmkp_pVKIoP2wPewAL8u2c0FFT5NL7GDqd1j_Eng6SNZbM_wgu7Jq96NY55RtDnDIMI-utATyjRDZteCSEcnzLYuq9ytzyD0qdHZeRiMAyRe97dRd8VxyeW6TYQHwHgydLWNB9y1FcEemryg3ylEBVxI0sw3oyu4Fu3sJZJMeJSvNfpJ0cmBt3rztcdEn_1TaaGHnrFZblgQj3FfgSvrOHvbUduAg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGILBAGU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGILBAGU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

