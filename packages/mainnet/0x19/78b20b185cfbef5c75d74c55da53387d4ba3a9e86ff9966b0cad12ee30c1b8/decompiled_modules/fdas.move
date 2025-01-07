module 0x1978b20b185cfbef5c75d74c55da53387d4ba3a9e86ff9966b0cad12ee30c1b8::fdas {
    struct FDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDAS>(arg0, 9, b"FDAS", b"et", b"FGD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab4b95f5-ec1d-4764-b5fe-a6bbe64b90d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

