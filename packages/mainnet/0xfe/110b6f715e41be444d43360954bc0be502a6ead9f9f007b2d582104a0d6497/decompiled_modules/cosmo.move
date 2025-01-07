module 0xfe110b6f715e41be444d43360954bc0be502a6ead9f9f007b2d582104a0d6497::cosmo {
    struct COSMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMO>(arg0, 6, b"COSMO", b"COSMONAUTICO", b"Official.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Astronauta_30f00f728b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COSMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

