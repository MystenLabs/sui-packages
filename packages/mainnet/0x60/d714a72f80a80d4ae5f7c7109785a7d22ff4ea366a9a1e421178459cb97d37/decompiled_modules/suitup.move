module 0x60d714a72f80a80d4ae5f7c7109785a7d22ff4ea366a9a1e421178459cb97d37::suitup {
    struct SUITUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITUP>(arg0, 6, b"SUITUP", b"ITS TIME TO SUITUP by SuiAI", b".'It's Time to Suit Up' isn't just a meme; it's a call to action for the crypto community to prepare for the next wave of blockchain technology and AI integration. This meme coin leverages the high performance and scalability of the Sui blockchain to offer a unique blend of humor, community engagement, and technological advancement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/s2_JRBW_0l_400x400_1e75728f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITUP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

