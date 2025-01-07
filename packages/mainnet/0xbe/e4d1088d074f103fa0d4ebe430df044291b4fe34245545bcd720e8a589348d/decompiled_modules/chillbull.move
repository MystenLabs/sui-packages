module 0xbee4d1088d074f103fa0d4ebe430df044291b4fe34245545bcd720e8a589348d::chillbull {
    struct CHILLBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBULL>(arg0, 6, b"ChillBull", b"The Chill Bull", b"The only Chill Bull on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732676079190.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

