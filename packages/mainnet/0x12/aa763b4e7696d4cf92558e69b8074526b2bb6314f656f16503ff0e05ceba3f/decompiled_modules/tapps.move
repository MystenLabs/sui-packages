module 0x12aa763b4e7696d4cf92558e69b8074526b2bb6314f656f16503ff0e05ceba3f::tapps {
    struct TAPPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAPPS>(arg0, 6, b"TAPPS", b"Tap App Store", b"Gram Sui corporate ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Diamond_256_971647a094.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAPPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

