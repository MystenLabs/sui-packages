module 0xfc7c5ee4d9efd1d0fdc7230207ed71f1f1bcd8d3f41253e7cd3e6d330558cab0::haha2 {
    struct HAHA2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA2>(arg0, 6, b"Haha2", b"haha", b"Heheh2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732611280212.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

