module 0x77a40205ac157e03f9e3b6a6d4c9a2b2aac2b25ea751c2116f1378436c9ba171::Limbo {
    struct LIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMBO>(arg0, 9, b"LIMBO", b"Limbo", b"where am i?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/b6ff0a2d-6951-46d9-af3f-4a1ee4e787d7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

