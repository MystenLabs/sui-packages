module 0x4fefc8c12624f46b0e6f8b40a121b8a9a47ea986758895300d1100652b4c97f::Retardio {
    struct RETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDIO>(arg0, 9, b"RETARD", b"Retardio", b"baseline intelligence activated. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/0a345048-c192-4645-a6cf-9180773ecdca.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETARDIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

