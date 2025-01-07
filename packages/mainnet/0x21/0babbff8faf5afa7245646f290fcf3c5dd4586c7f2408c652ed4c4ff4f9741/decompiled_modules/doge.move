module 0x210babbff8faf5afa7245646f290fcf3c5dd4586c7f2408c652ed4c4ff4f9741::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"DOGE ON SUI", b"Department Of Government Efficiency - Led by Elon Musk and Vivek Ramaswamy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_22_14_54_29_0c4b7733b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

