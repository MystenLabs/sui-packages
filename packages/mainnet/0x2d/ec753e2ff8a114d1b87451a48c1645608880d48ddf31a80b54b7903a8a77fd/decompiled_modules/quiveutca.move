module 0x2dec753e2ff8a114d1b87451a48c1645608880d48ddf31a80b54b7903a8a77fd::quiveutca {
    struct QUIVEUTCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUIVEUTCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUIVEUTCA>(arg0, 6, b"QUIVEUTCA", b"QUILAVEU", b"yo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3f68920dacb65f9a5bed37fe96aeec85_3_94cb77a45e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUIVEUTCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUIVEUTCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

