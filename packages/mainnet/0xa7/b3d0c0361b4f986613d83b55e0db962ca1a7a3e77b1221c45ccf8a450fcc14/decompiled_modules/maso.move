module 0xa7b3d0c0361b4f986613d83b55e0db962ca1a7a3e77b1221c45ccf8a450fcc14::maso {
    struct MASO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASO>(arg0, 9, b"MASO", b"Sachermas", b"SacherMaaaaa coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b801443-1c86-43b2-864f-c4c65e9090fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASO>>(v1);
    }

    // decompiled from Move bytecode v6
}

