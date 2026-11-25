module 0x49a408cc0260cc703d7de6d433f434c12f81b7cbaf6bc897b210178a1bac3f03::gtoxjayp {
    struct GTOXJAYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTOXJAYP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTOXJAYP>(arg0, 9, 0x1::string::utf8(b"GTOXJAYP"), 0x1::string::utf8(b"Jay-P"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/GjExLJChpJHQWdR1-ouv2k1saPCR3rAIDOd7ouu7SIZtnlvCxEWiXGWmwfz8-mY2b4jj15wHhwvSCjvT65gaGWzL7hwHFWmRZn1uWrwWdb7Jk_0MOkIAI93_lVORtom3gVeMBmLM2TobiZ4aqSwQo4Cqh2-tp7fLCI1PB9RbPnAmgGNhA-1-oAF7pK7Doh4CWnv3Dg-FpWclNpP1ZJOHOrGYk1RmZ8UMY4jRP3qPNA1q3rMje1eoXmN_E2wN5LMlw9bPQRyBxmr_koN30NcLODpARkuH1EUeuqvTacOrc1k7MPKRrU0cWtn0rGNc9jl8P-VvLS0zIcU0jyRnHpGY2w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTOXJAYP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTOXJAYP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

