module 0x3eb1ce38e5a04383ec0606d969214b13930ececcc7ef07c57c10f96070f9b67f::gtcryptolo {
    struct GTCRYPTOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTOLO>(arg0, 9, 0x1::string::utf8(b"GTCRYPTOLO"), 0x1::string::utf8(b"Logiicc"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/OmUBKGrnx6YEHOCOBtQXczAg6zoNiC_3BBBuyE7OlSBLe-Z2DwsjCcD7OELjFiimzMI-O81eO2yUleF3vVT2pZ233GiixV2LY1_hLPcWF2fgO-h7W1rEAcK0sFvOQ5mXtxvVLP0Pe3l638MVMmB-8PU18V1ehqGBrgJHJXxOG5SmlLrinKdLMlwsoHj9H0BAArYWrQ-FSX2-ZDkAZJ7_Gc_IUvjuhmEBzdfXSO_QDWoKoZly04oftpITU5vBHDO5TkhtOi64KWtHqUlq5IbrBOyGLi3Ll5fXR-NMDpyQ5OPCXvfVyaIPrKMQvf32-jJ_JPpD0BorLck4hxKTq5oQEA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTOLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

