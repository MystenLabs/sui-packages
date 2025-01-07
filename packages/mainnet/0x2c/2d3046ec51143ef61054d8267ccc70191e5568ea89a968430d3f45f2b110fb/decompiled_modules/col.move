module 0x2c2d3046ec51143ef61054d8267ccc70191e5568ea89a968430d3f45f2b110fb::col {
    struct COL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COL>(arg0, 9, b"COL", b"RANGO", b"COLORFUL COLORFUL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b37afe30-4f40-45a9-80af-02d60dd37f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COL>>(v1);
    }

    // decompiled from Move bytecode v6
}

