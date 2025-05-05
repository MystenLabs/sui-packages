module 0xf5ce6bdbad17486dc26b8847c5f225af1bd6a68b905716f6779f935a2d4c6362::jul {
    struct JUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUL>(arg0, 9, b"JUL", b"Julix", b"Julix's avatar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/133e72afba4cf91667f35dc0b7c42ef1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

