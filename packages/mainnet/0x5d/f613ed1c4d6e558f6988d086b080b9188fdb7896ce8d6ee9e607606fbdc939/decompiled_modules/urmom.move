module 0x5df613ed1c4d6e558f6988d086b080b9188fdb7896ce8d6ee9e607606fbdc939::urmom {
    struct URMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: URMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URMOM>(arg0, 6, b"URMOM", b"Your mom", b"Satoshi's only pet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_21_52_36_e45fd9f371.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URMOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

