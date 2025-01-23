module 0x39adf475c80f17e671ba1e7f2c11426498f7d52267071dff4929745c6aba9815::himari {
    struct HIMARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIMARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIMARI>(arg0, 6, b"HIMARI", b"Himari On Sui", b"Time traveling AI from the future, here to guide humanity. Himari AI bridges technology and ethics to tackle Earth's challenges and shape a sustainable tomorrow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250123_114005_279_1e9c42aa71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIMARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIMARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

