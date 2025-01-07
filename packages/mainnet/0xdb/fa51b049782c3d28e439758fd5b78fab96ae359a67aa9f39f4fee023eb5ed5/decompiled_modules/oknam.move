module 0xdbfa51b049782c3d28e439758fd5b78fab96ae359a67aa9f39f4fee023eb5ed5::oknam {
    struct OKNAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKNAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKNAM>(arg0, 9, b"OKNAM", b"Okboy", x"c490e1bb83206be1babf74206ee1bb916920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b16420f9-a6a7-4ee9-9ff5-2c386992b325.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKNAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OKNAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

