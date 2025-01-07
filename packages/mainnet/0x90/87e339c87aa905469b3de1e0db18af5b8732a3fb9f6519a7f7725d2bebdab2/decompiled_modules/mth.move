module 0x9087e339c87aa905469b3de1e0db18af5b8732a3fb9f6519a7f7725d2bebdab2::mth {
    struct MTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTH>(arg0, 6, b"MTH", b"Matterhorn.Fun", b"In honor of the most beautiful, most magnificent mountain in the world. Be part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731017144724.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

