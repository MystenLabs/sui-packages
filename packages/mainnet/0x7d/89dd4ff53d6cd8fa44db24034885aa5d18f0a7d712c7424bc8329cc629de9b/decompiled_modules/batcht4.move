module 0x7d89dd4ff53d6cd8fa44db24034885aa5d18f0a7d712c7424bc8329cc629de9b::batcht4 {
    struct BATCHT4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCHT4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<BATCHT4>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<BATCHT4>(arg0, 9, 0x1::string::utf8(b"BATCHT4"), 0x1::string::utf8(b"Batch test 4"), 0x1::string::utf8(b"Blast operational-worker batching test, 2026-10-29. Not a real coin."), 0x1::string::utf8(b""), v0, false, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

