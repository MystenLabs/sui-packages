module 0x35df817d57f50821101bddd9ddf7fee69572b8972fbc258ae02d768b9bdd3e9f::tuyul {
    struct TUYUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUYUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUYUL>(arg0, 9, b"TUYUL", b"Tuyull", b"A ghost", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f25f385-54ff-46a4-8ee6-1b38c6028003.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUYUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUYUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

