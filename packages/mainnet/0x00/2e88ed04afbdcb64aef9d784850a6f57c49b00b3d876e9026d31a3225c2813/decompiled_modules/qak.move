module 0x2e88ed04afbdcb64aef9d784850a6f57c49b00b3d876e9026d31a3225c2813::qak {
    struct QAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QAK>(arg0, 9, b"QAK", b"Quack", b"New meme like a duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/373d1372-ae4d-410e-bf0d-eea19dec4fb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

