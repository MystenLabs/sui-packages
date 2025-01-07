module 0x920c830fafac9b4227e6d4c992e45c9829ef315aad6c58cfa7ab16c6658a74b3::soi {
    struct SOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOI>(arg0, 9, b"SOI", b" Soi new s", b"Soii token free token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/345a4031-f748-4ca2-81f8-5fab3093fbf5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

