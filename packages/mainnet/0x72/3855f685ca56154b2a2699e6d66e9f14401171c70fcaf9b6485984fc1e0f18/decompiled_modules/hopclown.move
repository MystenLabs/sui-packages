module 0x723855f685ca56154b2a2699e6d66e9f14401171c70fcaf9b6485984fc1e0f18::hopclown {
    struct HOPCLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCLOWN>(arg0, 6, b"HOPCLOWN", b"Hop Not Fun", b"Hop.fun is a clown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985780759.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPCLOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCLOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

