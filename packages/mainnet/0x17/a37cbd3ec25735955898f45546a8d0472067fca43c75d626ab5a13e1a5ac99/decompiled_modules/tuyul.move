module 0x17a37cbd3ec25735955898f45546a8d0472067fca43c75d626ab5a13e1a5ac99::tuyul {
    struct TUYUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUYUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUYUL>(arg0, 9, b"TUYUL", b"Tuyull", b"A ghost", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f95d0d5d-b7a4-4f92-a60f-643122f7deca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUYUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUYUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

