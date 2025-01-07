module 0x30662c409f43b1d7d268a62530dd257baa782282228571c48267f2cb2a311556::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"RONDA ON SUI", b"Ronda on Sui is a community-driven meme coin project built on the Sui Network. Inspired by my adopted dog, Ronda, it focuses on creating a fun and engaging crypto community. The project emphasizes its playful nature while also providing details on it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731543173229.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

