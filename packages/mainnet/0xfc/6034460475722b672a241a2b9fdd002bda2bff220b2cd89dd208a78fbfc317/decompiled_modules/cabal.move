module 0xfc6034460475722b672a241a2b9fdd002bda2bff220b2cd89dd208a78fbfc317::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 6, b"CABAL", b"Cabal", b"Cabal coins by the same cabal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cabal_Street_57ada30743.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

