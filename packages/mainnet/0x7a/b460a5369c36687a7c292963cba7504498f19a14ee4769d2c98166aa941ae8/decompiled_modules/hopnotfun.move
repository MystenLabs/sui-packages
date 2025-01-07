module 0x7ab460a5369c36687a7c292963cba7504498f19a14ee4769d2c98166aa941ae8::hopnotfun {
    struct HOPNOTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPNOTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPNOTFUN>(arg0, 6, b"HOPNOTFUN", b"Hop Timedrainer", b"30 more minutes for release", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953358983.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPNOTFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPNOTFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

