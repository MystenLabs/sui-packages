module 0xa0087f45184e2b9a84479d339426a2487a2deba5909dac3d30a90aebc2e9ab47::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 6, b"RUFF", b"RUFFCTO", b"Just Ruffin' Around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ruff_6e0ec48313.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

