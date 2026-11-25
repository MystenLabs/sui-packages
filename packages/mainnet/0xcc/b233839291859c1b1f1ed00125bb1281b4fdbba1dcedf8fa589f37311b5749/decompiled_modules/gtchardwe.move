module 0xccb233839291859c1b1f1ed00125bb1281b4fdbba1dcedf8fa589f37311b5749::gtchardwe {
    struct GTCHARDWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCHARDWE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCHARDWE>(arg0, 9, 0x1::string::utf8(b"GTCHARDWE"), 0x1::string::utf8(b"Chard bats base"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/MmikeWyBxx0oyik9TfwXlxG3ua3Yd97kzV5NkU_EcmCXArclOzUpEHxEZnSS-0uBVqvlthxCK73puComH0LdOBsNQwACEMy98cIiQZZiIIKo0uyoKeWcK6oA3TJLS91L77aQbAbIMfQN1UU4exCeR7WLjBLu8iMNpBSGA2F3GN-1Q08vn--C0ytV6FaIsGC4jq66Al7ItxozXNbfuzYW1TyLgHH2lAUT5MEX7LNzmepXEfDslTXZnMEbXR6A8x57gjR7lMxFhdylJrd4OZPAbuoTrIBtyciRr2ZEBcueFnkDFrHJuRqEwRrrkxL-H6qEKO1SHkcumg4wS-aN6jpVRg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCHARDWE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCHARDWE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

