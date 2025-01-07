module 0xe87c6295ad875487f0a63dbfb62d326ec1b2bbcf58200e945ca42bf75e4f87a0::gtgt {
    struct GTGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTGT>(arg0, 9, b"GTGT", b"HAPPY ", b"HAAAPYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67116306-19e3-4fd9-980c-9270fe09a60a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

