module 0xc6e9d1ae1f25fa2b4fb9a50534f0d18bd97b9ab08252aade0b2bee5e8439721f::pepevos {
    struct PEPEVOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEVOS>(arg0, 6, b"PepEvos", b"$Pepe 4.0", b"Pepe 4.0 evolution to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733248507000.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEVOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEVOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

