module 0x90329362b81a30229f934273278ff92bb807a55238dee7b340d9b70f722f0821::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"POPCAT SUI", b"DON'T MISS Let me guess, you missed POPCAT on Solana and now you're down bad trying to find the next 1000x play? Dead wallets, pump and dumps, rug pulls... The market can seem lifeless at times. Buy fear not, we've been there before.  Now it's time to save the market, and don't miss second chance of POPCAT ON SUI - meet $POPSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_popcatsui_2_b9361c2744.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

