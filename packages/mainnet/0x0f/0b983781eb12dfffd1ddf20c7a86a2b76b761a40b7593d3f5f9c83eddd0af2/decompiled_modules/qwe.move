module 0xf0b983781eb12dfffd1ddf20c7a86a2b76b761a40b7593d3f5f9c83eddd0af2::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 9, b"QWE", b"QWERA", b"123465895", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfc66389-8ba5-419e-916c-cf1759e4d849.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

