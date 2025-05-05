module 0xb16a266620153f8f491cc1b0274e14a0644ad4f981bf3e0f47c43f853d70e778::tjkf {
    struct TJKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJKF>(arg0, 9, b"TJKF", b"Taiji Kuangfu", b"Taiji Kuangfu in Word.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/58d0d4665ca2e871595ca58530ea6a4bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJKF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJKF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

