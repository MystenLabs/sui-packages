module 0xeaa4cf5becf7656057728f87b0db5582b39b69345a37239861c2212e39a4b83c::ifxt {
    struct IFXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFXT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_account(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde")
        } else {
            0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::creator_authority::new_address(0x2::address::from_bytes(x"846e62d6e77fe8df74508d8e15fa6583cf3a4894a35108e549b7b448fa71acde"))
        };
        0x2::transfer::public_transfer<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::LaunchTicket<IFXT>>(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::launch_ticket::new<IFXT>(arg0, 9, 0x1::string::utf8(b"IFXT"), 0x1::string::utf8(b"INFLEX test IFXT"), 0x1::string::utf8(b"INFLEX integration test with TEST_SUI. Not a real coin."), 0x1::string::utf8(b"https://blast.fun/meme.png"), v0, false, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

