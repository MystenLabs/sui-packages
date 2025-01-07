module 0xa414018064faf359de52595abf50073d84499e5d90daad7a5595b43a68ffd75b::gomugomu_8 {
    struct GOMUGOMU_8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOMUGOMU_8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOMUGOMU_8>(arg0, 9, b"GOMUGOMU_8", b"Fruit Evil", b"The best moment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87969ee8-0848-461e-896f-83ded89fbaec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOMUGOMU_8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOMUGOMU_8>>(v1);
    }

    // decompiled from Move bytecode v6
}

