module 0xbb2cb835eeff5370120a556c860ae0ff49c74c1e9be0a22a767e42228dc1e6e4::jmai {
    struct JMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JMAI>(arg0, 6, b"JMAI", b"JOKEMASTER AI by SuiAI", b"JOKEMASTER AI is an AI-powered agent designed specifically to entertain and educate users about cryptocurrency through humor. This agent combines the dynamic world of blockchain, cryptocurrencies, and all its associated lingo into a light-hearted, comedic format. JOKEMASTER AI is the digital jester of the blockchain realm, an AI designed to weave humor with the complex tapestry of cryptocurrency culture. This AI agent is your go-to for a laugh in the volatile world of digital currencies, ensuring that even the most daunting market crash comes with a side of giggles..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/output_25d5d014f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

