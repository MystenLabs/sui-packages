module 0xcfb9a437a78270e29df535dceed0f1124126ee4a4f54cb630f1c66cf9c279032::plopai {
    struct PLOPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PLOPAI>(arg0, 6, b"PLOPAI", b"Plop Agent", b"Plop Agent is here to revolution the adventures on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_04_15_53_16_88b9158688.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLOPAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOPAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

