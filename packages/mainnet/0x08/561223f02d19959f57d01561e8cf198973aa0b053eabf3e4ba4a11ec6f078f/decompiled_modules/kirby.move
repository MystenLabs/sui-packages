module 0x8561223f02d19959f57d01561e8cf198973aa0b053eabf3e4ba4a11ec6f078f::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"Kirby ", b"https://en.m.wikipedia.org/wiki/Kirby_(character)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987550663.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

