module 0x9458ff292e7cf6620570d5d509592b7ca63bdc71fda3feac7971a6391cfeb8aa::maxi {
    struct MAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXI>(arg0, 6, b"MAXI", b"SUI MAXI", b"He only Buys SUI, believes it is the next Solana and NEVER sells his SUI. He is not in the game for the profits, he is in it for the tech: He is 100% SUI maxi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0375_1d27492b4d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

