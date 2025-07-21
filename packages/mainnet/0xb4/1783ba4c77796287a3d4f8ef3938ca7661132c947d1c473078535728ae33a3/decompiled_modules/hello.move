module 0xb41783ba4c77796287a3d4f8ef3938ca7661132c947d1c473078535728ae33a3::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"helo", b"@suilaunchcoin $hello + helo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hello-o33f18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

