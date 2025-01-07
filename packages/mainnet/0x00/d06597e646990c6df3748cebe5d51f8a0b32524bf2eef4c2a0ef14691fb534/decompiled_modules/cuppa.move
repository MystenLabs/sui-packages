module 0xd06597e646990c6df3748cebe5d51f8a0b32524bf2eef4c2a0ef14691fb534::cuppa {
    struct CUPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPPA>(arg0, 6, b"Cuppa", b"Frog in Cup", b"ribbit would u like a cuppa tea?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6508_390876b67e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

