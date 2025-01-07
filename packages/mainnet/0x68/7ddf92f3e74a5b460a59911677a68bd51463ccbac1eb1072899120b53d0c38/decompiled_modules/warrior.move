module 0x687ddf92f3e74a5b460a59911677a68bd51463ccbac1eb1072899120b53d0c38::warrior {
    struct WARRIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARRIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARRIOR>(arg0, 6, b"WARRIOR", b"WARR", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731433954910.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARRIOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARRIOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

