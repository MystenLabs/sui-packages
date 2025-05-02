module 0x2e02de3ea33795d81c6025c31466e492613874e7f193807ee6f04371ab1d5f3e::sooey {
    struct SOOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOEY>(arg0, 6, b"Sooey", b"Soooey", b"Sui's Top pig token SOOEY!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_22_f5f6e6db18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

