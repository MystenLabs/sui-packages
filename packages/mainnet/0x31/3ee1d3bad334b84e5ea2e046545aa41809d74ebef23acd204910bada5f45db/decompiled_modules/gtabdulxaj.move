module 0x313ee1d3bad334b84e5ea2e046545aa41809d74ebef23acd204910bada5f45db::gtabdulxaj {
    struct GTABDULXAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTABDULXAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTABDULXAJ>(arg0, 9, 0x1::string::utf8(b"GTABDULXAJ"), 0x1::string::utf8(b"Abdul Ajid"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Zt7o0wNhg6ct8JJbqgRa7tizB9WASapQwBxPxIp3LwVwCllM1s0tW1PNbypsJ1Sih6YNeJxNIGISq0nm3ViDvtTc3pzf1KXF6wPDFE3pBYdOVuG5H0ESz4d4R69Jaoq8EQZiGISXX8o0eMFDwW7Tu2pHQTT1x5JbH0a9ok9D3n3uh25HgHjb5NGzMl81djuTyQ1AMxmPskSXnevDvyrYhHC1d2XDWBoAp7S6u9cZmTMKmDQHY_vooHcyzbOFCp7fzHgdL1A4JOAgH5gym3GkCui8lTqCP-P6xPSoQB8fV9rjK0iArBsad9kUsFOMgZhPw6rQGmo9gr0YN6_ZufSqVg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTABDULXAJ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTABDULXAJ>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

