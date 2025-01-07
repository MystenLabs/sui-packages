module 0x6629eb1a8e9979283247395ddb9bfc9b21c85c51eeed513771a5bd0c02907872::zep {
    struct ZEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEP>(arg0, 9, b"ZEP", b"Zephyrhbar", b"Hail hedera", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d162f32-60c0-411b-9069-26658d960cd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

