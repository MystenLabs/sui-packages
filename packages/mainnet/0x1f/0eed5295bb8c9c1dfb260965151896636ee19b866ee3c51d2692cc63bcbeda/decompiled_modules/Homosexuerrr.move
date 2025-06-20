module 0x1f0eed5295bb8c9c1dfb260965151896636ee19b866ee3c51d2692cc63bcbeda::Homosexuerrr {
    struct HOMOSEXUERRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMOSEXUERRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMOSEXUERRR>(arg0, 9, b"HMSXR", b"Homosexuerrr", b"school teching the children how to be a homosexuerrr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/12f44881-1be8-44b5-9772-d244a44f1dfc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMOSEXUERRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMOSEXUERRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

