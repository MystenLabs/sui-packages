module 0x4392ce5ef8a7871aae2fb81b3c79e3958b84beb5fa723afc0cfdd22e0a8e6ab0::gtjuaramar {
    struct GTJUARAMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTJUARAMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTJUARAMAR>(arg0, 9, 0x1::string::utf8(b"GTJUARAMAR"), 0x1::string::utf8(b"Juara Markisa"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/h3mQzPfanG15-h8YOydci8SVRvZnlb3i4UewB9ZS2A1ucn7mN7KRZG8cvfP6VxdoGzZX2oYxiFyqBNKWpuu8y_o5F6qK5PdQ1F5XPbA_H_zmeU2Hgk_wLKE8D82W2961hcNDEE2NXlQY2TR6zilU_xxBVM1JFD4spwBR-yHdlXkh0Ffo97UFSgEMI1LnZVwUsBu1vdyBHtSZrjJL--fghq_DJO27AifZJBzlBSIDpm-TwiqnniHSEZgHdcEp55bENEUhvhQIT09C2dq_ngYesCtqOtTwUuRjmmUgEW5X3gUyFCsHkR0vj00tjFzNAiF1hASYVcNarIv0mMfuRHJnQg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTJUARAMAR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTJUARAMAR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

