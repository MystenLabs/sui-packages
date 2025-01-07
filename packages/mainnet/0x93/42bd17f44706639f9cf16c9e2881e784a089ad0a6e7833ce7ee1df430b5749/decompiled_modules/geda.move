module 0x9342bd17f44706639f9cf16c9e2881e784a089ad0a6e7833ce7ee1df430b5749::geda {
    struct GEDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEDA>(arg0, 6, b"GEDA", b"GEDAGEDIGEDAGEDAO", b"GEDA GEDI GEDA GEDA O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GEDA_1f4e9f398a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

