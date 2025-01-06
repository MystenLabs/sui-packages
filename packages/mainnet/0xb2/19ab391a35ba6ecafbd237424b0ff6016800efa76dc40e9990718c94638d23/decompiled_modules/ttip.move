module 0xb219ab391a35ba6ecafbd237424b0ff6016800efa76dc40e9990718c94638d23::ttip {
    struct TTIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TTIP>(arg0, 6, b"TTIP", b"TTipper by SuiAI", b"This Agent will be able to help you create and enhance your music. Enhance the listeners experience and above all, able to offer you a good time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4679_min_9841cf1333.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

