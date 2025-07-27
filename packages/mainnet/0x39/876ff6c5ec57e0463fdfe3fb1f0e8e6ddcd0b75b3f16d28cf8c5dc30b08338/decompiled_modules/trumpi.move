module 0x39876ff6c5ec57e0463fdfe3fb1f0e8e6ddcd0b75b3f16d28cf8c5dc30b08338::trumpi {
    struct TRUMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPI>(arg0, 6, b"TRUMPI", b" TRUMPI", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753642684090.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

