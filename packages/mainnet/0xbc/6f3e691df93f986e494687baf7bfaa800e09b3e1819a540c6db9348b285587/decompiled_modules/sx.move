module 0xbc6f3e691df93f986e494687baf7bfaa800e09b3e1819a540c6db9348b285587::sx {
    struct SX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SX>(arg0, 9, b"SX", b"Sex", b"Sex is a meme token create only task and fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1b34159-7bd9-4389-bfe8-e60364f8d0b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SX>>(v1);
    }

    // decompiled from Move bytecode v6
}

