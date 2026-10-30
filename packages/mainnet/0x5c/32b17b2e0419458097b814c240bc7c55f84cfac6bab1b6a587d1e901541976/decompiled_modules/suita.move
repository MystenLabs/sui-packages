module 0x5c32b17b2e0419458097b814c240bc7c55f84cfac6bab1b6a587d1e901541976::suita {
    struct SUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"865061a7253e00e8e89e76e23065f4b0326f11446e32e34906b7983d7ee1ace9")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"865061a7253e00e8e89e76e23065f4b0326f11446e32e34906b7983d7ee1ace9"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<SUITA>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<SUITA>(arg0, 9, 0x1::string::utf8(b"SUITA"), 0x1::string::utf8(b"sui-trench test A"), 0x1::string::utf8(b"sui-trench integration test A (opening round, Bluefin), not a real coin"), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

