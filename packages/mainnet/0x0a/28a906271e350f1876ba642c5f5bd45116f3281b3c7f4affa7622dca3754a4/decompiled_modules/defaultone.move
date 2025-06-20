module 0xa28a906271e350f1876ba642c5f5bd45116f3281b3c7f4affa7622dca3754a4::defaultone {
    struct DEFAULTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAULTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAULTONE>(arg0, 9, b"D1", b"defaultone", b"default coin (one)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/053dcf3f-5717-439a-bedb-ebaaf1e5c7a0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFAULTONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAULTONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

