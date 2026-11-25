module 0xec25d3ca127d7233516609a269151ec9587e50f33bc62a8607315bb524e640ed::gteazitech {
    struct GTEAZITECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTEAZITECH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTEAZITECH>(arg0, 9, 0x1::string::utf8(b"GTEAZITECH"), 0x1::string::utf8(b"EAZI TECH"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/Mre8e8TGb9cnVepF-GKQ6taChEljNZ-xDgtk1q3aBsOTIY6CMZceqHFQZYXxk8SR0lDAFktpTsG3G2QNh4MNlM1LpRRaf7PKrohV6BTHafY8S1csk3SKCtFRYjV1E38PbemDqvZb3hCD4eVlvbkfRcVOaa6XHEHIoHj4hfbkNH5ufZpXI7LD7rJajKBaUe4MwvGSQoP7FP1Z4XVwgRpouf5h_xYbZR4Y0wQ4R_HsB2aZLG1tja8H48Ct6ufeQ6_lcq-9c86ZrYtWYDjG1Y_Nh2BEZq95ag-dvUOhWbsPqTh1NpFVyszYQv6uSnCNKhY38nudWVFJhMs-h3SJL_tPQA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTEAZITECH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTEAZITECH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

