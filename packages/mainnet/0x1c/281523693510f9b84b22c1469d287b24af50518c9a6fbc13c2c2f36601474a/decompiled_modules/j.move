module 0x1c281523693510f9b84b22c1469d287b24af50518c9a6fbc13c2c2f36601474a::j {
    struct J has drop {
        dummy_field: bool,
    }

    fun init(arg0: J, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<J>(arg0, 6, b"J", b"Jze by SuiAI", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0789_2b5ccc2c83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<J>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

