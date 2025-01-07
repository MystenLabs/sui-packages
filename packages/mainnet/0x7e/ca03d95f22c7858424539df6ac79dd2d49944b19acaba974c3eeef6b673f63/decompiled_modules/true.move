module 0x7eca03d95f22c7858424539df6ac79dd2d49944b19acaba974c3eeef6b673f63::true {
    struct TRUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUE>(arg0, 9, b"TRUE", b"Trump Elon", b"The first Trump x Elon coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00504368-8cf7-4297-8b1b-ef82b6b5cf90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

