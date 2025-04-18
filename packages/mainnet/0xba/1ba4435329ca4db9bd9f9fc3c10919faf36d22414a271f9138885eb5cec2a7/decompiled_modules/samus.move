module 0xba1ba4435329ca4db9bd9f9fc3c10919faf36d22414a271f9138885eb5cec2a7::samus {
    struct SAMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMUS>(arg0, 9, b"SAMUS", b"Metroid", b"Metroid funs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dacdce53efbc463674478845c1ad1670blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

