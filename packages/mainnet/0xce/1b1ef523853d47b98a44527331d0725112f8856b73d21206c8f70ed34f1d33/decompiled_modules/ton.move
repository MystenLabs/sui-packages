module 0xce1b1ef523853d47b98a44527331d0725112f8856b73d21206c8f70ed34f1d33::ton {
    struct TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON>(arg0, 9, b"TON", b"BiGi", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e83d8233-2eda-496d-8c90-e46dd1db93f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON>>(v1);
    }

    // decompiled from Move bytecode v6
}

