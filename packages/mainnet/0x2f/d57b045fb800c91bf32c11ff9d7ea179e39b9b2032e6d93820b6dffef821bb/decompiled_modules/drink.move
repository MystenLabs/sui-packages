module 0x2fd57b045fb800c91bf32c11ff9d7ea179e39b9b2032e6d93820b6dffef821bb::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 9, b"DRINK", b"Coffee", b"Coffee originates from subtropical Africa and southern Asia. It belongs to the genus of 10 species of flowering plants of the Rubiaceae family. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fff90b8-1d0b-4aae-b9b3-c60a93055fa7-hinh-anh-cafe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

