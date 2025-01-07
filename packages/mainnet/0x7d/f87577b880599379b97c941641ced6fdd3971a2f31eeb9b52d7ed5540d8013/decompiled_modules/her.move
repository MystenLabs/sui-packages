module 0x7df87577b880599379b97c941641ced6fdd3971a2f31eeb9b52d7ed5540d8013::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Hercules", b"Token de mi perro Hercules", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/token2_4b6c282eaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

