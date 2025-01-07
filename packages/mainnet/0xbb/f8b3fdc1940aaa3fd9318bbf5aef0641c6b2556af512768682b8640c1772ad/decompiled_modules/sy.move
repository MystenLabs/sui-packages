module 0xbbf8b3fdc1940aaa3fd9318bbf5aef0641c6b2556af512768682b8640c1772ad::sy {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SY>(arg0, 9, b"SY", b"Shinyi", b"Shinyi ah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7914e0f7-1130-4f73-987d-284a3a9295d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SY>>(v1);
    }

    // decompiled from Move bytecode v6
}

