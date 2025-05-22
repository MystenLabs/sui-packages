module 0x6c58b4a7b7dace04f0bdcea4a767ce622aca00c18302cd1bb9bd8b228aac488b::fixone {
    struct FIXONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIXONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIXONE>(arg0, 9, b"f1", b"fixone", b"f1 desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/154a1806-c12c-4623-a599-d7a7a76bd19a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIXONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIXONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

