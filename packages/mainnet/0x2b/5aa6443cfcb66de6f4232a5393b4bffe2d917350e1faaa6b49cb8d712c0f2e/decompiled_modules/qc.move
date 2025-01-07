module 0x2b5aa6443cfcb66de6f4232a5393b4bffe2d917350e1faaa6b49cb8d712c0f2e::qc {
    struct QC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QC>(arg0, 9, b"QC", b"Quack", b"Quack Quack Quack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4145b3f9-e179-45a3-aec5-2a5843722b80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QC>>(v1);
    }

    // decompiled from Move bytecode v6
}

