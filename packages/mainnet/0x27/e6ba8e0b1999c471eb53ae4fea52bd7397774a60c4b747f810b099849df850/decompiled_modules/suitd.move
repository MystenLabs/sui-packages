module 0x27e6ba8e0b1999c471eb53ae4fea52bd7397774a60c4b747f810b099849df850::suitd {
    struct SUITD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"865061a7253e00e8e89e76e23065f4b0326f11446e32e34906b7983d7ee1ace9")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"865061a7253e00e8e89e76e23065f4b0326f11446e32e34906b7983d7ee1ace9"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<SUITD>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<SUITD>(arg0, 9, 0x1::string::utf8(b"SUITD"), 0x1::string::utf8(b"sui-trench test D"), 0x1::string::utf8(b"sui-trench integration test D (server sniper check), not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

