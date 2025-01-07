module 0x1a6adb1f5c0a43c944c033f431dec0a8d1d70f83b21c2f30b5085f9c4267e2c5::kk {
    struct KK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KK>(arg0, 9, b"KK", b"Keke", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8fb9669-1d12-496a-9e6f-142b20c02fc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KK>>(v1);
    }

    // decompiled from Move bytecode v6
}

