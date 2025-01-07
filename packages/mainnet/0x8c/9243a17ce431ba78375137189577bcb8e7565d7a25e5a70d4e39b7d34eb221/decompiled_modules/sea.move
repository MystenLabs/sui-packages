module 0x8c9243a17ce431ba78375137189577bcb8e7565d7a25e5a70d4e39b7d34eb221::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 9, b"SEA", b"SEAART", b"Sea Art showing the beauty of community and creativity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30d101cc-26e6-4510-9a17-ca363f6ac50b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

