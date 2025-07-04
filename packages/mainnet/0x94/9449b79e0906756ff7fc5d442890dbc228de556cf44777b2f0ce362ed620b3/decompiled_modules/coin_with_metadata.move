module 0x949449b79e0906756ff7fc5d442890dbc228de556cf44777b2f0ce362ed620b3::coin_with_metadata {
    struct COIN_WITH_METADATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_WITH_METADATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_WITH_METADATA>(arg0, 9, b"CWM", b"coin with metadata", b"coin with metadata and a description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a0258f1d-0c0e-4134-8d9d-2908b4b67df0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_WITH_METADATA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_WITH_METADATA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

