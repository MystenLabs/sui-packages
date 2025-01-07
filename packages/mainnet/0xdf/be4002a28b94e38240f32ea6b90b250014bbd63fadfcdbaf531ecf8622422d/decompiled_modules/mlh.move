module 0xdfbe4002a28b94e38240f32ea6b90b250014bbd63fadfcdbaf531ecf8622422d::mlh {
    struct MLH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLH>(arg0, 9, b"MLH", b"4HER", b"J4U", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/221b3aed-714a-4a43-89f0-644bfe74cec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLH>>(v1);
    }

    // decompiled from Move bytecode v6
}

