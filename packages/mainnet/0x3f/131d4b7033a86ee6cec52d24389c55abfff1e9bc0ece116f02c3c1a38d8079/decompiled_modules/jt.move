module 0x3f131d4b7033a86ee6cec52d24389c55abfff1e9bc0ece116f02c3c1a38d8079::jt {
    struct JT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JT>(arg0, 9, b"JT", b"John ", b"Trade now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e691814b-e370-4c06-aa7c-2a17468d7299.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JT>>(v1);
    }

    // decompiled from Move bytecode v6
}

