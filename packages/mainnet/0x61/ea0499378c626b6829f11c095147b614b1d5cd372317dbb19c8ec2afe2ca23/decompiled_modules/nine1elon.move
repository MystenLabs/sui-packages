module 0x61ea0499378c626b6829f11c095147b614b1d5cd372317dbb19c8ec2afe2ca23::nine1elon {
    struct NINE1ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINE1ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINE1ELON>(arg0, 6, b"NINE1ELON", b"9/1Elon", b"WEEWOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731961589385.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NINE1ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINE1ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

