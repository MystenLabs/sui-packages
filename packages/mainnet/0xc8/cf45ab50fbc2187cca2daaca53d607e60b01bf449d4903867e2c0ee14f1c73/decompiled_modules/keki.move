module 0xc8cf45ab50fbc2187cca2daaca53d607e60b01bf449d4903867e2c0ee14f1c73::keki {
    struct KEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKI>(arg0, 6, b"KEKI", b"Kekius Minimus", b"Just a Kekius Minimus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_055108_566_ee3c7e12f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

