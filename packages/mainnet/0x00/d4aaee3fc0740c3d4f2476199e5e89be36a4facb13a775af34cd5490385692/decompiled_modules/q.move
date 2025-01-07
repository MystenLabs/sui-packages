module 0xd4aaee3fc0740c3d4f2476199e5e89be36a4facb13a775af34cd5490385692::q {
    struct Q has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q>(arg0, 9, b"Q", b"Aoao", b"Skek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f60f06be-ad58-463d-8e92-2a2d09695924.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q>>(v1);
    }

    // decompiled from Move bytecode v6
}

