module 0x728b4fc5914e6aed66185dfc52d934fb82442d714d55a36672120138c4daee91::tto {
    struct TTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTO>(arg0, 9, b"TTO", b"Torres", b"Strong shots", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de63fe83-1344-478e-bddb-1cd0127ec6bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

