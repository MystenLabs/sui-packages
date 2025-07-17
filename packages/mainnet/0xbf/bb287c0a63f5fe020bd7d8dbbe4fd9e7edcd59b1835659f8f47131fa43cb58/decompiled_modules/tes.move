module 0xbfbb287c0a63f5fe020bd7d8dbbe4fd9e7edcd59b1835659f8f47131fa43cb58::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TES>(arg0, 6, b"TES", b"tes", b"tes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_removebg_preview_8a9333456e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

