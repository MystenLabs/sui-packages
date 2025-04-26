module 0xbca336a03d470be2ee11ee10d2d270862374e3f45bb901deaa31518a177a5610::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 9, b"HONEY", b"HON", b"Tedjdpdo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38967a58-579c-4090-bfc3-07528ca283d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

