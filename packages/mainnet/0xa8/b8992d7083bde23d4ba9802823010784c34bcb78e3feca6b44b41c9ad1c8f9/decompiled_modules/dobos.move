module 0xa8b8992d7083bde23d4ba9802823010784c34bcb78e3feca6b44b41c9ad1c8f9::dobos {
    struct DOBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBOS>(arg0, 6, b"DOBOS", b"Doge Boss", x"0a4974277320616c6c2061626f75742074686520636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734844883817.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

