module 0x5f0013fb7c0ede227d04a6b4918fbe7fb139e498cd3a7545a2e43efaeee80321::temupig {
    struct TEMUPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMUPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMUPIG>(arg0, 6, b"Temupig", b"TemuPigShirt", b"you cant run from it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_13_at_09_49_16_7ea1b6bc85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMUPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMUPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

