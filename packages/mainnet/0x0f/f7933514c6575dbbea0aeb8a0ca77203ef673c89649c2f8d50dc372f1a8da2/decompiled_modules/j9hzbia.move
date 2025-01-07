module 0xff7933514c6575dbbea0aeb8a0ca77203ef673c89649c2f8d50dc372f1a8da2::j9hzbia {
    struct J9HZBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: J9HZBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J9HZBIA>(arg0, 9, b"J9HZBIA", b"Oojnq", b"Bqohd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c2c044f-96f0-4268-8be0-2d15d17df17e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J9HZBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J9HZBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

