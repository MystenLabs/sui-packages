module 0xb7ae278d638a7e24a4374b05cd3371c414450e9f3fe37446c966c645d3644a81::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"5ae94f70dac74c5acacfe91de3ed57f6440fc892af74aee267eed4b9582c9341")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"5ae94f70dac74c5acacfe91de3ed57f6440fc892af74aee267eed4b9582c9341"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<BLAST>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<BLAST>(arg0, 9, 0x1::string::utf8(b"BLAST"), 0x1::string::utf8(b"BLAST Test"), 0x1::string::utf8(b"Test launch on Blast v2 with TEST_SUI. Not a real coin."), 0x1::string::utf8(b""), v0, true, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

