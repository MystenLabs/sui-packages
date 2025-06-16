module 0x9ea696499e34659d314132bf44537e16ce2c93d025aaaa2a1583cf8fad48d0bd::MariaResidential {
    struct MARIARESIDENTIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIARESIDENTIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIARESIDENTIAL>(arg0, 9, b"MRH", b"MariaResidential", b"Best care in the world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e7e67bc5-ebef-4ce9-8813-44a0a67e235d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIARESIDENTIAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIARESIDENTIAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

