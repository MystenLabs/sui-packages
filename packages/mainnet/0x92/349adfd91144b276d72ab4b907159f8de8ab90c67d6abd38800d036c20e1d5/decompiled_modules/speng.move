module 0x92349adfd91144b276d72ab4b907159f8de8ab90c67d6abd38800d036c20e1d5::speng {
    struct SPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENG>(arg0, 6, b"SPENG", b"SUI PENG", b"Meet SUI PENG, the smartest and cutest penguin-inspired memecoin powered by AI on the Sui Network! Combining the charm of penguins with the brilliance of artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736007208144.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

