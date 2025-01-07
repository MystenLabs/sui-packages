module 0x926a7fcef976193c3e43b8575f0503d426d8d116f853d53855659d621374cdbd::poolio {
    struct POOLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOLIO>(arg0, 6, b"POOLIO", b"Poolio", b"Poolio the Mascot of all pools on the water network - SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_16_01_55_46_dab25fc10b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOLIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

