module 0xb8627f12897f2d174d48ed0ce310577ac472f6c28feb2132d5ae9378aa0e7a01::suimani {
    struct SUIMANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANI>(arg0, 6, b"Suimani", b"suimani", b"Suimani is y/our forever friend who brought unconditional love to y/our life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737448721416.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMANI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

