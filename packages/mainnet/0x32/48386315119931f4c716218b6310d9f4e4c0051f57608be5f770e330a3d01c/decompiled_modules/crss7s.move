module 0x3248386315119931f4c716218b6310d9f4e4c0051f57608be5f770e330a3d01c::crss7s {
    struct CRSS7S has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRSS7S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRSS7S>(arg0, 6, b"CRSS7S", b"CristianoRonaldoSpeedSmurf7Siu", b" Conglomerate name for $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_10_01_34_496565174a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRSS7S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRSS7S>>(v1);
    }

    // decompiled from Move bytecode v6
}

