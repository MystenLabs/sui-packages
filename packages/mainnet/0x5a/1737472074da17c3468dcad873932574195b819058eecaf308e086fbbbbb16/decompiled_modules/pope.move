module 0x5a1737472074da17c3468dcad873932574195b819058eecaf308e086fbbbbb16::pope {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"Pope", b"POPE OF THE USA", b"The Pope of the United States ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746259012017.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

