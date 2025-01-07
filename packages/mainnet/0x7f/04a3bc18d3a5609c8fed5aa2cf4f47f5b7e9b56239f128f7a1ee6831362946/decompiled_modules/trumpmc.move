module 0x7f04a3bc18d3a5609c8fed5aa2cf4f47f5b7e9b56239f128f7a1ee6831362946::trumpmc {
    struct TRUMPMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMC>(arg0, 6, b"TRUMPMC", b"TRUMP MC", b"TRUMP MC ! TRUMP MC ! TRUMP MC ! TRUMP MC ! TRUMP MC ! TRUMP MC ! TRUMP MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/57ab768fce38f234008b5ea0_574ee8173b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

