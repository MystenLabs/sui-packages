module 0x2f411fb3b043374446fbc58f91e3e5f0cbb19125f809f33d83cc5b062f8be184::tsumar {
    struct TSUMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUMAR>(arg0, 9, b"TSUMAR", b"ARDI", b"lordtsumar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2810727b-8362-4b47-8c1e-ca1a149c98db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUMAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUMAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

