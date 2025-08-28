module 0x98be02932d2d2a4d2d56929c6035c378fb4296596af9e7f60ae6c52e49fb1c90::Fishy {
    struct FISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHY>(arg0, 9, b"FISH", b"Fishy", b"its a fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GyDd2gzbIAIwCzk?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

