module 0xc31bff7d95f9d563ec233ecf6af2aa07cf21ee1c648c7fccb5f771a699a84bcb::doken {
    struct DOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKEN>(arg0, 6, b"DOKEN", b"DoKenonSui", b"D-ken () Shortened name for Hakkaido-Ken. Intelligent and purebred dog that is a brave and devoted companion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5877521221160_0d15e17459e9e1bd9c55fa517744aadb_3b1a1bdc1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

