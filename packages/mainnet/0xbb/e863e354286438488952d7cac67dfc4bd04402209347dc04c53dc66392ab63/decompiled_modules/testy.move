module 0xbbe863e354286438488952d7cac67dfc4bd04402209347dc04c53dc66392ab63::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTY>(arg0, 6, b"TESTY", b"tester", b"Test launch  @suilaunchcoin $testy + tester  123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/testy-dlfxqx.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

