module 0x783e6dad28a858d0c74c74e13e045e55e31ce14d85049736d46e6d2d4e7a7da8::jjhb {
    struct JJHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJHB>(arg0, 6, b"Jjhb", b"Ehj", b"Garden eels ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732640502403.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJHB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJHB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

