module 0x8362808cc8b8b28e31dcd6940d6e1314dafeec64f1b4949046696c7658fff05f::something {
    struct SOMETHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMETHING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOMETHING>(arg0, 6, b"SOMETHING", b"something by SuiAI", b"something ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2164_453dc9639d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOMETHING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMETHING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

