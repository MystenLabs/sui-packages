module 0x7a56e29c5b04c3d1a4487ff8968a8dad63c49776079cd94d8e053e62b0ddde59::zeusui {
    struct ZEUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUSUI>(arg0, 6, b"ZEUSUI", b"Zeusui", b"Hi I'm ZEUSUI, built like sigma but not with my face!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731083012158.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEUSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

