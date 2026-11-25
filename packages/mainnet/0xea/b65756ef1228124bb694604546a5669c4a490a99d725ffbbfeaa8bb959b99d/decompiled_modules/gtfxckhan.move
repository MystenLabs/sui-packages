module 0xeab65756ef1228124bb694604546a5669c4a490a99d725ffbbfeaa8bb959b99d::gtfxckhan {
    struct GTFXCKHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFXCKHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFXCKHAN>(arg0, 9, 0x1::string::utf8(b"GTFXCKHAN"), 0x1::string::utf8(b"ferranisima"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/b1WUmtIaudEQ_vyTNfEWOHv4hYWUlzaiagtLGKEkKNlKC1Gt2WBwj5k4yq4KhgyY-RZtbG2CsJ-sOuWWkMzhtl1SSZJV0u1HEf3TfvdUNVHO3dWnidZ9epsUOPTY4zrq3PvwGQKba7t0ebkEwADSQghVmDa7_alNKXpLHSwt3qU8-c_lRorAlSTMHnO7LJaxkjv7CMYpDd_VukMmLT26LCOxO02T8oik4vYD2o0chHs_1Sp2fEDo6K4JH0mvdZX94gs9xkOzXz7jUNP5qUB3hfrqhTzQtu2VPLrkZRkbPnaJi5SFcoSpnLd2FMlOUs5qYw8SW4Hx9v3lvm8uO9Xh3w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFXCKHAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFXCKHAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

