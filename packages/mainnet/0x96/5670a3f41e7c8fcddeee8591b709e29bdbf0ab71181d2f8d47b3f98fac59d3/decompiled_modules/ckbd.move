module 0x965670a3f41e7c8fcddeee8591b709e29bdbf0ab71181d2f8d47b3f98fac59d3::ckbd {
    struct CKBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKBD>(arg0, 9, b"CKBD", b"CryptoKup", x"43525950544f4b55505f4244206368616e6e656c206d656d6520636f696e20f09faa99", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51813228-95c4-4868-9ae8-1963f8d41b39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

