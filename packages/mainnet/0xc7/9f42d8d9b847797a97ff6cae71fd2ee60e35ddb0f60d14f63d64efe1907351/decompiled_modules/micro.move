module 0xc79f42d8d9b847797a97ff6cae71fd2ee60e35ddb0f60d14f63d64efe1907351::micro {
    struct MICRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICRO>(arg0, 6, b"MICRO", b"Microsui", x"4d6963726f7761766520746f20636f6f6b206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo192_9eb7a14853.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

