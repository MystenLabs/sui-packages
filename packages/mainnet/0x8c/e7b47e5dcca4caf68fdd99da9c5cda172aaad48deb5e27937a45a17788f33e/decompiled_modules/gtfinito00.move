module 0x8ce7b47e5dcca4caf68fdd99da9c5cda172aaad48deb5e27937a45a17788f33e::gtfinito00 {
    struct GTFINITO00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTFINITO00, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTFINITO00>(arg0, 9, 0x1::string::utf8(b"GTFINITO00"), 0x1::string::utf8(b"Henry"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/SwgH-BxWtdJy1mrzopPx9KXG2fxv9Fa7HfWdAEjHyJUbWH_Es5kG2E97N_wxHHY8nNpw4nI28hQR8Q6s89_8myeDS-ln01F1rRN4NmTQ6jsdAg700KyC4rV3rntbkjcAx-tYX9pfoI2Ita5UeNl1BIXLCu7czrhSECBlTq23U7DowegZzjFn_vpdEo3_nO_ynpOT1Jw4dINMR-6Wv0aKCySFPwA6vxm8-LTD4brgn8_CHuOFZYuugmLNN7eRFDXoBb4k40QdYYkM90cFdSowbnomR0oysxmReD-qbrn-u-9gWW64l3lm02-a74SGnleJcZYGcEyVsjaikKbC6ufhIg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTFINITO00>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTFINITO00>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

