module 0x63da5b400b5e279988f151aa50f45bdf424a86e6de91ad7b6b4eff69f4192e77::gtb0i4k {
    struct GTB0I4K has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTB0I4K, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTB0I4K>(arg0, 9, 0x1::string::utf8(b"GTB0I4K"), 0x1::string::utf8(b"Gzmoon"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/FGm3isdHO2tCn1pqnLMewPEHBXGP-OQ2Th2ORc5v9ulP32UnFvKC0O6v2mCJawSlSz53MuvxQhMF3tzdSXNSxHiym8mNd4B3F75CdFa8Vjied-VLFWui45nADM2nGuxA0HVT5j-uAvlrdzrPcsnSDR6MRv7fU0-3ZlbMGLtY2ZpC9xjOgeiuLbujP3xtdX5u7foJojlbDUE4pwxUxye7l6ruadHJMfnDe9Sv208_8R-JPdrMH_C-zxH0TaEeuUGbpz48T5cFqvg95MgYmN8NGji_f3CK3sNhZjBHBTvcK0IMjzZxoeBW_UI8w11A-FQcY-zLndYgm0KnthOlKEtkOw.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTB0I4K>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTB0I4K>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

