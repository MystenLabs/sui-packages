module 0x567c8b24f21a3a495f030fde2c2b2ebe880eb12f1a7bfe0f67e007b702618c64::qgdg {
    struct QGDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGDG>(arg0, 9, b"Qgdg", b"iklrdk", b"tyujhdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8ec94228af9344b7030c169fa3c0d6d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGDG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGDG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

