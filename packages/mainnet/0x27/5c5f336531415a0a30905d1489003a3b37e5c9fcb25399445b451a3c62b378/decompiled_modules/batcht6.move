module 0x275c5f336531415a0a30905d1489003a3b37e5c9fcb25399445b451a3c62b378::batcht6 {
    struct BATCHT6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCHT6, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<BATCHT6>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<BATCHT6>(arg0, 9, 0x1::string::utf8(b"BATCHT6"), 0x1::string::utf8(b"Batch test 6"), 0x1::string::utf8(b"Blast operational-worker batching test, 2026-10-29. Not a real coin."), 0x1::string::utf8(b""), v0, false, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

