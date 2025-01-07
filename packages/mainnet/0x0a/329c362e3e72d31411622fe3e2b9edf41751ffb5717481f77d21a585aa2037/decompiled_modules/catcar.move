module 0xa329c362e3e72d31411622fe3e2b9edf41751ffb5717481f77d21a585aa2037::catcar {
    struct CATCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCAR>(arg0, 6, b"CATCAR", b"CAT IN A CAR", b"Cat Going home with car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_17_09_52_7a96076d1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

