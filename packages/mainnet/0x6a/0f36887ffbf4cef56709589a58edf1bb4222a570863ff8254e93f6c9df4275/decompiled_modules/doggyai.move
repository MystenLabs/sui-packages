module 0x6a0f36887ffbf4cef56709589a58edf1bb4222a570863ff8254e93f6c9df4275::doggyai {
    struct DOGGYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGGYAI>(arg0, 6, b"DOGGYAI", b"DOGGY AI by SuiAI", b"DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_19_38fc776aef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGGYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

