module 0xa59a8c32c68f76c571ff04128a79c506da904b40fdbc95de6f7b1dcb8357f064::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"Sui Street Bets", b"Sui Street Bets is an innovative community and platform inspired by the phenomenon of Wall Street Bets, but focused on the Sui blockchain ecosystem. We serve as a hub for investors and traders to share ideas, strategies, and the latest information on digital assets built on the Sui network, known for its fast performance and low transaction fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_85f7b2680a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

