module 0xd3c08b6d26e9e5b8ecc7f141b31d001757eee9a6be62310a4ed5c375a126c633::av {
    struct AV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AV>(arg0, 9, b"AV", b"Avira", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eae10ad0-f49e-4ee5-af50-204d37473d2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AV>>(v1);
    }

    // decompiled from Move bytecode v6
}

