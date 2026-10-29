module 0xdd86777f6c1c10c54a46508cb6cd284a4603b4e657355d3a064676e124e4817f::batcht5 {
    struct BATCHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<BATCHT5>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<BATCHT5>(arg0, 9, 0x1::string::utf8(b"BATCHT5"), 0x1::string::utf8(b"Batch test 5"), 0x1::string::utf8(b"Blast operational-worker batching test, 2026-10-29. Not a real coin."), 0x1::string::utf8(b""), v0, false, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

