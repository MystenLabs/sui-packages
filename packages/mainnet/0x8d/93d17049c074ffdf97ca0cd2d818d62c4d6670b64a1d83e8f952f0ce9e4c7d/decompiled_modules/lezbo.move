module 0x8d93d17049c074ffdf97ca0cd2d818d62c4d6670b64a1d83e8f952f0ce9e4c7d::lezbo {
    struct LEZBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEZBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEZBO>(arg0, 6, b"LEZBO", b"Lezbo Warren", b"A real life retarded Lezbo what is gonna fight the crypto baddies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731165483311.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEZBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEZBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

