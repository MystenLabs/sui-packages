module 0xfe9015f4bb570ee68efd2ea80ac3a2bb7eee8fd975ebf8d293fa800fa8e678ff::mashio {
    struct MASHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASHIO>(arg0, 6, b"Mashio", b"Pochitas Father", b"Pochitas Father ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_105444_1333a3834d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASHIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASHIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

