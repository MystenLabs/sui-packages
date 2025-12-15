module 0x92619ae98ac96feb02a9b7b746339b5190076d2827e38b9223dd3eff65b26a2::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 6, b"SP", b"testSP", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765764671233.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

