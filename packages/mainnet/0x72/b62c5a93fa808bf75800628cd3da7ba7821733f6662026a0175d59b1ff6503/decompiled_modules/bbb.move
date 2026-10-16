module 0x72b62c5a93fa808bf75800628cd3da7ba7821733f6662026a0175d59b1ff6503::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 6, b"BBB", b"bbbb", b"BBBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792132374096.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

