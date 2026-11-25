module 0x606d3314beca46adc410a48301ddd52bf56bc05685663f861cd497b993c24957::gtanonfang {
    struct GTANONFANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTANONFANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTANONFANG>(arg0, 9, 0x1::string::utf8(b"GTANONFANG"), 0x1::string::utf8(b"Fangu"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/X--N2r03ZPt4elYtkH3gv6o89r6WPCR_2JZF7hf4ROxRuyMEhF2CA-bDA1m04yllPKBODLsbmLJFn90_Q5Qb7TNlouKrbUTbrxbEOqLmBtrF51jhuOXOniAVYKsfn2FxFKDoSd4M7u8fA2fG-qZVp5hSA3G7jTmyi0yFUONMvIJtS3k6WlRIWEwc1N3DfVjdb5Ho-oHDINbxvU8c31Xrq3j8nX78b4LJtXEdXWQGersHjcVdbVnvI5NBJsZhkifpDG5nEfwQpEzoGgjhb4gUu7JnuKzSoD8_oIr5pt__jpmPTX55V4nA2lEAa3SJvDWh1utQ6isqvQ9IHG-MkSfnew.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTANONFANG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTANONFANG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

