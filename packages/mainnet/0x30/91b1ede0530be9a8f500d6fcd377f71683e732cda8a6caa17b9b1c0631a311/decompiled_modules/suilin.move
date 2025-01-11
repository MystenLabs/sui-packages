module 0x3091b1ede0530be9a8f500d6fcd377f71683e732cda8a6caa17b9b1c0631a311::suilin {
    struct SUILIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIN>(arg0, 6, b"Suilin", b"Suiet Union", b"Welcome to the migthty Suiet Union!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736620377951.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

