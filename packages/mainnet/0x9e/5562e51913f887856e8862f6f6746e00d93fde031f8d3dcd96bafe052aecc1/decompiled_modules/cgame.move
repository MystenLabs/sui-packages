module 0x9e5562e51913f887856e8862f6f6746e00d93fde031f8d3dcd96bafe052aecc1::cgame {
    struct CGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGAME>(arg0, 9, b"CGAME", b"CryptoGame", b"Top coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e671c37-7cd3-4167-b5ea-e5c27a16237c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

