module 0x4a6c6cb8ebc3cb1fbfcfa19c53a1e4078db72acd7d14d8efd692692c25e88c92::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"STAR SUI", b"Star in SuiSea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/90_K_Ph_C6o_400x400_49e9062ab4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

