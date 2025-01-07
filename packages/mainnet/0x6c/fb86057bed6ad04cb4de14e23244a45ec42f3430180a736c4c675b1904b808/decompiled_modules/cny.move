module 0x6cfb86057bed6ad04cb4de14e23244a45ec42f3430180a736c4c675b1904b808::cny {
    struct CNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNY>(arg0, 6, b"CNY", b"CHINA", b"SUI Dynasty was a great dynasty in Chinese history.  SUI coin will also be a currency representing Chinese sovereignty. SUI coins will make China great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732323671628.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

