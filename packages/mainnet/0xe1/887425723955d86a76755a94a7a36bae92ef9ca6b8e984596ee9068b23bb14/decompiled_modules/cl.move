module 0xe1887425723955d86a76755a94a7a36bae92ef9ca6b8e984596ee9068b23bb14::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CL>(arg0, 6, b"CL", b"Colours", b"Bright and colourful just like turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971198439.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

