module 0x180f7bce738d3720122165e0d1da2777362bdf53f474121cfed5d1d97b3fe71f::qwen {
    struct QWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEN>(arg0, 6, b"QWEN", b"Qwen 2.5", b"Qwen2.5 is the large language model series developed by Qwen team, Alibaba Cloud.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738478329375.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

