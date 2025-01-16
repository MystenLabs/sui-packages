module 0xc9549b8befbb427790057783679721119c86a3157852627da091fc25c47f0bff::mpoints {
    struct MPOINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPOINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPOINTS>(arg0, 9, b"mPOINTS", b"mPOINTS", b"Metastable points Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mstable.io/coins/mpoints.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPOINTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPOINTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

