module 0x59d31a4d2dec0fb2d49a148aba3a1e5f63ed0767f71fd31e26c37a9c92280bc8::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 6, b"KEKIUS", b"Kekius Maximus", b"A true leader in the space: Kekius Maximus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735651295672.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

