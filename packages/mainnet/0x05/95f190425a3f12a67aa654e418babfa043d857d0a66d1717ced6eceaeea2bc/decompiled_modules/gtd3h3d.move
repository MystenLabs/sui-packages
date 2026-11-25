module 0x595f190425a3f12a67aa654e418babfa043d857d0a66d1717ced6eceaeea2bc::gtd3h3d {
    struct GTD3H3D has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTD3H3D, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTD3H3D>(arg0, 9, 0x1::string::utf8(b"GTD3H3D"), 0x1::string::utf8(b"David"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/NUHy7uPXRvQMzgk4lCBZbdL33fYnEn9SQXhzB8al8kjXy5ZGhKxqdlHHyrbajKWJCzo9E5G9gR3n1J8rziL0XMW_TkLRc9aUMvHsDqEnmlez7keoP0Q6OevowLvFcp-gBEvamYEeHi55zgRqXUWK2rNp27_36KXrLf66X6tLubCx-xLVtJoRT_V0I4OijOSx9UNgw_VOqzo13tWSzwlUbx5dmmvDCwISs7hnLM3BlrJeHmfzxPadH1ShzTdZ2UcXGfhi1m1s8__5epgq1-KrZjX-qRDN4qFe_bZf7tWp-dt9NRXy2EiOZjbrUq7-9bxzLCNSF8y-AWposTl1ldQxvA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTD3H3D>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTD3H3D>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

