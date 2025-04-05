module 0x42a89011a09a8ee7360fb29a506bc5d28b11db9d75933b176ab59b1de17aa31c::ttfb {
    struct TTFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFB>(arg0, 9, b"TTfb", b"ggdt", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/82b63d1e60dcde22337beb071952aa0ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

